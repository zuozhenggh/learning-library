# Provision Autonomous Database and Compute Instance

## Introduction

In this lab, you will provision a Oracle linux compute instance and log into the instance. Then provision the 21c Oracle Autonomous Database (ADB) Always Free instance and connect to the database as new user.
<!---
Then you will create a bucket, Oracle Wallet, generate auth token and connect to Autonomous Transaction Processing instance using SQL Developer Web and create a database credential for the users in SQL Developer Web to access the object store.
--->
Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:

- Provision a Oracle Linux compute instance and SSH into the instance
- Provision an Oracle 21c Autonomous Transaction Processing instance 
- Create a new user using Database Actions
- Connect to ATP database using SQL Developer Web
<!---
- Create a bucket, Oracle Wallet and auth token
- Connect to ATP with the SQL Developer Web
- Create a Database Credential for the Users
- Create a Database user
--->
### Prerequisites

- You must have logged in to your own cloud account or a LiveLabs account.

## **STEP 1**: Provision a Compute Instance

1. Click on hamburger menu, search for **Compute** and select **Instances** under Compute.

2. Make sure you are in the same region and compartment as the provisioned ATP instance and click on **Create Instance**.

3. Give a name to the instance. In this lab, we use the Name - **DEMOVM**.

4. In Placement, Image and shape, choose the following:
    - **Availability Domain** - For this lab, leave the default instance Placement to Always Free Eligible or you can click on **Edit** and choose an Availability Domain (AD).
    - **Image and shape** - For this lab, leave the default - Always Free Eligible resource or you can click on **Edit** to change the image and shape.

5. In Add SSH keys, choose **Paste public keys** and paste the public key noted earlier in lab 1 and click **Create**.

    *Note* - If the instance is not provisioning, choose a different Availability Domain (AD) and repeat 3 to 5 steps.

6. Your instance will begin provisioning. In a few minutes, the state will turn from Provisioning to Available. At this point, your compute instance is ready to use! Have a look at your instance's details and copy the **Public IP Address** to use later in lab 7.

## **STEP 2** Connect to your Compute instance

There are multiple ways to connect to your cloud instance. Choose the way to connect to your cloud instance that matches the SSH Key you generated.  *(i.e If you created your SSH Keys in cloud shell, choose cloud shell)*

- Oracle Cloud Shell
- MAC or Windows CYCGWIN Emulator
- Windows Using Putty

### Oracle Cloud Shell

1. To re-start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon to the right of the region.  *Note: Make sure you are in the region you were assigned*

    ![](./images/cloudshell.png " ")

2.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
3.  On the instance homepage, find the Public IP address for your instance.

    ![](./images/linux-compute-step3-11.png " ")
4.  Enter the command below to login to your instance.    
    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````

    *Note: The angle brackets <> should not appear in your code.*
    ![](./images/linux-compute-step3-12.png " ")
5.  When prompted, answer **yes** to continue connecting.
6.  Continue to STEP 5 on the left hand menu.

### MAC or Windows CYGWIN Emulator
1.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment)
2.  On the instance homepage, find the Public IP address for your instance.

3.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/cloudshellssh.png " ")

    ![](./images/cloudshelllogin.png " ")

    *Note: The angle brackets <> should not appear in your code.*

4.  After successfully logging in, proceed to STEP 5.

### Windows using Putty

1.  Open up putty and create a new connection.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![](./images/ssh-first-time.png " ")

    *Note: The angle brackets <> should not appear in your code.*

2.  Enter a name for the session and click **Save**.

    ![](./images/putty-setup.png " ")

3. Click **Connection** > **Data** in the left navigation pane and set the Auto-login username to root.

4. Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking Browse under Private key file for authentication.

5. Navigate to the location where you saved your SSH private key file, select the file, and click Open.  NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

    ![](./images/putty-auth.png " ")

6. The file path for the SSH private key file now displays in the Private key file for authentication field.

7. Click Session in the left navigation pane, then click Save in the Load, save or delete a stored session STEP.

