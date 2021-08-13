
# Use Recovery Manager (RMAN) to Connect to a PDB to Use the Recovery Catalog

## Introduction

Oracle Database 19c provides complete backup and recovery flexibility for multitenant container databases (CDBs) and pluggable databases (PDBs) with recovery catalog support. You can use a virtual private catalog (VPC) user to control permissions to perform backup and restore operations at a PDB level. The metadata view is also limited, so a VPC user can view only data for which the user has been granted permission.

In this lab, you create a PDB named PDB19 to act as the recovery catalog database for all other PDBs in CDB1. `ARCHIVELOG` mode must be enabled on CDB1.

Estimated Lab Time: 15 minutes

### Objectives

Learn how to do the following:

- Prepare your environment
- Create a recovery catalog database
- Create a recovery catalog owner and grant it privileges
- Create the recovery catalog in the recovery catalog database with RMAN and register CDB1
- Grant VPD privileges to the base catalog schema owner
- Upgrade the recovery catalog
- Create VPC users
- Back up and restore PDB1
- Find the handle value that corresponds to your tag value
- Revoke privileges from the VPC users and drop the recovery catalog
- Reset your environment


### Prerequisites

Before you start, be sure that you have obtained and signed in to your `workshop-installed` compute instance. If not, see the lab called **Obtain a Compute Image with Oracle Database 19c Installed**.

## Task 1: Prepare your environment

1. Run the `enable_ARCHIVELOG.sh` shell script to enable `ARCHIVELOG` mode in CDB1. Enter **CDB1** at the prompt.

    ```
    $ <copy>$HOME/labs/19cnf/enable_ARCHIVELOG.sh</copy>
    CDB1
    ```

2. Run the `cleanup_PDBs_in_CDB1.sh` shell script to drop all PDBs in CDB1 that may have been created in other labs, and recreate PDB1. You can ignore any error messages that are caused by the script. They are expected.

    ```
    $ <copy>$HOME/labs/19cnf/cleanup_PDBs_in_CDB1.sh</copy>
    ```

3. Run the `create_PDB2_in_CDB1.sh` shell script to create PDB2 in CDB1. You can ignore any error messages that are caused by the script. They are expected.

    ```
    $ <copy>$HOME/labs/19cnf/recreate_PDB2_in_CDB1.sh</copy>
    ```

## Task 2: Create a recovery catalog database

Create a PDB named PDB19 to act as the recovery catalog database. This database provides an optional backup store for the RMAN repository.

1.  Run the `create_PDB19_in_CDB1.sh` shell script to create PDB19 in CDB1.

    ```
    $ <copy>$HOME/labs/19cnf/create_PDB19_in_CDB1.sh</copy>
    ```

2. Execute the `glogin.sh` shell script to format all of the columns selected in queries.

    ```
    $ <copy>$HOME/labs/19cnf/glogin.sh</copy>
    ```

## Task 3: Create a recovery catalog owner and grant it privileges

In PDB19, create a recovery catalog owner named `catowner` and grant it privileges.

1. Set the environment variable to CDB1. Enter **CDB1** at the prompt.

    ```
    $ <copy>. oraenv</copy>
    CDB1   
    ```

2. Connect to PDB19 as the `SYSTEM` user.

    ```
    $ <copy>sqlplus system/Ora4U_1234@PDB19</copy>
    ```

3. Create a user named `catowner` that will act as the recovery catalog owner.

    ```
    SQL> <copy>CREATE USER catowner IDENTIFIED BY Ora4U_1234;</copy>
    User created.
    ```

4. Grant the necessary privileges to `catowner`.

    ```
    SQL> <copy>GRANT create session, recovery_catalog_owner, unlimited tablespace TO catowner;</copy>
    Grant succeeded.
    ```

5. Exit SQL*Plus.

    ```
    SQL> <copy>EXIT</copy>
    ```

## Task 4: Create the recovery catalog in the recovery catalog database with RMAN and register CDB1

Create a virtual private catalog (VPC), also referred to simply as "recovery catalog", in PDB19 for users and databases. Register CDB1 in the recovery catalog.

1. Start Recovery Manager (RMAN).

    ```
    $ <copy>rman</copy>
    ```

