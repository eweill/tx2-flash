#!/bin/bash
# NVIDIA Jetson TX2
# Install Tensorflow dependencies

# Install Java
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer -y

# Install other dependencies
sudo apt-get install zip unzip autoconf automake libtool curl zlib1g-dev maven -y
sudo apt-get install python-numpy swig python-dev python-pip python-wheel -y

# Install Bazel (v0.9.0 used for this installation)
cd $HOME
wget --no-check-certificates https://github.com/bazelbuild/bazel/releases/download/0.9.0/bazel-0.9.0-dist.zip
unzip bazel-0.9.0-dist.zip -d bazel-0.9.0-dist
sudo chmod -R ug+rwx $HOME/bazel-0.9.0-dist
cd bazel-0.9.0-dist
./compile.sh
sudo cp output/bazel /usr/local/bin
