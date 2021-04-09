
# Install Oracle Database 19c with Automatic Configuration Script Execution

## Introduction

When you install and configure Oracle Database, certain operations must be performed by the `root` user. Starting with Oracle Database 19c, the Oracle Universal Installer includes an option to run configuration scripts automatically for you as the `root` user. It also includes the option run the scripts as a sudo user, which gives the specified user root permissions when running the scripts.

Setting up permissions for configuration scripts to run without user intervention can simplify database installation and help avoid inadvertent permission errors. If you prefer, you can still choose to run the scripts manually, like you would do for an Oracle Database 18c installation.

This lab shows you how to install Oracle Database 19c with the new option to run configuration scripts automatically as a sudo user. You also examine the response file and resulting container database (CDB) and pluggable database (PDB).


Estimated Lab Time: 30 minutes

### Objectives

- Download the Oracle Database 19c installation ZIP file to your local computer
- Upload the Oracle Database 19c installation ZIP file to object storage in Oracle Cloud Infrastructure
- Run the Oracle Database Preinstaller
- Create an `oracle` user account and two groups (`dba` and `oinstall`) on your compute instance
- Allow the `oracle` user to perform any operation as `root`
- Create the Oracle base and Oracle inventory directories
- Download the Oracle Database 19c installation ZIP file to a `stage` directory on your compute instance
- Create an OFA-compliant Oracle home directory and extract the Oracle Database 19c installation ZIP file into that directory
- Increase the swap space on your compute instance
- Install the database software by using the Oracle Database Setup Wizard
- Review the response file
- Discover the container database (CDB) and pluggable database (PDB)


### Prerequisites

- You have an Oracle Cloud account. You can use the account you created when you signed up for a free trial, one that was given to you through your own organization, or one provided to you by LiveLabs.
- You have a compartment in Oracle Cloud Infrastructure.
- Windows users: You have PuTTY installed on your local computer.
- You created a compute instance in Oracle Cloud Infrastructure that can support Oracle Database 19c. If not, see [Create Compute Instance](?lab=lab-1-create-compute-instance).


## **STEP 1**: Download the Oracle Database 19c installation ZIP file to your local computer

1. In a browser on your local machine, access `https://www.oracle.com/database/technologies/oracle-database-software-downloads.html#19c`.

2. Scroll down to **Linux x86-64** and click the **ZIP** link (2.8GB).

3. In the dialog box, select the **I reviewed and accept the Oracle License Agreement** check box.

4. Click the **Download LINUX.X64_193000_db_home.zip** button, and download the file to your browser's download directory.


## **STEP 2**: Upload the Oracle Database 19c installation ZIP file to object storage in Oracle Cloud Infrastructure

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

11. In the **Expiration** field, click the calendar icon, and set a date in the future for the pre-authentication request to end.

12. Leave the other settings as is to permit reads on the object, and click **Create Pre-Authentication Request**. The **Pre-Authenticated Request Details** dialog box is displayed.

13. Copy the pre-authenticated request URL to the clipboard. You can use the copy button.

14. Paste the url into a text editor, such as Notepad, where you can access it later.

15. Click **Close**.



## **STEP 3**: Run the Oracle Database Preinstaller

You can complete most preinstallation configuration tasks by using the Oracle Database preinstaller.

Execute the following command to run the preinstaller:

    ```nohighlighting
    # <copy>yum install oracle-database-preinstall-19c</copy>
    ```



## **STEP 4**: Create an `oracle` user account and two groups (dba and oinstall) on your compute instance

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



## **STEP 5**: Allow the `oracle` user to perform any operation as `root`

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




## **STEP 6**: Create the Oracle base and Oracle inventory directories

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




## **STEP 7**: Download the Oracle Database 19c installation ZIP file to a stage directory on your compute instance

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


## **STEP 8**: Create an OFA-compliant Oracle home directory and extract the Oracle Database 19c installation ZIP file into that directory

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



## **STEP 9**: Increase the swap space on your compute instance

The Oracle Database 19c installer expects at least 16GB of free total swap space available on the compute instance. If you followed the [Create a Compute Instance](?lab=lab-1-create-compute-instance) lab to create your compute instance, you need to create a swap file and add it to the swap.


1. Find out how many swap partitions exist on your compute instance.

    ```nohighlighting
    # <copy>swapon -s</copy>

    Filename                                Type            Size    Used    Priority
    /dev/sda2                               partition       8388604 0       -2
    ```
  The output indicates that there is one swap partition, and it is 8GB.


