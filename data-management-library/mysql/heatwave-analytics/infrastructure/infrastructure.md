# Infrastructure Configuration 

## Introduction

In this lab we will build the infrastructure that we will use to run the rest of the workshop. The main three elements that we will be creating are a Virtual Cloud Network which helps you define your own data centre network topology inside the Oracle Cloud by defining some of the following components (Subnets, Route Tables, Security Lists, Gateways, etc.), bastion host which is a compute instance that serves as the public entry point for accessing a private network from external networks like the internet, and finally we will create an Oracle Analytics Cloud instance which is embedded with machine learning, that helps organizations to discover unique insights faster with automation and intelligence.

Estimated Time: 30 minutes

### Objectives
 
-	Create a Virtual Cloud Network and allow traffic through MySQL Database Service port
-	Create a bastion host compute instance 
-	Connect to the bastion host, install MySQL Shell and download the workshop dataset
- Create an Oracle Analytics Cloud instance

### Prerequisites

  - Oracle Free Trial Account.


## Task 1: Create a Virtual Cloud Network and allow traffic through MySQL Database Service port

1. Log-in to your OCI tenancy. Once you have logged-in, select **Networking >> Virtual Cloud Networks** from the **menu icon** on the top left corner.

    ![](./images/task1.1.png)

2. From the Compartment picker on the bottom left side, select your compartment from the list.

  _Note: If you have not picked a compartment, you can pick the root compartment which was created by default when you created your tenancy (ie when you registered for the trial account). It is possible to create everything in the root compartment, but Oracle recommends that you create sub-compartments to help manage your resources more efficiently._

    ![](./images/task1.2.png)

3. To create a virtual cloud network, click on **Start VCN Wizard**.
  
    ![](./images/task1.3.png)

4. Select **VCN with Internet Connectivity** and click **Start VCN Wizard**.

    ![](./images/task1.4.png)

5. Now you need to complete some information and set the configuration for the VCN. In the **VCN Name** field enter the value 
**`analytics_vcn_test`** (or any name at your convenience), and make sure that the selected compartment is the right one. Leave all the rest as per default, Click **Next**.

    ![](./images/task1.5.png)

6. Review the information showed is correct and click **Create**.

    ![](./images/task1.6.png)

7. Once the VCN will be created click **View Virtual Cloud Network**.

    ![](./images/task1.7.png)

8. Click on the **`Public_Subnet-analytics_vcn_test`**. 

    ![](./images/task1.8.png)

9. Earlier we set up the subnet to use the VCN's default security list, that has default rules, which are designed to make it easy to get started with Oracle Cloud Infrastructure. 
 Now we will customize the default security list of the VCN to allow traffic through MySQL Database Service ports by clicking on  **`Default_Security_List_for_analytics_vcn_test`**.

    ![](./images/task1.9.png)

10. Click on **Add Ingress Rules**.

    ![](./images/task1.10.png)

11. Add the necessary rule to the default security list to enable traffic through MySQL Database Service port. 

  Insert the details as below:
    -  Source CIDR  **0.0.0.0/0**
    -  Port **3306**
    -  Description  **MySQL Port**

  At the end click the blue button **Add Ingress Rules**.

  ![](./images/task1.11.png)



## Task 2: Create a bastion host compute instance  

1. From the main menu on the top left corner select **Compute >> Instances**.
  
    ![](./images/task2.1.png)

2. In the compartment selector on the bottom left corner, select the same compartment where you created the VCN. Click on the **Create Instance** blue button to create the compute instance.

    ![](./images/task2.2.png)

3. In the **Name** field, insert **mysql-analytics-test-bridge** (or any other name at your convenience). This name will be used also as internal FQDN. 
  The **Placement and Hardware section** is the section where you can change Availability Domain, Fault Domain, Image to be used, and Shape of resources. For the scope of this workshop leave everything as default.

    ![](./images/task2.3.png)


4. As you scroll down you can see the **Networking** section, check that your previously created **VCN** is selected, and select your PUBLIC subnet **`Public Subnet-analytics_vcn_test(Regional)`** from the dropdown menu.
  
    ![](./images/task2.3-1.png)


5. Scroll down and MAKE SURE TO DOWNLOAD the proposed private key. 
You will use it to connect to the compute instance later on.
Once done, click **Create**.

    ![](./images/task2.4.png)

6. Once the compute instance will be up and running, you will see the square icon on the left turning green. However, you can proceed to the next **Task** until the provisioning is done.
  
    ![](./images/task2.5.png)


## Task 3: Connect to the bastion host, install MySQL Shell and download the workshop dataset

1. In order to connect to the bastion host, we will use the cloud shell, a small linux terminal embedded in the OCI interface.
To access cloud shell, click on the shell icon next to the name of the OCI region, on the top right corner of the page.

    ![](./images/task3.1.png)

2. Once the cloud shell is opened, you will see the command line:
  
    ![](./images/task3.2.png)

  We suggest to increase the font size:
  
    ![](./images/cloud-shell-3.png)

  On the top left corner of the cloud shell there are Minimize, Maximize and Close buttons. If you Maximize the cloud shell it will take the size of the entire page. Remember to Restore the size or Minimize prior of changing page in the OCI interface.

    ![](./images/cloud-shell-4.png)

3. Drag and drop the previously saved private key into the cloud shell. You can get the file name with the command **ll**.
  
    ![](./images/task3.3.png)

    ![](./images/task3.3-1.png)


4. Copy the **Public IP Address** of the compute instance you have just created.

    ![](./images/task3.4.png)

