# Run Faceswap (terminal and GUI)

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

## **Acknowledgements**

- **Created By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021
- **Last Updated By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021

## Need Help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a _New Discussion_ or _Ask a Question_. Please include your workshop name and lab name. You can also include screenshots and attach files. Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