8. Click Open to begin your session with the instance.

Congratulations!  You now have a fully functional Linux instance running on Oracle Cloud Compute.
<!---
## **STEP 3:** Create a Bucket

1. Click on the hamburger menu, search for Storage and click on **Buckets** under Object Storage & Archive..

2. Make sure you are in the right compartment where your ATP and compute instance are provisioned and click **Create Bucket**.

3. Give your bucket a name, leave the defaults and click **Create**. In this lab, we name the bucket **demo-bucket**.

4. Once the bucket is created, click on the bucket and make note of the **Bucket Name** and **Namespace**.

## **STEP 4:** Create Oracle Wallet in Cloud Shell

There are multiple ways to create an Oracle Wallet for Autonomous Database. We will be using Oracle Cloud Shell as this is not the focus of this workshop. To learn more about Oracle Wallets and use the interface to create one, please refer to the lab in this workshop: [Analyzing Your Data with ADB - Lab 6](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?p180_id=553)

1.  Click the Cloud Shell icon to start up Cloud Shell.

      ![](./images/cloud-shell.png " ")

2.  Use your **Autonomous Database OCID** to create the Oracle Wallet. You will be setting the wallet password to the same value as the ADB admin password for ease of use: **WElcome123##** Note: This is not a recommended practice and just used for the purposes of this lab.

3.  Copy the command below and paste it into Cloud Shell. *Do not hit enter yet.* Give a space and paste the OCID you noted earlier in step 1 and fill in the autonomous database OCID.

    ````
    <copy>
    cd ~
    oci db autonomous-database generate-wallet --password WElcome123## --file 21c-wallet.zip --autonomous-database-id  </copy> ocid1.autonomousdatabase.oc1.iad.xxxxxxxxxxxxxxxxxxxxxx
    ````

    Your command should look like this

    ```
    <copy>
    oci db autonomous-database generate-wallet --password WElcome123## --file 21c-wallet.zip --autonomous-database-id ocid1.autonomousdatabase.oc1.iad.abuwcljr2euv6kvtnbb32lttjidobc6mryiinvmt3zgp5dxk3edypohoz3zq
    </copy>
    ```

4.  Click **Enter**. Be patient, it takes about 20 seconds. The wallet file will be downloaded to your cloud shell file system in /home/yourtenancyname

    ![](./images/wallet.png " ")

5. Enter the list command in your cloud shell to verify the *21c-wallet.zip* was created.

    ````
    <copy>
    ls
    </copy>
    ````

    ![](./images/21cwallet.png " ")

## **STEP 5:** Create Auth Token

1.  Click on the person icon in the upper right corner.

2.  Select **User Settings**

    ![](./images/select-user.png " ")

3.  Copy the **Username**.

4.  Under the **User Information** tab, click the **Copy** button to copy your **User OCID**.

    ![](./images/copy-user-ocid.png " ")

5.  Create your auth token with description `demotoken`. Copy the below command and paste it on the cloud shell. * Do not hit enter.*  Give a space and paste your user OCID.

    *Note: If you already have an auth token, you may get an error if you try to create more than 2 per user*

    ````
    <copy>
    oci iam auth-token create --description demotoken --user-id </copy> ocid1.user.oc1..axxxxxxxxxxxxxxxxxxxxxx
    ````

    Your command should look like this

    ```
    oci iam auth-token create --description demotoken --user-id ocid1.user.oc1..aaaaaaaaofiwfzgmn6jqsk3lbpr3vhppx2ganh4rdw64s5ssvut5etzehleq
    ```

    ![](./images/token.png " ")

6.  Identify the line in the output that starts with "token" and copy the value for the **token** somewhere safe, you will need it in step 7.
--->

## **STEP 3**: Provision an ATP Instance

1. If you are using a Free Trial or Always Free account, and you want to use Always Free Resources, you need to be in a region where Always Free Resources are available. You can see your current default **Region** in the top, right hand corner of the page.

    ![Select region on the far upper-right corner of the page.](./images/Region.png " ")

