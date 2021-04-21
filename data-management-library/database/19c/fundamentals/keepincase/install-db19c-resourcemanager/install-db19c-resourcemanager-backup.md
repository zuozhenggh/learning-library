# Install Oracle Database 19c by Using Resource Manager

## Introduction

In this lab, you use Resource Manager in Oracle Cloud Infrastructure (OCI) to quickly create a compute instance and install Oracle Database 19c on it. You can use this database to try out all the new features that are covered in later labs.

In Resource Manager, you create a stack, which is a collection of Oracle Cloud Infrastructure resources corresponding to a given Terraform configuration. A Terraform configuration is a set of one or more TF files written in HashiCorp Configuration Language (HCL) that specify the Oracle Cloud Infrastructure resources to create. The Terraform configuration that you use in this lab is provided by LiveLabs and specifies a compute instance running Linux 7.8, a virtual cloud network (VCN), and Oracle Database 19c (release 19.7). After you create the stack, you apply it to start the provisioning job in OCI. When the job is completed, you connect to your compute instance and database. To learn more about Resource Manager, view this [video](https://youtu.be/udJdVCz5HYs).

In this lab, you use Cloud Shell to connect to your compute instance and database. Cloud Shell is a small virtual machine running a Bash shell, which you can access through the OCI console. With Cloud Shell, you always use SSH (Secure Shell protocol) with an SSH key pair (public key and private key) to connect to your compute instance. You need to create the SSH key pair before creating the stack in Resource Manager.


### Objectives

In this lab, you learn how to do the following:

- Create an SSH key pair
- Create and apply a stack in Resource Manager
- Connect to your compute instance from Cloud Shell
- Discover the container database (CDB) and pluggable database (PDB)

### Prerequisites

- You have an Oracle account. You can obtain a free account by using Oracle Free Tier or you can use a paid account provided to you by your own organization.

### Assumptions

- You are signed in to Oracle Cloud Infrastructure.


## **STEP 1**: Create an SSH key pair

1. On the toolbar in Oracle Cloud Infrastructure, click the **Cloud Shell** icon to open the Cloud Shell window, and wait for a terminal prompt to be displayed at the bottom of the page.

  ![Cloud Shell icon](images/cloud-shell-icon.png)

2. Create a `.ssh` directory to store your private key.

    ```nohighlighting
    $ <copy>mkdir .ssh</copy>
    ```

3. Set permissions on the `.ssh` directory so that only you (the owner) can read, write, and execute on the directory. Also set permissions on the private key itself so that only you (the owner) can read and write (but not execute) on the private key file.

  *REVIEWER*: Is this needed? I think you need to make sure the private key has chmod 600 * applied to it

    ```nohighlighting

    $ <copy>chmod 700 ~/.ssh</copy>
    $ <copy>cd .ssh</copy>
    $ <copy>chmod 600 *</copy>
    ```


4. While you are in the `.ssh` directory, generate an SSH key pair. This lab specifies `cloudshellkey` as the key name, however, you can use any name you like. When prompted, press **Enter** to not enter a passphrase.

    ```nohighlighting
    $ <copy>ssh-keygen -b 2048 -t rsa -f cloudshellkey

    Generating public/private rsa key pair.
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in cloudshellkey.
    Your public key has been saved in cloudshellkey.pub.
    The key fingerprint is:
    SHA256:EJBYzyxwwHi9y4jc+pqWVjSvFtiv2xmj+K9C4IovcSY jody_glove@2ff9ae3459e2
    The key's randomart image is:
    +---[RSA 2048]----+
    | oo=+o.          |
    |. +oo+ .         |
    | .  ..=          |
    |.  o.. .         |
    |+.=oo.  S        |
    |E=+=o.           |
    |+=+ +o           |
    |+*ooo.+          |
    |o*BB=+           |
    +----[SHA256]-----+</copy>
    ```

5. Confirm the private key and public key files exist in the `.ssh` directory. In this example, there is a private key named `cloudshellkey` and a public key named `cloudshellkey.pub`. For security reasons, it's important that you keep the private key safe and don't share its content with anyone.

    ```nohighlighting
    $ <copy>ls</copy>

    cloudshellkey  cloudshellkey.pub
    ```

6. Show the contents of the public key. It starts with `ssh-rsa`.

    ```nohighlighting
    $ <copy>cat cloudshellkey.pub</copy>

    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqs9uly7HqmiJlaSQmgJ8gmJ65avZt5KBGN+kgcgxKDbLdmVqaN0Ois3vnrMeHYN+gHFp2qRM4RV7bAwbrHaTo6PqAhqMqmF/k5o5c23/+WlL+HUOS00UXBBYLVz2v2kz3dq10E7zwX68DKqaBRo5iPSoLGssh2lWq8yTMFnD04nma5DSzV5LpIa9bWTaUU4jVGVhvAdX+832yOfzflkEWdaaX6rh17t6IuY5aiOWgDJmdNQouXsmqDHFS98tJFqmNDzrx7qL5tP0q0HzcQ7BNkdWamy1znwJBiRferLGzlLvOEEDpjgTzmgRKzeoLieFACQh+iXbTJ4jfyTrP9va1jody_glove@2ff9ae3459e2
    ```

7. Copy the contents of the public key to the clipboard and save it somewhere (for example, in NotePad++) for later. Make sure you remove any hard returns that sometimes get added when copying text. The public key needs to be all on one line.  

  Tip: In NotePad++, you can view hard returns by selecting **View**, then **Show Symbol**, and then **Show All Characters**.  


## **STEP 2**: Create and apply a stack in Resource Manager

1. Download [livelabs-db19compute-0812.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/R_vJuMUIrsFofKYcTuJOsDiXl2xdSjHNQU7yjQPtnh4/n/c4u03/b/labfiles/o/livelabs-db19ccompute-0812.zip) to a directory on your local computer. This ZIP file contains the terraform script.

2. On the home page in Oracle Cloud Infrastructure, click **Create a stack**. The **Create Stack** page is displayed. The **Create Stack** page is displayed.

  ![Create a stack tile on the home page](images/create-a-stack.png)

3. For **Stack Information**, do the following:

  a) Select **My Configuration**.

  b) In the **Stack Configuration** area, select **.ZIP file**, click **Browse**, select the ZIP file that you just downloaded (`livelabs-db19ccompute-0812.zip`), and then click **Open**.

  c) Scroll down, and in the **NAME** box, enter a name of your choice, for example, **livelabs19c**.

  ![Stack Information](images/stack-information-page.png)

  d) Click **Next**.

