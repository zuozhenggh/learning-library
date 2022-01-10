
<!-- Updated April 12, 2021 -->

# Provision an Autonomous Database


## Introduction

This lab walks you through the steps to quickly provision an Oracle Autonomous Database (either Autonomous Data Warehouse [ADW] or Autonomous Transaction Processing [ATP]) on Oracle Cloud. You will use this database in subsequent labs of this workshop.

### Objectives

-   Provision a new Autonomous Data Warehouse

### Prerequisites

-   This lab requires that you are already have an Oracle Cloud login.  

## Task 1: Creating the Database

1. Log in to the Oracle Cloud.
2. Once you are logged in, you are taken to the cloud services dashboard where you can see all the services available to you. Click the navigation menu in the upper left to show top level navigation choices.

      ![](./images/Picture100-36.png " ")

3. This lab shows provisioning of an Autonomous Data Warehouse database, so click **Autonomous Data Warehouse**.

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

4. Make sure your workload type is __Data Warehouse__ or __All__ to see your Autonomous Data Warehouse instances. You can use the __List Scope__ drop-down menu to select a compartment. Select your __root compartment__, or __another compartment of your choice__ where you will create your new ADW instance. If you want to create a new compartment, click <a href="https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm#three" target="\_blank">here</a>. To learn more about compartments, click <a href="https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/settinguptenancy.htm#Setting_Up_Your_Tenancy" target="\_blank">here</a>.

5. This console shows that no databases yet exist. If there were a long list of databases, you could filter the list by the state of the databases (available, stopped, terminated, and so on). You can also sort by __Workload Type__. Here, the __Data Warehouse__ workload type is selected.

    ![](./images/Compartment.png " ")


## Task 2: Creating the Autonomous Database Instance

1. Click **Create Autonomous Database** to start the instance creation process.

    ![](./images/Picture100-23.png " ")

2.  This brings up the __Create Autonomous Database__ screen where you will specify the configuration of the instance.
3. Provide basic information for the autonomous database:

    - __Choose a compartment__ - Select a compartment for the database from the drop-down list.
    - __Display Name__ - Enter a memorable name for the database for display purposes. For this lab, use your __FirstName LastName__ example (John Smith).
    - __Database Name__ - Use letters and numbers only, starting with a letter. Maximum length is 14 characters. (Underscores not initially supported.) For this lab, use __YOURNAME__ example (JOHNSMITH).

    ![](./images/database-name.png " ")

4. Choose a workload type. 

    - __Data Warehouse__ - For this lab, choose __Data Warehouse__ as the workload type.
    
    ![](./images/Picture100-26b.png " ")

5. Choose a deployment type. 

    - __Shared Infrastructure__ - For this lab, choose __Shared Infrastructure__ as the deployment type.
    
    ![](./images/Picture100-26_deployment_type.png " ")

6. Configure the database:

    - __Always Free__ - For this lab, you can select this option to create an always free autonomous database, or not select this option and create a database using your paid subscription. An always free database comes with 1 CPU and 20 GB of storage.
    - __Choose database version__ - Select a database version from the available versions.
    - __OCPU count__ - Number of CPUs for your service. For this lab, specify __1 CPU__. If you choose an always free database, it comes with 1 CPU.
    - __Storage (TB)__ - Select your storage capacity in terabytes. For this lab, specify __1 TB__ of storage. Or, if you choose an always free database, it comes with 20 GB of storage.
    - __Auto Scaling__ - For this lab, keep auto scaling enabled, to allow the system to automatically use up to three times more CPU and IO resources to meet workload demand.
    - __New Database Preview__ - If a checkbox is available to preview a new database version, do __not__ select it.

        ![](./images/Picture100-26c.png " ")

7. Create administrator credentials:

    - __Password and Confirm Password__ - Specify the password for ADMIN user of the service instance. The password must meet the following requirements:
    - The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character.
    - The password cannot contain the username.
    - The password cannot contain the double quote (") character.
    - The password must be different from the last 4 passwords used.
    - The password must not be the same password that is set less than 24 hours ago.
    - Re-enter the password to confirm it. Make a note of this password.

    ![](./images/Picture100-26d.png " ")
8. Choose network access:
    - For this lab, accept the default, "Allow secure access from everywhere".
  

    ![](./images/Picture100-26e.png " ")

9. Choose a license type. For this lab, choose __License Included__. 
    
10. Click __Create Autonomous Database__.

    ![](./images/Picture100-27.png " ")

11.  Your instance will begin provisioning. In a few minutes the state will turn from Provisioning to Available. At this point, your Autonomous Data Warehouse database is ready to use! Have a look at your instance's details here including its name, database version, CPU count and storage size.

    ![](./images/Picture100-32.png " ")



## Task 3: Connect with SQL Worksheet

Now that you created a database, you will connect to the database using SQL Worksheet, a browser-based tool that is easily accessible from the Autonomous Data Warehouse

1. In your database's details page, click the **Database Actions** button.

    ![Click the Database Actions button](./images/click-database-actions-button.png " ")

2. A sign-in page opens for Database Actions. For this lab, simply use your database instance's default administrator account, **Username - admin**, and click **Next**.

    ![Enter the admin username.](./images/Picture100-16.png " ")

3. Enter the Administrator **Password** you specified when creating the database. Click **Sign in**.

    ![Enter the admin password.](./images/Picture100-16-password.png " ")

4. The Database Actions page opens. In the **Development** box, click **SQL**.

    ![Click on SQL.](./images/Picture100-16-click-sql.png " ")

5. The first time you open SQL Worksheet, a series of pop-up informational boxes introduce you to the main features. Click **Next** to take a tour through the informational boxes.

    ![Click Next to take tour.](./images/Picture100-sql-worksheet.png " ")

    After touring through the informational boxes, keep this SQL Worksheet open and please **proceed to the next lab.**

## Want to Learn More?

Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/sql-developer-web.html#GUID-102845D9-6855-4944-8937-5C688939610F) for documentation on connecting with the built-in SQL Developer Web.

## Acknowledgements

- **Author** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Marion Smith, January 2022
