# JDE Trial Edition on Oracle Cloud Infrastructure Workshop
# Introduction

## Workshop Objectives

This workshop will demonstrate how to deploy JD Edwards EnterpriseOne Release 9.2 Trial Edition to Oracle Cloud Infrastructure (OCI) 

Upon completion of this lab, you will have a working deployment of JD Edwards EnterpriseOne Trial Edition with Tools Release 9.2 and Applications Release 9.2 on a fully functional suite of interconnected virtual machine.You can use it to verify functionality and to investigate proofs of concept

Trial Edition is for training and demonstration purposes only. It can be used to verify functionality and to investigate proofs of concept (POCs). The Trial Edition on OCI Compute contains only the Pristine (PS920) environment, which is one of the four standard JD Edwards EnterpriseOne environments  

This single image is built using an Oracle Linux VM instance containing these JD Edwards EnterpriseOne servers:

* Enterprise ServerDatabase Server

* HTML Web ServerBI Publisher (BIP) Server 

* Application Interface Services (AIS) Server

* Application Development Framework (ADF) Server

**Duration:** 2 hours (additional time may be needed for first-time users)

### About Product/Technology
Enter background information here....

*You may add an option video, using this format: [](youtube:YouTube video id)*

  [](youtube:zNKxJjkq0Pw)

### Objectives

In this lab, you will:
* Request and Obtain a Trial OCI Subscription
* Generate SSH Key for OCI Connection
* Deploy the JDE Trial Edition to OCI
* Configure JDE Trial Edition
* Sign in to JDE Trial Edition


### Prerequisites

* Oracle Cloud Infrastructure supports the latest versions of **Google Chrome** and **Firefox**  Firefox is preferred
* Valid email address
* Credit Card. YOU WILL NOT BE CHARGED
* Mobile Phone. Oracle will send you an SMS based text message for verification purposes
* ***For Windows users only:***  A Windows SSH utility is required to generate SSH key pairs on the client machine and to connect to the Linux based server using Secure Shell (SSH). We suggest either you either download and install the PuTTY tool (http://www.putty.org), or Git BASH (https://gitforwindows.org/).  Installation instructions are included in this document


### JDE Trial Edition on Oracle Cloud Infrastructure Overview

JD Edwards EnterpriseOne is a comprehensive suite of integrated global business applications. The machine image provided by Oracle allows organizations to create a trial instance of JD Edwards EnterpriseOne Release 9.2 in the Oracle Compute Cloud.  This 'All-in-One' Demo/Sandbox image enables customers to explore new functionality in JD Edwards EnterpriseOne Applications Release 9.2 & Tools Release 9.2.4.3 without installing JD Edwards EnterpriseOne in their data centers. New functionality may include:

* New industry modules
* One View Financial Statements
* Internet of Things Orchestrator
* UX One Content and Foundation 

### Mobile and other latest application enhancements Before You Begin

* It is desirable to have a fundamental understanding of the Oracle Cloud Infrastructure.
* It is highly recommended that you review the extensive collateral information, including training, at these sites:
    * [Oracle Cloud Infrastructure](https://www.oracle.com/cloud/)
    * [LearnJDE](https://docs.oracle.com/cd/E84502_01/learnjde/cloud_overview.html)

* You must have sufficient resources in Oracle Cloud Infrastructure to install and run JD Edwards EnterpriseOne Trial Edition. 
* Minimum Shape: VMStandard2.2 (2 OCPUs and 30 GB memory)
  Recommended Shape: VMStandard2.4 (4 OCPUs and 30 GB memory)
* Boot Volume Storage of 100 GB

## **OPTIONAL:** Generate a Secure Shell (SSH) Key Pair

**NOTE:**  If you have a previously generated key available, you can use that key and skip this exercise

### FOR MAC/LINUX

Generate ssh-keys for your machine if you don’t have one. If an id_rsa and id_rsa.pub key pair is present, they can be reused. By default, these are stored in ~/.ssh folder. 

Enter the following command if you are using MAC or Linux Desktop:  

    
    # ssh-keygen

Make sure permissions are restricted, sometimes ssh will fail if private keys have permissive permissions. Enter the following to ensure this.

    # chmod 0700 ~/.ssh  
    # chmod 0600 ~/.ssh/id_rsa  
    # chmod 0644 ~/.ssh/id_rsa.pub

### FOR WINDOWS

There are many tools available for Windows users to create SSH key pairs and connect to a Linux server.  In this guide, we provide instructions for both Git Bash and Putty, but you only need to follow the steps below for either Git Bash ***OR*** Putty, but not both

### Git Bash:

1)  Install Git for windows if not already Installed. Download the latest release of [Git](https://github.com/git-for-windows/git/releases/) for Windows and install accepting all the default settings.

2)  Open Git Bash by either checking the ***Launch Git Bash*** option in the installer ***OR*** by navigating to it from the Windows Start Menu:

   ![](./images/lab1_gitsetup.png " ")
   ![](./images/lab1_gitbash.png " ")

3)  Generate ssh-keys by the command ssh-keygen in Git Bash and then simply hit “Enter” for all steps:

    ssh-keygen  
    Generating public/private rsa key pair. Enter file in which to save the key

    (/c/Users/username/.ssh/id_rsa): (Press enter for this step)
    Created directory '/c/Users/username/.ssh'.

    Enter passphrase (empty for no passphrase): (Press enter for this step)

    Enter same passphrase again: (Press enter for this step)
    Your identification has been saved in /c/Users/username/.ssh/id_rsa.  
    Your public key has been saved in /c/Users/username/.ssh/id_rsa.pub

    **Note:**

    •   In Git Bash, C:\Users\username\ is shown as /c/Users/username/

    •   These instructions will create a minimally secure ssh key for you (and one well suited for this tutorial). For production environments we recommend an SSH-2 RSA key with 4096 bits and a passphrase. For example: ssh-keygen -t rsa -b 4096 -N "<myPassphrase>" -f ~/keys/id_rsa -C "This is my comment"

### Puttygen

1)  Install Puttygen (PUTTY) for Windows if not already installed. Download the latest release of [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html), 64-bit MSI Installer and install accepting all the default settings

