# Duplicate a CDB by Using DBCA in Silent Mode

## Introduction

This tutorial shows you how to use Database Configuration Assistant (DBCA) to duplicate a container database (CDB). In Oracle Database 18c, duplicating a CDB requires several commands to be executed.

Estimated Lab Time: 15 minutes

### What Do You Need?

- Oracle Database 19c installed
- A CDB: `CDB1` with `PDB1` in archivelog mode.
- `HR` schema installed in `PDB1` as an example of application tables.


### Objectives

Learn how to do the following:

- Check the Existence of Application Data in the CDB
- Use DBCA to Duplicate a CDB
- Check that the CDB Is Duplicated
- Use DBCA to Duplicate a CDB with OMF
- Clean Up the CDBs Duplicated

### Prerequisites

Be sure that the following tasks are completed before you start:

- Obtain an Oracle Cloud account.
- Create SSH keys.
- Sign in to Oracle Cloud Infrastructure.

## **STEP 1**: To enable ARCHIVELOG mode on a CDB:
1. Set the environment variable to CDB1.
```
$ . oraenv
CDB1
```
2. Run the enable_ARCHIVELOG.sh script. The script shuts down the database according to the user’s ORACLE_SID (. Oraenv). Once all of the settings have been set, the database will startup. If your lab needs to shut the DB down at the end, or if it’s shutdown at the beginning, you will need to keep this in mind.
```
$ @$HOME/labs/19cnf/enable_ARCHIVELOG.sh
```

## **STEP 2**: Check the Existence of Application Data in the CDB

1. Log in to `PDB1` in `CDB1` as `SYSTEM`.
    ```
    sqlplus system@PDB1
    Enter password: password
    ```

2. Verify that `PDB1` contains the `HR.EMPLOYEES` table.
    ```

    SELECT count(*) FROM hr.employees;

    COUNT(*)
    ----------
          107
    ```

3. Quit the session.

    ```
    EXIT
    ```
4. (Optional) If you completed step 1-3 successfully then you can skip this step
Use the [hr_main.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/duplicate-cdbs-using-dbca-silent-mode/files/hr.sql) script to create the `HR` user and `EMPLOYEES` table in `PDB1`.

    ```
    @/home/oracle/labs/19cnf/hr_main.sql
    ```

## **STEP 3**: Use DBCA to Duplicate a CDB

In this section, you use `DBCA` in silent mode to duplicate `CDB1` as `CDB19`.

1. Launch `DBCA` in silent mode to duplicate `CDB1` as `CDB19`. Update the hostname by your server name in the command. `SI` means Single Instance.
```
dbca -silent -createDuplicateDB -gdbName CDB19 -sid CDB19 -primaryDBConnectionString hostname:1521/ORCL -databaseConfigType SI -initParams db_unique_name=CDB19 -sysPassword password -datafileDestination /u02/app/oracle/oradata
```
```
Prepare for db operation 22% complete
Listener config step 44% complete
Auxiliary instance creation 67% complete
RMAN duplicate 89% complete
Post duplicate database operations 100% complete
Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDB19/CDB19.log" for further details.
```

## **STEP 4**: Check that the CDB Is Duplicated
1. Connect to `CDB19` as `SYS`.
```
sqlplus sys@CDB19 AS SYSDBA
Enter password: password
```

  ```
  SHOW PDBS

  CON_ID CON_NAME                       OPEN MODE  RESTRICTED
  --------------------------------------------------------------------
       2 PDB$SEED                       READ ONLY  NO
       3 PDB1                           READ WRITE NO

  ```
2. Check that `PDB1` contains the `HR.EMPLOYEES` table as in `PDB1` of `CDB1`.
```
CONNECT hr@PDB1
Enter password: password
```
```
SELECT count(*) FROM employees;

  COUNT(*)

       107
```

## **STEP 5**: Use DBCA to Duplicate a CDB with OMF
In this section, you use `DBCA` in silent mode to duplicate `CDB1` as `CDBOMF19` with `OMF` files.
1. Launch `DBCA` in silent mode to duplicate `CDB1` as `CDBOMF19`. Update the hostname by your server name in the command.
```
dbca -silent -createDuplicateDB -gdbName CDBOMF19 -sid CDBOMF19 -primaryDBConnectionString hostname:1521/ORCL -databaseConfigType SI -initParams db_unique_name=CDBOMF19 -sysPassword password -datafileDestination /u02/app/oracle/oradata –useOMF=TRUE
```
```
Prepare for db operation 22% complete
Listener config step 44% complete
Auxiliary instance creation 67% complete
RMAN duplicate 89% complete
Post duplicate database operations 100% complete
Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDBOMF19/CDBOMF19.log" for further details.
```


2. Connect to `CDBOMF19` as `SYS`.
```
sqlplus sys@CDBOMF19 AS SYSDBA
Enter password: password
```
```
COL name FORMAT A78
SELECT name FROM v$datafile;
```

  ```
  NAME
  --------------------------------------------------------------------
  /u02/app/oracle/oradata/CDBOMF19/system01.dbf
  ...
  /u02/app/oracle/oradata/CDBOMF19/PDB1/system01.dbf
  /u02/app/oracle/oradata/CDBOMF19/PDB1/sysaux01.dbf
  /u02/app/oracle/oradata/CDBOMF19/PDB1/undotbs01.dbf
  ...
  ```

3. Quit the session

  ```
  EXIT

  ```

## **STEP 6**: Clean Up the CDBs Duplicated
1. Use `DBCA` to delete `CDB19`.

```
$ORACLE_HOME/bin/dbca -silent -deleteDatabase -sourceDB CDB19 -sid CDB19 -sysPassword password

```
2. Use `DBCA` to delete `CDBOMF19`.

```
$ORACLE_HOME/bin/dbca -silent -deleteDatabase -sourceDB CDBOMF19 -sid CDBOMF19 -sysPassword password

```

## **STEP 7**: To disable ARCHIVELOG mode on a CDB:

1. Set the environment variable to CDB1.
```
$ . oraenv
CDB1
```
2. Run the disable_ARCHIVELOG.sh script.
```
$ @$HOME/labs/19cnf/disable_ARCHIVELOG.sh
```

## Learn More

- [Overview of CDBs and PDBs](https://docs.oracle.com/database/121/ADMQS/GUID-0FEBEF5F-DF3E-4101-B18B-84921E2F6AA2.htm#ADMQS12498)
- [DBCA Silent Mode Commands](https://docs.oracle.com/en/database/oracle/oracle-database/21/multi/dbca-command.html#GUID-EC3C396B-6FFB-4957-BC73-1BE8F4FD852E)


## Acknowledgements
* **Primary Author: Dominique Jeunot's, Consulting User Assistance Developer**
* **Last Updated By: Blake Hendricks, Solutions Engineer, 7/13/21**
