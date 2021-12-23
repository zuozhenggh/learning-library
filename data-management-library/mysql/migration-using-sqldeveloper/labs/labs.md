# Migration Workshop Lab

## Introduction

This is the main migration lab steps, where you will start from installing Oracle SQL Developer, to setting up appropriate user credentials and then create migration repository and connections and run the Wizard to complete the database migration from MySQL to Oracle ADB instance in the cloud. 

### Objectives

In this lab, you will perform following: 
* Download Latest Version & Install
* Create Connections for the Target (ADB) database
* Load MySQL JDBC Driver and Source Connection
* Create User for Migration Repository
* Create Migration Connection
* Create Migration Repository
* Complete Migration with the Wizard


## Task 1: Download Latest Version & Install

  Use the latest version of Oracle SQL Developer (which is v 21.2 as of writing of this workshop). This task will walk you through downloading and installing Oracle SQL Developer in a windows environment.
 
  Download and install SQL Developer on any windows pc (laptop/OCI), which has network access to both databases (source and target) as well as the repository database you choose (ADB in our case). You can download latest version of Oracle SQL Developer from following link for your appropriate platform. For thiw workshop, we'll choose Windows 64-bit with JDK 8 included from [https://www.oracle.com/tools/downloads/sqldev-downloads.html](https://www.oracle.com/tools/downloads/sqldev-downloads.html)


  **From Doc: 1.2 Installing and Getting Started with SQL Developer** 

  To install and start SQL Developer, you simply download its ZIP file and unzip it into a desired parent directory or folder, and then double-click the exe file name (sqldeveloper.exe) to open. 

  When you launch SQL Developer first time, it'll ask you importing project etc, select No. 


## Task 2: Create Connections for the Target (ADB) database

  Once you're running SQL Developer, first you'll need to create appropriate user for the target schema, which is ATP in our case. You can use following SQL script to create a sample user for the connection, with appropriate roles. You can follow step 1 from this link, for how to create connection to Autonomous Database from SQL Developer: [Connecting SQL Developer to Autonomous Transaction Processing](https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/atp/OBE_/connecting_sql_developer_to_autonomous_transaction_processing.html) (step 1 only). 
 
  Or you can follow this lab: [Connect Securely Using SQL Developer with a Connection Wallet] (?lab=adb-provision-conditional). NB: After completing, don't forget to return back to this Migration Workshop Lab, Task 2.1, to complete rest of the below steps. 

 
### Task 2.1 Create User in Target

  Once you've setup connectivity with ATP from SQL Developer, as described above, you can use that connection to create new user. You can execute following sample command as ADMIN user, using SQL Developer Worksheet. Set password appropriately before copying below command, replacing xxxxx.

  ```
  <copy> CREATE USER targetuser IDENTIFIED BY xxxxxxxx; </copy>
  ```
  ```
  <copy>
  GRANT CONNECT, RESOURCE TO targetuser;
  GRANT CREATE SESSION TO targetuser;
  GRANT UNLIMITED TABLESPACE TO targetuser;
  GRANT CREATE ANY VIEW TO targetuser;
  GRANT SELECT ANY TABLE TO targetuser; </copy>
  ```
    
  After executing above SQL commands, create a new connection named "ATP" in SQL Developer with the above TARGETUSER database credentials and the ATP wallet file. 

  > **Note:** SQL Developer does not migrate grant information from the source database. The Oracle DBA must adjust (as appropriate) user, login, and grant specifications after the migration.

