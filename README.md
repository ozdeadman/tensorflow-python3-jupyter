Tensorflow Python3 Jupyter _et al._
================================

Docker container with Python (3.5) version of Tensorflow accompanied by Jupyter and a number of useful packages. TensorFlow version is currently 0.11.0rc0. Includes TDB for breakpoints and real time visualisation of the data flowing through TensorFlows computational graph.

Also includes OpenCV 3.0.0 and support for exporting Jupyter notebooks as PDFs (via nbconvert and TeX).

Usage
-----

```bash
$ docker run -it -p 8888:8888 -p 6006:6006 \
    -v [path-to-notebooks]:/notebooks \
    --name ct_tf_py35 ozdeadman/ct_tf_py35
```

Credits
-------
[erroneousboat] (https://github.com/erroneousboat/tensorflow-python3-jupyter) - for the original Dockerfile

[yamatsuka-hiroto] (https://github.com/yamatsuka-hiroto/tensorflow-python3-jupyter) - for the addition of Keras

[ericjang] (https://github.com/ericjang/tdb) - for the TensorDebugger (TDB), a visual debugger for TensorFlow

[janza] (https://github.com/janza/docker-python3-opencv) - for the addition of OpenCV
