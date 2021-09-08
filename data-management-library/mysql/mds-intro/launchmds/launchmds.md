# Launch Your First MySQL Database Service System

## Introduction
In this lab, you will learn how to launch a MySQL Database Service System on Oracle Cloud Infrastructure (OCI) and connect to it using the Oracle Cloud Console.

In this Lab, you will learn how to launch a MySQL Database Service System on OCI and connect to it using the Console.

Estimated Lab Time: 90 minutes

### About MySQL Database Service

MySQL Database Service is a fully-managed OCI, developed, managed, and supported by the MySQL team in Oracle.

### Objectives

In this lab, you will be guided through the following tasks:

- Create a Compartment
- Create a Policy
- Create a Virtual Cloud Network
- Create a MySQL DB System
- Create a Client Virtual Machine
- Connect to a MySQL Database System
- Start, stop, reboot, or delete a MySQL Database

### Prerequisites

- An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
- Some Experience with MySQL Shell
- Create a local Secure Shell (SSH) key

## **TASK 1**: Create Compartment

You must have an Oracle Cloud Infrastructure service (OCI) tenancy subscribed to your home region and enough limits configured for your tenancy to create a MySQL Database System. Make sure to log-in to the Console as an Administrator.

1. From the **Navigation Menu** in the upper left, select **Identity & Security** and select **Compartments**.

   ![Oracle Cloud Console](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/id-compartment.png " ")

2. Click Create Compartment.

    ![Compartment2](./images/01compartment02.png " ")

  >**Note**:  Two Compartments, named Oracle Account Name (root) and a compartment for PaaS, were automatically created by the Oracle Cloud.

3. In the Create Compartment dialog box, in the Name field, enter **MDS_Sandbox**, and Description.  From the  Parent Compartment drop down list. select Parent Compartment.

4. Click Create Compartment.

    ![Compartment3](./images/01compartment03.png " ")

   **Completed Compartment**
    ![Compartment4](./images/01compartment04.png " ")

## **TASK 2**: Create Policy
1.	Click the **Navigation Menu** in the upper left, navigate to **Identity & Security** and select **Policies**.

    ![Policies page](./images/02policy02.png " ")

3.	On the Create Policy page, in the **Description** field, enter **MDS_Policy** and select the root compartment.

3. In the **Policy Builder** section, turn on the **Show manual editor** toggle switch.

    ![Create Policy page](./images/02policy03.png " ")

4. Enter the following required MySQL Database Service policies:

    - Policy statement 1:

    ```
    <copy>Allow group Administrators to {COMPARTMENT_INSPECT} in tenancy</copy>
    ```

    - Policy statement 2:

    ```
    <copy>Allow group Administrators to {VCN_READ, SUBNET_READ, SUBNET_ATTACH, SUBNET_DETACH} in tenancy</copy>
    ```

    c. Policy statement 3:

    ```
    <copy>Allow group Administrators to manage mysql-family in tenancy</copy>
    ```
5. Click the Create button

     ![Policy2](./images/02policy04.png " ")


    **Completed Policy Creation**
    ![Policy3](./images/02policy05.png " ")

## **TASK 3:** Create Virtual Cloud Network

    ![Create Policy page](./images/02policy04.png " ")

    > **Note:** The following screen shot shows the completed policy creation:

    ![Completed policy creation page](./images/02policy05.png " ")

## Task 3: Create a VCN

1. Click the **Navigation Menu** in the upper-left corner, navigate to **Networking**, and select **Virtual Cloud Networks**.

![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/networking-vcn.png " ")

4. click Button Start VCN Wizard
    ![VCN](./images/03vcn03.png " ")

5. Create a VCN with Internet Connectivity

6. On Basic Information  Complete the following fields
    - VCN Name **MDS_VCN**    
    - Compartment **MDS_Sandbox**

7. Your screen should look similar to the following
    ![VCN](./images/03vcn044.png " ")

8. Click the Next button at the bottom of the screen

9. Review Oracle Virtual Cloud Network (VCN), Subnets, and Gateways

10. Click Create button to create the VCN
    ![VCN](./images/03vcn04.png " ")

11. The Virtual Cloud Network creation is completing
    ![VCN](./images/03vcn05.png " ")

