
# Use Recovery Manager (RMAN) to Connect to a PDB to Use the Recovery Catalog

## Introduction

Oracle Database Release 19c provides complete backup and recovery flexibility for multitenant container database (CDB) and PDB level backups and restores, including recovery catalog support. You can use a virtual private catalog (VPC) user to control permissions to perform backup and restore operations at a PDB level. Metadata view is also limited, so a VPC user can view only data for which the user has been granted permission.

In this lab, you will set up a pluggable database (PDB) as a recovery catalog for all other PDBs in the container.

Estimated Lab Time: 15 minutes

### Objectives

Learn how to do the following:

- Enable `ARCHIVELOG` mode.
- Prepare the environment.
- Create a catalog owner and grant privileges.
- Create the recovery catalog with RMAN and register CDB1.
- Grant VPD privileges to the base catalog schema owner.
- Upgrade the recovery catalog.
- Create VPC users.
- Back up and restore `PDB1`.
- Find the handle value that corresponds to your tag value.
- Reset your environment.
- Disable `ARCHIVELOG` mode.


### Prerequisites

Be sure that the following tasks are completed before you start:

- Lab 4 completed.
- Obtain a compute instance with Oracle Database 19c installed on it and download the class files. If not, see "Obtain a Compute Image with Oracle Database 19c Installed". [Link to lab](https://www.oracle.com)
- If not downloaded, download 19cNewFeatures.zip

## **Task 1**: Enable `ARCHIVELOG` mode
1. To execute this lab, you must enable 'ARCHIVELOG' mod in `CDB1`. To do this, run the following script. When prompted with `ORACLE_SID`, insert `CDB1`.

    ```
    $ <copy>$HOME/labs/19cnf/enable_ARCHIVELOG.sh</copy>
    ORACLE_SID = [ORCL] ? CDB1
    ```

## **Task 2**: Prepare the environment
1. Execute the `$HOME/labs/19cnf/cleanup_PDBs_in_CDB1.sh` shell script to drop all PDBs in `CDB1` that may have been created by any of the practices, and recreates `PDB1`. You may ignore any error messages that are caused by the script, they are to be expected.
   
    ```
    $ <copy>$HOME/labs/19cnf/cleanup_PDBs_in_CDB1.sh</copy>
    ``` 

2. Execute the `$HOME/labs/19cnf/create_PDB2_in_CDB1.sh` shell script to create `PDB2` in `CDB1`. You may ignore any error messages that are caused by the script, they are to be expected.
   
    ```
    $ <copy>$HOME/labs/19cnf/recreate_PDB2_in_CDB1.sh</copy>
    ```

3.  Execute the `$HOME/labs/19cnf/create_PDB19_in_CDB1.sh` shell script. this will create `PDB19` in the `CDB1` container. `PDB19` will be the recovery catalog database. which is a database that provides an optional backup store for the RMAN repository in addition to the control file.
   
    ```
    $ <copy>$HOME/labs/19cnf/create_PDB19_in_CDB1.sh</copy>
    ```
4. Execute the `$HOME/labs/19cnf/glogin.sh` shell script to format all of the columns selected in queries.

    ```
    $ <copy>$HOME/labs/19cnf/glogin.sh</copy>
    ```

## **Task 3**: Create a catalog owner and grant privileges 
   To connect to the recovery catalog and to PDB1 as the target database, create a virtual private RMAN catalog (VPC) in PDB19 for groups of databases and users of CDB1, PDB1, and PDB2.
1. Set `$ORACLE_SID` to `CDB1`
   
    ```
    $ <copy>. oraenv</copy>
    ORACLE_SID = [ORCL] ? CDB1   
    ```
2. Connect to PDB19.
   
    ```
    $ <copy>sqlplus system/Ora4U_1234@PDB19</copy>
    ```
3. Create a new user `catowner` that will act as the catalog owner.
   
    ```
    SQL> <copy>CREATE USER catowner IDENTIFIED BY Ora4U_1234;</copy>

    user created.
    ```
4. Grant the following privileges to `catowner`.
   
    ```
    SQL> <copy>GRANT create session, recovery_catalog_owner, unlimited tablespace TO catowner;</copy> 

    Grant succeeded.
    ```
5. Exit SQL*Plus.
   
    ```
    SQL> <copy>EXIT</copy>
    ```

## **Task 4**: Create the recovery catalog with RMAN and register CDB1
1. Start RMAN.
    
    ```
    $ <copy>rman</copy>
    ```
2. Connect to the recovery catalog.

    ```
    RMAN> <copy>CONNECT CATALOG catowner/Ora4U_1234@PDB19</copy>

    connected to recovery catalog database
    ```

    ```
    RMAN> <copy>CREATE CATALOG;</copy>

    recovery catalog created
    ```

    ```
    RMAN> <copy>EXIT;</copy>

    Recovery Manager complete
    ```

3. Connect to the target (`CDB1`) and the recovery catalog (`PDB19`) through RMAN.

    ```
    $ <copy>rman target / catalog catowner/Ora4U_1234@PDB19</copy>

    Recovery Manager: Release 19.0.0.0.0 - Production on Thu Jul 15 12:07:26 2021
    Version 19.11.0.0.0

    Copyright (c) 1982, 2019, Oracle and/or its affiliates. All rights reserved.

    connected to target database: CDB1 (DBID=1051548720)
    connected to recovery catalog database
    ```
4. Register `CDB1` in the recovery catalog. 

    ```
    RMAN> <copy>REGISTER DATABASE;</copy>

    database registered in recovery catalog
    starting full resync of recovery catalog
    full resync complete
    ```

    ```
    RMAN> <copy>EXIT</copy>

    Recovery Manager complete.
    ```
## **Task 5**: Grant VPD privileges to the base catalog schema owner
1. Connect to the recovery catalog as the **SYS** user.

    ```
    $ <copy>sqlplus sys/Ora4U_1234@PDB19 AS SYSDBA</copy>
    ```
2. The VPD functionality is not enabled by default when the RMAN base recovery catalog is created. You need to explicitly enable the VPD model for a base recovery catalog by running the `$ORACLE_HOME/rdbms/admin/dbmsrmanvpc.sql` script after upgrading the base catalog schema. 
   
3. Execute **dbmsrmanvpc.sql** to grant VPD-required privileges to the base catalog owner. 

    ```
    SQL> <copy>@$ORACLE_HOME/rdbms/admin/dbmsrmanvpc.sql -vpd catowner</copy>

    checking the operating user... Passed

    Granting VPD privileges to the owner of the base catalog schema CATOWNER

    ==============================
    VPD SETUP STATUS:
    VPD privileges granted successfully!
    Connect to RMAN base catalog and perform UPGRADE CATALOG.

    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production

    Version 19.11.0.0.0
    ```
## **Task 6**: Upgrade the recovery catalog
1. Start RMAN.

    ```
    $ <copy>rman</copy>
    ```
2. Connect to the RMAN base catalog. 

    ```
    RMAN> <copy>CONNECT CATALOG catowner/Ora4U_1234@PDB19</copy>

    connected to recovery catalog database
    ```
3. Upgrade the recovery catalog. The following command will upgrade a recovery catalog schema from an older version to the version required by the RMAN client. 

    ```
    RMAN> <copy>UPGRADE CATALOG;</copy>

    recovery catalog owner is CATOWNER
    enter UPGRADE CATALOG command again to confirm catalog upgrade
    ```
4. Enter the command again to confirm upgrade.

    ```
    RMAN> <copy>UPGRADE CATALOG;</copy>

    recovery catalog upgraded to version 19.11.00.00.00

    DBMS_RCVMAN package upgraded to version 19.11.00.00

    DBMS_RCVCAT package upgraded to version
    ```
5. Exit RMAN

    ```
    RMAN> <copy>exit</copy>
    ```
       
## **Task 7**: Create VPC users
Create the VPC users, **vpc\_pdb1** and **vpc\_pdb2**, in the catalog. They will be given access to the metadata of `PDB1` and `PDB2`, respectively. Next, as the base catalog owner, give the VPC users access to the metadata of PDB1 and PDB2, respectively.
1. Connect to the recovery catalog as the **`SYSTEM`** user.

    ```
    $ <copy>sqlplus system/Ora4U_1234@PDB19</copy>
    ```
2. Create a **`vpc_pdb1`** user.

    ```
    SQL> <copy>CREATE USER vpc_pdb1 IDENTIFIED BY Ora4U_1234;</copy>

    User created.
    ```
3. Create a **`vpc_pdb2`** user.

    ```
    SQL> <copy>CREATE USER vpc_pdb2 IDENTIFIED BY Ora4U_1234;</copy>

    User created.
    ```
4. Grant the `CREATE SESSION` privilege to `vpc_pdb1` and `vpc_pdb2`.

    ```
    <copy>GRANT CREATE SESSION TO vpc_pdb1, vpc_pdb2;</copy>

    Grant succeeded.
    ```
5. Exit SQL*Plus.

    ```
    SQL> <copy>EXIT</copy>
    ```
6. As the base catalog owner, give the VPC users access to the metadata of `PDB1` and `PDB2`, respectively.

7. Connect to RMAN

    ```
    $ <copy>rman</copy> 
    ```
8. Connect to the recovery catalog as the catalog owner.

    ```
    RMAN> <copy>CONNECT CATALOG catowner/Ora4U_1234@PDB19</copy>

    connected to recovery catalog database
    ```
9. give the `vpc_pdb1` user the `GRANT CATALOG` privilege for `PDB1` 

    ```
    RMAN> <copy>GRANT CATALOG FOR PLUGGABLE DATABASE PDB1 TO vpc_pdb1;</copy>

    Grant succeeded.
    ```
10. give the `vpc_pdb2` user the `GRANT CATALOG` privilege for `PDB2`

    ```
    RMAN> <copy>GRANT CATALOG FOR PLUGGABLE DATABASE pdb2 TO vpc_pdb2;</copy>

    Grant succeeded.
    ```

    ```
    RMAN> <copy>EXIT</copy>
    ```
## **Task 8**: Back up and restore PDB1
Connect to the `PDB1` target PDB and to the recovery catalog as the **vpc_pdb1** user to back up and restore the `PDB1` target PDB.
1. Run RMAN with the following arguments. The `TARGET` keyword takes in a PDB as an argument. The `CATALOG` takes in a recovery catalog as an argument.

    ```
    $ <copy>rman TARGET sys/Ora4U_1234@PDB1 CATALOG vpc_pdb1/Ora4U_1234@PDB19</copy>

    connected to target database: CDB1:PDB1 (DBID=964683444)
    connected to recovery catalog database

    ```
2. RMAN can store backup data in a logical structure called a backup set, which is the smallest unit of an RMAN backup. A backup set contains the data from one or more datafiles, archived redo logs, control files, or server parameter file. A backup set contains one or more binary files in an RMAN-specific format. Each of these files is known as a backup piece. In the output from the BACKUP DATABASE command, you can find a handle value and a tag value.   The handle value is the destination of the backup piece. The tag value is a reference for the backupset. If you do not specify your own tag, RMAN assigns a default tag automatically to all backupsets created. The default tag has a format TAGYYYYMMDDTHHMMSS, where YYYYMMDD is a date and HHMMSS is a time of when taking the backup was started. The instance timezone is used.  In a later step, you create a query using your tag value to find the handle value.
   
3. Run the `BACKUP DATABASE;` commmand. This step will fail if you have not enabled `ARCHIVELOG` mode in `CDB1`. If you have not enabled `ARCHIVELOG` mode, please return to Step 1.

    ```
    RMAN> <copy>BACKUP DATABASE;</copy>

    Starting backup at 03-JUN-21
    allocated channel: ORA_DISK_1
    channel ORA_DISK_1: SID=144 device type=DISK
    channel ORA_DISK_1: starting full datafile backup set
    channel ORA_DISK_1: specifying datafile(s) in backup set
    input datafile file number=00017 name=/u01/app/oracle/oradata/CDB1/pdb1/CDB1/C3BA5E8EA41E0AAEE0530C00000A17E8/datafile/o1_mf_sysaux_jcf2oz64_.dbf
    input datafile file number=00016 name=/u01/app/oracle/oradata/CDB1/pdb1/CDB1/C3BA5E8EA41E0AAEE0530C00000A17E8/datafile/o1_mf_system_jcf2oz5v_.dbf
    input datafile file number=00018 name=/u01/app/oracle/oradata/CDB1/pdb1/CDB1/C3BA5E8EA41E0AAEE0530C00000A17E8/datafile/o1_mf_undotbs1_jcf2oz68_.dbf
    channel ORA_DISK_1: starting piece 1 at 03-JUN-21
    channel ORA_DISK_1: finished piece 1 at 03-JUN-21
    piece handle=/u01/app/oracle/oradata/CDB1/pdb1/0200gce1_2_1_1 tag=TAG20210603T184728 comment=NONE
    channel ORA_DISK_1: backup set complete, elapsed time: 00:00:15
    Finished backup at 03-JUN-21
    ```

4. Save your **TAG** value from the previous ouput, it is located in the third line from the bottom. In the example above, the tag value is TAG20210603T184728.

5. Exit RMAN

    ```
    RMAN> <copy>EXIT</copy>
    ```

6. Try to back up PDB1 as user vpc_pdb2. This step fails because vpc_pdb2 is allowed to access metadata for PDB2, not PDB1.

7. Connect to RMAN with the following arguments. 

    ```
    $ <copy>rman TARGET sys/Ora4U_1234@PDB1 CATALOG vpc_pdb2/Ora4U_1234@PDB19</copy>

    connected to target database: CDB1:PDB1 (DBID=690853089)
    connected to recovery catalog database
    ```
8. Run the `BACKUP DATABASE;` command.

    ```
    RMAN> <copy>BACKUP DATABASE;</copy>

    Starting backup at 05-AUG-21
    RMAN-00571: ===========================================================
    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
    RMAN-00571: ===========================================================
    RMAN-03002: failure of backup command at 08/05/2021 15:27:22
    RMAN-03014: implicit resync of recovery catalog failed
    RMAN-06004: Oracle error from recovery catalog database: RMAN-20001: target database not found in recovery catalog
    ```
1. Backup `PDB1`

    ```
    RMAN> <copy>BACKUP PLUGGABLE DATABASE PDB1;</copy>

    RMAN-00571: ===========================================================
    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
    RMAN-00571: ===========================================================
    RMAN-03002: failure of backup command at 07/19/2021 15:48:35
    RMAN-03014: implicit resync of recovery catalog failed
    RMAN-06004: Oracle error from recovery catalog database: RMAN-20001: target database not found in recovery catalog

    ```
2.  Exit RMAN

    ```
    $ <copy>EXIT;</copy>
    ```

## **Task 9**: Find the handle value that corresponds to your tag value.
Next we will query the `RC_BACKUP_PIECE` view, which contains information about backup pieces. This view corresponds to the `V$BACKUP_PIECE` view.
Each backup set contains one or more backup pieces. Multiple copies of the same backup piece can exist, but each copy has its own record in the control file and its own row in the view.

1. Connect to the recovery catalog as the catalog owner.

    ```
    $ <copy>sqlplus catowner/Ora4U_1234@PDB19</copy>
    ```
2. Query the `RC_BACKUP_PIECE` view for the handle that corresponds to your `TAG` value. Replace `<insert tag number>` with your `TAG` value.

    ```
    SQL> <copy>SELECT HANDLE FROM RC_BACKUP_PIECE WHERE TAG = '<insert tag number>';</copy>

    HANDLE
    --------------------------------------------------------------------
    /u01/app/oracle/recovery_area/CDB1/C77C7F498FD03099E0537600000AB488/
    backupset/2021_07_19/o1_mf_nnndf_TAG20210719T154436_jhc7h49j_.bkp

    ```
2. Exit SQL*Plus
   
    ```
    SQL> <copy>EXIT</copy>
    ```

## **Task 10**: Reset your environment
To reset your environment, you must revoke catalog privileges from your two VPC users, `vpc_pdb1` and `vpc_pdb2`. Then, you will verify this by attempting to back up PDB1 as `vpc_pdb1`. Finally, you will drop the catalog from `PDB19`.

1. connect to the recovery catalog through RMAN.

    ```
    $ <copy>rman CATALOG catowner/Ora4U_1234@PDB19</copy>

    connected to recovery catalog database
    ```
2. Revoke the `CATALOG FOR PLUGGABLE DATABASE PDB1` privilege from `vpc_pdb1`.

    ```
    RMAN> <copy>REVOKE CATALOG FOR PLUGGABLE DATABASE PDB1 FROM vpc_pdb1;</copy>

    Revoke succeeded.
    ```
3. Revoke the `CATALOG FOR PLUGGABLE DATABASE PDB1` privilege from `vpc_pdb2`.

    ```
    RMAN> <copy>REVOKE CATALOG FOR PLUGGABLE DATABASE PDB2 FROM vpc_pdb2;</copy>

    Revoke succeeded.
    ```
4. Exit RMAN.

    ```
    RMAN> <copy>EXIT;</copy>
    ```
5. Verify that the `vpc_pdb1` user cannot back up the `PDB1` target PDB via the recovery catalog.

6. Connect to `PDB1` and the recovery catalog through RMAN.

    ```
    $ <copy>rman TARGET sys/Ora4U_1234@PDB1 CATALOG vpc_pdb1/Ora4U_1234@PDB19</copy>

    connected to target database: CDB1:PDB1 (DBID=690853089)
    connected to recovery catalog database
    ```
7. Attempt to backup `PDB1`.

    ```
    RMAN> <copy>BACKUP DATABASE;</copy>

    Starting backup at 03-JUN-21
    RMAN-00571: ===========================================================
    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
    RMAN-00571: ===========================================================
    RMAN-03002: failure of backup command at 06/03/2021 20:31:37
    RMAN-03014: implicit resync of recovery catalog failed
    RMAN-06428: recovery catalog is not installed
    ```
8. Exit RMAN.

    ```
    RMAN> <copy>EXIT;</copy>
    ```
6. Connect to the recovery catalog through RMAN.

    ```
    $ <copy>rman CATALOG catowner/Ora4U_1234@PDB19</copy>

    connected to recovery catalog database
    ```
7. Drop the recovery catalog.

    ```
    RMAN> <copy>DROP CATALOG;</copy>

    recovery catalog owner is CATOWNER
    enter DROP CATALOG command again to confirm catalog removal
    ```
8. Confirm that you want to drop the catalog by repeating the command.

    ```
    RMAN> <copy>DROP CATALOG;</copy>

    recovery catalog dropped
    ```
9. Exit RMAN.

    ```
    RMAN> <copy>EXIT;</copy>
    ```
## **Task 11**: Disable `ARCHIVELOG` mode
1. To disable `ARCHIVELOG` mode, run the following script. When prompted with `ORACLE_SID`, insert `CDB1`.

    ```
    $ <copy>$HOME/labs/19cnf/disable_ARCHIVELOG.sh</copy>
    ORACLE_SID = [ORCL] ? CDB1
    ```

## Learn More

- [New Features in Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)
- [Backup and Recovery User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/18/bradv/managing-recovery-catalog.html#GUID-E836E243-6620-495B-ACFB-AC0001EF4E89)

## Acknowledgements

* **Author**- Dominique Jeunot, Consulting User Assistance Developer
* **Last Updated By/Date** - Matthew McDaniel, Austin Specialists Hub, July 2021

