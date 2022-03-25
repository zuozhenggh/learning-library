# Connect to ADB
## Introduction
Included with Oracle REST Data Services, Oracle SQL Developer Web is the web-based version of Oracle SQL Developer that enables you to execute queries and scripts, create database objects, build data models, and monitor database activity.

Oracle SQL Developer Web runs in Oracle REST Data Services and access to it is provided through schema-based authentication. To use Oracle SQL Developer Web, you must sign in as a database user whose schema has been enabled for SQL Developer Web.

In Oracle Autonomous Database databases, the ADMIN user is pre-enabled for SQL Developer Web.

Estimated time: 5 minutes

## Task 1: Connect to your Autonomous Database using SQL Developer Web

1. From the ADB Details page, click the Database Actions button ![](./images/db-actions-button.png)

![](./images/ADB-details-sdw-1.png)

2. The **Launch DB actions modal** window will appear.

![](./images/db-actions-modal.png)

This will open another browser tab/window. If you have popup blockers on, you may need to allow cloud.oracle.com access to open popup windows or open the popup window manually.

3. The popup window will take you directly to the Database Actions start page logged in as the **Admin** user. 

![](./images/db-actions-main.png)

If it does not, you will be directed to a login page.

![](./images/sdw-login.png)

4. Sign in with the database instance's default administrator account, **Username - ADMIN** with the admin password you specified when creating the database. Click **Sign in**.

![](./images/sdw-signin-admin.png " ")

4. From the Database Action menu, select the **SQL** tile.

![](./images/sql.png " ")

5. SQL Developer Web opens on a worksheet tab. The first time you open SQL Developer Web, a series of pop-up informational boxes introduce the main features.

![](./images/click-x.png  " ")

## Conclusion
 You are now connected to your Autonomous Database using SQL Developer Web.

## Acknowledgements

 - **Author** - Troy Anthony, Database Product Management, May 2020
 - **Contributors** - Anoosha Pilli, Product Manager
 - **Last Updated By/Date** - Brian Spendolini, April 2022
