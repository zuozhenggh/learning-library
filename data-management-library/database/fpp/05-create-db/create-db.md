# Provision a new database

## Introduction
FPP is best at provisioning Oracle Homes, patching Grid Infrastructure and Database environments. But it can also provision Databases. For Database provisioning Fleet Patching and Provisioning triggers the remote execution of the Database Creation Assistant (or dbca), that will take care of most of the creation steps.

By provisioning databases with FPP you don't have to spend time to run dbca in silent mode manually (or worse, doing everything in interactive mode). All you need is:
* a DBCA Template Database, either local on the client or included in the gold image (standard templates such as General_Purpose.dbt work perfectly well)
* one rhpctl command to provision the database on the target node or cluster

## Step 1: Provision the database using the standard template

Run the following command on the FPP Server (Est. 14-15 minutes):

```
[grid@fpps01 ~]$ rhpctl add database -workingcopy  WC_db_19_9_0_FPPC  \
  -dbname fpplive1_site1 -datafileDestination DATA -dbtype SINGLE \
  -sudouser opc -sudopath /bin/sudo
Enter user "opc" password:
fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 20
fpps01.pub.fpplivelab.oraclevcn.com: Starting database creation on node fppc ...
fppc: SYS_PASSWORD_PROMPT
fppc:********
fppc: SYSTEM_PASSWORD_PROMPT
fppc: **********
fppc: [WARNING] [DBT-06208] The 'SYS' password entered does not conform to the Oracle recommended standards.
fppc:    CAUSE:
fppc: a. Oracle recommends that the password entered should be at least 8 characters in length, contain at least 1 uppercase character, 1 lower case character and 1 digit [0-9].
fppc: b.The password entered is a keyword that Oracle does not recommend to be used as password
fppc:    ACTION: Specify a strong password. If required refer Oracle documentation for guidelines.
fppc: [WARNING] [DBT-06208] The 'SYSTEM' password entered does not conform to the Oracle recommended standards.
fppc:    CAUSE:
fppc: a. Oracle recommends that the password entered should be at least 8 characters in length, contain at least 1 uppercase character, 1 lower case character and 1 digit [0-9].
fppc: b.The password entered is a keyword that Oracle does not recommend to be used as password
fppc:    ACTION: Specify a strong password. If required refer Oracle documentation for guidelines.
fppc: Prepare for db operation
fppc: 10% complete
fppc: Registering database with Oracle Restart
fppc: 14% complete
fppc: Copying database files
fppc: 43% complete
fppc: Creating and starting Oracle instance
fppc: 45% complete
fppc: 49% complete
fppc: 53% complete
fppc: 56% complete
fppc: 62% complete
fppc: Completing Database Creation
fppc: 68% complete
fppc: 70% complete
fppc: 71% complete
fppc: Executing Post Configuration Actions
fppc: 100% complete
fppc: Database creation complete. For details check the logfiles at:
fppc:  /u01/app/oracle/cfgtoollogs/dbca/fpplive1_site1.
fppc: Database Information:
fppc: Global Database Name:fpplive1_site1
fppc: System Identifier(SID):fpplive1site
fppc: Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/fpplive1_site1/fpplive1_site1.log" for further details.
[grid@fpps01 ~]$
```

Notice that you have not specified the target name: the FPP server knows what is the target node (or cluster) because the working copy named `WC_db_19_9_0_FPPC` has been provisioned there. This information is stored in the FPP metadata schema.

## Step 2: Verify the new database

Connect to the target node:
```
[grid@fpps01 ~]$ ssh opc@fppc
opc@fppc's password: FPPll##123
Last login: Wed Apr  7 08:56:12 2021
[opc@fppc ~]$ sudo su - oracle
Last login: Wed Apr  7 08:56:17 GMT 2021
[oracle@fppc ~]$
```
As user `oracle`, set the environment for the new database:
```
[oracle@fppc ~]$ . oraenv
ORACLE_SID = [oracle] ? fpplive1site
The Oracle base has been set to /u01/app/oracle
[oracle@fppc ~]$
```
Check the status of the database with `srvctl` and `sqlplus`:
```
[oracle@fppc ~]$ srvctl status database -db fpplive1_site1 -verbose
Database fpplive1_site1 is running. Instance status: Open.

[oracle@fppc ~]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Wed Apr 7 09:25:07 2021
Version 19.9.0.0.0

Copyright (c) 1982, 2020, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.9.0.0.0

SQL> set lines 220
SQL> select PATCH_ID, PATCH_UID, STATUS, DESCRIPTION from DBA_REGISTRY_SQLPATCH;

  PATCH_ID  PATCH_UID STATUS                    DESCRIPTION
---------- ---------- ------------------------- ----------------------------------------------------------------------------------------------------
  31771877   23869227 SUCCESS                   Database Release Update : 19.9.0.0.201020 (31771877)

SQL> exit
Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.9.0.0.0
[oracle@fppc ~]$
```

The database is there, wasn't that easy? You may now [proceed to the next lab](#next) and try to patch it.
