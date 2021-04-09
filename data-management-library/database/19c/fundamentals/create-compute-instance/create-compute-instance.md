# Create a Compute Instance

## Introduction
This lab shows you how to quickly create a compute instance, virtual cloud network, and SSH keys in Oracle Cloud Infrastructure. You use Cloud Shell, which is a free Linux shell (within monthly tenancy limits) to access and run commands on your compute instance. You use Object Storage to store the Oracle Database 19c installation ZIP file.

To run the Oracle Universal Installer, which is a graphical user interface (GUI) installer, you need to set up X forwarding using Secure Shell (SSH) or virtual network computing (VNC). In this lab, you use X forwarding. Using X forwarding in an SSH session on your personal computer lets you securely run graphical applications (X clients). For X11 forwarding in SSH to work, your personal computer must be running an X server program, such as Xming or VcXsvr. The X server program manages the interaction between the remote application (the X client) and your computer's hardware. X forwarding is also referred to as X11 forwarding, where 11 stands for version 11.

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


## **STEP 2**: Upload your private key to your Cloud Shell machine

To connect to your compute instance using Cloud Shell, you need to add your private key to the `.ssh` directory on your Cloud Shell machine. The `.ssh` directory already exists on your machine so you do not need to create it.

1. On the toolbar, click the **Cloud Shell** icon. A Cloud Shell machine is created for you. Wait for the prompt to be displayed.

2. From the **Cloud Shell** menu, select **Upload**. The **File Upload to your Home Directory** dialog box is displayed.

3. Click **select from your computer**. Browse to and select your private key file, and then click **Open**. Click **Upload**. Your private key is uploaded to the `home` directory on your Cloud Shell machine.

4. Move your private key to the `.ssh` directory. In the code below, replace `private-key-filename` with the name of own private key file.

    ```
    <copy>mv private-key-filename.key .ssh</copy>
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

1. On the **Instance Information** tab for your compute instance, find the public IP address and copy it to the clipboard.

2. Enter the following `ssh` command to connect to your compute instance, replacing `private-key-file` and `public-ip-address` values with your own values.

    ```
    ssh -i ~/.ssh/private-key-file.key opc@public-ip-address
    ```

    You receive a message stating that the authenticity of your compute instance can't be established. Do you want to continue connecting?

3. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  The terminal prompt becomes `[opc@compute-instance-name ~]$`, where `compute-instance-name` is the name of your compute instance and `opc` is your user account on your compute instance. You are now connected to your new compute instance.



## **STEP 4**: Configure X11 forwarding on your compute instance

1. Still using Cloud Shell, switch to the `root` user.

    ```
    $ sudo su -
    ```

2. Using `yum`, install all the dependencies needed to run X11 applications.
    ```
    # yum install -y xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-utils xorg-x11-apps xorg-x11-fonts-* xorg-x11-font-utils xorg-x11-fonts-Type1
    ```

3. Open the `sshd_config file`

    ```
    # vi /etc/ssh/sshd_config
    ```

4. Edit the following lines to be as follows:

  - `X11Forwarding yes` (already set by default)
  - `X11DisplayOffset 10`
  - `X11UseLocalhost no`

5. Save and exit the vi editor (Press Esc, enter :wq, and press Enter.).

6. Restart the SSH service.

    # systemctl restart sshd
    ```




## **STEP 5**: Install an X server program on your local machine

### For Windows

In this example, you install **VcXsvr**. It's an easy program to install. After you install the program, you launch a program called XLaunch.

1. In a browser on your Windows machine, access the following URL:

    ```
    https://sourceforge.net/projects/vcxsrv/
    ```

2. Click **Download**.

3. In the dialog box, click **Save File** and save the executable to a directory on your local machine. At the time of this writing, the file is named `vcxsrv-64.1.20.9.0.installer.exe`.

4. Double-click the executable file to launch the installer for VcXsvr.

5. For type of install, do a full (all options selected, VcXsrv, Fonts, Start Menu Shortcuts, Desktop Shortcuts), and click **Next**.

6. For **Destination folder**, leave **C:\Program Files\VcXsrv** as is, and click **Install**.

7. When the installation is finished, click **Close**.

8. From the windows **Start** menu, select **VcXsrv** > **XLaunch**.

9. For **Display Settings**, leave **multiple windows** selected. For **Display number**, leave **-1** as is to let VcSsrv automatically choose one. Click **Next**.

