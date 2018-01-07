# Flash NVIDIA TX2 with Jetpack and install other software

This repository provides detailed instructions on how to flash NVIDIA's Jetson TX2 with the newest Jetpack software as well as installation instruction for other necessary deep learning software (i.e. Tensorflow).

## Flash TX2

### Flash TX2 using Mac with VirtualBox

Prerequisites and full instructions for using a Mac desktop/laptop to flash a NVIDIA Jetson TX2 are given [here](FLASH_MAC.md).  Instructions include important changes that need to be made when flashing with a Mac machine.

## Install Tensorflow

### Pre-build Installation

A pre-built wheel file for Python 2.7 (TF 1.5, CUDA 9.0, cuDNN 7.0) is available [here](https://github.com/eweill/tx2-flash/blob/master/TX2/tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl?raw=true) if you are not interested in building Tensorflow from source.  Once you have the wheel file proceed to install using python-pip.

    sudo apt-get install -y python-pip python-dev
    sudo pip install tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl

If you are interested in building from source or need a different version of TF (or CUDA/cuDNN support), continue for full instructions to install on the TX2.

### Build from Source

To built Tensorflow from source, a swapfile must be created on the internal eMMC, prerequisites must be installed and the tensorflow environment must be set up.  Instructions and links to scripts are provided [here](INSTALL_TF.md).



### Contributions

This repository was modified from the following pages:

* https://github.com/jetsonhacks/installTensorFlowJetsonTX
* https://github.com/jetsonhacks/installTensorFlowTX2
* http://blog.csdn.net/weixin_35654926/article/details/78635859
