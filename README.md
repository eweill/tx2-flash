# Flash NVIDIA TX2 with Jetpack and install other software

This repository provides detailed instructions on how to flash NVIDIA's Jetson TX2 with the newest Jetpack software as well as installation instruction for other necessary deep learning software (i.e. Tensorflow).

## Flash TX2

### Flash TX2 using Mac with VirtualBox

Prerequisites and full instructions for using a Mac desktop/laptop to flash a NVIDIA Jetson TX2 are given [here](FLASH_MAC.md).  Instructions include important changes that need to be made when flashing with a Mac machine.

## Install Tensorflow

### Pre-build Installation

A pre-built wheel file for Python 2.7 (TF 1.5, CUDA 9.0, cuDNN 7.0) is available [here](TX2/tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl) if you are not interested in building Tensorflow from source.  Once you have the wheel file proceed to install using python-pip.

    sudo apt-get install -y python-pip python-dev
    sudo pip install tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl

If you are interested in building from source or need a different version of TF (or CUDA/cuDNN support), read on for full instructions to install on the TX2.

### Build from Source


