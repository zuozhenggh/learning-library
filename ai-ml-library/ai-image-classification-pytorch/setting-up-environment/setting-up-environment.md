# Setting Up the Environment

## Introduction

In order to run the full workshop, a GPU-enabled compute instance is required. However, the majority of the material related to computer vision is in Lab 1, which is run on the CPU. The full lab is designed around writing CPU code first for simplicity, and then expanding into accelleration with a GPU.

Estimated lab time: 15 minutes

### Objectives

Topics covered in this lab:
* Setting up a python environment with PyTorch

### Prerequisites

* An Oracle Cloud Infrastructure environment

## **STEP 1**: Create a Virtual Machine and Connect Remotely with VSCode

OCI provides detailed documentation for all of our services. To create a GPU-enabled virtual machine [follow these steps](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/References/ngcimage.htm)

Lab 1 can be completed only with CPU resources, so if you'd prefer learning with a CPU-only system [follow these steps](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/launchinginstance.htm). It is recommended to use a system with at least 4 OCPUs.

You may [connect to the instance](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/accessinginstance.htm) using your preferred environment **or** use the integrated remote development suite with VSCode:

1. Download and install [VSCode](https://code.visualstudio.com/download) and then install the [Remote Development Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
2. [Follow the documention on connecting to the instance](https://code.visualstudio.com/docs/remote/ssh)

**NOTE:** If you are running VSCode in a Windows instance, you must create an ed25519 key as the default key to connect to the instance. VSCode does not support RSA keys. If you need to add a new key to your instance, [this command](https://stackoverflow.com/questions/12392598/how-to-add-rsa-key-to-authorized-keys-file) provides a succinct means of adding the key. 

        cat <your_public_key_file> >> ~/.ssh/authorized_keys

## **STEP 2**: Set up the environment

There are a number of methods to set up a python environment to run PyTorch. You may follow your preferred method or the following set of instructions.

1. Get a link for the [latest version of miniconda](https://docs.conda.io/en/latest/miniconda.html) by navigating to the site scrolling down to "Linux Installers" and copying the top link.
2. In a terminal for the instance, use wget to download the file. 

        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
3. [Run the install command](https://conda.io/projects/conda/en/latest/user-guide/install/linux.html) and complete the setup. 

        bash Miniconda3-latest-Linux-x86_64.sh

4. Exit the terminal and open a new terminal after installation, which ensures that conda is activated. Optional: create a specific environment for PyTorch by running the command `conda create --name pytorch python=3.6` and then enabling the environment by running `conda activate pytorch`
5. [Install PyTorch](https://pytorch.org/) through conda `conda install pytorch torchvision cudatoolkit=10.2 -c pytorch`

## **Acknowledgements**

- **Author** - Justin Blau - Senior Solutions Architect
- **Last Updated By/Date** - Justin Blau, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

You may proceed to the next lab.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *STEP* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.    Please include the workshop name and lab in your request.