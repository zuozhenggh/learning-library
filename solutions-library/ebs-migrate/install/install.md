<<<<<<< HEAD
# Migrating an Oracle E-Business Suite environment to Oracle Cloud Infrastructure

## Introduction

In this lab we create a backup of an existing Oracle E-Business Suite instance on the Oracle Cloud Infrastructure Object Storage service.

The steps in this tutorial take approximately 45 minutes to perform, not including the time required for the Oracle E-Business Suite Cloud Backup Module to finish creating the backup, which lasts about 2 hours and 30 minutes when using the EBS 12.2.8 image from Marketplace as source.

Estimated Lab Time: 45 minutes

### **Background**

Creating a backup of your source Oracle E-Business Suite instance is the first part of a lift and shift process. You can subsequently complete the lift and shift process by using Oracle E-Business Suite Cloud Manager to provision an environment on Oracle Cloud Infrastructure based on the backup.

Note: Although this process is intended primarily for on-premises instances, you can also run the Oracle E-Business Suite Cloud Backup module to conduct a lift and shift in certain cases when the source environment is already in Oracle Cloud Infrastructure with optional database services. These cases include the following:
  - You initially used a manual procedure, such as a platform migration, to migrate an environment to Oracle Cloud Infrastructure, and now would like to leverage Oracle E-Business Suite Cloud Manager to manage that environment going forward.
  - You want to migrate your environment from one tenancy to another. The lift and shift process can be used for this purpose whether or not you are currently using Oracle E-Business Suite Cloud Manager.

=======
# Install the Oracle E-Business Suite Cloud Backup Module

## Introduction

This lab will walkthrough the downloading and configuration of the Oracle E-Business Suite Cloud Backup Module. 

**Estimated Lab Time:** 10 minutes
>>>>>>> upstream/master

### **Objectives**

In this lab, you will:
<<<<<<< HEAD

* Prepare the Source Oracle E-Business Suite Environment
* Install the Oracle E-Business Suite Cloud Backup Module
* Create a Backup with the Oracle E-Business Suite Cloud Backup Module

### **Prerequisites**

* Complete Lab 1: Preparing Your Tenancy for Oracle E-Business Suite
* Complete Lab 2: Oracle E-Business Suite Cloud Manager Deployment and Configuration
* A source **Oracle E-Business Suite 12.2.8** instance with DB 12.1.0 provisioned on OCI following the tutorial described here: [Provision a New Oracle E-Business Suite Installation on a Single Node on Oracle Cloud Infrastructure](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/provision_ebs_on_single_node_on_oci/index.html). (Including step 6 - Configure Web Entry Point with hostname **apps**)

Note: If/When going through the above lab to provision a new EBS Instance remember to document the values that you set throughout that pre-requisite lab. (Specifically the ones noted under **From your source EBS Instance**)

=======
* Download and Install the Oracle E-Business Suite Cloud Backup Module

### **Prerequisites**

* Complete Lab 2: **Prepare the Source Oracle E-Business Suite Environment**
>>>>>>> upstream/master
* A MyOracleSupport account is needed to download the Cloud Backup tool to the source EBS environment.
* key-data.txt file documented with following information:

**From MyOracleSupport Account:**

* `MOS_Email_Address` (typically your tenancy admin user)

<<<<<<< HEAD
**From Provisioning your Cloud Manager Instance You Should have recorded:**

* `Oracle_Cloud_Region_Identifier`
* `Oracle_Cloud_Tenancy_Name`
* `Oracle_Cloud_Tenancy_OCID`
* `Cloud_Manager_Admin_User_OCID`
* `Cloud_Manager_Admin_Fingerprint`
* `Oracle_Cloud_Compartment_OCID`
* `Cloud_Manager_Instance_public_IP`

**From your source EBS Instance**

* `Source_EBS_Instance_public_IP`
* `Source_EBS_Instance_private_IP`
* `Fully_Qualified_Hostname` (In this Lab: apps.example.com)
* `apps_password` (In this Lab: apps)
* `weblogic_password` (In this Lab: welcome1)

