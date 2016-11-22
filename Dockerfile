# See https://github.com/ozdeadman/tensorflow-python3-jupyter for more details,
# and referenced files: jupyter_notebook_config.py, keras.json, run_jupyter.sh

FROM python:3.5
MAINTAINER ozdeadman <ozdeadman@gmail.com>

RUN apt-get update && apt-get install -y \
	build-essential \
	cmake \
	git \
	wget \
	unzip \
	yasm \
	pkg-config \
	libblas-dev \
	liblapack-dev\
	libatlas-base-dev \
	gfortran
	
# Add the following packages to support OpenCV
RUN apt-get update && apt-get install -y \
	libswscale-dev \
	libtbb2 \
	libtbb-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libjasper-dev \
	libavformat-dev \
	libpq-dev
	
RUN pip --no-cache-dir install \
	numpy
	
WORKDIR /
RUN wget https://github.com/Itseez/opencv/archive/3.0.0.zip \
&& unzip 3.0.0.zip \
&& mkdir /opencv-3.0.0/cmake_binary \
&& cd /opencv-3.0.0/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=OFF \
  -DENABLE_AVX=ON \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.5 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.5) \
  -DPYTHON_INCLUDE_DIR=$(python3.5 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.5 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
&& make install \
&& rm /3.0.0.zip \
&& rm -r /opencv-3.0.0
	
RUN pip --no-cache-dir install \
	flake8 \
	pep8 \
    --upgrade
	
# Add the following packages to support export of 
# Jupyter notebook to PDF.
RUN apt-get update && apt-get install -y \
	texlive \
	texlive-latex-extra \
	pandoc \
	xzdec && \
	
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN pip --no-cache-dir install \
	ipykernel \
	scipy \
	pandas \
	scikit-learn \
	scikit-image \
	Pillow \
	jupyter \
	matplotlib \
	keras \
	statsmodels \
	bs4 \
	openpyxl \
	xlrd \
	pytest \
	typing \
	tfdebugger \
	&& \
	python -m ipykernel.kernelspec

COPY jupyter_notebook_config.py /root/.jupyter/
RUN mkdir /root/.keras
COPY keras.json /root/.keras/

# Jupyter has issues with being run directly:
# https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# Use the tfdebugger_setup.py script to
# add the tfdebugger notebook extension
# as per: https://github.com/ericjang/tdb
COPY tfdebugger_setup.py /

ENV TENSORFLOW_VERSION 0.11.0

RUN pip --no-cache-dir install \
	https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-${TENSORFLOW_VERSION}-cp35-cp35m-linux_x86_64.whl

# tensorboard
EXPOSE 6006

# jupyter
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh"]
