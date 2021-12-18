# Migration Workshop Lab

## Introduction

This is the migration lab, where you will start from installing Oracle SQL Developer, to setting up appropriate user credentials and then creating migration repository and connections and run the Wizard to complete the database migration from MySQL to Oracle ADB instance in the cloud. 

Estimated Lab Time: 1 hr

### About Oracle SQL Developer
Use the latest version of Oracle SQL Developer (which is v 21.2 as of writing of this workshop). 


## Objective
In this lab, you will perform following: 
* Download Latest Version & Install
* Create Connections for the Target (ADB) database
* Load MySQL JDBC Driver and Source Connection
* Create User for Migration Repository
* Create Migration Connection
* Create Migration Repository
* Complete Migration with the Wizard

## Task 1: Download Latest Version & Install

This task will walk you through downloading and installing Oracle SQL Developer in a windows environment...

Download and install SQL Developer on any windows pc (laptop/OCI), which has network access to both databases (source and target) as well as the repository database you choose (ADB in our case). You can download latest version of Oracle SQL Developer from following link for your appropriate platform. For thiw workshop, we'll choose Windows 64-bit with JDK 8 included from [https://www.oracle.com/tools/downloads/sqldev-downloads.html](https://www.oracle.com/tools/downloads/sqldev-downloads.html)


#### From Doc: 1.2 Installing and Getting Started with SQL Developer
To install and start SQL Developer, you simply download its ZIP file and unzip it into a desired parent directory or folder, and then double-click the exe file name (sqldeveloper.exe) to open. 

When you launch SQL Developer first time, it'll ask you importing project etc, select No. 


## Task 2: Create Connections for the Target (ADB) database

First you'll need to create appropriate user for the target schema. You can use following SQL script to create a sample user for the connection, with appropriate roles. You will need to execute following with ADMIN user, using SQL Developer Worksheet. Set password appropriately before copying below command, replacing xxxxx.

 ```
<copy> CREATE USER targetuser IDENTIFIED BY xxxxxxxx;
GRANT CONNECT, RESOURCE TO targetuser;
GRANT CREATE SESSION TO targetuser;
GRANT UNLIMITED TABLESPACE TO targetuser;
GRANT CREATE ANY VIEW TO targetuser;
GRANT SELECT ANY TABLE TO targetuser; </copy>
 ```

 After executing above SQL commands, you can create a new connection named "ATP" in SQL Developer with the above TARGETUSER credentials and the ATP wallet file. You can follow [Connecting SQL Developer to Autonomous Transaction Processing](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/atp/OBE_/connecting_sql_developer_to_autonomous_transaction_processing.html) (step 1 only) to setup connection to ATP. Or you can follow below lab: Connect Securely Using SQL Developer with a Connection Wallet

Note: SQL Developer does not migrate grant information from the source database. The Oracle DBA must adjust (as appropriate) user, login, and grant specifications after the migration.