5. In order to establish an ssh connection with the bastion host using the Public IP, execute the following commands:
    ```
    <copy>
    chmod 600 <private-key-file-name>.key
    </copy>
    ```

    ```
    <copy>
    ssh -i <private-key-file-name>.key opc@<compute_instance_public_ip>
    </copy>
    ```
    ![](./images/task3.4-1.png)

  If prompted to accept the finger print, type **yes** and hit enter, then you will get a Warning.

  _**Warning: Permanently added '130. . . ' (ECDSA) to the list of known hosts.**_


6. From the established ssh connection, install MySQL Shell and MySQL client executing the following commands and the expected outputput should be as following:
      
    ```
    <copy>wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm</copy>
    ```
    ![](./images/task3.5.png)

    ```
    <copy>sudo yum localinstall mysql80-community-release-el7-3.noarch.rpm</copy>
    ```
    ![](./images/task3.5-1.png)

  When prompted a warning about the public key type "y"

    ```
    <copy>sudo yum install mysql-shell</copy>  
    ```
    ![](./images/task3.5-2.png)

  When prompted a warning about the public key type "y"

    ```
    <copy>sudo yum install mysql-community-client</copy>
    ```

    ![](./images/task3.5-3.png)

  When prompted a warning about the public key type "y"


7. Launch MySQL Shell executing the following command:
    ```
    <copy>mysqlsh</copy>
    ```
  When you see the MySQL Shell colorful prompt, exit with the following command:
    ```
    <copy>
    \q
    </copy>
    ```
    ![](./images/task3.6.png)


8. Download and unzip the workshop material using the following commands:
    ```
    <copy>
    cd /home/opc
    </copy>
    ```

    ```
    <copy>wget https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/Ufty1RlzG7jobFAsNTsyaEgDVBgSLfiPGcxLscTxVOUxDN8MX6Jswj85_Iw7_bS2/n/odca/b/workshops-livelabs-do-not-delete/o/heatwave_workshop.zip</copy>
    ```

    ![](./images/task3.7.png)

    ```
    <copy>unzip heatwave_workshop.zip</copy>
    ```

    ![](./images/task3.7-1.png)

9. Verify the extracted material executing **ll** command.
  Among the output, you should see the following file names:

  **`tpch_dump`**

  **`tpch_offload.sql`**

  **`tpch_queries_mysql.sql`**

  **`tpch_queries_rapid.sql`**

    ![](./images/task3.8.png)

## Task 4: Create an Oracle Analytics Cloud instance

In this task we will create an Oracle Analytics Cloud instance before we proceed to the next lab, since it may takes sometime to be provisioned, so it will be **Running** status when we will use it later in this workshop.

1. Click on the menu icon on the left. Verify that you are signed in as a **Single Sign On** (Federated user) user by selecting the **Profile** icon in the top right hand side of your screen. If your username is shown as:

    oracleidentitycloudservice/<your username>

 Then you are **connected** as a **Single Sign On** user.

    ![](./images/FU1.png)

  If your username is shown as:

    <your username>

 Then you are **signed in** as an **Oracle Cloud Infrastructure** user and you may proceed to the **Task 4.2** .

  If your user does not contain the identity provider (**oracleidentitycloudprovider**), please logout and select to authenticate using **Single Sign On**.

    ![](./images/FU3.png)

  To be capable of using **Oracle Analytics Cloud** we need to be Sign-On as a **Single Sign-On** (SSO) user.

  For more information about federated users, see **[User Provisioning for Federated Users.](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/usingscim.htm)**

2. Now going back to main page click the **hamburger menu** in the upper left corner and click on **Analytics & AI -> Analytics Cloud**.

    ![](./images/task4.2.png)


3. Click **Create instance** and in the new window, fill out the fields as shown in the image below. Make sure to select 2 OCPUs, the Enterprise version and the **License Included** button. Finally click **Create** to start the provisioning of the instance.

    ![](./images/task4.3.png)

    - Name: **OACDemo**
    - OCPU: **2**
    - License Type: **License Included**
  
  _**Note:** It takes about **15-20 minutes** to create the OAC instance._

    ![](./images/task4.3-1.png)

4. When the status of the instance changes to _Active_, click on the button **Configure Private Access Channel** under the Private Access Channel section to create a private access to the MySQL Database Service Instance.

    ![](./images/task4.4.png)

5. In the next window you first need to fill the name for the channel **PrivateChannel**. Then, choose the VCN created earlier **`analytics_vcn_test`**, and make sure you select the correct subnet, **`Public Subnet-analytics_vcn_test`**, otherwise you won't be able to connect!
Check **Virtual Cloud Network's domain name as DNS zone**, and remove the additional **DNS Zone**, using the X icon on the right side of the DNS Zone section, and finally click **Configure**.  

  _**Note:** It will take up to **50 minutes** to create the private channel so go get a nice cup of tea to kill the time!_

    ![](./images/task4.5.png)



As a recap we have created a VCN and added an additional Ingress rules to the Security list, and created a compute instance that serves as a bastion host and launched the cloud shell to import the private keys to connect to the compute instance, we also installed MySQL Shell and MySQL client, and downloaded the dataset that will be used later on for benchmark analysis.
Finally, we created an Oracle Analytics Cloud instance which we will eventually use later in this workshop.

Well done, you can now proceed to the next lab!

 

## Acknowledgements
- **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Vittorio Cioe - MySQL Solution Engineer
- **Contributors** - Priscila Iruela - Technology Product Strategy Director, Victor Martin - Technology Product Strategy Manager 
- **Last Updated By/Date** - Kamryn Vinson, August 2021