## **STEP 1**: Prepare the Source Oracle E-Business Suite Environment. 
You will now copy the API Signing key from the Cloud Manager instance to the source Oracle E-Business Suite environment. 
If you would like to use a different API key for the Source EBS instance you can follow the steps in these short tutorials. See [How to Generate an API Signing Key](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#How), [How to Get the Key's Fingerprint](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#How3), and "To Upload an API Signing Key" in [Using the Console](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcredentials.htm#three).

Then you will create the stage area directories that will hold the backups and the Backup tool.

You will ensure SSH connectivity between all the nodes:
  - The Node where the Backup tool is deployed
  - Application Tier Node 
  - Database Tier Node

Then, you will put the Database in Archive Mode before creating the backup.

### **Part 1. Copy the private API signing key files from the Cloud Manager instance to the source Oracle E-Business Suite environment.** 
The key file must be placed in a location where it can be referenced by the Oracle E-Business Suite Cloud Backup Module. For example: /u01/install/APPS/.oci/

a. Connect to your Oracle E-Business Suite Cloud Manager Compute instance that was created according to Lab 2: Oracle E-Business Suite Cloud Manager Deployment and Configuration. 
    
To connect, follow the instructions under “Connecting to a Linux Instance”  in [Connecting to an Instance](https://docs.cloud.oracle.com/iaas/Content/Compute/Tasks/accessinginstance.htm).
    
SSH into the Cloud Manager instance from your local machine by using the IP address in the ``key-data.txt`` file and the SSH private key you used during the deployment of the Cloud Manager in OCI or by using Putty on a Windows machine. 

    ssh -i <filepath_to_private_ssh_key> opc@<Cloud_Manager_Instance_public_IP>

![](./images/1.png " ")

b. Read the private API key using the ``cat`` command and copy the private API key to your clipboard or in a text file on your desktop.

    sudo cat /u01/install/APPS/.oci/<Cloud Manager_Admin_Username>.pem

Example:

    <copy>
    sudo cat /u01/install/APPS/.oci/myebscm.admin@example.com.pem
    </copy>

Select all the resulted characters to copy the key (make sure not to copy any spaces).

Paste the key in a text file on your desktop 

![](./images/2.png " ")
  
d. Connect to the source EBS environment.

To connect, follow the instructions under “Connecting to a Linux Instance”  in [Connecting to an Instance](https://docs.cloud.oracle.com/iaas/Content/Compute/Tasks/accessinginstance.htm).
SSH into the source EBS instance from your local machine by using the IP address and the SSH private key you used during the deployment of the source EBS instance . 

    ssh -i <filepath_to_private_ssh_key> opc@<Source_EBS_Instance_public_IP>

![](./images/3.png " ")

e. Switch to the Oracle user in the source EBS instance

    <copy>
    sudo su - oracle
    </copy>

![](./images/4.png " ")

f. Create a directory named **.oci**, create a .pem file with the same name as you had in the cloud manager instance. For example: **ebscm.admin@example.com.pem** and change permissions to the file.

    <copy>
    mkdir /u01/install/APPS/.oci
    cd /u01/install/APPS/.oci
    touch /u01/install/APPS/.oci/ebscm.admin@example.com.pem
    chmod 600 /u01/install/APPS/.oci/ebscm.admin@example.com.pem
    </copy>

![](./images/5.png " ")

g. Open the vi editor along with the path and name for the API key, paste the API key from your clipboard and Exit the vi editor with save.

    <copy>
    vi /u01/install/APPS/.oci/ebscm.admin@example.com.pem
    </copy>
    
![](./images/6.png " ")

Press **i** on your keyboard to insert text

Paste the key with right click

Press **Esc**

To save the file write **:wq** and press Enter
    
![](./images/7.png " ")

### **Part 2. Create stage area directories for the Application tier and Database Tier.**

These directories will hold:

  - Apps Stage Area directory - temporary files used during the application tier backup process as well as the application tier backup file in zip or tar format that is created locally before it is uploaded to Oracle Cloud Infrastructure Object Storage.
  - DB Stage Area directory - backup utilities and the temporary files used to process the backup.

        <copy>
        mkdir /u01/install/APPS/stage
        mkdir /u01/install/APPS/stage/appsStage
        mkdir /u01/install/APPS/stage/dbStage
        </copy>

![](./images/8.png " ")

### **Part 3. Do the following to ensure that the Oracle E-Business Suite Cloud Backup Module can connect to all required nodes:**

All nodes must have SSH enabled. 

In our case Application Tier Node, DB Tier Node and Backup module are on the same instance.

a. The SSH configuration file (~/.ssh/config) must have the entry **ServerAliveInterval 100**.

    <copy>
    cd  ~/.ssh
    touch ~/.ssh/config
    chmod 644 ~/.ssh/config
    vi ~/.ssh/config
    </copy>
    
![](./images/9.png " ")
        
Press **i** on your keyboard to insert text

Insert a new line containing **ServerAliveInterval 100**

Press **Esc**

To save the file write **:wq** and press **Enter**

![](./images/10.png " ")

b. Generate a new set of SSH keys without passphrase in the ~/.ssh/ directory.
Choose default name for the keys.

    <copy>
    cd ~/.ssh
    ssh-keygen
    </copy>

![](./images/11.png " ")

c. Create the authorized keys file and update it with the SSH public key.

    <copy>
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    </copy>

![](./images/12.png " ")

f. Verify if ssh connection using privateIP is working.

    ssh oracle@<Source_EBS_Instance_private_IP>

Choose yes to connect to the host

![](./images/13.png " ")

g. After verifing the connection is established you can close it. 
        
    <copy>
    exit
    </copy>

![](./images/14.png " ")

### **Part 4.** The Database must be in **Archive Mode**

a.	Stop Apps Tier using the stopapps.sh script

    <copy>
    /u01/install/APPS/scripts/stopapps.sh
    </copy>

![](./images/15.png " ")

b. Source the EBS environment and connect to the database
        
    <copy>
    cd /u01/install/APPS/12.1.0/
    . ./ebsdb_apps.env
    sqlplus / as sysdba
    </copy>

![](./images/16.png " ")

c. Check wether the Database is in archive mode

    <copy>
    archive log list;
    </copy>

![](./images/17.png " ")

e. Put the Database in Archive mode

    <copy>
    shutdown immediate;
    startup mount;
    alter database archivelog;
    alter database open;
    </copy>

![](./images/18.png " ")

f. Confirm that the Database is in Archive mode and close the Database connection

    <copy>
    archive log list;
    exit
    </copy>

![](./images/19.png " ")

g. Start the applications tier by running the startapps.sh script

    <copy>
    /u01/install/APPS/scripts/startapps.sh
    </copy>

![](./images/20.png " ")



=======
## **STEP 1:** Install the Oracle E-Business Suite Cloud Backup Module

This section describes how to install the Oracle E-Business Suite Cloud Backup Module on the Linux server that you have chosen to use as the backup module server, which can be located either on-premises or in OCI Compute. It can be one of the Oracle E-Business Suite nodes or another server that resides in your intranet. The backup module server must have at least 500 MB of free space and must have the wget libraries installed.

Download the Backup Module from My Oracle Support to the backup module server.

1. Connect to the source EBS environment.

    SSH into the source EBS instance from your local machine by using the IP address and the SSH private key you used during the deployment of the source EBS instance. 

    ```
    <copy>
    ssh -i <private_ssh_key_filepath> opc@<Source_EBS__public_IP>
    </copy>
    ```

2. Change to the stage directory.

        <copy>
        cd /u01/install/APPS/stage
        </copy>

    ![](./images/21.png " ")

3. Copy the download link for the Backup Module. 

    Access the latest version of the Backup Module from My Oracle Support [Patch 31254259](https://updates.oracle.com/download/31254259.html). 

    Right click on the Download button and select **Copy link address**

4. Enter the wget command containing the patch name, your MyOracleSupport e-mail address, and the download link.

    Make sure to replace firstname.name@oracle.com with your MOS email address in this example: 

        wget --output-document=p31254259_R12_Generic.zip --http-user=<MOS_Email_Address> --ask-password '<download link>'
    
    Example:

        wget --output-document=p31254259_R12_Generic.zip --http-user=firstname.name@oracle.com --ask-password 'https://updates.oracle.com/Orion/Download/process_form/p31254259_R12_GENERIC.zip?file_id=109968332&aru=23539624&userid=O-firstname.name@example.com&email=firstname.name@example.com.com&patch_password=&patch_file=p31254259_R12_GENERIC.zip'

    Enter your MyOracleSupport account password when prompted. 

    ![](./images/22.png " ")

5. Extract the downloaded patch. Unzipping the patch zip file creates a directory named RemoteClone.

        <copy>
        unzip p31254259_R12_Generic.zip
        </copy>

    ![](./images/23.png " ")

6. Change to the RemoteClone directory and change the permission to "execute" for all the downloaded scripts.

        <copy>
        cd 31254259
        cd RemoteClone
        chmod +x *.pl
        chmod +x lib/*.sh
        </copy>

    ![](./images/24.png " ")
>>>>>>> upstream/master
  
You may proceed to the next lab.

## Learn More

<<<<<<< HEAD


=======
>>>>>>> upstream/master
* [Creating a Backup of an On-Premises Oracle E-Business Suite Instance on Oracle Cloud Infrastructure](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/creating_backup_of_ebs_instance_on_oci/101_backup_oci.html)
* [Requirements for Oracle E-Business Suite on Oracle Cloud Infrastructure (Doc ID 2438928.1)](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=97656525609392&id=2438928.1&_afrWindowMode=0&_adf.ctrl-state=1bsk4t5eng_4#S2)

## Acknowledgements

<<<<<<< HEAD
* **Author:** Quintin Hill, Cloud Engineering
* **Contributors:** 
  - Aurelian Baetu, Technology Engineering HUB - Cloud Infrastructure
  - Santiago Bastidas, Product Management Director
  - William Masdon, Cloud Engineering
  - Mitsu Mehta, Cloud Engineering
* **Last Updated By/Date:** William Masdon, Cloud Engineering, Nov 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section. 
=======
* **Author:** William Masdon, Cloud Engineering
* **Contributors:** 
    - Aurelian Baetu, Technology Engineering HUB - Cloud Infrastructure
    - Santiago Bastidas, Product Management Director
    - Quintin Hill, Cloud Engineering
* **Last Updated By/Date:** William Masdon, Cloud Engineering, Nov 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/ebs-on-oci-automation). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one. 
>>>>>>> upstream/master