## 2a Connect Securely Using SQL Developer with a Connection Wallet


   This lab walks you through the steps to download and configure a *connection wallet* to connect securely to an Autonomous Database (Autonomous Data Warehouse [ADW] or Autonomous Transaction Processing [ATP]). You will use this connection wallet to connect to the database using **Oracle SQL Developer**. (Previous labs in this workshop used **SQL Developer Web** from a web browser, to access an autonomous database directly from the cloud console without a connection wallet. SQL Developer Web is a convenient browser-based tool, offering a subset of the features and functions in Oracle SQL Developer.)

   *Note: While this lab uses ADW, the steps are identical for connecting to an autonomous database in ATP.*

   Watch a video demonstration of connecting to an autonomous database instance using SQL Developer.

   [](youtube:PHQqbUX4T50)
   


   **Objectives**

   -   Learn how to download and configure a connection wallet
   -   Learn how to connect to your Autonomous Data Warehouse with Oracle SQL Developer

   ## Task 2.1: Download the Connection Wallet

   As ADW and ATP accept only secure connections to the database, you need to download a wallet file containing your credentials first. The wallet can be downloaded either from the instance's details page or from the ADW or ATP service console.

   2.1.1  If you are not logged in to Oracle Cloud Console, login and select Autonomous Data Warehouse from the hamburger menu and navigate into your ADW Finance Mart instance.

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

    ![](images/step1.1-adb.png " ")

   2.1.2  In your database's instance Details page, click on **DB Connection**.

    ![](./images/dbconnection.png " ")

   2.1.3  Use the Database Connection dialog to download client credentials.
    - Wallet Type - For this lab, select **Instance Wallet**. This wallet type is for a single database only. This provides a database-specific wallet.
    - Click **Download Wallet**.

    ![](./images/Picture100-15.png " ")

    *Note: Oracle recommends that you provide a database-specific wallet, using Instance Wallet, to end users and for application use whenever possible. Regional wallets should only be used for administrative purposes that require potential access to all Autonomous Databases within a region.*

   2.1.4 Specify a password of your choice for the wallet. You will need this password when connecting to the database via SQL Developer later. The password is also used as the JKS Keystore password for JDBC applications that use JKS for security. Click **Download** to download the wallet file to your client machine.

    *Note: If you are prevented from downloading your Connection Wallet, it may be due to your browser's pop-up blocker. Please disable it or create an exception for Oracle Cloud domains.*

    ![](./images/Picture100-16.png " ")

   2.1.5 Once the wallet is downloaded, click **Close** to close the Database Connection dialog.

   ## Task 2.2: Connect to the database using SQL Developer

   Start SQL Developer and create a connection for your database using the default administrator account "ADMIN" by following these steps.

   2.2.1 Click the **New Connection** icon in the Connections toolbox on the top left of the SQL Developer homepage.

    ![](./images/snap0014653.jpg " ")

   2.2.2 In **New / Select Database Connection** dialog, Fill in the connection details as below:

    -   **Name:** admin_high
    -   **Username:** ADMIN
    -   **Password:** The password you specified during provisioning your instance
    -   **Connection Type:** Cloud Wallet
    -   **Configuration File:** Enter the full path for the wallet file you downloaded before, or click **Browse...** to point to the location of the file.
    -   **Service:** There are 3 pre-configured database services for each database. Pick **<*databasename*>\_high** for this lab. For example, if the database you created was named adwfinance, select **adwfinance_high** as the service.

    ![](./images/Picture100-18.jpg " ")

   2.2.3 Test your connection by clicking the **Test** button. If it succeeds, you will see *Status: Success*, you can save your connection information by clicking **Save**, then connect to your database by clicking the **Connect** button. An entry for the new connection will appear under Connections.

   2.2.4 If you are behind a VPN or Firewall and this Test fails, make sure you have <a href="https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html" target="\_blank">SQL Developer 18.3</a> or higher. This version and above will allow you to select the "Use HTTP Proxy Host" option for a Cloud Wallet type connection. While creating your new ADW connection here, provide your proxy's Host and Port. If you are unsure where to find this, you may look at your computer's connection settings or contact your Network Administrator.

   ## Task 2.3: Querying Your Autonomous Database with SQL Developer

   The SH schema provides a small data set that you can use to run the sample queries in the <a href="https://docs.oracle.com/en/database/oracle/oracle-database/19/dwhsg/sql-analysis-reporting-data-warehouses.html#GUID-1D8E3429-735B-409C-BD16-54004964D89B" target="\_blank">Database Data Warehousing Guide</a>. For example, the following query shows you how the SQL function RANK() works:

   2.3.1 In a SQL Developer worksheet, perform the following `SH` query.

    ````
    <copy>
    SELECT channel_desc, TO_CHAR(SUM(amount_sold),'9,999,999,999') SALES$,
    RANK() OVER (ORDER BY SUM(amount_sold)) AS default_rank,
    RANK() OVER (ORDER BY SUM(amount_sold) DESC NULLS LAST) AS custom_rank
    FROM sh.sales, sh.products, sh.customers, sh.times, sh.channels, sh.countries
    WHERE sales.prod_id=products.prod_id AND sales.cust_id=customers.cust_id
    AND customers.country_id = countries.country_id AND sales.time_id=times.time_id
    AND sales.channel_id=channels.channel_id
    AND times.calendar_month_desc IN ('2000-09', '2000-10')
    AND country_iso_code='US'
    GROUP BY channel_desc;
    </copy>
    ````

    ![](./images/sh-query-results.jpg " ")

  Acknowledgements

   **Author** - Richard Green, DB Docs Team
   **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
   **Last Updated By/Date** - Richard Green, November 2021
  


## Task 3: Load MySQL JDBC Driver and Source Connection

  Setup MySQL JDBC driver and make connection in the SQL Developer
  Fist you'll need to download the jar file for MySQL JDBC connectivity. Go to [http://dev.mysql.com/downloads/connector/j](http://dev.mysql.com/downloads/connector/j) and click on Operating system dropdown, select "Platform Independent", then it will show you the options to download tar.gz file or zip file. Download the zip file and extract it, and within that folder you will find mysql-connector-XXX.jar file. In my case, I chose, mysql-connector-8.0.27.jar Follow the instructions below to attach the jar file in SQL Developer.
 
  **From Doc: 3.2.4.3 Before Migrating From MySQL**

    To configure a MySQL database for migration, install MySQLConnector/J release 3.1.12 or 5.0.4 on the system where you have installed SQL Developer and set the appropriate SQL Developer preference. Follow these steps:
  
  3.1 Ensure that you can connect to the MySQL database from the system where you have installed SQL       Developer.
  
  3.2 Ensure that you have downloaded the MySQLConnector/J API from the MySQL website at http://www.mysql.com/.
  
  3.3 In SQL Developer, if you have not already installed the MySQL JDBC driver using Check for Updates  (on the Help menu), do the following:
  
  3.3a Click Tools, then Preferences, then Database, then Third Party JDBC Drivers.
  
  3.3b Click Add Entry.
  
  3.3c Select the jar file for the MySQL driver you downloaded from http://www.mysql.com/.
  
  3.3d Click OK.
  
  3.4 Ensure that the source database is accessible by the MySQL user that is used by SQL Developer for the source connection. This user must be able to see any objects to be captured in the MySQL database; objects that the user cannot see are not captured. For example, if the user can execute a stored procedure but does not have sufficient privileges to see the source code, the stored procedure cannot be captured.
 
  
  Under the Connections page, click on green plus sign to create New Database Connection. Once you perform above steps, when you create a new connection, the "Database Type" dropdown includes the MySQL option. Provide MySQL User Name, Password, Host and Port info and set the name of the connection as MySQL in SQL Developer. Then Test the connection, Save and Close. For multi-schema migration, choose the user that has access to all other schemas that needs to be migrated.