2. Connect to the recovery catalog database as the recovery catalog owner.

    ```
    RMAN> <copy>CONNECT CATALOG catowner/Ora4U_1234@PDB19</copy>
    connected to recovery catalog database
    ```

3. Create the recovery catalog.

    ```
    RMAN> <copy>CREATE CATALOG;</copy>
    recovery catalog created
    ```

4. Exit RMAN.

    ```
    RMAN> <copy>EXIT</copy>
    Recovery Manager complete.
    ```

5. Connect to CDB1 and the recovery catalog (PDB19) through RMAN.

    ```
    $ <copy>rman target / catalog catowner/Ora4U_1234@PDB19</copy>

    Recovery Manager: Release 19.0.0.0.0 - Production on Thu Jul 15 12:07:26 2021
    Version 19.11.0.0.0

    Copyright (c) 1982, 2019, Oracle and/or its affiliates. All rights reserved.

    connected to target database: CDB1 (DBID=1051548720)
    connected to recovery catalog database
    ```

6. Register CDB1 in the recovery catalog.

    ```
    RMAN> <copy>REGISTER DATABASE;</copy>

    database registered in recovery catalog
    starting full resync of recovery catalog
    full resync complete
    ```

7. Exit RMAN.

    ```
    RMAN> <copy>EXIT</copy>
    Recovery Manager complete.
    ```

## Task 5: Grant VPD privileges to the base catalog schema owner

Oracle Virtual Private Database (VPD) creates security policies to control database access at the row and column level. The VPD functionality is not enabled by default when the RMAN base recovery catalog is created. You need to explicitly enable the VPD model for a base recovery catalog by running the `$ORACLE_HOME/rdbms/admin/dbmsrmanvpc.sql` script.

1. Connect to the recovery catalog database as the `SYS` user.

    ```
    $ <copy>sqlplus sys/Ora4U_1234@PDB19 AS SYSDBA</copy>
    ```

2. Enable the VPD model for the recovery catalog by running the `dbmsrmanvpc.sql` script with the `–vpd` option.

    The following command enables the VPD model for the recovery catalog owned by the user `catowner`.

    ```
    SQL> <copy>@/$ORACLE_HOME/rdbms/admin/dbmsrmanvpc.sql -vpd catowner</copy>

    checking the operating user... Passed

    Granting VPD privileges to the owner of the base catalog schema CATOWNER

    ==============================
    VPD SETUP STATUS:
    VPD privileges granted successfully!
    Connect to RMAN base catalog and perform UPGRADE CATALOG.

    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production

    Version 19.11.0.0.0
    ```

## Task 6: Upgrade the recovery catalog

1. Start RMAN.

    ```
    $ <copy>rman</copy>
    ```
2. Connect to the recovery catalog database.

    ```
    RMAN> <copy>CONNECT CATALOG catowner/Ora4U_1234@PDB19</copy>
    connected to recovery catalog database
    ```
3. Upgrade the recovery catalog. The following command upgrades the recovery catalog schema from an older version to the version required by the RMAN client.

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



## Task 7: Create VPC users

Connect to the recovery catalog database as the `SYSTEM` user and create the VPC users `vpc_pdb1` and `vpc_pdb2`. Grant the users the `CREATE SESSION` privilege. Next, connect to the recovery catalog database as the base catalog owner and grant the `vpc_pdb1` and `vpc_pdb2` users access to the metadata of PDB1 and PDB2, respectively.

1. Connect to the recovery catalog database as the `SYSTEM` user.

    ```
    $ <copy>sqlplus system/Ora4U_1234@PDB19</copy>
    ```

2. Create a `vpc_pdb1` user.

    ```
    SQL> <copy>CREATE USER vpc_pdb1 IDENTIFIED BY Ora4U_1234;</copy>
    User created.
    ```

3. Create a `vpc_pdb2` user.

    ```
    SQL> <copy>CREATE USER vpc_pdb2 IDENTIFIED BY Ora4U_1234;</copy>
    User created.
    ```

4. Grant the `CREATE SESSION` privilege to `vpc_pdb1` and `vpc_pdb2`.

    ```
    SQL> <copy>GRANT CREATE SESSION TO vpc_pdb1, vpc_pdb2;</copy>
    Grant succeeded.
    ```

5. Exit SQL*Plus.

    ```
    SQL> <copy>EXIT</copy>
    ```

