Tensorflow Python3 Jupyter _et al._
================================

Docker container with Python 3(.4) version of Tensorflow accompanied by Jupyter and a number of useful packages. TensorFlow version is currently r0.11.

Included packages (excluding dependencies):
* ipykernel
* jupyter
* matplotlib
* scipy
* scikit-learn
* pandas
* keras
* Pillow
* statsmodels
* openpyxl
* pytest
* typing

Also includes support for exporting Jupyter notebooks as PDFs (via nbconvert).

Usage
-----

```bash
$ docker run -it -p 8888:8888 -p 6006:6006 \
    -v [path-to-notebooks]:/notebooks \
    --name ct_tf_py34 ConsiliumTechnology/TensorFlow_py3.4
```

Credits
-------
[erroneousboat] (https://github.com/erroneousboat/tensorflow-python3-jupyter)
[yamatsuka-hiroto] (https://github.com/yamatsuka-hiroto/tensorflow-python3-jupyter)
