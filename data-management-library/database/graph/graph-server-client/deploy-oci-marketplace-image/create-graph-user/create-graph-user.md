# Create and Enable a Database User in Database Actions

## Introduction

This lab walks you through the steps to get started with Database Actions. You will learn how to create a user in Database Actions and provide that user the access to Database Actions.

Estimated time: 3 minutes

### Objectives

- Learn how to setup the required database roles in Database Actions.
- Learn how to create a database user in Database Actions.

### Prerequisites

- Oracle cloud account
- Provisioned Autonomous Database

## Task 1: Login to Database Actions

Login as the Admin user in Database Actions of the newly created ADB instance.

Click the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **Autonomous Transaction Processing**.

![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-atp.png " ")

In Autonomous Database Details page, open **Tools** tab and click **Database Actions**. Make sure your brower allow pop-up windows.

![](images/adb-console.jpg)

Enter **ADMIN** as Username and go next.

![](images/login-1.jpg)

Input the password (you set up at Lab 2) and sign in.

![](images/login-2.jpg)

Go to **SQL** menu once you logged in as the **ADMIN** user. 

![](images/ADB_SQLDevWebHome.jpg)

## Task 2: Create a database user

Now create the **CUSTOMER_360** user and provide Database Actions access for this user.

Open the main menu and click "Database Users".

![](images/user-1.jpg)

Click **Create User** button, input user name and password. Enable **Graph** and **Web Access**, and set the quota to **UNLILMITED**.

![](images/user-2.png)

Proceed with **Create User**, and open the login window.

![](images/user-4.jpg)

Confirm that you can login with the new user.

![](images/user-5.jpg)

For details, see the ["Provide Database Actions Access to Database Users"](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/sql-developer-web.html#GUID-4B404CE3-C832-4089-B37A-ADE1036C7EEA) section in the documentation.

You may now proceed to the next lab.

## Acknowledgements

* **Author** - Jayant Sharma, Product Manager, Spatial and Graph
* **Contributors** - Arabella Yao, Jenny Tsai
* **Last Updated By/Date** - Ryota Yamanaka, January 2022

