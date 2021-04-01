# Set Up a Compute Instance

## Introduction
This lab shows you how to quickly create a compute instance, virtual cloud network, and SSH keys for yourself in Oracle Cloud Infrastructure. You use Cloud Shell, which is a free Linux shell (within monthly tenancy limits) to access and run commands on your compute instance. You use Object Storage to store the Oracle Database 19c installation ZIP file.

Estimated Lab Time:  25 minutes


### Objectives

- Create a VM instance
- Upload your private key to your Cloud Shell machine
- Connect to your compute instance from your Cloud Shell machine
- Download the Oracle Database 19c installation ZIP file to your local computer
- Upload the Oracle Database 19c installation ZIP file to object storage in Oracle Cloud Infrastructure


### Prerequisites

- You have an Oracle Cloud account. You can use the account you created when you signed up for a free trial, one that was given to you through your own organization, or one provided to you by LiveLabs.
- You have a compartment in which you can create a compute instance

## **STEP 1**: Create a VM instance

1. On the **Home** page in Oracle Cloud Infrastructure, under **Quick Actions**, click **Create a VM instance**.

  The **Create Compute Instance** page is displayed.

2. For **Name**, enter a name for your instance; for example, **computeinstance1**.

3. For **Create in compartment**, select the compartment that you created or was provided to you.

4. For **Placement**, leave as is. Oracle automatically chooses an availability domain for you, sets the capacity type to **On-demand capacity**, and chooses the best fault domain for you.

5. For **Image and shape**, do the following:

  a) Click **Edit**.

  b) Leave **Oracle Linux 7.9** selected as the image build.

  c) Click **Change Shape**. In the **Browse All Shapes** window, scroll down and select **VM.Standard.E2.4**. Click **Select Shape**. This shape has enough memory to run the database 19c binaries.

6. For In **Networking**, leave the default values as is. Oracle provides a default VCN and subnet name and assigns your compute instance a public IPv4 address so that you can access it from the internet. *Make note of your public IP address.*

7. For **Add SSH keys**, do the following:

  a) Leave **Generate SSH key pair** selected.

  b) *IMPORTANT!* Click **Save Private Key**. Download and save the private key to a local directory so that you can later connect to your instance using SSH. It's helpful to have a directory on your computer to store keys, for example, `C:/oracle/keys`.

8. For **Boot** volume, do not select any of the options.

9. Click **Create**.

  Oracle Cloud Infrastructure provisions your compute instance in less than a minute. During provisioning, your compute instance's page is displayed. Here you can view general information, instance details, shape configuration, instance access, primary vnic, and launch options.

10. Wait for the status of the compute instance to be set to **RUNNING**.


## **STEP 2**: Upload your private key to your Cloud Shell machine

Your private key needs to reside in the `.ssh` directory on your Cloud Shell machine. The `.ssh` directory already exists on your machine so you do not need to create it.

1. On the toolbar, click the **Cloud Shell** icon. A Cloud Shell machine is created for you. Wait for the prompt to be displayed.

2. From the Cloud Shell menu, select **Upload**. The **File Upload to your Home Directory** dialog box is displayed.

3. Click "select from your computer". Browse to and select your private key file, and then click **Open**. Click **Upload**. The private key is uploaded to the `home` directory on your Cloud Shell machine.

4. Move your private key to the `.ssh` directory. In the code below, replace `private-key-filename` with your own private key file name.

    ```
    <copy>mv <private-key-filename> .ssh</copy>
    ```

5. Set permissions on the `.ssh` directory so that only you (the owner) can read, write, and execute on the directory.

    ```
    <copy>chmod 700 ~/.ssh</copy>
    ```

6. Change to the `.ssh` directory

    ```
    <copy>cd .ssh</copy>
    ```

7. Set permissions on the private key so that only you (the owner) can read and write (but not execute) on the private key file.

    ```
    <copy>chmod 600 *</copy>
    ```


## **STEP 3**: Connect to your compute instance from your Cloud Shell machine

1. Use the `ssh` command to connect to your compute instance. The following command assumes that you are still in the `.ssh` directory on the Cloud Shell machine. You receive a message stating that the authenticity of the host can't be established.

    ```
    ssh -i ssh-key-2021-04-01.key opc@193.122.62.167
    ```
2. At the prompt to continue, enter **yes** to continue. The public IP address is added to the list of known hosts.

3. Verify that the terminal prompt now reads `[opc@computeinstance1 ~]$`. `opc` is your user account on your compute instance.


## **STEP 4**: Download the Oracle Database 19c installation ZIP file to your local computer

1. In a browser, access https://www.oracle.com/database/technologies/oracle-database-software-downloads.html#19c.

2. Scroll down to **Linux x86-64** and click the ZIP link (2.8GB).

3. In the dialog box, select the **I reviewed and accept the Oracle License Agreement** check box.

4. Click the **Download LINUX.X64_193000_db_home.zip** button, and download the file to your browser's download directory.


## **STEP 5**: Upload the Oracle Database 19c installation ZIP file to object storage in Oracle Cloud Infrastructure

1. From the Oracle Cloud Infrastructure navigation menu, select **Object Storage**, and then **Object Storage**. The **Objects Storage** page is displayed.

2. On the right, click **Create Bucket**. The **Create Bucket** dialog box is displayed.

3. Leave the default values as is, and click **Create**.

4. Click the name of your bucket, and then scroll down to the **Object** section.

5. Click **Upload**. The **Upload Objects** dialog box is displayed.

6. In the **Choose Files from your Computer** area, click **select files**. The **File Upload** dialog box is displayed.

7. Browse to and select your Oracle Database 19c install ZIP file, and then click **Open**. The install ZIP file for Oracle Database 19.3 is 2.86 GB.

8. Click **Upload**.

9. Wait for the upload to finish. It takes about 15 minutes.

10. Click the three dots in the object storage table for your ZIP file, and select **Create Pre-Authentication Request**. The **Create Pre-Authentication Request** dialog box is displayed.

11. Leave the default settings as is to permit default reads on the object, and click **Create Pre-Authentication Request**. The **Pre-Authenticated Request Details** dialog box is displayed.

12. Copy the pre-authenticated request URL to the clipboard. You can use the copy button to do so.

13. Paste the url into a text editor like Notepad where you can access it later.

13. Click **Close**.

You can now [proceed to the next lab](#next).


## Learn More

- [Get Started with Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/)
- [Install and Upgrade to Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/install-and-upgrade.html)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Technical Contributor** - James Spiller, Principal User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, April 1 2021
