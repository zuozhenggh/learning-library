
# Install Oracle Database 19c with Automatic Configuration Script Execution

## Introduction

When you install and configure Oracle Database, certain operations must be performed by the `root` user. Starting with Oracle Database 19c, the Oracle Universal Installer includes options for automatically running the configuration scripts. You can choose to run them as the `root` user, which requires you to know the `root` user password. Or, you can choose to run the scripts as a sudo user (password is also required), which gives the specified user root permissions when running the scripts.

Setting up permissions for configuration scripts to run without user intervention can simplify database installation and help avoid inadvertent permission errors. If you prefer, you can still choose to run the scripts manually, like you would do for an Oracle Database 18c installation.

This lab shows you how to install Oracle Database 19c with the new option to run configuration scripts automatically with an `oracle` sudo user. You also examine the response file after you complete the installation as well as the resulting container database (CDB) and pluggable database (PDB).


Estimated Lab Time: 30 minutes

### Objectives

In this lab, you learn how to do the following:

- Stage the Oracle Database 19c ZIP file installer in object storage in Oracle Cloud Infrastructure
- Run the Oracle Database Preinstaller
- Create an `oracle` user account and two groups (`dba` and `oinstall`) on your compute instance
- Allow the `oracle` user to perform any operation as `root`
- Create the Oracle base and Oracle inventory directories
- Download the Oracle Database 19c installation ZIP file to a `stage` directory on your compute instance
- Create an OFA-compliant Oracle home directory and extract the Oracle Database 19c installation ZIP file into that directory
- Install the database software by using the Oracle Database Setup Wizard
- Review the response file
- Discover the container database (CDB) and pluggable database (PDB)


### Prerequisites

- You have an Oracle Cloud account. You can use the account you created when you signed up for a free trial, one that was given to you through your own organization, or one provided to you by LiveLabs.
- You have a compartment in Oracle Cloud Infrastructure.
- Windows users: You have PuTTY installed on your local computer.
- You created a compute instance in Oracle Cloud Infrastructure that can support Oracle Database 19c. If not, see [Create Compute Instance](?lab=create-compute-instance).


## **STEP 1**: Stage the Oracle Database 19c installation ZIP file in object storage in Oracle Cloud Infrastructure

1. In a browser on your local machine, access `https://www.oracle.com/database/technologies/oracle-database-software-downloads.html#19c`.

2. Scroll down to **Linux x86-64** and click the **ZIP** link (2.8GB).

3. In the dialog box, select the **I reviewed and accept the Oracle License Agreement** check box.

4. Click the **Download LINUX.X64_193000_db_home.zip** button, and download the file to your browser's download directory.

5. From the Oracle Cloud Infrastructure navigation menu, select **Object Storage**, and then **Object Storage**. The **Objects Storage** page is displayed.

6. On the right, click **Create Bucket**. The **Create Bucket** dialog box is displayed.

7. Leave the default values as is, and click **Create**.

8. Click the name of your bucket, and then scroll down to the **Object** section.

9. Click **Upload**. The **Upload Objects** dialog box is displayed.

10. In the **Choose Files from your Computer** area, click **select files**. The **File Upload** dialog box is displayed.

11. Browse to and select your Oracle Database 19c install ZIP file, and then click **Open**. The install ZIP file for Oracle Database 19.3 is 2.86 GB.

12. Click **Upload**.

13. Wait for the upload to finish. It takes about 15 minutes.

14. Click the three dots in the object storage table for your ZIP file, and select **Create Pre-Authentication Request**. The **Create Pre-Authentication Request** dialog box is displayed.

15. In the **Expiration** field, click the calendar icon, and set a date in the future for the pre-authentication request to end.

16. Leave the other settings as is to permit reads on the object, and click **Create Pre-Authentication Request**. The **Pre-Authenticated Request Details** dialog box is displayed.

17. Copy the pre-authenticated request URL to the clipboard. You can use the copy button.

18. Paste the url into a text editor, such as Notepad, where you can access it later.

19. Click **Close**.



## **STEP 2**: Run the Oracle Database Preinstaller

You can complete most preinstallation configuration tasks by using the Oracle Database preinstaller.

Execute the following command to run the preinstaller:

    ```nohighlighting
    # <copy>yum install oracle-database-preinstall-19c</copy>
    ```



