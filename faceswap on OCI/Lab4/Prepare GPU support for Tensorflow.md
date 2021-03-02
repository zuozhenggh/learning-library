# Prepare GPU support for Tensorflow

## Introduction

Before we can install and run Faceswap (train the GAN) on our GPU virtual machine running on Ubuntu on OCI, we have to make sure that we install the drivers & libraries to ensure the support of Tensorflow on the GPU and that we build the Tensorflow pip package from source.
We will closely follow the Tensorflow documentation to [install the drivers & libraries for GPU support of Tensorflow](https://www.tensorflow.org/install/gpu) and to [build the TensorFlow pip package from source](https://www.tensorflow.org/install/source).

**Note:** A PAYG account is required to provision GPU instances on OCI. If you are using the Oracle Free Tier or the Always Free offering and are planning to run Faceswap on the CPU(s), you can skip this lab and proceed to the next one.

### Objectives

- Install the drivers and libraries to ensure the support of Tensorflow on the GPU
- Build the Tensorflow pip package from source and install it on Ubuntu

### What Do You Need?

- Complete Lab 1 to Lab 3

## **Step 1:** Install the drivers & libraries for GPU support of Tensorflow

1. Install Python and the TensorFlow package dependencies:

```
   <copy>sudo apt install python3-dev python3-pip</copy>
```

2. Install the TensorFlow pip package dependencies:

```
   <copy>pip3 install -U --user pip numpy wheel</copy>
```

```
   <copy>pip3 install -U --user keras_preprocessing --no-deps</copy>
```

3. Install Bazel using Bazelisk. Bazelisk is a launcher for Bazel which automatically downloads and installs an appropriate version of Bazel.
   First, install npm, package manager for the Node JavaScript platform.

```
   <copy>sudo apt install npm</copy>
```

Then you can go ahead install Bazelisk using npm.

```
   <copy>npm install -g @bazel/bazelisk</copy>
```

4. Install the TensorFlow pip package that includes GPU support for CUDA-enabled cards.

```
   <copy>pip3 install tensorflow</copy>
```

5. Install CUDA 11 on your Ubuntu 18.04 machine.

```
<copy>
# Add NVIDIA package repositories

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update

wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb

sudo apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt-get update

# Install NVIDIA driver

sudo apt-get install --no-install-recommends nvidia-driver-450

# Reboot. Check that GPUs are visible using the command: nvidia-smi

wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libnvinfer7_7.1.3-1+cuda11.0_amd64.deb
sudo apt install ./libnvinfer7_7.1.3-1+cuda11.0_amd64.deb
sudo apt-get update

# Install development and runtime libraries (~4GB)

sudo apt-get install --no-install-recommends \
 cuda-11-0 \
 libcudnn8=8.0.4.30-1+cuda11.0 \
 libcudnn8-dev=8.0.4.30-1+cuda11.0

# Install TensorRT. Requires that libcudnn8 is installed above.

sudo apt-get install -y --no-install-recommends libnvinfer7=7.1.3-1+cuda11.0 \
 libnvinfer-dev=7.1.3-1+cuda11.0 \
 libnvinfer-plugin7=7.1.3-1+cuda11.0
 </copy>
```

## **Step 2:** Build the TensorFlow pip package from source

1. Download the TensorFlow source code:

```
   <copy>git clone https://github.com/tensorflow/tensorflow.git</copy>
```

Navigate to the tensorflow folder:

```
   <copy>cd tensorflow</copy>
```

2. Configure your system build by running the ./configure. This script prompts you for the location of TensorFlow dependencies and asks for additional build configuration options (compiler flags, for example).

```
   <copy>./configure</copy>
```

The following shows a sample run of ./configure script.

3. Build the TensorFlow package builder with GPU support:

```
   <copy>bazel build --config=cuda //tensorflow/tools/pip_package:build_pip_package</copy>
```

This step may take 2-3 hours.

## **Acknowledgements**

- **Created By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021
- **Last Updated By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021

## Need Help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a _New Discussion_ or _Ask a Question_. Please include your workshop name and lab name. You can also include screenshots and attach files. Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
