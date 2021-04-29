# Patch the database

## Introduction

As explained in the lab *Install the Oracle Database homes (working copies)* , FPP implements out-of-place patching.
From the command line point of view, this is achieved by passing the **source working copy** (the non-patched Oracle Home) and the **target working copy** (the patched Oracle Home). Again, FPP knows where these two working copies are, so there is no need to pass the target nodes.

Along with these two parameters, you can pass a **list of databases** (by default all the databases hosted in the source working copy are patched).

FPP detects automatically the type of deployment (cluster or single node), type of database (RAC, RAC One Node or Single Instance), missing patches on the target working copy, etc.

If the database is in RAC mode (it is not the case in this workshop), FPP relocates gracefully the services and move one instance at the time to the new home, then runs datapatch at the end.
Again, this is achieved with a single line of code.

Estimated lab time: 10 minutes

### Objectives
In this lab, you will:
- Run the patching evaluation
- Patch the database
- Verify that the DB is patched and running in the new Oracle Home

### Prerequisites
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
      - Lab: Generate SSH Keys (Free-tier and Paid Tenants only)
      - Lab: Create the environment with Resource Manager (Free-tier and Paid Tenants only)
      - Lab: Get the Public IP of the FPP Server (Livelabs Tenant only)
      - Lab: Get Acquainted with the Environment and the rhpctl Command line tool
      - Lab: Import Gold Images
      - Lab: Provision an Oracle Restart environment
      - Lab: Install the Oracle Database homes (working copies)
      - Lab: Provision a new database

## **Step 1:** Run the patching evaluation
Like all the disruptive FPP commands, `rhpctl move database` can be run with the `-eval` switch to evaluate the basic requirements before executing the actual patching.
It is recommended to use `-eval` whenever possible. For patching, it is a good idea to run it hours or days before the intervention, so that any errors or missing requirements can be fixed in time.

1. Run the following command:

    ```
    $ rhpctl move database -sourcewc  WC_db_19_9_0_FPPC \
      -patchedwc WC_db_19_10_0_FPPC -dbname fpplive1_site1 \
      -sudouser opc -sudopath /bin/sudo -eval
    Enter user "opc" password: FPPll##123
    fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 27
    fpps01.pub.fpplivelab.oraclevcn.com: Evaluation in progress for "move database" ...
    fpps01.pub.fpplivelab.oraclevcn.com: verifying versions of Oracle homes ...
    fpps01.pub.fpplivelab.oraclevcn.com: verifying owners of Oracle homes ...
    fpps01.pub.fpplivelab.oraclevcn.com: verifying groups of Oracle homes ...
    fpps01.pub.fpplivelab.oraclevcn.com: Evaluation finished successfully for "move database".
    ```

  Because you have specified the correct groups when adding the working copy, this command succeeds.
  Otherwise, you might have seen an error similar to this:

    ```
    fpps01.pub.fpplivelab.oraclevcn.com: verifying groups of Oracle homes ...
    fpps01.pub.fpplivelab.oraclevcn.com: PRGO-1774 : The evaluation revealed potential failure for command "move database".
    PRGO-1619 : The groups "OSOPER=oper" of the source home are not configured in the patched working copy.\nPRGO-1618 : The groups "OSBACKUP=backupdba,OSDG=dgdba,OSKM=kmdba,OSRAC=racdba" of the source home do not match the groups "OSBACKUP=dba,OSDG=dba,OSKM=dba,OSRAC=dba" of the patched working copy.
    ```

## **Step 2:** Patch the database
1. The command is the same as before, but without the `-eval` switch:

    ```
    [grid@fpps01 ~]$ rhpctl move database -sourcewc  WC_db_19_9_0_FPPC \
      -patchedwc WC_db_19_10_0_FPPC -dbname fpplive1_site1 \
      -sudouser opc -sudopath /bin/sudo
    Enter user "opc" password: FPPll##123
    fpps01.pub.fpplivelab.oraclevcn.com: Audit ID: 28
    fpps01.pub.fpplivelab.oraclevcn.com: verifying versions of Oracle homes ...
    fpps01.pub.fpplivelab.oraclevcn.com: verifying owners of Oracle homes ...
    fpps01.pub.fpplivelab.oraclevcn.com: verifying groups of Oracle homes ...
    fpps01.pub.fpplivelab.oraclevcn.com: starting to move the following databases: "fpplive1_site1"
    fpps01.pub.fpplivelab.oraclevcn.com: restarting databases: "fpplive1_site1" ...
    fppc: trying datapatch run for fpplive1site, attempt### 1 ###
    fppc: datapatch completed successfully for database : fpplive1_site1
    fpps01.pub.fppllvcn.oraclevcn.com: Completed the 'move database' operation for databases: "fpplive1_site1"
    ```

## **Step 3:** Verify that the DB is patched and running in the new Oracle Home
1. Connect to the target node as `oracle`:

    ```
    [grid@fpps01 ~]$ ssh opc@fppc
    opc@fppc's password: FPPll##123
    Last login: Wed Apr  7 13:50:14 2021
    [opc@fppc ~]$ sudo su - oracle
    Last login: Wed Apr  7 13:56:39 GMT 2021 on pts/0
    ```

2. Set the environment:

    ```
    [oracle@fppc ~]$ . oraenv
    ORACLE_SID = [oracle] ? fpplive1site
    The Oracle base has been set to /u01/app/oracle
    ```

3. Verify the Oracle Restart configuration for the database:

    ```
    [oracle@fppc ~]$ srvctl config database -db fpplive1_site1
    Database unique name: fpplive1_site1
    Database name: fpplive1
    Oracle home: /u01/app/oracle/product/19.0.0.0/WC_db_19_10_0_FPPC
    Oracle user: oracle
    Spfile: +DATA/FPPLIVE1_SITE1/PARAMETERFILE/spfile.266.1069232853
    Password file:
    Domain:
    Start options: open
    Stop options: immediate
    Database role: PRIMARY
    Management policy: AUTOMATIC
    Disk Groups: DATA
    Services:
    OSDBA group:
    OSOPER group:
    Database instance: fpplive1site
    ```

  It is running in the new Oracle Home, the `srvctl` configuration has been adapted as well!

4. Let's see the patching level:

    ```
    [oracle@fppc ~]$ sqlplus / as sysdba

    SQL*Plus: Release 19.0.0.0.0 - Production on Tue Apr 13 14:22:47 2021
    Version 19.10.0.0.0

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0

    SQL> set lines 220
    SQL> select PATCH_ID, PATCH_UID, STATUS, DESCRIPTION from DBA_REGISTRY_SQLPATCH;

      PATCH_ID  PATCH_UID STATUS                    DESCRIPTION
    ---------- ---------- ------------------------- ----------------------------------------------------------------------------------------------------
      31771877   23869227 SUCCESS                   Database Release Update : 19.9.0.0.201020 (31771877)
      32067171   23947975 SUCCESS                   OJVM RELEASE UPDATE: 19.10.0.0.210119 (32067171)
      32218454   24018797 SUCCESS                   Database Release Update : 19.10.0.0.210119 (32218454)
      31465389   23988611 SUCCESS                   RMAN RECOVER FAILS FOR PDB$SEED DATAFILES RMAN-06163 RMAN-06166

    SQL> exit
    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    ```

From the output you can see that the Database has been patched correctly.

Congratulations! You have completed all the labs in this workshop. We hope you have liked it!

## Acknowledgements

- **Author** - Ludovico Caldara
- **Contributors** - Kamryn Vinson
- **Last Updated By/Date** -  Ludovico Caldara, April 2021