4. For **Configure Variables**, do the following:

  a) Leave **Region** as is.

  b) Select the compartment in which you want to create the compute instance.

  c) Select an availability domain.

  d) Select **Paste SSH Key**, and paste the contents of your public key into the box.

  e) Leave **VMStandard.E2.4** selected as the instance shape. This shape meets the memory requirements for installing Oracle Database 19c.

  f) Leave the network settings as is.

  ![Configure Variables](images/configure-variables-page.png)

  g) Click **Next**.

5. On the **Review** page, verify that the information is correct.

  ![Review page](images/review-page.png)

6. Click **Create**. Your stack is created and the **Stack Details** page is displayed.

  ![Stack Details page](images/stack-details-page.png)

6. From the **Terraform Actions** drop-down, select **Apply**. The **Apply** window is displayed.

7. In the **Apply** window, leave the name as is and the **APPLY JOB PLAN RESOLUTION** set to **Automatically approve**, and click **Apply**. Resource Manager starts a job to deploy your resources.

  ![Apply window](images/apply-window.png)

8. When the job is finished, inspect the log. The last line should read `Apply complete!`.




## **STEP 3**: Connect to your compute instance from Cloud Shell

1. From the navigation menu, select **Compute**, and then **Instances**.

2. Find the compute instance that you created (called **Workshop**) and make note of its public IP address.

3. Open Cloud Shell if it not already opened.

4. Enter the following `ssh` command to connect to your compute instance. Replace `private-key-file` with the name of your private key file. In this example, we use `cloudshellkey`. Replace `public-ip-address` with the public IP address of your compute instance.

    ```nohighlighting
    $ <copy>ssh -i ~/.ssh/cloudshellkey opc@public-ip-address</copy>
    ```

    You receive a message stating that the authenticity of your compute instance can't be established. Do you want to continue connecting?

5. Enter **yes** to continue. The public IP address of your compute instance is added to the list of known hosts on your Cloud Shell machine.

  The terminal prompt becomes `[opc@compute-instance-name ~]$` (for example, `opc@workshop`), where `compute-instance-name` is the name of your compute instance and `opc` is your user account on your compute instance. You are now connected to your new compute instance.