## Task 4: Create User for Migration Repository

Since, we have planned to create repository in the ATP database, let’s create separate user for migration, in the target (ATP) database named: MIGRATIONS, with the required roles and privileges and tablespace quotas. We will use this connection/user to run our migration jobs in SQL Developer.
 
  **Note:** 
     Remove Repository: How to cleanly remove existing repository. If you already have a repository associated with a user/database, you can use that. Otherwise, if you want to re-create the repository, you should follow these steps to cleanly remove it:
     a.    Migration --> Repository Management --> Truncate Repository
     b.    Select menu Migration --> Repository Management --> Delete Repository
     c.    Then drop that migration (db) user with cascade and start over from previous step. That is, create new migration user with above roles and Privileges, etc. and so on.
 
You can copy following (SQL) script and execute via SQL Developer – Worksheet. Make sure, you’re connected as ADMIN user in the worksheet in ATP (and not with the target DB user or any other user). Set password appropriately before copying the commands below, replacing xxxxx and execute in order.


``` 
<copy>
CREATE USER migrations IDENTIFIED BY xxxxxxx
  DEFAULT TABLESPACE data TEMPORARY TABLESPACE temp;
ALTER USER migrations QUOTA UNLIMITED ON data;
 </copy>
```
```
<copy>
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW,
   CREATE PUBLIC SYNONYM TO migrations WITH ADMIN OPTION;
</copy>
``` 
```
<copy>
GRANT  ALTER ANY ROLE, ALTER ANY SEQUENCE, ALTER ANY TABLE, ALTER TABLESPACE, ALTER ANY TRIGGER, COMMENT ANY TABLE, CREATE ANY SEQUENCE, CREATE ANY TABLE, CREATE ANY TRIGGER, CREATE ROLE, CREATE TABLESPACE, CREATE USER, DROP ANY SEQUENCE, DROP ANY TABLE, DROP ANY TRIGGER, DROP TABLESPACE, DROP USER, DROP ANY ROLE, GRANT ANY ROLE, INSERT ANY TABLE, SELECT ANY TABLE, UPDATE ANY TABLE TO migrations;
</copy>
``` 

Once you are done with migration, you may like to revoke back those high privileges from MIGRATIONS user for security purposes.   


## Task 5: Create Migration Connection

Create a database connection named Migration Repository that connects with the MIGRATIONS user created in previous step, to connect to ATP.  Following is a reference from Oracle’s docs (you need not to follow again).
 
**From Doc: 2.1.1.1 Repository**
The Repository page of the wizard requires that you specify the database connection for the migration repository to be used.

The migration repository is a collection of schema objects that SQL Developer uses to manage metadata for migrations. If you do not already have a migration repository and a database connection to the repository, create them as follows:

  4.1    Create an Oracle user named MIGRATIONS with default tablespace Data and temporary tablespace TEMP; and grant it at least the RESOURCE role and the CREATE SESSION, CREATE VIEW, and CREATE MATERIALIZED VIEW privileges. (For multischema migrations, you must grant the RESOURCE role with the ADMIN option; and you must also grant this user the CREATE ROLE, CREATE USER, and ALTER ANY TRIGGER privileges, all with the ADMIN option.)
  Connection: The database connection to the migration repository to be used.
  Truncate: If this option is enabled, the repository is cleared (all data from previous migrations is removed) before any data for the current migration is created.


## Task 6: Create Migration Repository

Right click on Migrations_Repository connection that you created in the above step and select Migration Repository and then select Associate Migration Repository. It will take some time to create the repository in the ATP database in the MIGRATIONS schema.


## Task 7: Complete Migration with the Wizard

The migration wizard can be invoked in a variety of contexts. You can right-click a third-party database connection (MySQL connect in our case) and select “Migrate to Oracle” or you can click from the menu “Tools>Migration>Migrate…”.

You can follow the self-explanatory Wizard to provide details about the source and target connection, repository connection, database selected for migration, and objects under the database to be migrated and any data-type conversion required etc and at the end choose to create an offline script file for migration. You can refer to the [documentation](https://docs.oracle.com/en/database/oracle/sql-developer/19.4/rptug/migrating-third-party-databases.html#GUID-51B0F243-D970-43A0-BFA4-97477CB14C48) for explianation of the steps of this wizard.

This workshop walked you through one scenario, of moving data from MySQL Database to Oracle Autonomous Transactions Processing (ADB).

## Acknowledgements
* **Author** - Muhammad Shuja, Principal Cloud Solution Engineer
* **Last Updated By/Date** - Muhammad Shuja, Dec 22, 2021