12. Click "View Virtual Cloud Network" button to display the  created VCN
    ![VCN](./images/03vcn06.png " ")

13. Click the VCN Name **MDS_VCN**.
            ![COMPUTE](./images/03vcn08.png " ")

14.	On the Virtual Cloud Network Details page, under Resources, click Security Lists (2).
        ![COMPUTE](./images/03vcn09.png " ")

15.	On Security Lists in <Compartment Name> Compartment, click Security List for Private Subnet-MDS_VCN.

    ![COMPUTE](./images/03vcn10.png " ")

16.	On Security List for Private Subnet-MDS_VCN  page, under Ingress Rules, click Add Ingress Rules.
    ![COMPUTE](./images/03vcn11.png " ")

17.	On Add Ingress Rule, add an Ingress Rule with Source CIDR 0.0.0.0/0, Destination Port Name 3306, 33060, and Description  

18. Click Add Ingress Rule.
    ![COMPUTE](./images/03vcn12.png " ")

19.	On Security List for Private Subnet-MDS_VCN page

 New Ingress Rules will be shown under the Ingress Rules List
    ![COMPUTE](./images/03vcn13.png " ")

## **TASK 4:** Create a MySQL Database System.

1. Click the **Navigation Menu** in the upper-left corner, navigate to **Databases**, and select **Database Systems**.

![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-dbsys.png " ")

2. Click **Create MySQL Database System**.

    ![MDS](./images/04mysql02.png " ")

3. On the Create MySQL Database System dialog box, complete the fields in each section:

    - Provide basic information for the database system
    - Set up your required database system
    - Create administrator credentials
    - Configure networking
    - Configure placement
    - Configure hardware
    - Configure backups
    - Show advanced options

4. In **Provide basic information for the DB System**, select the **MDS\_Sandbox** Compartment, in the **Name** field and **Description** field, enter **MDS_DB**.

    ![MDS](./images/04mysql02_02.png " ")

5. In **Setup your required Database System**, select **Standalone** to specify a single-instance database system.

    ![MDS](./images/04mysql02_03.png " ")

6. In **Create Administrator credentials**, enter **admin** for the user name, enter **Welcome1!** for the password, and then enter **Welcome1!** to confirm the password.   

    ![MDS](./images/04mysql02_04.png " ")

7. In **Configure networking**, keep default values **MDS\_VCN** for the VCH and **Private Subnet-MDS\_VCN (Regional)** for the subnet.

    ![MDS](./images/04mysql02_05.png " ")

8. In **Configure placement**, keep **Availability Domain** selected.

    > **Note:** Do not select **Choose a Fault Domain** for this database system. Oracle will select the best placement for you.

    ![MDS](./images/04mysql02_06.png " ")

9. In **Configure hardware**, keep default shape **MySQL.VM.Standard.E3.1.8GB** and keep the default value **50** for the **Data Storage Size (GB)**.

    ![MDS](./images/04mysql02_07.png " ")

10. On Configure Backups, keep  "Enable Automatic Backups" checked

    set Retention period to **7**

    select "Default Backup Window"

    ![MDS](./images/04mysql02_08.png " ")

11. Click Create button
    ![MDS](./images/04mysql02_09.png" ")

12. The New MySQL Database System will be ready to use after a few minutes.

    > **Note:** The New MySQL Database System will be ready to use after a few minutes. The state will be shown as **Creating** during the creation.

    ![MDS](./images/04mysql02_10.png " ")

13. The state Active indicates that the Database System is ready to use.

21. On the MySQL Database System Details page, verify that the MySQL endpoint (address) displays under **Instances**.

    ![MDS](./images/04mysql02_11.png " ")

## **TASK 5:** Create Client Virtual Machine

**Important:** If you have not already completed **Lab 1: Create Local SSH Key**, please do so now.
- When you are finished, return to this TASK 5 #1.

1. You will need a client machine to connect to your brand new MySQL database. Click the **Navigation Menu** in the upper left, navigate to **Compute**, and select **Instances**

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/compute-instances.png " ")

2. On Instances in **MDS_Sandbox** Compartment, click Create Instance.
    ![COMPUTE](./images/05compute02.png " ")

3. On Create Compute Instance enter **MDS_Client**  for the instance Name.

