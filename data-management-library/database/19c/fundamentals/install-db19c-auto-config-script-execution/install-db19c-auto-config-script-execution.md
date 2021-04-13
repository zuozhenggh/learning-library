
# Install Oracle Database 19c with Automatic Configuration Script Execution

## Introduction

When you install and configure Oracle Database, certain operations must be performed by the `root` user. Starting with Oracle Database 19c, the Oracle Universal Installer includes options for automatically running the configuration scripts. You can choose to run them as the `root` user, which requires you to know the `root` user password. Or, you can choose to run the scripts as a sudo user (password is also required), which gives the specified user root permissions when running the scripts.

Setting up permissions for configuration scripts to run without user intervention can simplify database installation and help avoid inadvertent permission errors. If you prefer, you can still choose to run the scripts manually, like you would do for an Oracle Database 18c installation.

This lab shows you how to install Oracle Database 19c with the new option to run configuration scripts automatically with an `oracle` sudo user. You also examine the response file after you complete the installation as well as the resulting container database (CDB) and pluggable database (PDB).


Estimated Lab Time: 30 minutes

### Objectives

In this lab, you learn how to do the following:

- Perform pre-installation tasks
- Download and stage the Oracle Database 19c installer files in the Oracle home directory on your compute instance
- Install the database software by using the Oracle Database Setup Wizard
- Review the response file
- Discover the container database (CDB) and pluggable database (PDB)


### Prerequisites

- You have an Oracle Cloud account. You can use the account you created when you signed up for a free trial, one that was given to you through your own organization, or one provided to you by LiveLabs.
- You have a compartment in Oracle Cloud Infrastructure.
- Windows users: You have PuTTY installed on your local computer.
- You created a compute instance in Oracle Cloud Infrastructure that can support Oracle Database 19c. If not, see [Create Compute Instance](?lab=create-compute-instance).


## **STEP 1**: Perform pre-installation tasks
The preinstaller performs many pre-installation and pre-configuration tasks for you. It also creates a `dba` and `oinstall` group, creates an `oracle` user, and adds the `oracle` user to the `dba` and `oinstall` groups.

1.  On the toolbar in Oracle Cloud Infrastructure, click the **Cloud Shell** icon to open Cloud Shell.