2. Once you are logged in, you can view the cloud services dashboard where all the services available to you. Click on hamburger menu, search Oracle Database and choose Autonomous Transaction Processing (ATP).

    **Note:** You can also directly access your Autonomous Transaction Processing service in the **Quick Actions** section of the dashboard.

    ![](./images/choose-adb.png " ")

3. From the compartment drop-down menu select the **Compartment** where you want to create your ATP instance. This console shows that no databases yet exist. If there were a long list of databases, you could filter the list by the **State** of the databases (Available, Stopped, Terminated, and so on). You can also sort by **Workload Type**. Here, the **Transaction Processing** workload type is selected.

    ![](images/livelabs-compartment.png " ")

4. Click **Create Autonomous Database** to start the instance creation process.

    ![Click Create Autonomous Database.](./images/Picture100-23.png " ")

5.  This brings up the **Create Autonomous Database** screen. Specify the configuration of the instance:
    - **Compartment** - Select a compartment for the database from the drop-down list.
    - **Display Name** - Enter a memorable name for the database for display purposes. This lab uses **DEMOATP** as the ADB display name.
    - **Database Name** - Use letters and numbers only, starting with a letter. Maximum length is 14 characters. (Underscores not initially supported.) This lab uses **DEMOATP** as the database name.

    ![Enter the required details.](./images/adw-wine.png " ")

6. Choose a workload type, deployment type and configure the database:
    - **Choose a workload type** - For this lab, choose __Transaction Processing__ as the workload type.
    - **Choose a deployment type** - For this lab, choose **Shared Infrastructure** as the deployment type.
    - **Always Free** - If your Cloud Account is an Always Free account, you can select this option to create an always free autonomous database. An always free database comes with 1 CPU and 20 GB of storage. For this lab, we recommend you to check **Always Free**.
    - **Choose database version** - Select **21c** database version from the available database versions.
    - **OCPU count** - Number of CPUs for your service. Leave as it is. An Always Free databas comes with 1 CPU.
    - **Storage (TB)** - Storage capacity in terabytes. Leave as it is. An Always Free database comes with 20 GB of storage.
    - **Auto Scaling** - For this lab, leave auto scaling unchecked.

    ![Choose the remaining parameters.](./images/Picture100-26c.png " ")

7. Create administrator credentials, choose network access and license type and click **Create Autonomous Database**.

    - **Password** - Specify the password for **ADMIN** user of the service instance. For this lab, we use the password - **WElcome123##**.
    - **Confirm Password** - Re-enter the password to confirm it. Make a note of this password. For this lab, re-enter and confirm password - **WElcome123##**.
    - **Choose network access** - For this lab, accept the default, "Allow secure access from everywhere".
    - **Choose a license type** - For this lab, choose **License Included**.

    ![](./images/create.png " ")

9.  Your instance will begin provisioning. In a few minutes, the state will turn from Provisioning to Available. At this point, your Autonomous Transaction Processing database is ready to use! Have a look at your instance's details here including its name, database version, OCPU count, and storage size.

    ![Database instance homepage.](./images/provision.png " ")

    ![Database instance homepage.](./images/provision-2.png " ")
<!---
10. From the Autonomous Database Details page, make note of your ATP instance **OCID** by clicking on the **Copy** button. You will need it later in this lab.
--->
## **STEP 4:** Create a New User Using Database Actions
<!---
1. Navigate to your ATP, click on the hamburger menu, search for **Oracle Database** and click **Autonomous Transaction Processing**.

2. Click on the Display Name of your ADB instance to navigate to your ADB instance details page. In this lab, click on the provisioned **DEMOATP** instance.

    *Note:* If you can't find your ADB instance, ensure you are in the correct region, compartment and have chosen the right flavor of your ADB instance.
--->
1. On the DEMOATP instance details page, click on the **Tools** tab, select **Database Actions**, a new tab will open up.

