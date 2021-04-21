# Access Your LiveLabs Compute Instances

## Introduction
This lab shows you how to access the compute instance and Oracle database that LiveLabs provides for you. You can perform most of the steps in this lab by using Cloud Shell. Cloud Shell is a small virtual machine running a Bash shell, which you can access through the OCI console.

Estimated Lab Time: 10 minutes

### Objectives
In this lab, you learn how to do the following:
- Obtain the public IP address of your compute instance
- Confirm your Oracle Database 19c is up and running

### Prerequisites

- You have a LiveLabs Cloud account and assigned compartment.
- You have a valid SSH private key. You are provided this key when you register for this workshop.

## **STEP 1**: Obtain the public IP address of your compute instance

1. Sign in to Oracle Cloud Infrastructure using your **LiveLabs Cloud account** credentials.

2. From the navigation menu, select **Compute**, and then **Instances**.

3. Select the compartment that is assigned to you by LiveLabs.

4. Find the instance that is created for you by LiveLabs and jot down its public IP address.

    *REVIEWER: Can we create the instance with the name Workshop?*

   ![Create a stack](images/workshop-012.png)



## **STEP 2**: Connect to your compute instance from your Cloud Shell machine

To connect to your compute instance using Cloud Shell, you need to add your private key to an `.ssh` directory on your Cloud Shell machine. You only need to add your private key once (step 2 below). After your private key is in its proper place, you can simply SSH to connect in future sessions (step 4 below).

1. On the toolbar in Oracle Cloud Infrastructure, click the **Cloud Shell** icon to open the Cloud Shell window, and wait for a terminal prompt to be displayed.

 ![Cloud Shell icon](images/cloud-shell-icon.png)

2. Upload your private key to the `.ssh` directory on your Cloud Shell machine.

  a) From the **Cloud Shell** menu, select **Upload**. The **File Upload to your Home Directory** dialog box is displayed.

  b) Click **select from your computer**. Browse to and select your private key file, and then click **Open**. Click **Upload**. Your private key is uploaded to the `home` directory on your Cloud Shell machine.

  c) Create an `.ssh` directory in the `home` directory, if one does not exist.

    ```nohighlighting
    $ <copy>mkdir ~/.ssh/</copy>
    ```

  d) Move your private key to the `.ssh` directory. In the code below, replace `private-key-filename` with the name of own private key file. Be sure to include the slash (/) after .ssh in the command to ensure that the file gets moved to a directory.

    ```nohighlighting
    $ <copy>mv private-key-filename.key .ssh/</copy>
    ```

  e) Set permissions on the `.ssh` directory so that only you (the owner) can read, write, and execute on the directory. Also set permissions on the private key itself so that only you (the owner) can read and write (but not execute) on the private key file.

    ```nohighlighting

    $ <copy>chmod 700 ~/.ssh</copy>
    $ <copy>cd .ssh</copy>
    $ <copy>chmod 600 *</copy>
    ```

3. Enter the following `ssh` command to connect to your compute instance, replacing `private-key-file` and `public-ip-address` with your own values.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/private-key-file.key opc@public-ip-address</copy>
    ```

    You receive a message stating that the authenticity of your compute instance can't be established. Do you want to continue connecting?

4. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  The terminal prompt becomes `[opc@compute-instance-name ~]$`, where `compute-instance-name` is the name of your compute instance and `opc` is your user account on your compute instance. You are now connected to your new compute instance.

  *REVIEWER: Can we create the instance with the name Workshop?*

































































## **STEP 3**: Verify the ORCL database is up

Once you deploy your compute instance, tail the log to determine when the database has been configured and is available for use.
1. Run the following command to verify the database with the SID **ORCL** is up and running.

    ````
    <copy>
    ps -ef | grep ORCL
    </copy>
    ````
    ![](./images/pseforcl.png " ")

2. Verify the listener is running
    ````
    <copy>
    ps -ef | grep tns
    </copy>
    ````

    ![](./images/pseftns.png " ")

3. Switch to the oracle user.
      ````
    <copy>
    sudo su - oracle
    </copy>
    ````

    ![](./images/sudo-oracle.png " ")

4.  Set the environment variables to point to the Oracle binaries.  When prompted for the SID (Oracle Database System Identifier), enter **ORCL**.
    ````
    <copy>
    . oraenv
    </copy>
    ORCL
    ````
    ![](./images/oraenv.png " ")

5.  Login using SQL*Plus as the **oracle** user.  

    ````
    <copy>
    sqlplus system/Ora_DB4U@localhost:1521/orclpdb
    </copy>
    ````
    ![](./images/sqlplus.png " ")
*Note:  If you encounter any errors with this step, please see the Troubleshooting Tips in the appendix.

## **STEP 4**: Exit SQLPLUS
1.  Exit the sqlplus session.

    ````
    SQL> <copy>exit</copy>
    ````
2. Type exit again to *switch back to the opc user*.

    ```
    <copy>exit</copy>
    ```

3. Verify that you are now the **opc** user using the *whoami* command.  

    ```
    <copy>
    whoami
    </copy>
    ```

    ![](./images/whoami.png " ")

You may now *proceed to the next lab*.  


## Appendix: Troubleshooting Tips

If you encountered any issues during the lab, follow the steps below to resolve them.  If you are unable to resolve, please skip to the **Need Help** section to submit your issue via our  support forum.
1. Can't login to instance
2. Invalid public key
3. Limits Exceeded
4. Database Creation stuck at 3x %
5. Apply job is stuck in provisioning state

### Issue 1: Can't login to instance
Participant is unable to login to instance

#### Tips for fixing Issue #1
There may be several reasons why you can't login to the instance.  Here are some common ones we've seen from workshop participants
- Incorrectly formatted ssh key (see above for fix)
- User chose to login from MAC Terminal, Putty, etc and the instance is being blocked by company VPN (shut down VPNs and try to access or use Cloud Shell)
- Incorrect name supplied for ssh key (Do not use sshkeyname, use the key name you provided)
- @ placed before opc user (Remove @ sign and login using the format above)
- Make sure you are the oracle user (type the command *whoami* to check, if not type *sudo su - oracle* to switch to the oracle user)
- Make sure the instance is running (type the command *ps -ef | grep oracle* to see if the oracle processes are running)


### Issue 2: Invalid public key
![](images/invalid-ssh-key.png  " ")

#### Issue #2 Description
When creating your SSH Key, if the key is invalid the compute instance stack creation will throw an error.

#### Tips for fixing for Issue #2
- Go back to the registration page, delete your registration and recreate it ensuring you create and **copy/paste** your *.pub key into the registration page correctly.
- Ensure you pasted the *.pub file into the window.


## Acknowledgements
- **Author** - Kay Malcolm, DB Product Management
- **Contributors** - Robert Pastijn, DB Product Management, PTS
- **Last Updated By/Date** - Kay Malcolm, August 2020
