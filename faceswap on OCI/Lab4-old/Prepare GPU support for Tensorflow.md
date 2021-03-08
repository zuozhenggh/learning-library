# Prepare GPU support for Tensorflow

## Introduction

Before we can run Faceswap (train the GAN) on our GPU virtual machine running on Ubuntu on OCI, we have to make sure that we install the drivers & libraries to ensure the support of Tensorflow on the GPU and that we build the Tensorflow pip package from source.
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
   <copy>sudo npm install -g @bazel/bazelisk</copy>
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

The following shows a sample run of ./configure script with the configuration options you can choose.

```
   <copy>
./configure
You have bazel 3.7.2 installed.
Please specify the location of python. [Default is /usr/bin/python3]:


Found possible Python library paths:
  /usr/lib/python3/dist-packages
  /usr/local/lib/python3.6/dist-packages
Please input the desired Python library path to use.  Default is [/usr/lib/python3/dist-packages]

Do you wish to build TensorFlow with ROCm support? [y/N]: n
No ROCm support will be enabled for TensorFlow.

Do you wish to build TensorFlow with CUDA support? [y/N]: y
CUDA support will be enabled for TensorFlow.

Do you wish to build TensorFlow with TensorRT support? [y/N]: n
No TensorRT support will be enabled for TensorFlow.

Found CUDA 11.0 in:
    /usr/local/cuda-11.0/targets/x86_64-linux/lib
    /usr/local/cuda-11.0/targets/x86_64-linux/include
Found cuDNN 8 in:
    /usr/lib/x86_64-linux-gnu
    /usr/include


Please specify a list of comma-separated CUDA compute capabilities you want to build with.
You can find the compute capability of your device at: https://developer.nvidia.com/cuda-gpus. Each capability can be specified as "x.y" or "compute_xy" to include both virtual and binary GPU code, or as "sm_xy" to only include the binary code.
Please note that each additional compute capability significantly increases your build time and binary size, and that TensorFlow only supports compute capabilities >= 3.5 [Default is: 7.0]:


Do you want to use clang as CUDA compiler? [y/N]:
nvcc will be used as CUDA compiler.

Please specify which gcc should be used by nvcc as the host compiler. [Default is /usr/bin/gcc]:


Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -Wno-sign-compare]:


Would you like to interactively configure ./WORKSPACE for Android builds? [y/N]: N
Not configuring the WORKSPACE for Android builds.

Preconfigured Bazel build configs. You can use any of the below by adding "--config=<>" to your build command. See .bazelrc for more details.
        --config=mkl            # Build with MKL support.
        --config=mkl_aarch64    # Build with oneDNN support for Aarch64.
        --config=monolithic     # Config for mostly static monolithic build.
        --config=numa           # Build with NUMA support.
        --config=dynamic_kernels        # (Experimental) Build kernels into separate shared objects.
        --config=v2             # Build TensorFlow 2.x instead of 1.x.
Preconfigured Bazel build configs to DISABLE default on features:
        --config=noaws          # Disable AWS S3 filesystem support.
        --config=nogcp          # Disable GCP support.
        --config=nohdfs         # Disable HDFS support.
        --config=nonccl         # Disable NVIDIA NCCL support.
Configuration finished
</copy>
```

3. Build the TensorFlow package builder with GPU support:

```
   <copy>bazel build --config=cuda //tensorflow/tools/pip_package:build_pip_package</copy>
```

This step may take a couple of hours.
The bazel build command creates an executable named build_pip_package—this is the program that builds the pip package. Run the executable as shown below to build a .whl package in the /tmp/tensorflow_pkg directory.

4. Build the package.

```
   <copy>./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg</copy>
```

5. Install the package. The filename of the generated .whl file depends on the TensorFlow version and your platform (e.g. tensorflow-2.5.0-cp36-cp36m-linux_x86_64.whl)

```
   <copy>pip3 install /tmp/tensorflow_pkg/tensorflow-version-tags.whl</copy>
```

TensorFlow is now installed.

## **Acknowledgements**

- **Created By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021
- **Last Updated By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021

## Need Help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a _New Discussion_ or _Ask a Question_. Please include your workshop name and lab name. You can also include screenshots and attach files. Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

boost application speed https://developer.nvidia.com/blog/increase-performance-gpu-boost-k80-autoboost/

training speed EG/s https://github.com/occoder/common_sql/issues/160