2)  Open PuTTY Gen: 

![](./images/lab1_puttygen.png " ")

3)  In the PuTTY Key Generator, ensure that the ***Type of key to generate*** is set to ***RSA*** and the Number of bits in a generated key is set to ***2048***, and then click the ***Generate*** button
 
![](./images/lab1_puttykey.png " ")

4)  After clicking the ***Generate button***, move the mouse around the blank area to generate randomness for the SSH key to be generated
 
![](./images/lab1_keygenerator.png " ")

5)  In the PuTTY Key Generator dialog, select all the characters in the ***Public key for pasting into OpenSSH authorized_keys file*** field, and then right-click and select ***Copy***

**Note:** Ensure that you select all the characters and not just the ones shown in the narrow window. Scroll down as necessary
 
![](./images/lab1_copykey.png " ")

6)  Paste the copied string into a plain text editor (such as Notepad) and save the plain text file. Save it to a known location with any file name but ensure that it has the extension .pub (example: OCISSHKey.pub) to indicate that it is a public key.  Make note of this file name as you will need it later

7)  Next, save the OpenSSH private key. In the same PuTTY Key Generator window, from the ***Conversions*** menu, select the ***Export OpenSSH key*** option.

![](./images/lab1_exportkey.png " ")

8)  PuTTYgen will ask you to verify that the key will be saved without a passphrase. Click the ***Yes*** button.
 
![](./images/lab1_puttyyes.png " ")

9)  Again, save the file to the same known location with any file name but ensure that the file has ***NO extension*** on it (example: OCISSHKey).  Make note of this file name as you will need it later.

10) Save the Windows private key. In the same PuTTY Key Generator window, click the ***Save private key*** button. 
 
![](./images/lab1_puttyprivatekey.png " ")

11) Again, click the ***Yes*** button to verify saving the key without a passphrase.

12) Save this file to the same known location with any file name and a .ppk extension (example: OCISSHKey.ppk).

## Summary
At this point, everything is allocated and generated to start creating instances in Oracle Cloud Infrastructure.  

#
## Acknowledgements
* **Author** - AJ Kurzman, Cloud Engineer
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.




<<<<<<< HEAD
=======
## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
>>>>>>> upstream/master