4. Make sure **MDS_Sandbox** compartment is selected.

5. Choose an operating system or image source

    for this lab , select Oracle Linux

6. In the **Configure placement and hardware** section, select the **Availability Domain** and select  **VM.Standard.E2.1.Micro** for the **Shape**.

   ![COMPUTE](./images/05compute03.png " ")

    > **Note:** For the **Virtual cloud network**, make sure **MDS_VCN** is selected and **Assign a public IPv4 address** is set to **Yes**.  

7. Select the Availability Domain and Instance Shape

    select VM.Standard.E2.1.Micro
    ![COMPUTE](./images/05compute03.png " ")

8. For VCN make sure **MDS_VCN** is selected, "Assign a public IP address" should be set to Yes.  
    ![COMPUTE](./images/05compute04.png " ")

9. If you have not already created your SSH key

    * Perform Lab 1: Create Local SSH Key

    * When you are done return to the next line

10. In the Add SSH keys section, generate an SSH key pair or upload your own public key.

11. Select one of the following options:
    * **Generate SSH keys:** Oracle Cloud Infrastructure generates an RSA key pair for the instance. Click Save Private Key, and then save the private key on your computer. Optionally, click Save Public Key and then save the public key.
    * **Generate SSH keys:** Oracle Cloud Infrastructure generates an RSA key pair for the instance. Click Save Private Key, and then save the private key on your computer. Optionally, click Save Public Key and then save the public key.  
    * **Choose SSH key files:** Upload the public key portion of your key pair. Either browse to the key file that you want to upload, or drag and drop the file into the box. To provide multiple keys, press and hold down the Command key (on Mac) or the CTRL key (on Windows) while selecting files.
    * **Paste SSH keys:** Paste the public key portion of your key pair in the box.
    * **No SSH keys:** Do NOT select this option! You will not be able to connect to the Compute Instance using SSH.
     ![COMPUTE](./images/05compute06.png " ")

12. The New Virtual Machine will be ready to use after a few minutes. The state will be shown as Provisioning during the creation
    ![COMPUTE](./images/05compute07.png " ")

13.	The state Running indicates that the Virtual Machine is ready to use.

14. **Save the Public IP Address** under "Instance Access"  on the **MDS_Client** Instance page.
    ![COMPUTE](./images/05compute08.png " ")

## **TASK 6:** Connect to MySQL Database

1. If you are a Linux, Mac, or  Windows 10 Powershell user go to TASK 6: #2

2. If you are a Windows user click Start menu from your windows machine for Git which should include the Git Bash command.

3. Click the Git Bash command. This will take you to the Git Bash terminal as shown below and continue to  TASK 6: #4.
    ![Connect](./images/06connect0.png" ")

4.  From a terminal window on your local system. Connect to the Compute Instance with the SSH command.

5. Indicate the location of the private key you created earlier with **MDS_Client**.

6. Enter the username **opc** and the Public **IP Address**.

    * Note: The **MDS_Client**  shows the  Public IP Address as mentioned on TASK 5: #10

    * (Example: **ssh -i ~/.ssh/id_rsa opc@&132.145.170.990**)

     ````
    <copy>ssh -i ~/.ssh/id_rsa opc@&<your_compute_instance_ip>;</copy>
     ````

    ![Connect](./images/06connect01.png " ")

7. You will need a MySQL client tool to connect to your new MySQL Database System from your client machine.

8. Install MySQL release package  with the following command:

      ````
    <copy>sudo yum -y install https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm</copy>
     ````   

    ```[opc@...]$ sudo yum -y install https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm```

    ![Connect](./images/06connect03.png " ")

9. Install MySQL Shell with the following command

     ````
    <copy>sudo yum install –y mysql-shell</copy>
     ````

    ![Connect](./images/06connect05.png " ")

10. From your Compute instance, connect to MySQL using the MySQL Shell client tool.

    The endpoint (IP Address) can be found in the MySQL Database System Details page, under the "Endpoints" resource.

    ![Connect](./images/06connect06.png " ")

11.  Use the following command to connect to MySQL using the MySQL Shell client tool.

    (Example  **mysqlsh -uadmin -p -h132.145.170....**)

     ````
    <copy>mysqlsh -u<MDS_admin_username> -p -h<MDS_endpoint> </copy>
     ````

    ![Connect](./images/06connect07.png " ")

