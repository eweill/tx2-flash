# Install Tensorflow on TX2

## Create Swap Space on eMMC

A swapfile should be created (minimum of 8GB recommended) as there is not enough physical memory on the Jetson to compile Tensorflow.  The swap file will be located on the internal eMMC and can be removed after the build.

The following creates a 8GB swapfile on the eMMC in the home directory:

    ./scripts/createSwapfile.sh -d ~/ -s 8

After successfully building Tensorflow, the swapfile can be removed to free up the 8GB:

    sudo swapoff -c $HOME/swapfile
    sudo rm $HOME/swapfile

## Install Prerequisites

The following script installs all prerequisites including Java and Bazel version 0.9.0:

    ./scripts/installPrereqs.sh

## Clone Tensorflow

Due to a small patch being needed for tensorflow for AARCH64 architectures, a script has not yet been developed (a script with patch included is in progress).  The following steps illustrate the steps necessary for cloning Tensorflow and patching it correctly for AARCH64.

    # Clone the repository
    git clone https://github.com/tensorflow/tensorflow.git

    # Checkout v1.5.0
    cd tensorflow
    git checkout v1.5.0rc0

To apply the patch, edit the file `tensorflow/stream_executor/cuda/cuda_gpu_executor.cc` in the function `static int TryToReadNumaNode(const string &pci_bus_id, int device_ordinal)` by adding the folowing code at the beginning of the function.  This hardcodes the function to return 0 since there is no NUMA node in the ARM architecture.

    LOG(INFO) << "ARM has no NUMA node, hardcoding to return zero";
    return 0;

Lastly, make sure cudnn.h is in the correct location:

    sudo mkdir /usr/lib/aarch64-linux-gnu/include/
    sudo cp /usr/include/cudnn.h /usr/lib/aarch64-linux-gnu/include/cudnn.h

Configure the Tensorflow installation using the following script:

    ./configure

Follow the prompts installing only the necessary packages with Tensorflow (i.e. there is no need to install Google Cloud Platform support, Hadoop support, etc.).  MAKE SURE TO PROVIDE THE CORRECT VERSION OF CUDA AND CUDNN AS WELL AS THE CORRECT PATHS WHEN PROMPTED (cuDNN is located at /usr/lib/aarch64-linux-gnu).

## Build and Package Tensorflow using Bazel

The following script uses the tensorflow installation to create a wheel file that can be used for installing using python pip

    ./scripts/buildTensorflow.sh

## Install Tensorflow using Pip

Once Tensorflow has completed building and a wheel file has been created, it can be installed as a python package.  The wheel file is located in the $HOME directory (per the script ran before).

    sudo pip install $HOME/tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl

After successful installation, reboot the system and then you should be able to test the installation as shown below:

~~~~
# Reboot the system
sudo reboot

# Test Tensorflow python package
nvidia@tegra-ubuntu:~$ python
>>> import tensorflow as tf
>>> hello = tf.constant('hello, all')
>>> sess = tf.Session()
2018-01-07 14:47:40.548395: I tensorflow/stream_executor/cuda/cuda_gpu_executor.cc:858] ARM has no NUMA node, hardcoding to return zero
2018-01-07 14:47:40.548512: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1105] Found device 0 with properties: 
name: NVIDIA Tegra X2 major: 6 minor: 2 memoryClockRate(GHz): 1.3005
pciBusID: 0000:00:00.0
totalMemory: 7.66GiB freeMemory: 3.94GiB
2018-01-07 14:47:40.548559: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1195] Creating TensorFlow device (/device:GPU:0) -> (device: 0, name: NVIDIA Tegra X2, pci bus id: 0000:00:00.0, compute capability: 6.2)
>>> print(sess.run(hello))
hello, all
~~~~