2. View details about partitions.

    ```nohighlighting
    # <copy>free -m</copy>

                  total        used        free      shared  buff/cache   available
    Mem:          31824        1151       19582           8       11091       30209
    Swap:          8191           0        8191
    ```

  The output indicates that there is one partition set up.


3. Identify a file system that has space available.  

   ```nohighlighting
   # <copy>df -h</copy>

    Filesystem      Size  Used Avail Use% Mounted on
    devtmpfs         16G     0   16G   0% /dev
    tmpfs            16G     0   16G   0% /dev/shm
    tmpfs            16G  8.8M   16G   1% /run
    tmpfs            16G     0   16G   0% /sys/fs/cgroup
    /dev/sda3        39G   13G   26G  34% /
    /dev/sda1       200M  8.6M  192M   5% /boot/efi
    tmpfs           3.2G     0  3.2G   0% /run/user/0
    tmpfs           3.2G     0  3.2G   0% /run/user/994
    tmpfs           3.2G     0  3.2G   0% /run/user/1000
    ```

  The output indicates that ``/dev/sda3` has 26G available.


4. Find the current swap space.

    ```nohighlighting
    # <copy>cat /etc/fstab</copy>

    #
    # /etc/fstab
    # Created by anaconda on Wed Mar 17 22:21:38 2021
    #
    # Accessible filesystems, by reference, are maintained under '/dev/disk'
    # See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
    #
    UUID=8381a3a6-892e-40a0-bbaf-3423632fdf6c /                       xfs     defaults,_netdev,_netdev 0 0
    UUID=0F1D-8861          /boot/efi               vfat    defaults,uid=0,gid=0,umask=0077,shortname=winnt,_netdev,_netdev,x-initrd.mount 0 0
    UUID=154d2352-4fc7-471b-a4bb-efd52ae00a8b swap                    swap    defaults,_netdev,x-initrd.mount 0 0
    ######################################
    ## ORACLE CLOUD INFRASTRUCTURE CUSTOMERS
    ##
    ## If you are adding an iSCSI remote block volume to this file you MUST
   ## include the '_netdev' mount option or your instance will become
    ## unavailable after the next reboot.
    ## SCSI device names are not stable across reboots; please use the device UUID instead of /dev path.
    ##
    ## Example:
    ## UUID="94c5aade-8bb1-4d55-ad0c-388bb8aa716a"   /data1    xfs       defaults,noatime,_netdev      0      2
    ##
    ```
  The output indicates that the current swap space is :

  `UUID=154d2352-4fc7-471b-a4bb-efd52ae00a8b swap                   swap   defaults,_netdev,x-initrd.mount 0 0`


5. Allocate 8GB of swap space.

    ```nohighlighting
    # <copy>fallocate -l 8G /swapfile</copy>
    ```

6. Allow only the `root` user to read/write to swap.

    ```nohighlighting
    # <copy>chmod 600 /swapfile</copy>
    ```

7. Format the file to make it a swap file.

    ```nohighlighting
    # <copy>mkswap /swapfile</copy>

    Setting up swapspace version 1, size = 8388604 KiB
    no label, UUID=322b862d-083d-429c-b5b8-a71fff68fa5d
    ```

8. Enable `/swapfile`.

    ```nohighlighting
    # <copy>swapon /swapfile</copy>
    ```

9. Check that the compute instance now has enough free swap space.

    ```nohighlighting
    # <copy>free -m</copy>

                  total        used        free      shared  buff/cache   available
    Mem:          31824        1158       19572           8       11093       30201
    Swap:         16383           0       16383
    ```

  The output indicates that the compute instance now has 16GB of free swap space.

10. Make the changes permanent.

  a) Using the `vi` editor, open `/etc/fstab`.

    ```nohighlighting
    # <copy>vi /etc/fstab</copy>
    ```

  b) Scroll to the bottom and add the following as the last line.

    ```nohighlighting
    <copy>/swapfile swap swap defaults 0 2</copy>
    ```





## **STEP 10**: Install the database software by using the Oracle Database Setup Wizard

### On Windows 10

In this step, you need to use PuTTY. As the `oracle` user, you install Oracle Database 19c using the Oracle Database Setup Wizard. During installation, choose to automatically run the configuration scripts (*new feature!*).

1. Open PuTTY and connect to your compute instance as the `opc` user using X forwarding. In the  
[Create Compute Instance](?lab=lab-1-create-compute-instance) lab, you save a configuration in PuTTY that you can load here to make it fast and easy to get connected.

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



## **STEP 11**: Review the Response File

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



## **STEP 12**: Discover the container database (CDB) and pluggable database (PDB)

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
- **Last Updated By/Date** - Jody Glover, Database team, April 8 2021