## **STEP 3**: Create an `oracle` user account and two groups (dba and oinstall) on your compute instance

You need to create an Oracle installation user account (`oracle`) that will own the installation software binaries.

1. On the toolbar in Oracle Cloud Infrastructure, click the **Cloud Shell** icon to open Cloud Shell.

2. Connect to your compute instance. In the command below, replace `private-key-file-name` with the name of your own private key file. Replace `public-ip-address` with the public IP address of your compute instance.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/private-key-file-name opc@public-ip-address</copy>
    ```

3. Switch to the `root` user.

    ```nohighlighting
    $ <copy>sudo su -</copy>
    ```
4. Create a `dba` group, `oinstall` group, and an `oracle` user account. Add `oracle` to both the `oinstall` and `dba` groups.

    ```nohighlighting
    # <copy>groupadd dba</copy>
    # <copy>groupadd oinstall</copy>
    # <copy>useradd -m -g oinstall -g dba oracle</copy>
    ```

5. Set the password for the `oracle` user. You are prompted to enter and confirm a password.

    ```nohighlighting
    # <copy>passwd oracle</copy>
    ```



## **STEP 4**: Allow the `oracle` user to perform any operation as `root`

During installation, you specify the `oracle` user as a sudo user so that the installer can run configuration scripts as the `oracle` user. This step gives the `oracle` user root permission without the need for them to know the root password. Sudoers must be edited by running `visudo`.

1. Run `visudo`.

    ```nohighlighting
    <copy>sudo visudo</copy>
    ```

2. Insert the following line after the `root    ALL=(ALL)       ALL` line:

    ```nohighlighting
    <copy>oracle  ALL=(root)      ALL</copy>
    ```

    Tip: Press **i** to insert text.

3. Save the changes.

  Tip: To save, press **Esc**, enter **:wq**, and then press **Enter.




## **STEP 5**: Create the Oracle base and Oracle inventory directories

Still as the `root` user, create the **Oracle base** and **Oracle inventory** directories as per the Oracle Optimal Flexible Architecture (OFA) recommendations. Also specify the owner, group, and permissions for these directories. All files in Linux belong to an owner and a group.

1. Create the **Oracle base** and **Oracle inventory** directories.

    ```nohighlighting
    # <copy>mkdir -p /u01/app/oracle</copy>
    # <copy>mkdir -p /u01/app/oraInventory</copy>
    ```

2. Specify `oracle` as the owner and `oinstall` as the group for the Oracle base and Oracle inventory directories.

    ```nohighlighting
    # <copy>chown -R oracle:oinstall /u01/app/oracle</copy>
    # <copy>chown -R oracle:oinstall /u01/app/oraInventory</copy>
    ```
3. Set the permissions on the `/u01/app` directory and all if its subdirectories (which includes the Oracle base and Oracle inventory directories) so that the owner and group can read, write, and execute on the directories.

    ```nohighlighting
    # <copy>chmod -R 775 /u01/app</copy>
    ```




## **STEP 6**: Download the Oracle Database 19c installation ZIP file to a stage directory on your compute instance

In an earlier step, you uploaded the Oracle Database 19c installation ZIP file to object storage in Oracle Cloud Infrastructure. In this step, you download it to your compute instance.


1. Continuing as the `root` user, create a `/stage` directory to store the Oracle Database 19c installation ZIP file and grant the `oracle` user read, write, and execute permissions on it.

    ```nohighlighting
    # <copy>mkdir -p /stage</copy>
    # <copy>chown -R oracle:oinstall /stage</copy>
    ```

2. Change the current user to `oracle`.

    ```nohighlighting
    $ <copy>su - oracle</copy>
    ```

3. Use the `wget` command to download the Oracle Database 19c installation ZIP file from object storage to the `stage` directory. In the command below, replace `url-ZIP-file` with the url to the Oracle Database 19c ZIP file in your own object storage.

    ```nohighlighting
    $ <copy>wget url-ZIP-file -P /stage</copy>
    ```

REVIWER: This is here temporarily for Jody's testing purposes:
wget https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/m3rTsRbg5ofiqEWJtqo-pfR18VVngF_8oq-KtroohAvQ_rZ1Gsw03QarPuR9O2v4/n/frmwj0cqbupb/b/bucket-20210401-1123/o/LINUX.X64_193000_db_home.zip -P /stage*

4. Change to the `stage` directory and verify that the Oracle Database 19c installation ZIP file is there.

    ```nohighlighting
    $ <copy>cd /stage </copy>
    $ <copy>ls</copy>
    ```


## **STEP 7**: Create an OFA-compliant Oracle home directory and extract the Oracle Database 19c installation ZIP file into that directory

It's important that the Oracle home directory is in compliance with the Oracle Optimal Flexible Architecture recommendations. Make sure that the current user is still `oracle`.  

1. As the `oracle` user, create an **Oracle home** directory and change to that directory.

    ```nohighlighting
    $ <copy>mkdir -p /u01/app/oracle/product/19.10.0/dbhome_1</copy>
    $ <copy>cd /u01/app/oracle/product/19.10.0/dbhome_1</copy>
    ```

2. Extract the Oracle Database 19c installation ZIP file from the `stage` directory into the Oracle home directory.

    ```nohighlighting
    $ <copy>unzip -q /stage/LINUX.X64_193000_db_home.zip</copy>
    ```

3. List the files. You should have several directories and files.

    ```nohighlighting
    $ <copy>ls</copy>
    ```

4. Exit Cloud Shell.






## **STEP 8**: Install the database software by using the Oracle Database Setup Wizard

### Windows 10

If you are running Windows on your personal computer, you can connect to your compute instance with PuTTY. The following steps show you how to install Oracle Database 19c using the Oracle Database Setup Wizard. During installation, choose to automatically run the configuration scripts (*new feature!*) as the sudo `oracle` user.

1. Open PuTTY and connect to your compute instance as the `opc` user using X forwarding. In the  
[Create Compute Instance](?lab=create-compute-instance) lab, you saved a connection configuration in PuTTY that you can load here to connect quickly.

2. As the `opc` user, copy the Xauthority file from the `opc` user to the `oracle` user so that `oracle` can display the graphical user interface of the Oracle Database 19c installer.

    ```nohighlighting
    $ <copy>sudo cp ~/.Xauthority /home/oracle/.Xauthority</copy>
    ```

3. Switch to the `oracle` user and enter the password.

    ```nohighlighting
    $ <copy>su - oracle</copy>
    ```
4. Change to the Oracle home directory.

    ```nohighlighting
    $ <copy>cd /u01/app/oracle/product/19.10.0/dbhome_1</copy>
    ```
5. Launch the Oracle Database 19c installer. It's important that you run the `runInstaller` command from the Oracle home directory only.

    ```nohighlighting
    <copy>./runInstaller</copy>
    ```

6. On the **Select Configuration Option** page, leave **Create and configure a single instance database** selected, and click **Next**. This option creates a starter database with one container database (CDB) and one pluggable database (PDB).

7. On the **Select System Class** page, leave **Desktop Class** selected, and click **Next**.

8. On the **Typical Installation** page, leave the default entries as is. For the **Password** and **Confirm password** boxes, enter a password for the database `admin` user. Make note of this password as you will need it later. The name of the pluggable database is `orclpdb`. Click **Next**.

9. On the **Create Inventory** page, leave the default settings as is, and click **Next**.

10. On the **Root script execution** page, select the **Automatically run configuration scripts** check box. Select **Use sudo**, and enter the password for the `oracle` user. Click **Next**.

  *This is the new feature that this lab is all about!*

11. On the **Prerequisite Checks** page, wait for the installer to verify that your environment meets the minimum installation and configuration requirements.

12. On the **Summary** page, save the response file so that you can later review how the configuration scripts get automatically executed. To do that, follow these steps:

  a) Click **Save Response File**. The **Save Response File** dialog box is displayed.

  b) Browse to and select the `/tmp` directory.

  c) Leave **db.rsp** as the name, and click **Save**.

13. Click **Install** to begin installing the software.

14. On the **Install Product** page, monitor the progress of the steps being executed.

15. When prompted to run the configuration scripts as the privileged user, click **Yes** to continue. The installation takes about 15 minutes.

  ![Installation message](images/install-message.png)

16. On the **Finish** page, click **Close**. The installation is finished.



## **STEP 9**: Review the Response File

1. Change to the response file directory.

    ```nohighlighting
    $ <copy>cd /tmp</copy>
    ```
2. Review the response file (`db.rsp`).

    ```nohighlighting
    $ <copy>cat db.rsp</copy>

    The response file for this session can be found at:
    /u01/app/oracle/product/19.10.0/dbhome_1/install/response/db_2021-04-08_07-28-08PM.rsp

    You can find the log of this install session at:
   /tmp/InstallActions2021-04-08_07-28-08PM/installActions2021-04-08_07-28-08PM.log
    Moved the install session logs to:
 /u01/app/oraInventory/logs/InstallActions2021-04-08_07-28-08PM
    ...
    ```



## **STEP 10**: Discover the container database (CDB) and pluggable database (PDB)

1. Set the Oracle environment variables. You need to set these each time you open a new terminal window and want to access your database.

  a) List the search path that holds the `oraenv` script.

    ```nohighlighting
    $ <copy>which oraenv</copy>

    /usr/local/bin/oraenv
    $
    ```

  b) Source the `oraenv` script. The dot in the `. oraenv` command means to do a source operation. `oraenv` sets the required environment variables needed for you to connect to your database instance. For example, it sets the  `ORACLE_SID` and `ORACLE_HOME` environment variables and includes the `$ORACLE_HOME/bin` directory in the  `PATH` environment variable setting. Environment variables that this script sets will persist in the terminal window until you close it. Don't forget to put a space after the dot. For the `ORACLE_SID` value, enter `orcl` (in lowercase). For `ORACLE_HOME`, enter `/u01/app/oracle/product/19.10.0/dbhome_1`.

    ```nohighlighting
    $ <copy>. oraenv</copy>

    ORACLE_SID = [oracle] ? <copy>orcl</copy>
    ORACLE_HOME = [/home/oracle] ? <copy>/u01/app/oracle/product/19.10.0/dbhome_1</copy>

    The Oracle base has been set to /u01/app/oracle
    $
    ```

2. View the environment variables set by the `. oraenv` command that you just ran.

    ```nohighlighting
    $ <copy>set | grep ORACLE</copy>

    OLD_ORACLE_BASE=
    ORACLE_BASE=/u01/app/oracle
    ORACLE_HOME=/u01/app/oracle/product/19.10.0/dbhome_1
    ORACLE_SID=orcl
    $
    ```


3. Using SQLPlus, connect to the `root` container of your database. SQL*Plus is an interactive and batch query tool that is installed with every Oracle Database installation.

    ```nohighlighting
    $ <copy>sqlplus / as sysdba</copy>

    SQL*Plus: Release 19.0.0.0.0 - Production on Thu Apr 8 21:08:02 2021
    Version 19.3.0.0.0

    Copyright (c) 1982, 2019, Oracle. All rights reserved.

    Connected to an idle instance.

    SQL>
    ```


4. Verify that you are logged in to the `root` container as the `SYS` user.

    ```nohighlighting
    SQL> <copy>SHOW user</copy>

    USER is "SYS"
    SQL>
    ```

5. Find the current container name. Because you're currently connected to the `root` container, the name should be `CDB$ROOT`.

    ```nohighlighting
    SQL> <copy>SHOW con_name</copy>

    CON_NAME
    -------------------
    CDB$ROOT
    SQL>
    ```

6. List all of the containers in the CDB by querying the `V$CONTAINERS` view. The results should list three containers - the `root` container (`CDB$ROOT`), the seed PDB (`PDB$SEED`), and the pluggable database (`ORCLPDB`).

    ```nohighlighting
    SQL> <copy>COLUMN name FORMAT A8</copy>
    SQL> <copy>SELECT name, con_id FROM v$containers ORDER BY con_id;</copy>

    NAME         CON_ID
    -------- ----------
    CDB$ROOT          1
    PDB$SEED          2
    ORCLPDB           3
    SQL>
    ```

7. Exit SQL*Plus.

    ```nohighlighting
    $ <copy>EXIT</copy>
    ```

Congratulations! You have a fully functional Oracle Database 19c instance running on a compute instance in Oracle Cloud Infrastructure.



## Learn More

- [Get Started with Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/)
- [Install and Upgrade to Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/install-and-upgrade.html)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Technical Contributors** - James Spiller, Principal User Assistance Developer, Database Development; Dragos Negru, Principal Cloud Specialist - Data Management, TE Hub
- **Last Updated By/Date** - Jody Glover, Database team, April 9 2021
