# Configuring OCI ADB-S Database for PeopleSoft

## Introduction

This lab walks you through the steps to configure ADB-S database for PeopleSoft before performing the one click "**MV2ADB**"

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:
* Run SQL scripts to configure ADB-S for PeopleSoft
 

### Prerequisties
* Root login to the on-premise system and connected to ADB-S database using ADB wallet




## Task: Login to ADB-S and perform the SQL execution

Login to the on-premise PeopleSoft system as root and connect to the ADB-S database and excute the following SQL commands for preparing the database before performimg the MV2ADB operation

   ```
<copy>[root@pscs92dmo-lnxdb-2 wallet]# sqlplus admin@psadb_high
SQL*Plus: Release 19.0.0.0.0 - Production on Thu Apr 22 07:25:36 2021
Version 19.10.0.0.0
Copyright (c) 1982, 2020, Oracle. All rights reserved.
Enter password:
Last Successful login time: Thu Apr 22 2021 07:00:19 +00:00
Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.5.0.0.0
SQL> DROP ROLE PSADMIN;
DROP ROLE PSADMIN
*
ERROR at line 1:
ORA-01919: role 'PSADMIN' does not exist
SQL> CREATE ROLE PSADMIN;
GRANT
CREATE SESSION,
CREATE TABLE,
CREATE PROCEDURE,
CREATE SYNONYM,
CREATE VIEW,
CREATE TRIGGER,
CREATE DATABASE LINK,
CREATE MATERIALIZED VIEW,
CREATE SEQUENCE
TO PSADMIN ;

Role created.

SQL> GRANT SELECT ON USER_AUDIT_POLICIES to PSADMIN;
Grant succeeded.
SQL> GRANT EXECUTE ON DBMS_FGA to PSADMIN;
Grant succeeded.
SQL> grant execute on DBMS_METADATA to PSADMIN;
Grant succeeded.
SQL> grant execute on DBMS_MVIEW to PSADMIN;
Grant succeeded.
SQL> grant execute on DBMS_SESSION to PSADMIN;
Grant succeeded.
SQL> grant execute on DBMS_STATS to PSADMIN;
Grant succeeded.
SQL> grant execute on DBMS_XMLGEN to PSADMIN;
Grant succeeded.
SQL> grant execute on DBMS_APPLICATION_INFO to PSADMIN;
Grant succeeded.
SQL> grant execute on dbms_refresh to PSADMIN;
Grant succeeded.
SQL> grant execute on dbms_job to PSADMIN;
Grant succeeded.
SQL> grant execute on dbms_lob to PSADMIN;
Grant succeeded.
SQL> grant execute on DBMS_OUTPUT to PSADMIN;
Grant succeeded.
SQL> GRANT CREATE MATERIALIZED VIEW TO PSADMIN;
Grant succeeded. </copy>
   ```




You may now **proceed to the next lab.**


## Acknowledgements
* **Authors** - Deepak Kumar M, PeopleSoft Architect
* **Contributors** - Deepak Kumar M, PeopleSoft Architect
* **Last Updated By/Date** - Deepak Kumar M, PeopleSoft Architect, Aug 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.