## Task 3: Load MySQL JDBC Driver and Source Connection

  Setup MySQL JDBC driver and make connection in the SQL Developer
  
  Fist you'll need to download the jar file for MySQL JDBC connectivity. Go to [http://dev.mysql.com/downloads/connector/j](http://dev.mysql.com/downloads/connector/j) and click on Operating system dropdown, select "Platform Independent", then it will show you the options to download tar.gz file or zip file. Download the zip file and extract it, and within that folder you will find mysql-connector-XXX.jar file. In my case, I chose, mysql-connector-8.0.27.jar Follow the instructions below to attach the jar file in SQL Developer.
 
  **From Doc: 3.2.4.3 Before Migrating From MySQL**

  To configure a MySQL database for migration, install MySQLConnector/J release 3.1.12 or 5.0.4 on the system where you have installed SQL Developer and set the appropriate SQL Developer preference. Follow these steps:
  
  1. Ensure that you can connect to the MySQL database from the system where you have installed SQL       Developer.
  
  2. Ensure that you have downloaded the MySQLConnector/J API from the MySQL website at http://www.mysql.com/.
  
  3. In SQL Developer, if you have not already installed the MySQL JDBC driver using Check for Updates  (on the Help menu), do the following:
  
  1. Click Tools, then Preferences, then Database, then Third Party JDBC Drivers.
  
  2. Click Add Entry.
  
  3. Select the jar file for the MySQL driver you downloaded from http://www.mysql.com/.
  
  4.   Click OK.
  
  4. Ensure that the source database is accessible by the MySQL user that is used by SQL Developer for the  source connection. This user must be able to see any objects to be captured in the MySQL database; objects that the user cannot see are not captured. For example, if the user can execute a stored procedure but does not have sufficient privileges to see the source code, the stored procedure cannot be captured.
 
  Under the Connections page, click on green plus sign to create New Database Connection. Once you perform above steps for JDBC driver, when you create a new connection, the "Database Type" dropdown includes the MySQL option. Provide MySQL User Name, Password, Host and Port info appropriately and set the name of the connection as MySQL in SQL Developer. Then Test the connection, Save and Close. For multi-schema migration, choose the user that has access to all other schemas that needs to be migrated.


## Task 4: Create User for Migration Repository

  Since, we have planned to create repository in the ATP database, let’s create separate user for migration, in the target (ATP) database named: MIGRATIONS, with the required roles and privileges and tablespace quotas. We will use this connection(SQL Developer) and user(database) to run our migration jobs in SQL Developer.
 
  > **Note: Remove Repository:** How to cleanly remove existing repository. If you already have a repository associated with a user/database, you can use that. Otherwise, if you want to re-create the repository, you should follow these steps to cleanly remove it first:
     a.    Migration --> Repository Management --> Truncate Repository
     b.    Select menu Migration --> Repository Management --> Delete Repository
     c.    Then drop that migration (db) user with cascade and start over from previous step. That is, create new migration user with above roles and Privileges, etc. and so on.
 
  You can copy following (SQL) script and execute via SQL Developer – Worksheet. Make sure, you’re connected as ADMIN user in the worksheet in ATP (and not with the target DB user or any other user). Set password appropriately before copying the commands below, replacing xxxxx and execute in order.

  ``` 
  <copy>
  CREATE USER migrations IDENTIFIED BY xxxxxxx
    DEFAULT TABLESPACE data TEMPORARY TABLESPACE temp;
  </copy>
  ```
  ```
  <copy>
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

  > **Note:** Once you are done with migration, you may like to revoke back those high privileges from MIGRATIONS user for security purposes.   


## Task 5: Create Migration Connection

  In SQL Developer, create a database connection named Migration_Repository using the MIGRATIONS user created in previous step, to connect to ATP. For help with making such connection, you can refer back the above lab: [Connect Securely Using SQL Developer with a Connection Wallet] (?lab=adb-provision-conditional). Once completed, return back to Task 6 in Migration Workshop Lab. 


## Task 6: Create Migration Repository

  Right click on Migrations_Repository connection that you created in the previous step and select Migration Repository and then select Associate Migration Repository. It will take some time to create the repository in the ATP database in the MIGRATIONS schema.


## Task 7: Complete Migration with the Wizard

  The migration wizard can be invoked in a variety of contexts. You can right-click a third-party database connection (MySQL connect in our case) and select “Migrate to Oracle” or you can click from the menu “Tools>Migration>Migrate…”.

  You can follow the self-explanatory Wizard to provide details about the source and target connection, repository connection, database selected for migration, and objects under the database to be migrated and any data-type conversion required etc and at the end choose to create an offline script file for migration. You can refer to the [documentation](https://docs.oracle.com/en/database/oracle/sql-developer/19.4/rptug/migrating-third-party-databases.html#GUID-51B0F243-D970-43A0-BFA4-97477CB14C48) for explianation of the steps of this wizard.

  That is the end of the workshop. This workshop walked you through one scenario, of moving data from MySQL Database to Oracle Autonomous Database (ADB).


Learn more about this migration scenario:
* [Need to Migrate MySQL Database to Oracle ADB ?](http://docs.oracle.com)

## Acknowledgements
* **Author** - Muhammad Shuja, Principal Cloud Solution Engineer, ODP - ANZ
* **Last Updated By/Date** - Muhammad Shuja, December 2021
