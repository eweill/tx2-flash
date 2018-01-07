# Flash NVIDIA TX2 with Jetpack using Mac with VirtualBox

This repository provides detailed instructions on how to flash NVIDIA's Jetson TX2 with a Mac running VirtualBox.  Current OS setup is given for reference and has not been tested on other setups.

---

## Prerequisite Checklist

   :wavy_dash: Desktop/Laptop running macOS High Sierra 10.13.2 (tested version, may work with others)
   
   :wavy_dash: Internet and power connection
   
   :wavy_dash: NVIDIA Jetson TX2
   
   :wavy_dash: Monitor (for Jetson), HDMI Cable, USB keyboard and mouse (connected to jetson with USB hub)

---

## Installation of VirtualBox

**Install VirtualBox**

   - Download VirtualBox for Mac: [:link:](http://download.virtualbox.org/virtualbox/5.1.28/VirtualBox-5.1.28-117968-OSX.dmg)
   - Downlaod VirtualBox extension for USB-2/USB-3: [:link:](http://download.virtualbox.org/virtualbox/5.1.28/Oracle_VM_VirtualBox_Extension_Pack-5.1.28-117968.vbox-extpack)

**Create Ubuntu VM**

   - Download Ubuntu 16.04 ISO image: [:link:](http://releases.ubuntu.com/16.04/ubuntu-16.04.3-desktop-amd64.iso)
   - Create Ubuntu VM with the following minimum settings:
      - Storage at least 50GB
      - Go to Settings :arrow_right: Network :arrow_right: Adapter 1, change `Attached to` to `Bridged Adapter` and name to whatever under WiFi
      - Go to Settings :arrow_right: Ports :arrow_right: USB, make sure `Enable USB Controller` is under `USB 3.0 (xHCI) Controller`
   - Load the ISO downloaded ISO image and start the VM

---

## Download NVIDIA JetPack

Inside the VM, open Firefox browser (or Chromium) and proceed to NVIDIA's developer [website](https://developer.nvidia.com/embedded/jetpack) and if you have not already done so, create a developer account.

At the time of writing this tutorial, the newest JetPack is `JetPack 3.2 Developer Preview` (including support for Tensorflow models, up to 15% perf/W improvement for DL applications, out-of-the-box kernel support for Docker and native support for Ubuntu 16.04 on the host machine).

After downloading, you should find a file called `JetPack-L4T-3.2-linux-x64_b157.run` (or something similar depending on the JetPack version you chose) in the `Downloads` directory.

---

## Installing JetPack

Open a terminal and navigate to the `Downloads` directory and change the permissions on the `.run` file to executable:

    cd
    cd ~/Downloads
    chmod +x ./JetPack-L4T-3.2-linux-x64_b157.run

Then, run the .run file:

    ./JetPack-L4T-3.2-linux-x64_b157.run
    
Follow the steps (2-12, excluding 9) [here](http://docs.nvidia.com/jetpack-l4t/2_1/content/developertools/mobile/jetpack/jetpack_l4t/2.0/jetpack_l4t_install.htm):
   
   - Choose TX2
   - Choose JetPack L4T 3.2
   - Choose Full install
   
After a while, the dependencies will download and a window will pop up for installation confirmation.  When download/installation on the host machine is complete, a terminal will pop up similar to the following:

![](http://docs.nvidia.com/jetpack-l4t/2_1/content/developertools/mobile/jetpack/images/jetpack_l4t_force_recovery_mode.001_600x364.png)

Before continuing, a few things need to be completed:

   - Plug in the microUSB to USB connector to the Jetson (microUSB) and the desktop/laptop (USB)
   - Connect a keyboard and mouse (via USB hub) to the Jetson as well as an HDMI to the monitor (to monitor what's going on)
   - Follow the description to enable `Force USB Recovery Mode` (but DO NOT hit `Enter` on the host machine quite yet)
   - Before pressing `Enter` on the host machine terminal, open Settings :arrow_right: Ports :arrow_right: USB and click `Add new USB filters will all ...`, then add `NVIDIA Corp. APX`
   - Then, inside the VM window at the bottom right corner, click the USB and select `NVIDIA Corp, APX`
   - Lastly, go back to the host and press `Enter` in the terminal
   
This process will take a while (probably 30 minutes or so depending on connection speeds, etc.).

## TX2 Validation

Once the Jetson has been successfully flashed, open a terminal on the TX2:

    # Validate NVCC
    nvcc -V
    
    # Validate CUDA
    ls /usr/local | grep cuda
    
    # Run an example (if necessary)
