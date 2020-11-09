# Migrating an Oracle E-Business Suite environment to Oracle Cloud Infrastructure

## Introduction

In this lab we create a backup of an existing Oracle E-Business Suite instance on the Oracle Cloud Infrastructure Object Storage service.

The steps in this tutorial take approximately 45 minutes to perform, not including the time required for the Oracle E-Business Suite Cloud Backup Module to finish creating the backup, which lasts about 2 hours and 30 minutes when using the EBS 12.2.8 image from Marketplace as source.

Estimated Lab Time: 45 minutes

## Background

Creating a backup of your source Oracle E-Business Suite instance is the first part of a lift and shift process. You can subsequently complete the lift and shift process by using Oracle E-Business Suite Cloud Manager to provision an environment on Oracle Cloud Infrastructure based on the backup.

Note: Although this process is intended primarily for on-premises instances, you can also run the Oracle E-Business Suite Cloud Backup module to conduct a lift and shift in certain cases when the source environment is already in Oracle Cloud Infrastructure with optional database services. These cases include the following:
  - You initially used a manual procedure, such as a platform migration, to migrate an environment to Oracle Cloud Infrastructure, and now would like to leverage Oracle E-Business Suite Cloud Manager to manage that environment going forward.
  - You want to migrate your environment from one tenancy to another. The lift and shift process can be used for this purpose whether or not you are currently using Oracle E-Business Suite Cloud Manager.


### Objectives

In this lab, you will:

* Prepare the Source Oracle E-Business Suite Environment
* Install the Oracle E-Business Suite Cloud Backup Module
* Create a Backup with the Oracle E-Business Suite Cloud Backup Module

### Prerequisites

* Lab 1: Preparing Your Tenancy for Oracle E-Business Suite
* Lab 2: Oracle E-Business Suite Cloud Manager Deployment and Configuration
* A source **Oracle E-Business Suite 12.2.8** instance with DB 12.1.0 provisioned on OCI following the tutorial described here: [Provision a New Oracle E-Business Suite Installation on a Single Node on Oracle Cloud Infrastructure](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/provision_ebs_on_single_node_on_oci/index.html). (Including step 6 - Configure Web Entry Point with hostname **apps**)
* A MyOracleSupport account is needed to download the Cloud Backup tool to the source EBS environment.
* key-data.txt file documented with following information:

    * `Oracle_Cloud_Region_Identifier`
    * `Oracle_Cloud_Tenant_Name`
    * `Oracle_Cloud_Tenant_OCID`
    * `Cloud_Manager_Admin_OCID`
    * `Cloud_Manager_Admin_Fingerprint`
    * `Oracle_Cloud_Compartment_OCID`
    * `Cloud_Manager_Instance_public_IP`
    * `Source_EBS_Instance_public_IP`
    * `Source_EBS_Instance_private_IP`