## **STEP 4**: Discover the container database (CDB) and pluggable database (PDB)

1. Switch to the `oracle` user.

    ```nohighlighting
    [opc@workshop ~]$ <copy>sudo su - oracle</copy>
    ```

2. Track the database installation and configuration by viewing the `dbsingle.log` file.

    ```nohighlighting
    [oracle@workshop ~]$ <copy>tail -f /u01/ocidb/buildsingle.log</copy>
    ```
    ...
    INFO (node:workshop): Creating database (ORCL) (Single Instance)
    ...
    Prepare for db operation
    8% complete
    Copying database files
    31% complete
    Creating and starting Oracle instance
    32% complete
    36% complete
    ...
    ```

3. Wait for the log to state the following information. It takes *approximately 20-30 minutes* for the database to be configured and ready for use.

    ```nohighlighting
    ...
    21-04-18 22:29:38:[buildsingle:Done :workshop] Building 19c Single Instance
    2021-04-18 22:29:38:[buildsingle:Time :workshop] Completed successfully in 2367 seconds (0h:39m:27s)
    ```

4. Run the following command to verify the database is running.

    ```nohighlighting
    $ <copy>ps -ef | grep ORCL</copy>

    ...
    oracle   12100     1  0 22:40 ?        00:00:00 ora_w00e_ORCL
    oracle   12104     1  0 22:40 ?        00:00:00 ora_w00f_ORCL
    opc      12412 10323  0 22:44 pts/1    00:00:00 grep --color=auto ORCL
    ```

5. Verify the listener is running.

    ```nohighlighting
    $ <copy>ps -ef | grep tns</copy>

    root        61     2  0 21:49 ?        00:00:00 [netns]
    oracle    4574     1  0 21:50 ?        00:00:00 /u01/app/oracle/product/19c/dbhome_1/bin/tnslsnr LISTENER -inherit
    opc      12602 10323  0 22:46 pts/1    00:00:00 grep --color=auto tns
    ```

6. Set the environment variables to point to the Oracle binaries. When prompted for the SID (Oracle Database System Identifier), enter **ORCL**.

    ```nohighlighting
    $ <copy>. oraenv</copy>
    ORACLE_SID = [oracle] ? ORCL
    The Oracle base has been set to /u01/app/oracle
    [oracle@workshop ~]$
    ```

7. Using SQLPlus, connect to the `root` container of your database. SQL*Plus is an interactive and batch query tool that is installed with every Oracle Database installation.

    ```nohighlighting
    $ <copy>sqlplus / as sysdba</copy>

    SQL*Plus: Release 19.0.0.0.0 - Production on Wed Apr 14 22:52:11 2021
    Version 19.10.0.0.0

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0

    SQL>
    ```

8. Verify that you are logged in to the `root` container as the `SYS` user.

    ```nohighlighting
    SQL> <copy>SHOW user</copy>

    USER is "SYS"
    SQL>
    ```

9. Find the current container name. Because you're currently connected to the `root` container, the name is `CDB$ROOT`.

    ```nohighlighting
    SQL> <copy>SHOW con_name</copy>

    CON_NAME
    -------------------
    CDB$ROOT
    SQL>
    ```

10. List all of the containers in the CDB by querying the `V$CONTAINERS` view. The results list three containers - the `root` container (`CDB$ROOT`), the seed PDB (`PDB$SEED`), and the pluggable database (`ORCLPDB`).

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

11. Exit SQL*Plus.

    ```nohighlighting
    SQL> <copy>EXIT</copy>

    $
    ```
12. Using SQL*Plus, connect to the pluggable database `orclpdb` as the `oracle` user.

  *REVIEWER: Why do we say connect as the oracle user? Isn't this the SYSTEM user?*

    ```nohighlighting
    $ <copy>sqlplus system/Ora_DB4U@localhost:1521/orclpdb</copy>      
    ```
13. Exit SQL*Plus.

    ```nohighlighting
    SQL> <copy>EXIT</copy>
    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0

    $
    ```
Congratulations! You have a fully functional Oracle Database 19c instance running on a compute instance in Oracle Cloud Infrastructure.

You may now [proceed to the next lab](#next).
