# Install VNC Server- LiveLabs #

## Introduction
This lab will show you how to install a VNC Server, for graphical applications, on a Compute Instance.

# Prerequisites
This lab assumes that you have created a Compute Instance using an image that does not contain a VNC server or an application development environment.
Oracle Cloud Infrastructure Marketplace offers a <a href="https://cloudmarketplace.oracle.com/marketplace/en_US/adf.task-flow?adf.tfId=adhtf&adf.tfDoc=/WEB-INF/taskflow/adhtf.xml&application_id=54030984" "target=\_blank">Developer Image /a> that you can use to create an Oracle Cloud Compute instance to serve as your application development system. This image is preconfigured to contain many development tools and utilities.

## **Step 1:** Install VNC Server and GNOME Desktop

1. Open an SSH or Putty connection to your Compute Instance and log in as *opc*
![./images/putty_connect.png]()

2. Install the GNOME desktop
````
<copy>
sudo yum -y groups install "Server with GUI"
</copy>
````
You will see output similar to:
````
Loaded plugins: langpacks, ulninfo
Repository ol7_latest is listed more than once in the configuration
...
Transaction Summary
==================================================
Install  209 Packages (+659 Dependent packages)
Upgrade               (   3 Dependent packages)

Total download size: 678 M
Is this ok [y/d/N]: y
Downloading packages:
...
Complete!
````
**Note** This is a truncated view

3. Install a VNC Server. We use TigerVNC in this example

````
<copy>
sudo yum -y install tigervnc-server
</copy>
````
You will see output similar to:
````
Loaded plugins: langpacks, ulninfo
...
Resolving Dependencies
--> Running transaction check
---> Package tigervnc-server.x86_64 0:1.8.0-17.0.1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

====================================================================
 Package           Arch      Version             Repository    Size
====================================================================
Installing:
 tigervnc-server   x86_64    1.8.0-17.0.1.el7    ol7_latest   215 k
Transaction Summary
====================================================================
Install  1 Package

Total download size: 215 k
Installed size: 509 k
...
Installed:
  tigervnc-server.x86_64 0:1.8.0-17.0.1.el7
Complete!
````
**Note** This is a truncated view

3. Configure your VNC server

````
vncserver
````
You will be required to provide a *password* that you will need to remember to be able to access this server via VNC. There is no need to enter a *view-only password*.

You will see output similar to:
````
You will require a password to access your desktops.
Password:
Verify:
Would you like to enter a view-only password (y/n)? n
A view-only password is not used
xauth:  file /home/opc/.Xauthority does not exist

New 'instance-2019xxx-15xx:1 (opc)' desktop is instance-2019xxx-15xx:1

Creating default startup script /home/opc/.vnc/xstartup
Creating default config /home/opc/.vnc/config
Starting applications specified in /home/opc/.vnc/xstartup
Log file is /home/opc/.vnc/instance-20191113-1544:1.log
````

# Step 2 VNC Viewer On your laptop
If you are using an Apple Mac, you can use the <a href="https://support.apple.com/guide/mac-help/share-the-screen-of-another-mac-mh14066/mac" "target=\_blank"> Screen Sharing application </a>. On other operating systems you will need a suitable VNC viewer.

1. Install a VNC viewer for Windows
<a href="https://tigervnc.org/TigerVNC" "target=\_blank"> TigerVNC</a> is available from *My Desktop* for Oracle employees

2. Configure an SSH Tunnel
You will need the full path to the SSH private-key generated earlier and the IP address of your Compute Instance

Open a Terminal Window on Apple Mac or Powershell on Windows (Press the Windows key and search for Powershell)
![./images/powershell.png]()

````
ssh -N -L 5901:127.0.0.1:5901 -i 'C:\My_SSH_Key\My_compute_instance_private_key_openSSH.ppk' opc@120.130.140.10
````
*Note* You will need the path to your private key and the IP address of your Compute Instance
*Note* You must either be outside the Oracle Firewall (VPN NOT running) or have a proxy defined
Do Not close the Powershell Window or Mac terminal window - this will close the tunnel

This will create a tunnel for VNC through SHH.

3. Open a VNC Viewer using *localhost:1* as the address of the VNC Server
![./images/tigervnc-viewer.png]()

# Step 3 Connect to the VNC Server on your Compute Instance
1. Provide the password you set for the VNC Server
![./images/tigervnc_autheticate.png]()

#Step 4 Configure GNOME desktop - on first login

1. The first time you login to the VNC viewer you will be asked a series of questions to configure the GNOME desktop:
![./images/Gnome_setup_1.png]()

Choose your language of choice, keyboard layout, privacy setting for Location Services, and *Skip* conecting your online accounts.
![./images/Gnome_setup-5.png]()

# Step 5 - Logged in

1. You should now be logged in to your Compute Instance

![./images/tigervnc_screen.png]()


## Acknowledgements

- **Author** - Troy Anthony, DB Product Management
- **Last Updated By/Date** - Troy Anthony, May 21 2020


-----------------------------


## **STEP 6**: Set up VNC Server on your compute instance
VNC (Virtual Network Computing) Server allows the remote Desktop sharing using remote VNC clients like VNC viewer. In CentOS 7 & RHEL 7 package named “tigervnc-server” needs to be installed in order to setup the VNC server. In order to set up VNC server, you first need to install Gnome Desktop.


1. Log in as the `root` user. You can use either the -X or -Y flog to enable X11 forwarding through SSH.

ssh –Y root@compute-instance-name

```
ssh -Y private-key-file.key root@public-ip-address
```


----------

1. Install VNC Server on your compute instance

# sudo yum -y install tigervnc-server

5.Configure VNC Server


# vncserver

output:
 New 'computeinstance1:3 (root)' desktop is computeinstance1:3

  Starting applications specified in /root/.vnc/xstartup
  Log file is /root/.vnc/computeinstance1:3.log


6. Configure VNC Viewer on your local computer

If you are using an Apple Mac, you can use the <a href="https://support.apple.com/guide/mac-help/share-the-screen-of-another-mac-mh14066/mac" "target=\_blank"> Screen Sharing application </a>.
On other operating systems you will need a suitable VNC viewer.

If on Windows, install TigerVNC Viewer for Windows
<a href="https://tigervnc.org/TigerVNC" "target=\_blank"> TigerVNC Viewer 1.3 </a> is available from *My Desktop* for Oracle employees.




---------------------

## **STEP 6**: Install a VCN Server on the compute instance

You need to install a VCN Server on your compute instance so that the Oracle Universal Installer can be displayed on your local computer. Refer to this doc:https://docs.oracle.com/cd/E89497_01/html/rpm_80_installation/GUID-951AEA8D-AC3E-4F8C-83E6-9D88D312D055.htm.

1. Change to the root user.

2. Install TigerVNC Server.

    ```nohighlighting
    # <copy>yum install tigervnc-server
    ```

3. Reboot your compute instance.

    ```nohighlighting
    # reboot
log in as root
start server: vncserver :1 (start server as user you want to be connected as)
- we logged in as oracle

vcn password J0415gjj!123

creates a desktop

ps -ef | grep vnc