2. In Cloud Shell, connect to your compute instance. In the command below, replace `private-key-file` with the  name of your own private key file. Replace `public-ip-address` with the private IP address of your compute instance.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/private-key-file.key opc@public-ip-address</copy>
    ```

3. Change to the `root` user.

    ```nohighlighting
    $ <copy> sudo su -</copy>
    ```

4. Execute the following command to run the preinstaller. .

    ```nohighlighting
    # <copy>yum install oracle-database-preinstall-19c</copy>
    ```

5. Set the password for the `oracle` user. You are prompted to enter and confirm a password.

    ```nohighlighting
    # <copy>passwd oracle</copy>
    ```

6. Allow the `oracle` user to perform any operation as `root`. This step gives the `oracle` user root permission without the need for them to know the root password. Sudoers must be edited by running `visudo`. You need to do this step so that later in the Oracle Database 19c installer, you can specify the `oracle` user as the sudo user to run configuration scripts.

  a) Run `visudo`.

    ```nohighlighting
    # <copy>sudo visudo</copy>
    ```

  b). Insert the following line after the `root    ALL=(ALL)       ALL` line:

    ```nohighlighting
    <copy>oracle  ALL=(root)      ALL</copy>
    ```

    Tip: Press **i** to insert text.

  c). Save the changes.

    Tip: To save, press **Esc**, enter **:wq**, and then press **Enter.

7. Create the **Oracle base** and **Oracle inventory** directories.

    ```nohighlighting
    # <copy>mkdir -p /u01/app/oracle</copy>
    # <copy>mkdir -p /u01/app/oraInventory</copy>
    ```

8. Specify `oracle` as the owner and `oinstall` as the group for the Oracle base and Oracle inventory directories.

    ```nohighlighting
    # <copy>chown -R oracle:oinstall /u01/app/oracle</copy>
    # <copy>chown -R oracle:oinstall /u01/app/oraInventory</copy>
    ```
9. Set the permissions on the `/u01/app` directory and all if its subdirectories (which includes the Oracle base and Oracle inventory directories) so that the owner and group can read, write, and execute on the directories.

    ```nohighlighting
    # <copy>chmod -R 775 /u01/app</copy>
    ```
10. Increase the swap space on your compute instance to 16GB. Currently, your compute instance has 8GB of free swap space. The Oracle Database 19c installer requires at least 16GB, so you need to increase the amount on your compute instance.

  a) Allocate 8GB of swap space.

        ```nohighlighting
        # <copy>fallocate -l 8G /swapfile</copy>
        ```

  b) Allow only the `root` user to read/write to swap.

    ```nohighlighting
    # <copy>chmod 600 /swapfile</copy>
    ```

  c) Format the file to make it a swap file.

    ```nohighlighting
    # <copy>mkswap /swapfile</copy>

    Setting up swapspace version 1, size = 8388604 KiB
    no label, UUID=322b862d-083d-429c-b5b8-a71fff68fa5d
    ```

  d). Enable the swap file.

    ```nohighlighting
    # <copy>swapon /swapfile</copy>
    ```

  e) Check that the compute instance now has enough free swap space (16GB).

        ```nohighlighting
        # <copy>free -m</copy>

                      total        used        free      shared  buff/cache   available
        Mem:          31824        1158       19572           8       11093       30201
        Swap:         16383           0       16383
        ```

        The output indicates that the compute instance now has 16GB of free swap space.

  g) Using the `vi` editor, open `/etc/fstab`.

        ```nohighlighting
        # <copy>vi /etc/fstab</copy>
        ```

  h) Scroll to the bottom, add the following as the last line, and save the file. This step makes the changes permanent.

        ```nohighlighting
        <copy>/swapfile swap swap defaults 0 2</copy>
        ```

## **STEP 2**: Download and stage the Oracle Database 19c installer files in the Oracle home directory on your compute instance

For your convenience, LiveLabs stores the Oracle Database 19c installer ZIP file in its tenancy in object storage. You can download this file to your compute instance and extract it into the Oracle home directory.

1. Continuing as the `root` user, create a `/stage` directory to store the Oracle Database 19c installation ZIP file and grant the `oracle` user read, write, and execute permissions on it.

    ```nohighlighting
    # <copy>mkdir -p /stage</copy>
    # <copy>chown -R oracle:oinstall /stage</copy>
    ```

2. Change the current user to `oracle`.

    ```nohighlighting
    # <copy>su - oracle</copy>
    ```

3. Use the `wget` command to download the Oracle Database 19c installation ZIP file from object storage (in the LiveLabs tenancy) to the `stage` directory.

    ```nohighlighting
    $ <copy>wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/oLJlacFqVtVHOBctOs9-lQlNDQMSVzl9YytidymEaYU2z99DvhagnwIoJOh7ZxkD/n/cfhteam1/b/data-safe/o/LINUX.X64_193000_db_home.zip -P /stage</copy>
    ```

4. Change to the `stage` directory and verify that the Oracle Database 19c installation ZIP file is there.

    ```nohighlighting
    $ <copy>cd /stage </copy>
    $ <copy>ls</copy>
    ```


5. Create an **Oracle home** directory and change to that directory. It's important that the Oracle home directory is in compliance with the Oracle Optimal Flexible Architecture recommendations. Make sure that the current user is still `oracle`.

    ```nohighlighting
    $ <copy>mkdir -p /u01/app/oracle/product/19.10.0/dbhome_1</copy>
    $ <copy>cd /u01/app/oracle/product/19.10.0/dbhome_1</copy>
    ```

6. Extract the Oracle Database 19c installation ZIP file from the `stage` directory into the Oracle home directory.

    ```nohighlighting
    $ <copy>unzip -q /stage/LINUX.X64_193000_db_home.zip</copy>
    ```

7. List the files. You should have several directories and files.

    ```nohighlighting
    $ <copy>ls</copy>
    ```

8. Exit Cloud Shell.






## **STEP 3**: Install the database software by using the Oracle Database Setup Wizard

### Windows 10

If you are running Windows 10 on your personal computer, use PuTTY to connect to your compute instance and then run the Oracle Database 19c installer. During installation, choose to automatically run the configuration scripts (*new feature!*) as the sudo `oracle` user.

1. Open PuTTY and connect to your compute instance as the `opc` user using X forwarding. In the  
[Create Compute Instance](?lab=create-compute-instance) lab, you saved a connection configuration in PuTTY that you can load here to connect quickly. It's important to connect using X forwarding so that the graphical user interface of the Oracle Database 19c installer is displayed on your personal computer.

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



## **STEP 4**: Review the Response File

You can continue to use your PuTTY connection for this step.

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



## **STEP 5**: Discover the container database (CDB) and pluggable database (PDB)

You can continue to use your PuTTY connection for this step.

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
