
# Install Oracle Database 19c with Automatic Configuration Script Execution

## Introduction

In this lab, you create a compute instance in Oracle Cloud Infrastructure (OCI) and install Oracle Database 19c on it. During installation, you opt to use a new feature in 19c where the installer runs the configuration scripts for you automatically. This feature simplifies the installation process and helps you avoid inadvertent permission errors. Note that manual script execution is still available, if you prefer that method instead.

During installation, you can configure the `root` user or a sudoer user to run the configuration scripts. Both options require the user's password. In this lab, you create an `oracle` user as a sudoer and specify `oracle` as the user to run the configuration scripts. After the database is installed, you examine the response file as well as the container database (CDB) and pluggable database (PDB) that get created.

You can perform most of the steps in this lab using Cloud Shell. Cloud Shell is a small virtual machine running a Bash shell, which you can access through the OCI console. To run the graphical Oracle Database 19c installer, you need to use a terminal on your personal computer, and not Cloud Shell. To display the graphical interface of the installer, X11 forwarding using Secure Shell (SSH) or virtual network computing (VNC) on your compute instance is required. This lab shows you how to set up X11 forwarding.


Estimated Lab Time: 30 minutes

### Objectives

In this lab, you learn how to do the following:

- Create a compute instance in Oracle Cloud Infrastructure
- Connect to your compute instance from your Cloud Shell machine
- Configure X11 forwarding on your compute instance
- Perform pre-installation tasks
- Download and stage the Oracle Database 19c installer files in the Oracle home directory on your compute instance
- Connect to your compute instance from your personal computer
- Install the database software by using the Oracle Database Setup Wizard
- Review the response file
- Discover the container database (CDB) and pluggable database (PDB)


### Prerequisites

- You have an Oracle Cloud account. You can use the account you created when you signed up for a free trial, one that was given to you through your own organization, or one provided to you by LiveLabs.
- You have a compartment in Oracle Cloud Infrastructure.
- You have PuTTY installed on your local computer.


## **STEP 1**: Create a compute instance in Oracle Cloud Infrastructure

1. On the **Home** page in Oracle Cloud Infrastructure, under **Quick Actions**, click **Create a VM instance**.

  The **Create Compute Instance** page is displayed.

2. For **Name**, enter a name for your instance; for example, **compute-1**.

3. For **Create in compartment**, select the compartment that you created or was provided to you.

4. For **Placement**, leave as is. Oracle automatically chooses an availability domain for you, sets the capacity type to **On-demand capacity**, and chooses the best fault domain for you.

5. For **Image and shape**, do the following:

  a) Click **Edit**.

  b) Leave **Oracle Linux 7.9** selected as the image build. This installs Linux Kernel version 5.4.17-2036.104.5.el7uek.x86_64.

  c) Click **Change Shape**. In the **Browse All Shapes** window, scroll down and select **VM.Standard.E2.4**. Click **Select Shape**. This shape has enough memory to run the database 19c binaries.

6. For **Networking**, leave the default values as is. Oracle provides a default VCN and subnet name and assigns your compute instance a public IPv4 address so that you can access it from the internet.

7. For **Add SSH keys**, do the following:

  a) Leave **Generate SSH key pair** selected.

  b) *IMPORTANT!* Click **Save Private Key**. Download and save the private key to a local directory on your computer so that you can later connect to your instance using SSH. Be sure to select a directory on which only you (the owner of the directory) has permissions to access.

8. For **Boot** volume, do not select any of the options.

9. Click **Create**.

  Oracle Cloud Infrastructure provisions your compute instance in less than a minute. During provisioning, your compute instance's page is displayed and shows you general information, instance details, shape configuration, instance access details (your public IP address and username), primary VNIC information, and launch options.

10. Wait for the status of the compute instance to turn to **RUNNING**.


## **STEP 2**: Connect to your compute instance from your Cloud Shell machine

To connect to your compute instance using Cloud Shell, you need to add your private key to the `.ssh` directory on your Cloud Shell machine. The `.ssh` directory already exists on your machine so you do not need to create it. You only need to add your private key once (step 2 below). After your private key is in its proper place, you can simply SSH to connect in future sessions (step 4 below).