## **STEP 1**: Prepare the Source Oracle E-Business Suite Environment. 
You will now copy the API Signing key from the Cloud Manager instance to the source Oracle E-Business Suite environment. If you would like to use a different API key for the Source EBS instance you can follow the steps in these short tutorials. See [How to Generate an API Signing Key](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#How), [How to Get the Key's Fingerprint](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#How3), and "To Upload an API Signing Key" in [Using the Console](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcredentials.htm#three).
Then you will create the stage area directories that will hold the backups and the Backup tool.
You will ensure SSH connectivity between all the nodes 
  - The Node where the Backup tool is deployed
  - Application Tier Node 
  - Database Tier Node

Finally, you will put the Database in Archive Mode before creating the backup.

1. Copy the private API signing key files from the Cloud Manager instance to the source Oracle E-Business Suite environment.
The key file must be placed in a location where it can be referenced by the Oracle E-Business Suite Cloud Backup Module. For example: /u01/install/APPS/.oci/

    a. Connect to your Oracle E-Business Suite Cloud Manager Compute instance that was created according to Lab 2: Oracle E-Business Suite Cloud Manager Deployment and Configuration. 
    To connect, follow the instructions under “Connecting to a Linux Instance”  in [Connecting to an Instance](https://docs.cloud.oracle.com/iaas/Content/Compute/Tasks/accessinginstance.htm).
    SSH into the Cloud Manager instance from your local machine by using the IP address in the ``key-data.txt`` file and the SSH private key you used during the deployment of the Cloud Manager in OCI or by using Putty on a Windows machine. 

        <copy>
        ssh -i <filepath_to_private_ssh_key> opc@<cloud_manager_public_ip>
        </copy>

    ![](./images/1.png " ")

    b. Read the private API key using the ``cat`` command and copy the private API key to your clipboard or in a text file on your desktop.

        <copy>
        sudo cat /u01/install/APPS/.oci/ebscm.admin@example.com.pem
        </copy>

    Select all the resulted characters to copy the key (make sure not to copy any spaces)
    Paste the key in a text file on your desktop 

    ![](./images/2.png " ")
  
    d. Connect to the source EBS environment. 
    To connect, follow the instructions under “Connecting to a Linux Instance”  in [Connecting to an Instance](https://docs.cloud.oracle.com/iaas/Content/Compute/Tasks/accessinginstance.htm).
    SSH into the source EBS instance from your local machine by using the IP address and the SSH private key you used during the deployment of the source EBS instance . 

        <copy>
        ssh -i <filepath_to_private_ssh_key> opc@<ebsvm_public_ip>
        </copy>

    ![](./images/3.png " ")

    e. Switch to the Oracle user in the source EBS instance

        <copy>
        sudo su - oracle
        </copy>

    ![](./images/4.png " ")

    f. Create a directory named **.oci**, create a .pem file named **ebscm.admin@example.com.pem** and change permissions to the file.

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

2. Create stage area directories for the Application tier and Database Tier.

These directories will hold:

  - Apps Stage Area directory - temporary files used during the application tier backup process as well as the application tier backup file in zip or tar format that is created locally before it is uploaded to Oracle Cloud Infrastructure Object Storage.
  - DB Stage Area directory - backup utilities and the temporary files used to process the backup.

        <copy>
        mkdir /u01/install/APPS/stage
        mkdir /u01/install/APPS/stage/appsStage
        mkdir /u01/install/APPS/stage/dbStage
        </copy>

![](./images/8.png " ")

3. Do the following to ensure that the Oracle E-Business Suite Cloud Backup Module can connect to all required nodes:
All nodes must have SSH enabled. 
In our case Application Tier Node, DB Tier Node and Backup module are on the same instance

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
    To save the file write **:wq** and press Enter

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
        
        <copy>
        ssh oracle@<ebsvm-private-ip>
        </copy>

    Choose yes to connect to the host

    ![](./images/13.png " ")

    g. After verifing the connection is established you can close it. 
        
        <copy>
        exit
        </copy>

    ![](./images/14.png " ")

4. The Database must be in **Archive Mode**

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

    c. Check weather the Database is in archive mode

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

## **STEP 2:** Install the Oracle E-Business Suite Cloud Backup Module

This section describes how to install the Oracle E-Business Suite Cloud Backup Module on the Linux server that you have chosen to use as the backup module server, which can be located either on-premises or in OCI Compute. It can be one of the Oracle E-Business Suite nodes or another server that resides in your intranet. The backup module server must have at least 500 MB of free space and must have the wget libraries installed.

Download the Backup Module from My Oracle Support to the backup module server.

1. Change to the stage directory

        <copy>
        cd /u01/install/APPS/stage
        </copy>

![](./images/21.png " ")

2. Copy the download link for the Backup Module. 
Access the latest version of the Backup Module from My Oracle Support [Patch 31254259](https://updates.oracle.com/download/31254259.html). Right click on the Download button and select **Copy link address**

3. Enter the wget command containing the patch name, your MyOracleSupport e-mail address and the download link.

    Make sure to replace firstname.name@oracle.com with your MOS email address in this example: 
        
        wget --output-document=p31254259_R12_Generic.zip --http-user=firstname.name@example.com --ask-password 'https://updates.oracle.com/Orion/Download/process_form/p31254259_R12_GENERIC.zip?file_id=109968332&aru=23539624&userid=O-firstname.name@example.com&email=firstname.name@example.com.com&patch_password=&patch_file=p31254259_R12_GENERIC.zip'

    Enter your MyOracleSupport account password

![](./images/22.png " ")

4. Extract the downloaded patch. Unzipping the patch zip file creates a directory named RemoteClone.

        <copy>
        unzip p31254259_R12_Generic.zip
        </copy>

![](./images/23.png " ")

5. Change to the RemoteClone directory and change the permission to "execute" for all the downloaded scripts.

        <copy>
        cd 31254259
        cd RemoteClone
        chmod +x *.pl
        chmod +x lib/*.sh
        </copy>

![](./images/24.png " ")

## **STEP 3:** Create a Backup with the Oracle E-Business Suite Cloud Backup Module

In this section, you will run the Oracle E-Business Suite Cloud Backup Module, EBSCloudBackup.pl, to create a backup of your on-premises Oracle E-Business Suite environment on Oracle Cloud Infrastructure Backup Service.

The EBSCloudBackup.pl script validates key requirements before beginning the actual backup, including checking the available space, checking connections, verifying that archive logging is enabled, and verifying that mandatory patches have been applied. Check that these requirements are in place before you start running the script, so that the script can proceed with creating the backup after performing the validations.

To ensure a successful backup, avoid activities that could interfere with the backup process while EBSCloudBackup.pl is running.

  - Do not apply patches. Note that this restriction applies not only to   - Oracle E-Business Suite patches, but to application technology stack and database patches as well. If you are running Oracle E-Business Suite Release 12.2, you must complete any active patching cycle before you begin the backup process.
  - Do not remove or move archive logs.
  - Do not shut down application tier or database tier services.
  - Do not perform configuration updates.

1. Before you start running EBSCloudBackup.pl, inform users that a backup is being taken, and request that they do not perform any destructive operation on the file system, such as removing directories, until the backup is complete.

2. Temporarily stop any application tier or database backup cron jobs that are scheduled.
If you have not already done so, change to the RemoteClone directory on the backup module server.

3. Run the EBSCloudBackup.pl script using the following command in the RemoteClone directory.
If you are using an Oracle E-Business Suite application tier node or database tier node as the backup module server, note that you should not source the Oracle E-Business Suite environment before running the Oracle E-Business Suite Cloud Backup Module.

        <copy>
        3pt/perl/bin/perl EBSCloudBackup.pl
        </copy>

![](./images/25.png " ")

4. On the first screen, choose option 1, Create E-Business Suite Backup and Upload to Oracle Cloud Infrastructure.

![](./images/26.png " ")

5. Next, indicate whether communication between the source database server and Oracle Cloud Infrastructure Object Storage takes place through a proxy and you need to specify the proxy details.
We are not going to use a proxy, choose option 2

![](./images/27.png " ")

6. Enter the details for the database tier of the source Oracle E-Business Suite environment.

When entering the host name for the source database server, ensure that you enter the fully qualified domain name.

You must specify an operating system user name with which to connect to the source database server using SSH. You can choose to authenticate the OS user with either a password, a custom private SSH key and passphrase, or the default SSH key ($HOME/.ssh/id_rsa) on the backup module server. The prompts for the custom private key and passphrase appear only if you do not enter an OS user password. 
**Do not enter a password or a custom private key.** The script indicates that the default SSH key will be used and prompts you to confirm that you want to continue with the SSH key at the indicated location.

Additionally, enter the location of the context file on the database tier, including the complete file path.

Specify whether Transparent Data Encryption (TDE) is enabled for the source database. If TDE is enabled, then you must also enter the password for the TDE wallet. **TDE is not enabled by default on the source EBS 12.2.8 image from the OCI Marketplace**

Finally, specify the location of the stage area directory you prepared to hold the temporary files that will be created on the database tier during the backup creation process.

        Enter Fully Qualified Hostname : **apps.example.com**
        OS User Name : **oracle**
        OS User Password [skip if not applicable] : Press Enter to skip
        OS User Custom Private Key [skip if not applicable] : Press Enter to skip     
        OS User Passphrase [skip if not applicable] : Press Enter to skip
        
        Context File : **/u01/install/APPS/12.1.0/appsutil/ebsdb_apps.xml**
        
        Database Transparent Data Encrypted ( TDE ): ( Yes | No ) : **No**

        You have not entered Password or Custom Private Key location
        We will be using default SSH key at /home/oracle/.ssh/id_rsa 	
        Do you want to continue (Yes | No) : **Yes**

        Validating the details...
        Stage Directory : **/u01/install/stage/dbStage**
        
![](./images/28.png " ")

7. Next, indicate whether communication between the source application tier and Oracle Cloud Infrastructure Object Storage takes place through a proxy and you need to specify the proxy details.
We are not going to use a proxy, choose option 2

![](./images/29.png " ")

8. When entering the host name for the source application tier server, ensure that you enter the fully qualified domain name.

You must specify an operating system user name with which to connect to the source application tier server using SSH. You can choose to authenticate the OS user with either a password, a custom private SSH key and passphrase, or the default SSH key ($HOME/.ssh/id_rsa) on the backup module server. The prompts for the custom private key and passphrase appear only if you do not enter an OS user password. 
**Do not enter a password or a custom private key.** The script indicates that the default SSH key will be used and prompts you to confirm that you want to continue with the SSH key at the indicated location.

Additionally, specify the location of the context file on the application tier, including the complete file path, the password for the Oracle E-Business Suite APPS schema, and the location of the stage area directory you created to hold the temporary files created on the application tier during the backup creation process.

For Oracle E-Business Suite Release 12.2 only, you must also specify the Oracle WebLogic Server administrator password for the source environment.

        Enter Fully Qualified Hostname : **apps.example.com**
        OS User Name : **oracle**
        OS User Password [skip if not applicable] : Press Enter to skip
        OS User Custom Private Key [skip if not applicable] : Press Enter to skip  
        OS User Passphrase [skip if not applicable] : Press Enter to skip

        Context File : **/u01/install/APPS/fs1/inst/apps/ebsdb_apps/appl/admin/ebsdb_apps.xml**

        APPS Password (example: **apps**) : password
        
        You have not entered Password or Custom Private Key location
        We will be using default SSH key at /home/oracle/.ssh/id_rsa 	
        Do you want to continue (Yes | No) : **Yes**

        Validating the details... 
        Stage Directory : **/u01/install/stage/appsStage**

        WebLogic Server Admin Password : **welcome1**
        
![](./images/30.png " ")

9. Enter details to specify how you want to create the backup on Oracle Cloud Infrastructure Object Storage.

    - Backup Identifier Tag - Enter a name to uniquely identify your backup. The script adds this tag as a prefix when creating the containers to store objects in a compartment within an Oracle Cloud Infrastructure Object Storage namespace, known as buckets. The generic bucket for the application tier and database tier Oracle home backup is named ``<Backup_Identifier_Tag>Generic``. The database bucket for the database RMAN backup is named ``<Backup_Identifier_Tag>DB``.
    - Backup Thread Count - Specify the number of threads used to upload the application tier and database tier file system backups. The default value is 1. If your CPU count is less than 8, then the maximum value for the backup thread count is 2 times the CPU count. If your CPU count is 8 or more, then the maximum value for the backup thread count is 1.5 times the CPU count.
    - Backup Archive Type - Specify tgz to compress the backups before the upload, or tar if you do not want to compress the backups. We recommend that you specify tgz.
    - RMAN Advanced Configuration Parameter File Path - If you created an advanced configuration parameter file in Section 4, then specify the directory path and file name for the file in this parameter. Otherwise, leave this parameter blank.
    - Backup Encryption Password - Specify a password to encrypt the application tier file system and database tier file system. If Transparent Data Encryption (TDE) is not enabled in the source database, then this password is also used to encrypt the database RMAN backup.
    - Confirm Backup Encryption Password - Re-enter the same backup encryption password to confirm it.

        ```
        Backup Identifier Tag                           : **EBS1228COMPUTE**
        Backup Thread Count                             : **4**
        Backup Archive Type ( tar | tgz )               : **tgz**
        RMAN Advanced Configuration Parameter File Path : Press Enter to skip
        Backup Encryption Password                      : **password**
        Confirm Backup Encryption Password              : **password**

![](./images/31.png " ")

10. Next, indicate whether you access the cloud service through a proxy and need to specify the proxy details.
We are not going to use a proxy, choose option 2

![](./images/32.png " ")

11. Enter your Oracle Cloud Infrastructure details.

    - The user who performs the backup must be a member of the Oracle E-Business Suite administrators group defined according to Lab 2: Oracle E-Business Suite Cloud Manager Deployment and Configuration.
    In this workshop the user is **ebscm.admin@example.com**
    - Enter the OCID for your tenancy, the [region identifier](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm) of the region where you plan to provision an environment from this backup, your tenancy name, and the OCID of the compartment where the backup buckets should be created.

    For environments with Oracle Database Release 12.1.0.2 or Release 19c, you must also specify the Cloud database service on which you plan to provision the target environment based on this backup.

    - For a Compute VM, enter Compute.
    - For 1-Node VM DB System (Single Instance) or 2-Node VM DB System (Oracle RAC), enter VM DB System.
    - For Exadata DB System, enter Exadata DB System.

        ```
        Oracle Cloud User OCID : **ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx**
        Oracle Cloud Fingerprint : **xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx**
        Oracle Cloud User Private Key Path on Database Tier : **/u01/install/APPS/.oci/ebscm.admin@example.com.pem**
        Oracle Cloud User Private Key Path on APPS Tier : **/u01/install/APPS/.oci/ebscm.admin@example.com.pem**
        Oracle Cloud Tenancy OCID : **ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx**
        Oracle Cloud Region : **xx-xxxxxx-1**
        Oracle Cloud Tenant Name : **xxxxxxx**
        Oracle Cloud Compartment OCID : **ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx**

        Target Database Type - (Compute | VM DB System | Exadata DB System ): **Compute**

![](./images/33.png " ")

12. Review the values specified for the backup creation. The mode is set automatically based on your database release and target database type.
    - BMCS - Environments with Oracle Database Release 11.2.0.4, or environments with Oracle Database Release 12.1.0.2 or 19c where the target database service is Compute
    - BMCS_CDB - Environments with Oracle Database Release 12.1.0.2 or 19c where the target database service is Virtual Machine DB System or Exadata DB System
The custom private key locations for the source database tier and source application tier are shown only if you chose to authenticate the OS user on those tiers with a custom private SSH key.

If you are satisfied with the values shown, enter option 1 to proceed.

![](./images/34.png " ")

**Note:** Do not close the SSH connection until the backup is completed. 

The script performs the following tasks:

  - Validates OS level authentications.
  - Validates whether the Oracle Database version is certified.
  - Validates whether the database is archivelog enabled.
  - Validates whether mandatory patches are present.
  - Creates a database backup.
  - Executes remote calls to the application tier to create a tar package containing the application files. 
    For Oracle E-Business Suite Release 12.2, the tar package includes the contents of the EBSapps directory on the run file system, including the APPL_TOP directory, the COMMON_TOP directory, the OracleAS 10.1.2 directory, and a packaged version of the Oracle Fusion Middleware home. For Oracle E-Business Suite Release 12.1.3, the tar package includes the contents of the APPL_TOP, COMMON_TOP, OracleAS 10.1.2, and OracleAS 10.1.3 directories.
  - Transfers the application tier tar package and database backup to a new bucket in your Oracle Cloud Infrastructure Backup Service account associated with your Oracle Cloud Infrastructure tenancy.

If the script indicates that a validation failed, you can review the log files in the RemoteClone/logs directory to help identify which value failed validation.

13. After the script finishes and the backup is complete, you should notify users that they can resume normal file system activities. You should also restart any application tier or database backup cron jobs that you stopped before you began running the script, and resume patching and maintenance activities as needed.

![](./images/35.png " ")

14. You can use Oracle E-Business Suite Cloud Manager to provision an environment on Oracle Cloud Infrastructure based on the backup you created. 
See [Using Advanced Provisioning in Oracle E-Business Suite Cloud Manager on Oracle Cloud Infrastructure](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/advanced_provisioning_in_ebs_cloud_manager_on_oci/104advprov.html).

![](./images/36.png " ")

  
You may proceed to the next lab.

## Learn More



* [Creating a Backup of an On-Premises Oracle E-Business Suite Instance on Oracle Cloud Infrastructure](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/creating_backup_of_ebs_instance_on_oci/101_backup_oci.html)
* [Requirements for Oracle E-Business Suite on Oracle Cloud Infrastructure (Doc ID 2438928.1)](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=97656525609392&id=2438928.1&_afrWindowMode=0&_adf.ctrl-state=1bsk4t5eng_4#S2)

## Acknowledgements

* **Author:** Quintin Hill, Cloud Engineering
* **Contributors:** 
  - Aurelian Baetu, Technology Engineering HUB - Cloud Infrastructure
  - Santiago Bastidas, Product Management Director
  - William Masdon, Cloud Engineering
  - Mitsu Mehta, Cloud Engineering
* **Last Updated By/Date:** Quintin Hill, Cloud Engineering, Sept 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section. 
