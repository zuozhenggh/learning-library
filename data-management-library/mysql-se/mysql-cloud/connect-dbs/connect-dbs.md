# CONNECT TO MYSQL DATABASE SYSTEM
![INTRO](./images/00_mds_heatwave_2.png " ") 


## Introduction

When working in the cloud, there are often times when your servers and services are not exposed to the public internet. The Oracle Cloud Infrastructure (OCI) MySQL HeatWave Dabase Service instances is an example of a service that is only accessible through private networks. Since the service is fully managed, we keep it siloed away from the internet to help protect your data from potential attacks and vulnerabilities. It’s a good practice to limit resource exposure as much as possible, but at some point, you’ll likely want to connect to those resources. That’s where Compute Instance, also known as a Bastion host, enters the picture. This Compute Instance Bastion Host is a resource that sits between the private resource and the endpoint which requires access to the private network and can act as a “jump box” to allow you to log in to the private resource through protocols like SSH.  This bastion host requires a Virtual Cloud Network and Compute Instance to connect with the MySQL DB Systems. 

Today, you will use the already created Compute Instance with MySQL Shell to connect to the DB Systems. 

_Estimated Lab Time:_ 20 minutes


### Objectives

In this lab, you will be guided through the following tasks:


- Setup Compute Instance with MySQL Shell
- Connect to MySQL Standalone DB System
- Connect to MySQL High Availability DB System

### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell
- Must Complete Lab 3


## Task 1: Connect to MySQL Database System

1. Copy the public IP address of the active Compute Instance to your notepad

    - Go to Navigation Menu 
            Compute 
            Instances
    ![CONNECT](./images/db-list.png " ")

    - Click the `MDS-Client` Compute Instance link
    
    ![CONNECT](./images/05compute08-b.png " ")
    
    - Copy `MDS-Client` plus  the `Public IP Address` to the notepad

2. Copy the private IP address of the MySQl Standalone Database Service Instance to your notepad

    - Go to Navigation Menu 
            Databases 
            MySQL
     ![](./images/db-list.png " ")

    - Click the `MDS-Standalone` Database System link

     ![CONNECT](./images/db-active.png " ")
    
    - Copy `MDS-Standalone` plus the `Private IP Address` to the notepad

3. Your notepad should look like the following:
     ![CONNECT](./images/notepad-rsa-key-compute-mds-1.png " ")
    
4. Indicate the location of the private key you created earlier with **MDS-Client**. 
    
    Enter the username **opc** and the Public **IP Address**.

    Note: The **MDS-Client**  shows the  Public IP Address as mentioned on TASK 5: #11
    
    (Example: **ssh -i ~/.ssh/id_rsa opc@132.145.170...**) 

    ```
    <copy>ssh -i ~/.ssh/id_rsa opc@<your_compute_instance_ip></copy>
    ```
    ![CONNECT](./images/06connect01-signin.png " ")

    **Install MySQL Shell on the Compute Instance**

5. You will need a MySQL client tool to connect to your new MySQL DB System from your client machine.

    Install MySQL Shell with the following command (enter y for each question)

    **[opc@…]$**

     ```
    <copy>sudo yum install mysql-shell -y</copy>
    ```
    ![CONNECT](./images/06connect02-shell.png " ")

   **Connect to MySQL Database Service**

6. From your Compute instance, connect to MDS-HW MySQL using the MySQL Shell client tool. 
   
   The endpoint (IP Address) can be found in your notepad or  the MDS-HW MySQL DB System Details page, under the "Endpoint" "Private IP Address". 

    ![CONNECT](./images/06connect03.png " ")

7.  Use the following command to connect to MySQL using the MySQL Shell client tool. Be sure to add the MDS-HW private IP address at the end of the command. Also enter the admin user and the db password created on Lab 1

    (Example  **mysqlsh -uadmin -p -h10.0.1..   --sql**)

 **[opc@...]$**

    ```
    <copy>mysqlsh -uadmin -p -h 10.0.1.... --sql</copy>
    ```
    ![CONNECT](./images/06connect04-myslqsh.png " ")

9. View  the airportdb total records per table in 
    ```
    <copy>SELECT table_name, table_rows FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'airportdb';</copy>
    ```
        
    ![CONNECT](./images/airportdb-list.png " ") 
    
You may now proceed to the next lab.

## Learn More

* [Cloud Shell](https://www.oracle.com/devops/cloud-shell/?source=:so:ch:or:awr::::Sc)
* [Virtual Cloud Network](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/overview.htm)
* [OCI Bastion Service ](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/Bastion/Tasks/connectingtosessions.htm)
## Acknowledgements
* **Author** - Perside Foster, MySQL Solution Engineering 
* **Contributor** - Frédéric Descamps, MySQL Community Manager 
* **Last Updated By/Date** - Perside Foster, February 2022