1. On the toolbar, click the **Cloud Shell** icon. A Cloud Shell machine is created for you. Wait for the prompt to be displayed.

2. Do this once: Upload your private key to the `.ssh` directory on your Cloud Shell machine.

  a) From the **Cloud Shell** menu, select **Upload**. The **File Upload to your Home Directory** dialog box is displayed.

  b) Click **select from your computer**. Browse to and select your private key file, and then click **Open**. Click **Upload**. Your private key is uploaded to the `home` directory on your Cloud Shell machine.

  c) Move your private key to the `.ssh` directory. In the code below, replace `private-key-filename` with the name of own private key file. Be sure to include the slash (/) after .ssh in the command to ensure that the file gets moved to a directory.

    ```nohighlighting
    $ <copy>mv private-key-filename.key .ssh/</copy>
    ```

  d) Set permissions on the `.ssh` directory so that only you (the owner) can read, write, and execute on the directory. Also set permissions on the private key itself so that only you (the owner) can read and write (but not execute) on the private key file.

    ```nohighlighting

    $ <copy>chmod 700 ~/.ssh</copy>
    $ <copy>cd .ssh</copy>
    $ <copy>chmod 600 *</copy>
    ```

3. On the **Instance Information** tab for your compute instance, find the public IP address and copy it to the clipboard.

