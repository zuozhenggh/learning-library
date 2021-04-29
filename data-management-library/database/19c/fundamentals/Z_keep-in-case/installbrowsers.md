## **STEP 8**: Install a browser on your compute instance

In this example, you install Firefox.

1. Find which versions of Firefox are available through the `yum` repositories.

    ```
    $ sudo yum --showduplicates list firefox
    ```

2. Install Firefox using the most current version. At the time of this writing, the latest is 78.9.0. Enter **y** when prompted. This command installs firefox to /usr/bin/firefox.

    ```
    $ sudo yum install firefox-78.9.0
    ```

    *To uninstall, sudo yum remove firefox*
    or

this worked:
    sudo su -
    rpm -evv firefox

3. yum install dbus-x11


3. Launch firefox in the background (&).

    ```
    $ firefox -P
    ```

    A Firefox - Choose User Profile@compute-1 dialog box is displayed.

4.  Leave all of the default settings as is, and click **Start Firefox**.



**********
CHROME
*************

#sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

# sudo yum -y install redhat-lsb libXScrnSaver (nope)
sudo yum install ./google-chrome-stable_current_*.rpm

# sudo yum -y localinstall google-chrome-stable_current_x86_64.rpm (nope)


uninstall
yum remove google-chrome-stable