6. Start RMAN.

    ```
    $ <copy>rman</copy>
    ```

7. Connect to the recovery catalog database as the recovery catalog owner.

    ```
    RMAN> <copy>CONNECT CATALOG catowner/Ora4U_1234@PDB19</copy>
    connected to recovery catalog database
    ```

8. Grant the `vpc_pdb1` user the `GRANT CATALOG` privilege for PDB1.

    ```
    RMAN> <copy>GRANT CATALOG FOR PLUGGABLE DATABASE PDB1 TO vpc_pdb1;</copy>
    Grant succeeded.
    ```

9. Grant the `vpc_pdb2` user the `GRANT CATALOG` privilege for PDB2.

    ```
    RMAN> <copy>GRANT CATALOG FOR PLUGGABLE DATABASE pdb2 TO vpc_pdb2;</copy>
    Grant succeeded.
    ```

10. Exit RMAN.

    ```
    RMAN> <copy>EXIT</copy>
    ```

## Task 8: Back up and restore PDB1

RMAN can store backup data in a logical structure called a backup set, which is the smallest unit of an RMAN backup. A backup set contains the data from one or more datafiles, archived redo logs, control files, or server parameter file. A backup set contains one or more binary files in an RMAN-specific format. Each of these files is known as a backup piece. In the output from the `BACKUP DATABASE` command, you can find a handle value and a tag value. The handle value is the destination of the backup piece. The tag value is a reference for the backupset. If you do not specify your own tag, RMAN assigns a default tag automatically to all backupsets created. The default tag has a format `TAGYYYYMMDDTHHMMSS`, where `YYYYMMDD` is a date and `HHMMSS` is a time of when taking the backup was started. The instance timezone is used.  In a later task, you create a query using your tag value to find the handle value.

In RMAN, connect to PDB1 (the target PDB) and to the recovery catalog database as the `vpc_pdb1` user to back up and restore PDB1. Next, try to back up PDB1 as user `vpc_pdb2` and observe what happens.

1. Run RMAN with the following arguments. The `TARGET` keyword takes in the target PDB as an argument. The `CATALOG` keyword takes in the recovery catalog database as an argument.

    ```
    $ <copy>rman TARGET sys/Ora4U_1234@PDB1 CATALOG vpc_pdb1/Ora4U_1234@PDB19</copy>

    connected to target database: CDB1:PDB1 (DBID=964683444)
    connected to recovery catalog database
    ```

2. Run the `BACKUP DATABASE` commmand.

    If you did not previously enable `ARCHIVELOG` mode in CDB1, this step fails.

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

3. Save your `tag` value from the previous output. It is located on the third line from the bottom. In the example above, the tag value is `TAG20210603T184728`.

4. Exit RMAN.

    ```
    RMAN> <copy>EXIT</copy>
    Recovery Manager complete.
    ```

5. Using RMAN, connect to PDB1 and the recovery catalog database as the `vpc_pdb2` user.

    ```
    $ <copy>rman TARGET sys/Ora4U_1234@PDB1 CATALOG vpc_pdb2/Ora4U_1234@PDB19</copy>

    connected to target database: CDB1:PDB1 (DBID=690853089)
    connected to recovery catalog database
    ```

6. Try to run the `BACKUP DATABASE` command to back up PDB1.

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
    The backup fails because `vpc_pdb2` is not allowed to access metadata for PDB1.

7. Try to run the `BACKUP PLUGGABLE DATABASE` command to back up PDB1.

    ```
    RMAN> <copy>BACKUP PLUGGABLE DATABASE PDB1;</copy>

    RMAN-00571: ===========================================================
    RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
    RMAN-00571: ===========================================================
    RMAN-03002: failure of backup command at 07/19/2021 15:48:35
    RMAN-03014: implicit resync of recovery catalog failed
    RMAN-06004: Oracle error from recovery catalog database: RMAN-20001: target database not found in recovery catalog
    ```

    The backup fails again because `vpc_pdb2` is not allowed to access metadata for PDB1. The VPC user can perform operations only on the target PDB to which the user is granted access.

8.  Exit RMAN

    ```
    $ <copy>EXIT</copy>
    Recovery Manager complete.
    ```

## Task 9: Find the handle value that corresponds to your tag value