2. Provide the **Username - ADMIN** and click **Next**.

3. Now provide the **Password - WElcome123##** for the ADMIN user you created when you provisioned your ADB instance and click **Sign in** to sign in to Database Actions.

4.  In Oracle Database Actions menu, select **Database Users** under Administration.

5. Click on **Create User** to create a new user to access the database.

6. In the Create User page, under User tab, provide the following details:
    - **User Name** - Give the new user a User Name. In the lab, we name the user **Username - DEMOUSER** 
    - **Password** - Provide the new user a password and confirm the Password. In this lab, we provide the same password as admin user for ease of use, **Password - WElcome123##** and confirm the password.
    - **Quota on tablespace DATA** - Set a value for the Quota on tablespace DATA for the user. Click the drop-down and choose **500M**.
    - **Web Access** - Turn on the Web Access radio button to access the SQL Developer Web.
    - **Web access advanced features** - Expand the Web access advanced features and turn off the Authorization required radio button to disable the authorization for `demouser` REST services

7. In the Create User page, under Grant Roles tab, check all the Grated Admin and Default checkboxes for **CONNECT**, **RESOURCE**, **DWROLE** roles.

8.  Click **Create User**. Notice that the new user is created successfully.

9. Click on the copy button for the DEMOUSER REST link and save it noted. Edit the link in notepad by removing the `/ords/demouser/_sdw/` at the end of the link and save it as Autonomous Database URL.

    The saved link should look like this

    ```
    https://c7arcf7q2d0tmld-demoatp.adb.us-ashburn-1.oraclecloudapps.com
    ```

## **STEP 5:** Connect to ATP as a New User

1. Click on the hamburger menu of the Oracle Database Actions and select **SQL** under Development.
<!---
7. Run the below query in the worksheet to grant the DEMOUSER privileges to create directories in a schema.

    ```
    <copy>
    GRANT CREATE ANY DIRECTORY TO DEMOUSER;
    </copy>
    ```

8. To access data in the Object Store you have to enable your database user to authenticate itself with the Object Store using your OCI object store account and Auth token. You do this by creating a private CREDENTIAL object for your user that stores this information encrypted in your Autonomous Transaction Processing. This information is only usable for your user schema.

9.  Copy and paste this the code snippet in to SQL Developer worksheet. Specify the credentials for your Oracle Cloud Infrastructure Object Storage service:

	- Credential name: Description of the auth token. In this example, the auth token is created with the description - `demotoken` in step 5.
	- Username: The username will be the OCI Username. you noted in step 5. Replace the `<username>` with the OCI Username you noted in step 5.
	- Password: The password will be the OCI Object Store Auth Token. Replace the `<token>` with the token you generated in step 5.

	```
	<copy>
	BEGIN
  		DBMS_CLOUD.CREATE_CREDENTIAL(
    		credential_name => 'demotoken',
    		username => '<username>',
    		password => '<token>'
  		);
	END;
	/
	</copy>
	```

    Your procedure should look like this

    ```
    BEGIN
      DBMS_CLOUD.CREATE_CREDENTIAL(
        credential_name => 'demotoken',
        username => 'admin@gmail.com',
        password => 'Sl(Y5Lc90JqxrceFS)N7'
      );
    END;
    /
    ```

10. Click **Run Script** button to run the script. Once the PL/SQL procedure is completed successfully, you are ready to load data from the Object Store.
--->
2. Click on the the URL of the SQL Developer Web tab, replace `admin` with **demouser** and hit Enter.

3. On the Database Actions sign in page, provide the **Username - DEMOUSER**, **Password - WElcome123##** and click **Sign In**.

Congratulations!! Now you are connected to the ATP instance as DEMOUSER from SQL Developer Web.

## Acknowledgements

* **Author** - Anoosha Pilli, Database Product Manager
* **Contributors** -  Anoosha Pilli, Database Product Management
* **Last Updated By/Date** - Anoosha Pilli, July 2021
