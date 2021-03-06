# See https://github.com/ozdeadman/tensorflow-python3-jupyter for more details,
# and referenced files: jupyter_notebook_config.py, keras.json, run_jupyter.sh

FROM python:3.5

RUN apt-get update && apt-get install -y \
	libblas-dev \
	liblapack-dev\
	libatlas-base-dev \
	gfortran
    
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
	numpy \
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
	h5py \
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

ENV TENSORFLOW_VERSION 0.11.0rc0

RUN pip --no-cache-dir install \
	https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-${TENSORFLOW_VERSION}-cp35-cp35m-linux_x86_64.whl

# tensorboard
EXPOSE 6006

# jupyter
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh"]
CMD ["python /tfdebugger_setup.py"]
