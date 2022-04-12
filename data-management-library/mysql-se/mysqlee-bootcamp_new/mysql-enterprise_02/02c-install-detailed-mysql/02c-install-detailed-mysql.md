# Install Detailed MySQL EE on Linux

## About this Workshop

### Objective

In this lab, you will use Tarball to Install MySQL 8 Enterprise on Linux.

Using Server: **mysql1**

**Notes:**

* we call this instance mysql-advanced
* this is the most used instance in the labs

### Prerequisites and Reminders

1. You need an empty trial environment or a dedicated compartment inside Oracle Cloud Infrastructure (OCI) with user settings access
2. To sign in to the Console, you need the following:
    * Cloud account name
    * User name and Password
3. Oracle Cloud Infrastructure supports the latest versions of
    * Google Chrome
    * Firefox
    * Internet Explorer 11.
    * **It does not support the Edge browser**
4. You should have compled Lab 2a

### Lab standard

This lab uses color coding to identify input type

* **<span style="color:green">shell></span>** The command must be executed in the Operating System shell
* **<span style="color:blue">mysql></span>** The command must be executed in a client like MySQL, MySQL Workbench
* **<span style="color:orange">mysqlsh></span>** The command must be executed in MySQL shell

## Task 1:  Install MySQL EE on Linux

1. If not already connected, connect to mysql1 server trhougth app-srvard

    **<span style="color:green">shell-app-srv></span>**

    ```text
    <copy>ssh -i $HOME/sshkeys/id_rsa_mysql1 mysql1</copy>
    ```

2. On Oracle Linux8/RHEL8/Centos 8 is required to install ncurses-compat-libs to use the tar package (not for the rpms)

    **<span style="color:green">shell-mysql1></span>**

    ```text
    <copy>sudo yum install -y ncurses-compat-libs</copy>
    ```

3. Usually, to run mysql the user “mysql” is used, but because it is already available we show here how  to create a new one.

    Create a new **user/group** for your MySQL service (mysqluser/mysqlgrp) and a add **‘mysqlgrp’** group to opc to help with labs execution.

    a. **<span style="color:green">shell-mysql1></span>**

    ```text
    <copy>sudo groupadd mysqlgrp</copy>
    ```

    b. **<span style="color:green">shell-mysql1></span>**

    ```text
    <copy>sudo useradd -r -g mysqlgrp -s /bin/false mysqluser</copy>
    ```

    c. **<span style="color:green">shell-mysql1></span>**

    ```text
    <copy>sudo usermod -a -G mysqlgrp opc</copy>
    ```

    **You may now proceed to the next lab**

4. Create new directory structure:

    a. **<span style="color:green">shell-mysql1></span>**

    ```text
    <copy>sudo mkdir /mysql/ /mysql/etc /mysql/data</copy>
    ```

    b. **<span style="color:green">shell-mysql1></span>**

    ```text
    <copy>sudo mkdir /mysql/log /mysql/temp /mysql/binlog</copy>
    ```

5. To simplify the lab, add the mysql bin folder to the bash profile and customize the client prompt.

    You can edit the file with the editor that you prefer, here some examples

    **<span style="color:green">shell-mysql1></span>**

    ```text
    <copy>nano /home/opc/.bashrc</copy>
    ```

    **OR**

    **<span style="color:green">shell-mysql1></span>**

    ```text
    <copy>vi /home/opc/.bashrc</copy>
    ```

    Please insert these lines at the end of the file **/home/opc/.bashrc**

    a.

    ```text
    <copy>export PATH=$PATH:/mysql/mysql-latest/bin</copy>
    ```

    b.

    ```text
    <copy>export MYSQL_PS1="\\u on \\h>\\_"</copy>
    ```

6. **<span style="color:red">Close the ssh session and reopen it to activate the new privilege and settings for opc user</span>**

## Learn More

* [https://www.mysql.com/](https://www.mysql.com/)
* [https://docs.oracle.com/en-us/iaas/mysql-database/index.html](https://docs.oracle.com/en-us/iaas/mysql-database/index.html)

## Acknowledgements

* **Author** - Perside Foster, MySQL Engineering
* **Content Creator** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - Perside Foster, April, 2022