10. On the **Select how to start clients** page, select **Start no client**, and click **Next**.

11. On the **Extra settings** page, select all options, including **Disable access control**, click **Next**.

12. Click **Finish**.

  In the bottom right corner, a VcXsrv icon is displayed.

13. If you need to stop XLaunch, double-click the icon and click **Exit**. But leave it running for now.






## **STEP 6**: Convert your private key to a .ppk file

On Windows:

1. Open **PuTTY Key Generator**.

2. From the **Conversions** menu, select **Import key**.

3. Browse to and select the private key file (.key) that was generated for you when you created your compute instance, and click **Open**. Your private key is converted into PPK format.

4. Leave **RSA** as the type of key to generate, and click **Save private key**.

5. Click **Yes** to save without a passphrase.

6. Enter a name for your private key, and click **Save**. It's helpful to use the same name as your original `KEY` file, but with a `PPK` file extension.

7. Close PuTTY Key Generator.





## **STEP 7**: Connect to your compute instance from your local machine

### Connect via PuTTY (Windows):

1. Open PuTTY. A **PuTTY Configuration** dialog box is displayed.

2. Configure the **Session** tab as follows:

  - **Hostname**: Enter the public IP address for your compute instance
  - **Port**: Leave port **22** as is.


3. Browse to **Connection** > **SSH** > **Auth**, and configure the following:

  a) In the **Authentication parameters** area, click **Browse**.

  b) Browse to your private key directory, select your private key (in `PPK` format), and then click **Open**.

4. Browse to **Connection** > **SSH** > **X11**, and configure the following:

  a) Select **Enable X11 forwarding**.

  b) Leave the **X display location** box empty.


5. Return to the **Session** tab. In the **Saved Sessions** box, enter the name of your compute instance, and then click **Save**.

5. Click **Open**. A message is displayed that the server's host key is not cached in the registry.

6. Click **Yes** because you trust this host. You are now logged in as the `opc` user.

  The following line is displayed:

  `/usr/bin/xauth: file /home/opc/.Xauthority does not exist`

  The .Xauthority file is automatically generated the first time you log in to your compute instance. For subsequent logins, you do not see this message. The .Xauthority file stores credentials in cookies used by `xauth` for authentication of X sessions. Once an X session is started, the cookie is used to authenticate connections to that specific display.

7. Display the authorization information for the `opc` user used to connect to the X server.

    ```
    xauth list
    ```
    The output is similar to the following:
    ```
    compute1.subnet03311012.vcn03311012.oraclevcn.com:10  MIT-MAGIC-COOKIE-1  9055a7967897789f94fd6a3fbc1b4b90
    ```

8. View the `DISPLAY` environment variable.

    ```
    echo $DISPLAY
    ```
    The output should be `your-computer-ip:10.0`. Notice that the `10` is also part of the authentication information in the previous step.

9. Test that the `opc` user can open a graphical user interface application like `xeyes`.

    ```
    $ xeyes
    ```
  A pair of eyes is displayed in a separate window. If you move your cursor over the eyes, the eyes will follow it.

8. Hover over the XLaunch application icon. The application indicates that there is one client connected.

9. Close `xclock`. The XLaunch application icon indicates that there are zero clients connected.







You can now [proceed to the next lab](#next).


## Learn More

- [Get Started with Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/)
- [Install and Upgrade to Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/install-and-upgrade.html)

## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Technical Contributor** - James Spiller, Principal User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, April 1 2021




just in case

## **STEP x**: Permanently set the `DISPLAY variable` for the `root` and `opc` users

1. Open the `root` user's profile into the `vi` editor.

    ```
    vi ~/.bash_profile
    ```

2. Under `PATH=$PATH:$HOME/bin`, add the following line:

    ```
    DISPLAY=localhost:10.0
    ```
  Note: In the line above, the 10.0 means that the display = `10` and screen =`0`.
  Tip: Press "i" for insert mode in the vi editor. Press "d" and use the left and right arrow keys to delete text.

3. Under `export PATH`, enter the following line:

    ```
    export DISPLAY
    ```

4. Press **ESC**, enter **:wq**, and then press **Enter** to save your changes.

5. Change to the `opc` user.

    ```
    # su - opc
    ```

5. Repeat steps 1 to 4 for the `opc` user.
