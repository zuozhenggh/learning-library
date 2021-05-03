# Appendix A: Create a Compute Instance with X11 Forwarding

## Introduction

In this lab, you create a compute instance in Oracle Cloud Infrastructure (OCI), configure X11 forwarding, and prepare the instance for an Oracle Database 19c installation.
Using X11 forwarding in an SSH session on your local personal computer is one way that you can securely run graphical applications (X clients). For X11 forwarding in SSH to work, your local computer must be running an X server program. The X server program manages the interaction between the remote application (the X client, and in this case, the Oracle Database 19c installer) and your computer's hardware. In this lab, you use PuTTY on Windows 10 with VcXsrv (X server).

You can perform most of the steps in this lab by using Cloud Shell. Cloud Shell is a small virtual machine running a Bash shell, which you can access through the OCI console. You also learn how to use PuTTY and X11 forwarding to connect to your compute instance from your personal computer.


Estimated Lab Time: 30 minutes

### Objectives

In this lab, you learn how to do the following:

- Create a compute instance in Oracle Cloud Infrastructure
- Connect to your compute instance from your Cloud Shell machine
- Configure X11 forwarding on your compute instance
- Install an X Server on your local computer
- Convert your private key to a .ppk file
- Configure an X11 forwarding connection in PuTTY that connects to your compute instance
- Test that X forwarding is working
- Configure X11 forwarding for an `oracle` user



### Prerequisites

- You have an Oracle account. You can obtain a free account by using Oracle Free Tier or you can use a paid account provided to you by your own organization.
- You have a compartment in Oracle Cloud Infrastructure.
- You have PuTTY installed on your local computer.

### Assumptions

- You are signed in to Oracle Cloud Infrastructure.


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

To connect to your compute instance using Cloud Shell, you need to add your private key to an `.ssh` directory on your Cloud Shell machine. You only need to add your private key once (step 2 below). After your private key is in its proper place, you can simply SSH to connect in future sessions (step 4 below).

1. On the toolbar in Oracle Cloud Infrastructure, click the **Cloud Shell** icon to open the Cloud Shell window, and wait for a terminal prompt to be displayed.

  ![Cloud Shell icon](images/cloud-shell-icon.png)

2. Upload your private key to the `.ssh` directory on your Cloud Shell machine.

  a) From the **Cloud Shell** menu, select **Upload**. The **File Upload to your Home Directory** dialog box is displayed.

  b) Click **select from your computer**. Browse to and select your private key file, and then click **Open**. Click **Upload**. Your private key is uploaded to the `home` directory on your Cloud Shell machine.

  d) Create an `.ssh` directory in the `home` directory.

    ```nohighlighting
    $ <copy>mkdir .ssh/</copy>
    ```

  e) Move your private key to the `.ssh` directory. In the code below, replace `private-key-filename` with the name of own private key file. Be sure to include the slash (/) after .ssh in the command to ensure that the file gets moved to a directory.

    ```nohighlighting
    $ <copy>mv private-key-filename.key .ssh/</copy>
    ```

  f) Set permissions on the `.ssh` directory so that only you (the owner) can read, write, and execute on the directory. Also set permissions on the private key itself so that only you (the owner) can read and write (but not execute) on the private key file.

    ```nohighlighting

    $ <copy>chmod 700 ~/.ssh</copy>
    $ <copy>cd .ssh</copy>
    $ <copy>chmod 600 *</copy>
    ```

3. On the **Instance Information** tab for your compute instance, find the public IP address and copy it to the clipboard.

4. Enter the following `ssh` command to connect to your compute instance, replacing `private-key-file` and `public-ip-address` with your own values.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/private-key-file.key opc@public-ip-address</copy>
    ```

    You receive a message stating that the authenticity of your compute instance can't be established. Do you want to continue connecting?

5. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  The terminal prompt becomes `[opc@compute-instance-name ~]$`, where `compute-instance-name` is the name of your compute instance and `opc` is your user account on your compute instance. You are now connected to your new compute instance.




## **STEP 2**: Configure X11 forwarding on your compute instance

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


## **STEP 4** Install an X Server on your local computer

From this point on in the lab, you need to use your personal computer to connect to your compute instance as you cannot run the graphical user interface of the Oracle Database 19c installer from Cloud Shell.

On Windows, you can install the X Server called VcXsrv.


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


## **STEP 5**: Convert your private key to a .ppk file

You need to convert the private key that you obtained from Oracle Cloud Infrastructure into a .ppk file format so that you can use it with PuTTY.

1. Open **PuTTY Key Generator**.

2. From the **Conversions** menu, select **Import key**.

3. Browse to and select the private key file (.key) that was generated for you when you created your compute instance, and click **Open**. Your private key is converted into PPK format.

4. Leave **RSA** as the type of key to generate, and click **Save private key**.

5. Click **Yes** to save without a passphrase.

6. Enter a name for your private key, and click **Save**. It's helpful to use the same name as your original `KEY` file, but with a `PPK` file extension.

7. Close PuTTY Key Generator.


## **STEP 6**: Configure an X11 forwarding connection in PuTTY that connects to your compute instance

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


## **STEP 7**: Test that X forwarding is working

1. Test that the `opc` user can open a graphical user interface application like `xeyes`.

    ```
    $ <copy>xeyes</copy>
    ```
  A pair of eyes is displayed in a separate window. If you move your cursor over the eyes, the eyes follow it.

2. Hover your cursor over the XLaunch application icon.

  The application indicates that there is one client connected.

3. Close `xclock`.

  The XLaunch application icon indicates that there are zero clients connected.



## **STEP 8**: Configure X11 forwarding for an `oracle` user

It's important to configure X11 forwarding for the `oracle` user too because eventually, you need to be able to display the graphical user interfaces, such as the Oracle Database 19c installer, as the `oracle` user.

1. Create an `oracle` user. The following commands are used to create an `oracle` user in preparation for an Oracle Database 19c installation.

    ```nohighlighting
    $ <copy>groupadd -g 54321 oinstall</copy>
    $ <copy>groupadd -g 54322 dba</copy>
    $ <copy>groupadd -g 54323 oper</copy>
    $ <copy>useradd -u 54321 -g oinstall -G dba,oper oracle</copy>
    ```

2. *IMPORTANT!* As the `opc` user, copy the Xauthority file from the `opc` user to the `oracle` user.

    ```nohighlighting
    $ <copy>sudo cp ~/.Xauthority /home/oracle/.Xauthority</copy>
    ```


3. Switch to the `oracle` user and enter the password.

    ```nohighlighting
    $ <copy>su - oracle</copy>
    ```


## What's Next?

If you intend to install Oracle Database 19c on your compute instance, you need to complete the prerequisite tasks first. See the [Perform Prerequisite Tasks for an Oracle Database 19c Installation](?lab=perform-db19c-prerequisite-tasks.md) lab.



## Learn More

- [Get Started with Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/)
- [Install and Upgrade to Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/install-and-upgrade.html)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Technical Contributors**
    - James Spiller, Principal User Assistance Developer, Database Development
    - Dragos Negru, Principal Cloud Specialist - Data Management, TE Hub
    - Jean-Francois Verrier, User Assistance Director, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, April 21 2021