Query the `RC_BACKUP_PIECE` view, which contains information about backup pieces. This view corresponds to the `V$BACKUP_PIECE` view.
Each backup set contains one or more backup pieces. Multiple copies of the same backup piece can exist, but each copy has its own record in the control file and its own row in the view.

1. Connect to the recovery catalog database as the catalog owner.

    ```
    $ <copy>sqlplus catowner/Ora4U_1234@PDB19</copy>
    ```

2. Query the `RC_BACKUP_PIECE` view for the handle that corresponds to your `tag` value. Replace `<insert tag number>` with your `tag` value.

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

## Task 10: Revoke privileges from the VPC users and drop the recovery catalog

Revoke recovery catalog privileges from the two VPC users, `vpc_pdb1` and `vpc_pdb2`. Verify by attempting to back up PDB1 as `vpc_pdb1`. Drop the recovery catalog from PDB19.

1. Connect to the recovery catalog database as the recovery catalog owner.

    ```
    $ <copy>rman CATALOG catowner/Ora4U_1234@PDB19</copy>
    connected to recovery catalog database
    ```

2. Revoke recovery catalog privileges from `vpc_pdb1`.

    ```
    RMAN> <copy>REVOKE CATALOG FOR PLUGGABLE DATABASE PDB1 FROM vpc_pdb1;</copy>
    Revoke succeeded.
    ```

3. Revoke recovery catalog privileges from `vpc_pdb2`.

    ```
    RMAN> <copy>REVOKE CATALOG FOR PLUGGABLE DATABASE PDB2 FROM vpc_pdb2;</copy>
    Revoke succeeded.
    ```

4. Exit RMAN.

    ```
    RMAN> <copy>EXIT</copy>
    Recovery Manager complete.
    ```

5. Connect to `PDB1` and the recovery catalog database as the `vpc_pdb1` user through RMAN.

    ```
    $ <copy>rman TARGET sys/Ora4U_1234@PDB1 CATALOG vpc_pdb1/Ora4U_1234@PDB19</copy>

    connected to target database: CDB1:PDB1 (DBID=690853089)
    connected to recovery catalog database
    ```

6. Try to back up `PDB1`.

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

    The backup fails, as it should.

7. Exit RMAN.

    ```
    RMAN> <copy>EXIT</copy>
    Recovery Manager complete.
    ```


8. Connect to the recovery catalog database as the catalog owner through RMAN.

    ```
    $ <copy>rman CATALOG catowner/Ora4U_1234@PDB19</copy>
    connected to recovery catalog database
    ```

9. Drop the recovery catalog.

    ```
    RMAN> <copy>DROP CATALOG;</copy>

    recovery catalog owner is CATOWNER
    enter DROP CATALOG command again to confirm catalog removal
    ```

10. Confirm that you want to drop the recovery catalog by repeating the command.

    ```
    RMAN> <copy>DROP CATALOG;</copy>
    recovery catalog dropped
    ```

11. Exit RMAN.

    ```
    RMAN> <copy>EXIT</copy>
    Recovery Manager complete.
    ```

## Task 11: Restore your environment

Disable `ARCHIVELOG` mode on CDB1 and clean up the PDBs in CDB1.

1. Run the `disable_ARCHIVELOG.sh` shell script to disable `ARCHIVELOG` mode. Enter **CDB1** at the prompt.

    ```
    $ <copy>$HOME/labs/19cnf/disable_ARCHIVELOG.sh</copy>
    ORACLE_SID = [ORCL] ? CDB1
    ```
2. Run the `cleanup_PDBs_in_CDB1.sh` shell script to recreate PDB1 and remove other PDBs in the container database if they exist. You can ignore any error messages.

    ```
    $ <copy>$HOME/labs/19cnf/cleanup_PDBs_in_CDB1.sh</copy>

    ```

## Learn More

- [Database New Features Guide (Release 19c)](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)
- [Managing a Recovery Catalog](https://docs.oracle.com/en/database/oracle/oracle-database/18/bradv/managing-recovery-catalog.html#GUID-E836E243-6620-495B-ACFB-AC0001EF4E89)

## Acknowledgements

- **Author** - Dominique Jeunot, Consulting User Assistance Developer
- **Technical Contributor** - Jody Glover, Principal User Assistance Developer
- **Last Updated By/Date** - Matthew McDaniel, Austin Specialists Hub, August 13 2021
