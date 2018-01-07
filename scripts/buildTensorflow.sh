#!/bin/bash
# NVIDIA Jetson TX2
# Tensorflow Installation, Build, and Package

# Build Tensorflow
cd $HOME/tensorflow
bazel build -c opt --local_resources 3072,4.0,1.0 --verbose_failures --config=cuda //tensorflow/tools/pip_package:build_pip_package

# Build PIP Package
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
mv /tmp/tensorflow_pkg/tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl $HOME/
