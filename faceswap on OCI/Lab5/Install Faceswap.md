# Install Faceswap

## Introduction

Now that we made sure that our GPU machine supports Tensorflow (see Lab 4), we can go ahead and install Faceswap.
We will closely follow the Faceswap documentation to [install Faceswap](https://forum.faceswap.dev/viewtopic.php?f=4&t=68).

### Objectives

- Install Faceswap on our Ubuntu machine

### What Do You Need?

- Complete Lab 1 to Lab 3
- Complete Lab 4 to make sure that your GPU machine supports Tensorflow, otherwise the Faceswap GAN will not utilize the GPU

## **Step 1:** Install Faceswap

1. Enter the following command in your terminal to access your Ubuntu compute instance where you need to substitute _private-key_ with your OpenSSH private key and _public_IP_ with the public IP address of your Ubuntu instance.

```
   <copy>ssh -i private-key ubuntu@public_ip</copy>
```

2. Download the latest version of the Faceswap installer.

```
   <copy>wget https://github.com/deepfakes/faceswap/releases/latest/download/faceswap_setup_x64.sh</copy>
```

3. Navigate to the download location and enter the following command:

```
   <copy>bash ./faceswap_setup_x64.sh</copy>
```

The following shows a sample run of ./faceswap_setup_x64.sh script.

## **Acknowledgements**

- **Created By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021
- **Last Updated By/Date** - Maria Patelkou, HPC Solution Architect, Oracle Proposal to Production programme, March 2021

## Need Help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a _New Discussion_ or _Ask a Question_. Please include your workshop name and lab name. You can also include screenshots and attach files. Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