12. On MySQL Shell, switch to SQL mode  to try out some SQL commands

13. Type the following command at the prompt:

    **\sql**

    ![Connect](./images/06connect13.png " ")

14. To display a list of databases, type the following command at the prompt:

     ````
    <copy>SHOW DATABASES;</copy>
     ````   

15. To display the database version, current_date, and user type the following command at the prompt:
     ````
    <copy>SELECT VERSION(), CURRENT_DATE, USER();</copy>
     ````

16. To display MysQL user and host from user table type the following command at the prompt:

     ````
    <copy>SELECT USER, HOST FROM mysql.user;</copy>
     ````
17. (Optional) At this point, you can also use MySQL Workbench from your local machine to connect to the MySQL endpoint using your new Compute instance as a jump box.

18. In your pre installed MySQL Workbench, configure a connection using the method "Standard TCP/IP over SSH" and use the credentials of the Compute instance for SSH.

19. MySQL Workbench Configuration for MDS:

     ![Connect](./images/06workbench01.png " ")

20. MySQL Workbench Launched for MDS:

     ![Connect](./images/06workbench02.png " ")

## **TASK 7:** Start, stop, or reboot MySQL Database System

1. Click the **Navigation Menu** in the upper left, navigate to **Databases**, and select **Database Systems**.
![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-dbsys.png " ")

2. List Database Systems
![MDS](./images/04mysql02_06.png " ")
3. Choose  **MDS_Sandbox** Compartment

4. Click **MDS_DB** to open the Database System details page
![MDS](./images/04mysql07.png " ")

5. Select one of the following actions:
    * Start: Starts a stopped Database System. After the Database System is started, the Stop action is enabled and the Start option is disabled.
    * Stop: Stops a running Database System. After the Database System is powered off, the Start action is enabled.
    * Restart: Shuts down a Database System, and restarts it.
    * Note: Stopping a Database System stops billing for all OCPUs associated with it.
    * Billing continues for storage.
    * Billing for OCPUs resumes if you restart the Database System.
    * If you selected Stop or Restart, the Stop/Restart MySQL Database System dialog is displayed.

6. Select a shutdown type:
    * Fast: Flushes dirty pages before shutting down the Database System.
    * Some flush operations must be performed during next startup, potentially increasing the duration of the startup process.
    * Slow: Flushes dirty pages and purges undo log pages for older transactions.
    * The shutdown itself can take longer, but the subsequent startup is faster.
    * Immediate: Does not flush dirty pages and does not purge any undo log pages.
    * Stops MySQL immediately. Page flushes and log purging will take place during the next startup, increasing the duration of the startup process.

7. Select the required shutdown type and click the Stop or Restart button, depending on the action chosen.

## **TASK 8:** Delete MySQL Database System

1. Click the **Navigation Menu** in the upper-left corner, navigate to **Databases**, and select **DB Systems**.

1. Click the **Navigation Menu** in the upper left, navigate to **Databases**, and select **Database Systems**.
![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-dbsys.png " ")

2. List Database Systems
![MDS](./images/04mysql02_06.png " ")
Choose  **MDS_Sandbox** Compartment

3. Click **MDS_DB** to open the Database System details page
![MDS](./images/04mysql07.png " ")

4. Click "More Actions" drop down list and select **Delete**
![MDS](./images/04mysql08.png " ")

5. A prompt is displayed asking you to confirm the deletion.
![MDS](./images/04mysql08_1.png " ")
Enter the word, all caps, "DELETE" and click "Delete 1 MySQL Database System" button.

6. When delete process is done **MDS_DB** will be set to Delete status.
## Learn More

* [Oracle Cloud Infrastructure MySQL Database Service Documentation ](https://docs.cloud.oracle.com/en-us/iaas/mysql-database)
* [MySQL Database Documentation](https://www.mysql.com)

## Acknowledgements
* **Author** -  Perside Foster, MySQL Solution Engineering
* **Contributors** -  Airton Lastori, MySQL Principal Product Manager, Priscila Galvao, MySQL Solution Engineering
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, July 2021