4. Enter the following `ssh` command to connect to your compute instance, replacing `private-key-file` and `public-ip-address` values with your own values.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/private-key-file.key opc@public-ip-address</copy>
    ```

    You receive a message stating that the authenticity of your compute instance can't be established. Do you want to continue connecting?

5. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  The terminal prompt becomes `[opc@compute-instance-name ~]$`, where `compute-instance-name` is the name of your compute instance and `opc` is your user account on your compute instance. You are now connected to your new compute instance.



## **STEP 3**: Configure X11 forwarding on your compute instance

1. As the `root` user, use `yum` to install all the dependencies needed to run X11 applications.

    ```nohighlighting
    # <copy>yum install -y xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-utils xorg-x11-apps xorg-x11-fonts-* xorg-x11-font-utils xorg-x11-fonts-Type1</copy>
    ```

2. Open the `sshd_config` file, which is the configuration file for the SSH service.

    ```nohighlighting
    # <copy>vi /etc/ssh/sshd_config</copy>
    ```

3. Edit the following lines to be as follows:

    - `X11Forwarding yes` (already set by default)
    - `X11DisplayOffset 10`
    - `X11UseLocalhost no`

  Tip: To delete text, press **d** and use the left and right arrow keys. To add text, press **i** and enter text.

4. Save and exit the vi editor.

  Tip: Press **Esc**, enter **:wq**, and then press **Enter**.

5. Restart the SSH service so the new settings take effect.

    ```nohighlighting
    # <copy>systemctl restart sshd</copy>
    ```



## **STEP 4**: Perform pre-installation tasks
The preinstaller for Oracle Database 19c performs many pre-installation and pre-configuration tasks for you. It also creates a `dba` and `oinstall` group, creates an `oracle` user, and adds the `oracle` user to the `dba` and `oinstall` groups.

1. Continuing as the `root` user, execute the following command to run the preinstaller.

    ```nohighlighting
    # <copy>yum install oracle-database-preinstall-19c</copy>
    ```

2. Set the password for the `oracle` user. You are prompted to enter and confirm a password.

    ```nohighlighting
    # <copy>passwd oracle</copy>
    ```

3. Allow the `oracle` user to perform any operation as `root`. This step gives the `oracle` user root permission without the need for them to know the root password. Sudoers must be edited by running `visudo`. You need to do this step so that later in the Oracle Database 19c installer, you can specify the `oracle` user as the sudo user to run configuration scripts.

  a) Run `visudo`.

    ```nohighlighting
    # <copy>sudo visudo</copy>
    ```

  b) Insert the following line after the `root    ALL=(ALL)       ALL` line:

    ```nohighlighting
    <copy>oracle  ALL=(root)      ALL</copy>
    ```

    Tip: Press **i** to insert text.

  c) Save the changes.

    Tip: To save, press **Esc**, enter **:wq**, and then press **Enter.

4. Create the **Oracle base** and **Oracle inventory** directories.

    ```nohighlighting
    # <copy>mkdir -p /u01/app/oracle</copy>
    # <copy>mkdir -p /u01/app/oraInventory</copy>
    ```

5. Specify `oracle` as the owner and `oinstall` as the group for the Oracle base and Oracle inventory directories.

    ```nohighlighting
    # <copy>chown -R oracle:oinstall /u01/app/oracle</copy>
    # <copy>chown -R oracle:oinstall /u01/app/oraInventory</copy>
    ```
6. Set the permissions on the `/u01/app` directory and all if its subdirectories (which includes the Oracle base and Oracle inventory directories) so that the owner and group can read, write, and execute on the directories.

    ```nohighlighting
    # <copy>chmod -R 775 /u01/app</copy>
    ```
7. Increase the swap space on your compute instance to 16GB. Currently, your compute instance has 8GB of free swap space. The Oracle Database 19c installer requires at least 16GB, so you need to increase the amount on your compute instance.

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

  d) Enable the swap file.

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

## **STEP 5**: Download and stage the Oracle Database 19c installer files in the Oracle home directory on your compute instance

For your convenience, LiveLabs stores the Oracle Database 19c installer ZIP file in its tenancy in object storage. In this step, you download this file to your compute instance and extract it into the Oracle home directory.

1. Continuing as the `root` user, create a `/stage` directory to store the Oracle Database 19c installation ZIP file. Grant the `oracle` user read, write, and execute permissions on the directory.

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


## **STEP 6**: Connect to your compute instance from your personal computer

From this point on in the lab, you need to use your personal computer to connect to your compute instance as you cannot run the graphical user interface of the Oracle Database 19c installer from Cloud Shell.

Using X11 forwarding in an SSH session on your local personal computer is one way that you can securely run graphical applications (X clients). For X11 forwarding in SSH to work, your local computer must be running an X server program. The X server program manages the interaction between the remote application (the X client, and in this case, the Oracle Database 19c installer) and your computer's hardware. In this lab, you use PuTTY on Windows 10 with VcXsrv (X server).


#### Part A - Install VcXsrv

1. In a browser on your Windows machine, access the following URL:

    ```nohighlighting
    <copy>https://sourceforge.net/projects/vcxsrv/</copy>
    ```

2. Click **Download**.

3. In the dialog box, click **Save File** and save the executable to a directory on your local machine. At the time of this writing, the file is named `vcxsrv-64.1.20.9.0.installer.exe`.

4. Double-click the executable file to launch the installer for VcXsvr.

5. For type of install, do a full (all options selected, VcXsrv, Fonts, Start Menu Shortcuts, Desktop Shortcuts), and click **Next**.

6. For **Destination folder**, leave **C:\Program Files\VcXsrv** as is, and click **Install**.

7. When the installation is finished, click **Close**.

8. From the windows **Start** menu, select **VcXsrv**, and then **XLaunch**.

9. For **Display Settings**, leave **multiple windows** selected. For **Display number**, leave **-1** as is to let VcSsrv automatically choose one. Click **Next**.

10. On the **Select how to start clients** page, select **Start no client**, and click **Next**.

11. On the **Extra settings** page, select all options, including **Disable access control**, click **Next**.

12. Click **Finish**. Leave VcXsrv running.

  In the bottom right corner, a VcXsrv icon is displayed. If you need to stop XLaunch for some reason, double-click the icon and click **Exit**.


#### Part B - Convert your private key to a .ppk file

You need to convert the private key that you obtained from Oracle Cloud Infrastructure into a .ppk file format so that you can use it with PuTTY.

1. Open **PuTTY Key Generator**.

2. From the **Conversions** menu, select **Import key**.

3. Browse to and select the private key file (.key) that was generated for you when you created your compute instance, and click **Open**. Your private key is converted into PPK format.

4. Leave **RSA** as the type of key to generate, and click **Save private key**.

5. Click **Yes** to save without a passphrase.

6. Enter a name for your private key, and click **Save**. It's helpful to use the same name as your original `KEY` file, but with a `PPK` file extension.

7. Close PuTTY Key Generator.


#### Part C - Configure an X11 forwarding connection in PuTTY that connects to your compute instance

1. Open PuTTY on your local Windows computer.

2. On the **Session** tab, configure the following:

    - **Hostname**: Enter the public IP address for your compute instance.
    - **Port**: Leave port **22** as is.

3. Browse to **Connection** > **Data**, and enter `opc` as the **Auto-login username**.

4. Browse to **Connection** > **SSH** > **Auth**, and configure the following:

  a) In the **Authentication parameters** area, click **Browse**.

  b) Browse to your private key directory, select your private key (in `PPK` format), and then click **Open**.

5. Browse to **Connection** > **SSH** > **X11**, and configure the following:

  a) Select **Enable X11 forwarding**.

  b) Leave the **X display location** box empty.


6. Return to the **Session** tab. In the **Saved Sessions** box, enter the name of your compute instance, and then click **Save**.

  In the future, you can simply load your saved session and quickly connect.

7. Click **Open**.

  A message is displayed that the server's host key is not cached in the registry.

8. Click **Yes** because you trust this host.

  You are now logged in as the `opc` user. Notice that the following line is displayed:

  `/usr/bin/xauth: file /home/opc/.Xauthority does not exist`

  The .Xauthority file is automatically generated the first time you log in to your compute instance. For subsequent logins, you do not see this message. The .Xauthority file stores credentials in cookies used by `xauth` for authentication of X sessions. Once an X session is started, the cookie is used to authenticate connections to that specific display.

9. Display the authorization information for the `opc` user used to connect to the X server.

    ```
    $ <copy>xauth list</copy>

    compute1.subnet03311012.vcn03311012.oraclevcn.com:10  MIT-MAGIC-COOKIE-1  9055a7967897789f94fd6a3fbc1b4b90
    ```

10. View the `DISPLAY` environment variable.

    ```
    $ <copy>echo $DISPLAY</copy>
    ```
    The output is `your-computer-ip:10.0`. Notice that the `10` is also part of the authentication information in the previous step.

11. Test that the `opc` user can open a graphical user interface application like `xeyes`.

    ```
    $ <copy>xeyes</copy>
    ```
  A pair of eyes is displayed in a separate window. If you move your cursor over the eyes, the eyes follow it.

12. Hover your cursor over the XLaunch application icon.

  The application indicates that there is one client connected.

13. Close `xclock`.

  The XLaunch application icon indicates that there are zero clients connected.




## **STEP 7**: Install the database software by using the Oracle Database Setup Wizard

In this step, you enable the `oracle` user to run the graphical Oracle Database 19c installer. During installation, choose to automatically run the configuration scripts (*new feature!*) as the sudo `oracle` user.

1. As the `opc` user, copy the Xauthority file from the `opc` user to the `oracle` user so that `oracle` can display the graphical user interface of the Oracle Database 19c installer.

    ```nohighlighting
    $ <copy>sudo cp ~/.Xauthority /home/oracle/.Xauthority</copy>
    ```

2. Switch to the `oracle` user and enter the password.

    ```nohighlighting
    $ <copy>su - oracle</copy>
    ```
3. Change to the Oracle home directory.

    ```nohighlighting
    $ <copy>cd /u01/app/oracle/product/19.10.0/dbhome_1</copy>
    ```
4. Launch the Oracle Database 19c installer. It's important that you run the `runInstaller` command from the Oracle home directory only.

    ```nohighlighting
    <copy>./runInstaller</copy>
    ```

5. On the **Select Configuration Option** page, leave **Create and configure a single instance database** selected, and click **Next**. This option creates a starter database with one container database (CDB) and one pluggable database (PDB).

  ![Select Configuration Option page](images/select-configuration-option-page.png)

6. On the **Select System Class** page, leave **Desktop Class** selected, and click **Next**.

  ![Select System Class page](images/select-system-class-page.png)

7. On the **Typical Installation** page, leave the default entries as is. For the **Password** and **Confirm password** boxes, enter a password for the database `admin` user. Make note of this password as you will need it later. The name of the pluggable database is `orclpdb`. Click **Next**.

  ![Typical Install Configuration page](images/typical-install-configuration-page.png)

8. On the **Create Inventory** page, leave the default settings as is, and click **Next**.

  ![Create Inventory page](images/create-inventory-page.png)

9. On the **Root script execution configuration** page, select the **Automatically run configuration scripts** check box. Select **Use sudo**, and enter the password for the `oracle` user. Click **Next**. The sudo user name must be the username of the user installing the database.

  *This is the new feature that this lab is all about!*

  ![Root script execution configuration page](images/root-script-execution-configuration-page.png)

10. On the **Perform Prerequisite Checks** page, wait for the installer to verify that your environment meets the minimum installation and configuration requirements. If everything is fine, the **Summary** page is displayed.

  ![Perform Prerequisite Checks page](images/prerequisite-checks-page.png)

  ![Summary page](images/summary-page.png)

11. On the **Summary** page, save the response file.

  a) Click **Save Response File**. The **Save Response File** dialog box is displayed.

  b) Browse to and select the `/tmp` directory.

  c) Leave **db.rsp** as the name, and click **Save**.

12. Click **Install** to begin installing the software.

13. On the **Install Product** page, monitor the progress of the steps being executed.

  ![Install Product page](images/install-product-page.png)

14. When prompted to run the configuration scripts as the privileged user, click **Yes** to continue. The installation takes between 15 to 20 minutes to complete.

  ![Run configuration scripts prompt](images/run-configuration-scripts-prompt.png)

15. On the **Finish** page, click **Close**. The installation is finished.

    ![Finish page](images/finish-page.png)



## **STEP 8**: Review the response file

You can continue to use your PuTTY connection for this step.

1. Change to the `/tmp` directory where you saved the response file.

    ```nohighlighting
    $ <copy>cd /tmp</copy>
    ```
2. Review the response file (`db.rsp`).

    ```nohighlighting
    $ <copy>cat db.rsp</copy>

    ####################################################################
    ## Copyright(c) Oracle Corporation 1998,2019. All rights reserved.##
    ##                                                                ##
    ## Specify values for the variables listed below to customize     ##
    ## your installation.                                             ##
    ##                                                                ##
    ## Each variable is associated with a comment. The comment        ##
    ## can help to populate the variables with the appropriate        ##
    ## values.                                                        ##
    ##                                                                ##
    ## IMPORTANT NOTE: This file contains plain text passwords and    ##
    ## should be secured to have read permission only by oracle user  ##
    ## or db administrator who owns this installation.                ##
    ##                                                                ##
    ####################################################################


    #------------------------------------------------------------------------------
    # Do not change the following system generated value.
    #------------------------------------------------------------------------------
    oracle.install.responseFileVersion=/oracle/install/rspfmt_dbinstall_response_schema_v19.0.0

    #-------------------------------------------------------------------------------
    # Specify the installation option.
    # It can be one of the following:
    #   - INSTALL_DB_SWONLY
    #   - INSTALL_DB_AND_CONFIG
    #-------------------------------------------------------------------------------
    oracle.install.option=INSTALL_DB_AND_CONFIG

    #-------------------------------------------------------------------------------
    # Specify the Unix group to be set for the inventory directory.
    #-------------------------------------------------------------------------------
    UNIX_GROUP_NAME=oinstall

    #-------------------------------------------------------------------------------
    # Specify the location which holds the inventory files.
    # This is an optional parameter if installing on
    # Windows based Operating System.
    #-------------------------------------------------------------------------------
    INVENTORY_LOCATION=/u01/app/oraInventory

    #-------------------------------------------------------------------------------
    # Specify the complete path of the Oracle Base.
    #-------------------------------------------------------------------------------
    ORACLE_BASE=/u01/app/oracle

    #-------------------------------------------------------------------------------
    # Specify the installation edition of the component.
    #
    # The value should contain only one of these choices.

    #   - EE     : Enterprise Edition

    #   - SE2     : Standard Edition 2


    #-------------------------------------------------------------------------------

    oracle.install.db.InstallEdition=EE
    ###############################################################################
    #                                                                             #
    # PRIVILEGED OPERATING SYSTEM GROUPS                                          #
    # ------------------------------------------                                  #
    # Provide values for the OS groups to which SYSDBA and SYSOPER privileges     #
    # needs to be granted. If the install is being performed as a member of the   #
    # group "dba", then that will be used unless specified otherwise below.       #
    #                                                                             #
    # The value to be specified for OSDBA and OSOPER group is only for UNIX based #
    # Operating System.                                                           #
    #                                                                             #
    ###############################################################################

    #------------------------------------------------------------------------------
    # The OSDBA_GROUP is the OS group which is to be granted SYSDBA privileges.
    #-------------------------------------------------------------------------------
    oracle.install.db.OSDBA_GROUP=dba

    #------------------------------------------------------------------------------
    # The OSOPER_GROUP is the OS group which is to be granted SYSOPER privileges.
    # The value to be specified for OSOPER group is optional.
    #------------------------------------------------------------------------------
    oracle.install.db.OSOPER_GROUP=dba

    #------------------------------------------------------------------------------
    # The OSBACKUPDBA_GROUP is the OS group which is to be granted SYSBACKUP privileges.
    #------------------------------------------------------------------------------
    oracle.install.db.OSBACKUPDBA_GROUP=dba

    #------------------------------------------------------------------------------
    # The OSDGDBA_GROUP is the OS group which is to be granted SYSDG privileges.
    #------------------------------------------------------------------------------
    oracle.install.db.OSDGDBA_GROUP=dba

    #------------------------------------------------------------------------------
    # The OSKMDBA_GROUP is the OS group which is to be granted SYSKM privileges.
    #------------------------------------------------------------------------------
    oracle.install.db.OSKMDBA_GROUP=dba

    #------------------------------------------------------------------------------
    # The OSRACDBA_GROUP is the OS group which is to be granted SYSRAC privileges.
    #------------------------------------------------------------------------------
    oracle.install.db.OSRACDBA_GROUP=dba
    ################################################################################
    #                                                                              #
    #                      Root script execution configuration                     #
    #                                                                              #
    ################################################################################

    #-------------------------------------------------------------------------------------------------------
    # Specify the root script execution mode.
    #
    #   - true  : To execute the root script automatically by using the appropriate configuration methods.
    #   - false : To execute the root script manually.
    #
    # If this option is selected, password should be specified on the console.
    #-------------------------------------------------------------------------------------------------------
    oracle.install.db.rootconfig.executeRootScript=true

    #--------------------------------------------------------------------------------------
    # Specify the configuration method to be used for automatic root script execution.
    #
    # Following are the possible choices:
    #   - ROOT
    #   - SUDO
    #--------------------------------------------------------------------------------------
    oracle.install.db.rootconfig.configMethod=SUDO
    #--------------------------------------------------------------------------------------
    # Specify the absolute path of the sudo program.
    #
    # Applicable only when SUDO configuration method was chosen.
    #--------------------------------------------------------------------------------------
    oracle.install.db.rootconfig.sudoPath=/usr/bin/sudo

    #--------------------------------------------------------------------------------------
    # Specify the name of the user who is in the sudoers list.
    # Applicable only when SUDO configuration method was chosen.
    # Note:For Single Instance database installations,the sudo user name must be the username of the user installing the database.
    #--------------------------------------------------------------------------------------
    oracle.install.db.rootconfig.sudoUserName=oracle

    ###############################################################################
    #                                                                             #
    #                               Grid Options                                  #
    #                                                                             #
    ###############################################################################

    #------------------------------------------------------------------------------
    # Value is required only if the specified install option is INSTALL_DB_SWONLY
    #
    # Specify the cluster node names selected during the installation.
    #
    # Example : oracle.install.db.CLUSTER_NODES=node1,node2
    #------------------------------------------------------------------------------
    oracle.install.db.CLUSTER_NODES=

    ###############################################################################
    #                                                                             #
    #                        Database Configuration Options                       #
    #                                                                             #
    ###############################################################################

    #-------------------------------------------------------------------------------
    # Specify the type of database to create.
    # It can be one of the following:
    #   - GENERAL_PURPOSE
    #   - DATA_WAREHOUSE
    # GENERAL_PURPOSE: A starter database designed for general purpose use or transaction-heavy applications.
    # DATA_WAREHOUSE : A starter database optimized for data warehousing applications.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.type=GENERAL_PURPOSE

    #-------------------------------------------------------------------------------
    # Specify the Starter Database Global Database Name.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.globalDBName=orcl.subnet2.vcn.oraclevcn.com

    #-------------------------------------------------------------------------------
    # Specify the Starter Database SID.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.SID=orcl

    #-------------------------------------------------------------------------------
    # Specify whether the database should be configured as a Container database.
    # The value can be either "true" or "false". If left blank it will be assumed
    # to be "false".
    #-------------------------------------------------------------------------------
    oracle.install.db.ConfigureAsContainerDB=true

    #-------------------------------------------------------------------------------
    # Specify the  Pluggable Database name for the pluggable database in Container Database.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.PDBName=orclpdb

    #-------------------------------------------------------------------------------
    # Specify the Starter Database character set.
    #
    #  One of the following
    #  AL32UTF8, WE8ISO8859P15, WE8MSWIN1252, EE8ISO8859P2,
    #  EE8MSWIN1250, NE8ISO8859P10, NEE8ISO8859P4, BLT8MSWIN1257,
    #  BLT8ISO8859P13, CL8ISO8859P5, CL8MSWIN1251, AR8ISO8859P6,
    #  AR8MSWIN1256, EL8ISO8859P7, EL8MSWIN1253, IW8ISO8859P8,
    #  IW8MSWIN1255, JA16EUC, JA16EUCTILDE, JA16SJIS, JA16SJISTILDE,
    #  KO16MSWIN949, ZHS16GBK, TH8TISASCII, ZHT32EUC, ZHT16MSWIN950,
    #  ZHT16HKSCS, WE8ISO8859P9, TR8MSWIN1254, VN8MSWIN1258
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.characterSet=AL32UTF8

    #------------------------------------------------------------------------------
    # This variable should be set to true if Automatic Memory Management
    # in Database is desired.
    # If Automatic Memory Management is not desired, and memory allocation
    # is to be done manually, then set it to false.
    #------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.memoryOption=false

    #-------------------------------------------------------------------------------
    # Specify the total memory allocation for the database. Value(in MB) should be
    # at least 256 MB, and should not exceed the total physical memory available
    # on the system.
    # Example: oracle.install.db.config.starterdb.memoryLimit=512
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.memoryLimit=12730

    #-------------------------------------------------------------------------------
    # This variable controls whether to load Example Schemas onto
    # the starter database or not.
    # The value can be either "true" or "false". If left blank it will be assumed
    # to be "false".
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.installExampleSchemas=true

    ###############################################################################
    #                                                                             #
    # Passwords can be supplied for the following four schemas in the             #
    # starter database:                                                           #
    #   SYS                                                                       #
    #   SYSTEM                                                                    #
    #   DBSNMP (used by Enterprise Manager)                                       #
    #                                                                             #
    # Same password can be used for all accounts (not recommended)                #
    # or different passwords for each account can be provided (recommended)       #
    #                                                                             #
    ###############################################################################

    #------------------------------------------------------------------------------
    # This variable holds the password that is to be used for all schemas in the
    # starter database.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.password.ALL=

    #-------------------------------------------------------------------------------
    # Specify the SYS password for the starter database.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.password.SYS=

    #-------------------------------------------------------------------------------
    # Specify the SYSTEM password for the starter database.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.password.SYSTEM=

    #-------------------------------------------------------------------------------
    # Specify the DBSNMP password for the starter database.
    # Applicable only when oracle.install.db.config.starterdb.managementOption=CLOUD_CONTROL
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.password.DBSNMP=

    #-------------------------------------------------------------------------------
    # Specify the PDBADMIN password required for creation of Pluggable Database in the Container Database.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.password.PDBADMIN=

    #-------------------------------------------------------------------------------
    # Specify the management option to use for managing the database.
    # Options are:
    # 1. CLOUD_CONTROL - If you want to manage your database with Enterprise Manager Cloud Control along with Database Express.
    # 2. DEFAULT   -If you want to manage your database using the default Database Express option.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.managementOption=DEFAULT

    #-------------------------------------------------------------------------------
    # Specify the OMS host to connect to Cloud Control.
    # Applicable only when oracle.install.db.config.starterdb.managementOption=CLOUD_CONTROL
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.omsHost=

    #-------------------------------------------------------------------------------
    # Specify the OMS port to connect to Cloud Control.
    # Applicable only when oracle.install.db.config.starterdb.managementOption=CLOUD_CONTROL
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.omsPort=0

    #-------------------------------------------------------------------------------
    # Specify the EM Admin user name to use to connect to Cloud Control.
    # Applicable only when oracle.install.db.config.starterdb.managementOption=CLOUD_CONTROL
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.emAdminUser=

    #-------------------------------------------------------------------------------
    # Specify the EM Admin password to use to connect to Cloud Control.
    # Applicable only when oracle.install.db.config.starterdb.managementOption=CLOUD_CONTROL
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.emAdminPassword=

    ###############################################################################
    #                                                                             #
    # SPECIFY RECOVERY OPTIONS                                                    #
    # ------------------------------------                                        #
    # Recovery options for the database can be mentioned using the entries below  #
    #                                                                             #
    ###############################################################################

    #------------------------------------------------------------------------------
    # This variable is to be set to false if database recovery is not required. Else
    # this can be set to true.
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.enableRecovery=false

    #-------------------------------------------------------------------------------
    # Specify the type of storage to use for the database.
    # It can be one of the following:
    #   - FILE_SYSTEM_STORAGE
    #   - ASM_STORAGE
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE

    #-------------------------------------------------------------------------------
    # Specify the database file location which is a directory for datafiles, control
    # files, redo logs.
    #
    # Applicable only when oracle.install.db.config.starterdb.storage=FILE_SYSTEM_STORAGE
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=/u01/app/oracle/oradata

    #-------------------------------------------------------------------------------
    # Specify the recovery location.
    #
    # Applicable only when oracle.install.db.config.starterdb.storage=FILE_SYSTEM_STORAGE
    #-------------------------------------------------------------------------------
    oracle.install.db.config.starterdb.fileSystemStorage.recoveryLocation=

    #-------------------------------------------------------------------------------
    # Specify the existing ASM disk groups to be used for storage.
    #
    # Applicable only when oracle.install.db.config.starterdb.storageType=ASM_STORAGE
    #-------------------------------------------------------------------------------
    oracle.install.db.config.asm.diskGroup=

    #-------------------------------------------------------------------------------
    # Specify the password for ASMSNMP user of the ASM instance.
    #
    # Applicable only when oracle.install.db.config.starterdb.storage=ASM_STORAGE
    #-------------------------------------------------------------------------------
    oracle.install.db.config.asm.ASMSNMPPassword=[oracle@compute-jfv2 tmp]$
    ```



## **STEP 9**: Discover the container database (CDB) and pluggable database (PDB)

You can continue to use your PuTTY connection for this step.

1. Set the Oracle environment variables. You need to set these each time you open a new terminal window and want to access your database.

  a) List the search path that holds the `oraenv` script.

    ```nohighlighting
    $ <copy>which oraenv</copy>

    /usr/local/bin/oraenv
    $
    ```

  b) Source the `oraenv` script. The dot in the `. oraenv` command means to do a source operation. `oraenv` sets the required environment variables needed for you to connect to your database instance. For example, it sets the  `ORACLE_SID` and `ORACLE_HOME` environment variables and includes the `$ORACLE_HOME/bin` directory in the  `PATH` environment variable setting. Environment variables that this script sets will persist in the terminal window until you close it. Don't forget to put a space after the dot.

    For the `ORACLE_SID` value, enter `orcl` (in lowercase).

    ```nohighlighting
    $ <copy>. oraenv</copy>

    ORACLE_SID = [oracle] ? orcl
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

5. Find the current container name. Because you're currently connected to the `root` container, the name is `CDB$ROOT`.

    ```nohighlighting
    SQL> <copy>SHOW con_name</copy>

    CON_NAME
    -------------------
    CDB$ROOT
    SQL>
    ```

6. List all of the containers in the CDB by querying the `V$CONTAINERS` view. The results list three containers - the `root` container (`CDB$ROOT`), the seed PDB (`PDB$SEED`), and the pluggable database (`ORCLPDB`).

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
    SQL> <copy>EXIT</copy>

    $
    ```

Congratulations! You have a fully functional Oracle Database 19c instance running on a compute instance in Oracle Cloud Infrastructure.



## Learn More

- [Get Started with Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/)
- [Install and Upgrade to Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/install-and-upgrade.html)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Technical Contributors**
    - James Spiller, Principal User Assistance Developer, Database Development
    - Dragos Negru, Principal Cloud Specialist - Data Management, TE Hub
    - Jean-Francois Verrier, User Assistance Director, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, April 13 2021
