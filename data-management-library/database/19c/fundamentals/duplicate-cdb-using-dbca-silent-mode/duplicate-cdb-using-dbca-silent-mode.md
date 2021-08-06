# Duplicate a CDB by Using DBCA in Silent Mode

## Introduction

Starting with Oracle Database 19c, you can duplicate a container database by using the `createDuplicateDB` command in silent mode in Database Configuration Assistant (DBCA).

In this lab, you duplicate CDB1 twice by using the createDuplicateDB command of DBCA in silent mode. First, you duplicate CDB1 as a single individual database named DUPCDB1 with a basic configuration that uses the default listener. The second time you duplicate CDB1 as OMFCDB1 with Oracle Managed Files (OMF) enabled and a new listener. Oracle Managed Files (OMF) simplifies the creation of databases as Oracle does all OS operations and file naming.

Estimated Lab Time: 30 minutes

### Prerequisites

Before you start, be sure that you have done the following:
- Obtained an Oracle Cloud account
- Created SSH keys
- Signed in to Oracle Cloud Infrastructure
- Created a workshop-installed compute instance. If not, see Obtain a Compute Image with Oracle Database 19c Installed. On your compute instance, you will use CDB1 and PDB1, where PDB1 has sample data installed.


### Objectives

Learn how to do the following:

- Enable ARCHIVELOG mode on CDB1
- Check the existence of sample data in PDB1
- Use DBCA to duplicate CDB1 as a single individual database
- Use DBCA to duplicate CDB1 as OMFCDB1 and enable Oracle Managed Files
- Use DBCA to duplicate a CDB with OMF
- Clean up the CDBs duplicated

## Task 1: To enable ARCHIVELOG mode on CDB1:
The CDB must be in `ARCHIVELOG` mode before you can duplicate a CDB by using DBCA in silent mode.

1. Set the environment variable to CDB1.
```
$ . oraenv
CDB1
```
2. Run the enable_ARCHIVELOG.sh script and enter CDB1 at the prompt. The script shuts down the database according to the user’s ORACLE_SID. Once all of the settings have been set, the database will startup.
```
$ HOME/labs/19cnf/enable_ARCHIVELOG.sh
   CDB1
```

## Task 2: Check the existence of sample data in PDB1

In this step, you verify that PDB1 has sample data. After you duplicate CDB1 in a later step, you verify that the sample data is also duplicated.

1. After you enable ARCHIVELOG mode, PDB1 is closed, so you can't connect to it right away. You'll need to connect to CDB1 first, open PDB1, and then connect to it.

  ```
  . oraenv

  CDB1

  sqlplus / as sysdba

  ALTER PLUGGABLE DATABASE PDB1 OPEN;

  ALTER SESSION SET CONTAINER = PDB1;
  ```


2. Log in to `PDB1` in `CDB1` as `SYSTEM`.
    ```
    sqlplus system@PDB1
    Enter password: password
    ```

3. Verify that `PDB1` contains data in the `HR.EMPLOYEES` table.
    ```

   SQL> SELECT count(*) FROM hr.employees;

    COUNT(*)
    ----------
          107
    ```
4. (Optional) If in the previous step you find that you do not have an `HR.EMPLOYEES` table, run the [hr_main.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/duplicate-cdbs-using-dbca-silent-mode/files/hr.sql) script to create the HR user and `EMPLOYEES` table in `PDB1`.
        SQL> @/home/oracle/labs/19cnf/hr_main.sql
        Ora4U_1234 USERS TEMP $ORACLE_HOME/demo/schema/log/

5. Quit the session.

    ```
    EXIT
    ```


## Task 3: Use DBCA to duplicate CDB1 as a single individual database

In this step, you use the ``-createDuplicateDB`` command in DBCA to duplicate CDB1as a single individual database called DUPCDB1. The database configuration type is set to `SINGLE`, which means single individual database. The storage type is set to file system (FS). Because a listener is not specified in the DBCA command, DBCA automatically configures the default listener, LISTENER, for both DUPCDB1 and PDB1. After the DBCA command is finished running, verify that DUPCDB1 exists and contains PDB1, that PDB1 contains sample data, and that both DUPCDB1 and PDB1 use the default listener, LISTENER.

1. Run the -createDuplicateDB command.

  ```
  $ dbca -silent \
  -createDuplicateDB \
  -primaryDBConnectionString workshop-installed.livelabs.oraclevcn.com:1523/CDB1.livelabs.oraclevcn.com \
  -sysPassword Ora4U_1234 \
  -gdbName DUPCDB1.livelabs.oraclevnc.com \
  -sid DUPCDB1 \
  -datafileDestination /u01/app/oracle/oradata \
  -databaseConfigType SINGLE \
  -storageType FS

  RESULT:
  Prepare for db operation
  22% complete
  Listener config step
  44% complete
  Auxiliary instance creation
  67% complete
  RMAN duplicate
  89% complete
  Post duplicate database operations
  100% complete

  Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/DUPCDB1/DUPCDB1.log" for further details.
  ```

Now, we can change our environment and connect to `DUPCDB1`.
2. Set the environment variable to `DUPCDB1`.

  ```
  $ .oraenv
  DUPCDB1
  The Oracle base remains unchanged with value /u01/app/oracle
  ```

3. Connect as the SYS user to DUPCDB1.
```
sqlplus / as sysdba
```

4. List the PDBs in DUPCDB1. The results should indicate that PDB1 was duplicated too.
```
SQL> SHOW PDBS
```

5. View the list of data files. Make note of how the files are named. Also notice that the data files for PDB1 are included.

  ```
  SQL> COL name FORMAT A78

  SQL> SELECT name FROM v$datafile;

  NAME
  ------------------------------------------------------------------------------
  /u01/app/oracle/oradata/DUPCDB1/system01.dbf
  /u01/app/oracle/oradata/DUPCDB1/sysaux01.dbf
  /u01/app/oracle/oradata/DUPCDB1/undotbs01.dbf
  /u01/app/oracle/oradata/DUPCDB1/pdbseed/system01.dbf
  /u01/app/oracle/oradata/DUPCDB1/pdbseed/sysaux01.dbf
  /u01/app/oracle/oradata/DUPCDB1/users01.dbf
  /u01/app/oracle/oradata/DUPCDB1/pdbseed/undotbs01.dbf
  /u01/app/oracle/oradata/DUPCDB1/PDB1/system01.dbf
  /u01/app/oracle/oradata/DUPCDB1/PDB1/sysaux01.dbf
  /u01/app/oracle/oradata/DUPCDB1/PDB1/undotbs01.dbf
  /u01/app/oracle/oradata/DUPCDB1/PDB1/users01.dbf

  11 rows selected.
  ```
6. Connect to PDB1 as the HR user.
```
connect HR/Ora4U_1234@PDB1.
```
7. Verify that PDB1 has an HR.EMPLOYEES table with data in it.
```
$ SELECT count(*) FROM employees;
```
8. Exit SQL*Plus
```
EXIT
```
9. View the status of the default listener. Notice that both DUPCDB1 and PDB1 are listed as a service.

  ```
  $ lsnrctl status LISTENER

  LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 16-JUL-2021 19:02:28

  Copyright (c) 1991, 2021, Oracle. All rights reserved.

  Connecting to (ADDRESS=(PROTOCOL=TCP)(HOST=workshop-installed.livelabs.oraclevcn.com)(PORT=1521))
  STATUS of the LISTENER
  ------------------------
  Alias LISTENER
  Version TNSLSNR for Linux: Version 19.0.0.0.0 - Production
  Start Date 16-JUL-2021 14:28:54
  Uptime 0 days 4 hr. 33 min. 34 sec
  Trace Level off
  Security ON: Local OS Authentication
  SNMP OFF
  Listener Parameter File /u01/app/oracle/product/19c/dbhome_1/network/admin/listener.ora
  Listener Log File /u01/app/oracle/diag/tnslsnr/workshop-installed/listener/alert/log.xml
  Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=workshop-installed.livelabs.oraclevcn.com)(PORT=1521)))
  Services Summary...
  Service "CDB1XDB.livelabs.oraclevnc.com" has 1 instance(s).
  Instance "DUPCDB1", status READY, has 1 handler(s) for this service...
  Service "DUPCDB1" has 1 instance(s).
  Instance "DUPCDB1", status UNKNOWN, has 1 handler(s) for this service...
  Service "DUPCDB1.livelabs.oraclevnc.com" has 1 instance(s).
  Instance "DUPCDB1", status READY, has 1 handler(s) for this service...
  Service "c6a44dd9e86f6a1de0534d00000acc39.livelabs.oraclevnc.com" has 1 instance(s).
  Instance "DUPCDB1", status READY, has 1 handler(s) for this service...
  Service "pdb1.livelabs.oraclevnc.com" has 1 instance(s).
  Instance "DUPCDB1", status READY, has 1 handler(s) for this service...
  The command completed successfully
  ```


## Task 4: Use DBCA to duplicate CDB1 as OMFCDB1 and enable Oracle Managed Files
In this step, you use the `-createDuplicateDB` command in `DBCA` to duplicate `CDB1` as a single individual database called `OMFCDB1`. This time when running the `-createDuplicate` command, you enable Oracle Managed Files and create a dynamic listener called `LISTOMFCDB1` that listens on port 1525.


1. Launch `DBCA` in silent mode to duplicate `CDB1` as `OMFCDB1`.

  ```
  $ dbca -silent \
  -createDuplicateDB \
  -primaryDBConnectionString workshop-installed.livelabs.oraclevcn.com:1523/CDB1.livelabs.oraclevcn.com \
  -sysPassword Ora4U_1234 \
  -gdbName OMFCDB1.livelabs.oraclevnc.com \
  -sid OMFCDB1 \
  -datafileDestination /u01/app/oracle/oradata \
  -databaseConfigType SINGLE \
  -storageType FS \
  -createListener LISTENER_OMFCDB1:1565 \
  -useOMF true

  Prepare for db operation
  22% complete
  Listener config step
  44% complete
  Auxiliary instance creation
  67% complete
  RMAN duplicate
  89% complete
  Post duplicate database operations
  100% complete

  Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/OMFCDB1/OMFCDB1.log" for further details.

  ```


2. Using the file system or vi  editor, open ``$ORACLE_HOME/network/admin/tnsnames.ora`` file, and add the following listener to the bottom of the file. The tnsnames. ora file is a network configuration file that contains network service names mapped to connect descriptors for the local naming method, or net service names mapped to listener protocol addresses. In our case, this entry resolves the `LISTOMFCDB1` alias to the TCP protocol address `workshop-installed.livelabs.oraclevcn.com` on port `1565`.
```
LISTENER_OMFCDB1 =
(ADDRESS = (PROTOCOL = TCP)(HOST = workshop-installed.livelabs.oraclevcn.com)(PORT = 1565))
```
3. Using the file system or the cat command, open the ``$ORACLE_HOME/network/admin/listener.ora`` file and verify that DBCA added the listener information. There should be an entry for LISTENER_OMFCDB1. Dynamic service registration does not make use of the `listener.ora` file; however, you do need to configure the file if you want to manage listeners with the Listener Control utility.

  ```
  $ cat $ORACLE_HOME/network/admin/listener.ora

  ...

  LISTENER_OMFCDB1 =
     (ADDRESS_LIST =
        (ADDRESS = (PROTOCOL = TCP)(HOST = workshop-installed.livelabs.oraclevcn.com)(PORT = 1565))
  )

  ...
  ```

4. View the status of the listener.
```
$ lsnrctl status LISTENER_OMFCDB1
```

5. Set the environment variable to OMFCDB1.

  ```
  $ . oraenv
  OMFCDB1
  The Oracle base remains unchanged with value /u01/app/oracle
  ```
6. Connect as the SYS user to OMFCDB1.

  ```
  sqlplus / as sysdba

  SQL>
  ```
7. Verify that DBCA configured the `LOCAL_LISTENER` parameter to `LISTENER_OMFCDB1`. By default, DBCA uses the naming convention `LISTENER_<SID>` when configuring the `LOCAL_LISTENER` parameter value. That is why we used the name `LISTENER_OMFCDB1` when running the `-createDuplicateDB` command in DBCA. Had we used a different name, we would need to update the `LOCAL_LISTENER` parameter value.

  ```
  SQL> SHOW PARAMETER LOCAL_LISTENER

  NAME                                               TYPE          VALUE

  ------------------------------------ ----------- ------------------------------

  local_listener                                    string         LISTENER_OMFCDB1
  ```
8. Check if the `LOCAL_LISTENER` parameter is a static or dynamic parameter by querying the `V$PARAMETER` view. The results tell you that you can't change it's value at the session level, but you can at the system level, and the change will take effect immediately. This means that the `LOCAL_LISTENER` parameter is a dynamic system-level parameter.

  ```
  SQL> SELECT isses_modifiable, issys_modifiable FROM v$parameter
       WHERE name='local_listener';

  ISSES ISSYS_MOD

  ----- ---------

  FALSE IMMEDIATE

  SQL>
  ```

9. List the PDBs in OMFCDB1. Notice that PDB1 was duplicated too.
  ```
  SQL> SHOW PDBS

      CON_ID  CON_NAME                       OPEN MODE RESTRICTED

  ---------- ------------------------------ ---------- ----------

            2 PDB$SEED                      READ ONLY NO

            3 PDB1                          READ WRITE NO
  ```

10.  View the list of data files. Notice how the files are named when Oracle Managed Files is enabled on the CDB versus when it is not (as in DUPCDB1).

  ```
  SQL> COL name FORMAT A78

  SQL> SELECT name FROM v$datafile;

  NAME
  ------------------------------------------------------------------------------
  /u01/app/oracle/oradata/OMFCDB1/datafile/o1_mf_system_jh38hypr_.dbf
  /u01/app/oracle/oradata/OMFCDB1/datafile/o1_mf_sysaux_jh38jfsv_.dbf
  /u01/app/oracle/oradata/OMFCDB1/datafile/o1_mf_undotbs1_jh38jwvm_.dbf
  /u01/app/oracle/oradata/OMFCDB1/C6A4294A032D57BEE0534D00000AB5C1/datafile/o1_mf_system_jh38kcwc_.dbf

  /u01/app/oracle/oradata/OMFCDB1/C6A4294A032D57BEE0534D00000AB5C1/datafile/o1_mf_sysaux_jh38kly7_.dbf

  /u01/app/oracle/oradata/OMFCDB1/datafile/o1_mf_users_jh38kt16_.dbf
  /u01/app/oracle/oradata/OMFCDB1/C6A4294A032D57BEE0534D00000AB5C1/datafile/o1_mf_undotbs1_jh38kv31_.dbf

  /u01/app/oracle/oradata/OMFCDB1/C6A44DD9E86F6A1DE0534D00000ACC39/datafile/o1_mf_system_jh38ky58_.dbf

  /u01/app/oracle/oradata/OMFCDB1/C6A44DD9E86F6A1DE0534D00000ACC39/datafile/o1_mf_sysaux_jh38l57c_.dbf

  /u01/app/oracle/oradata/OMFCDB1/C6A44DD9E86F6A1DE0534D00000ACC39/datafile/o1_mf_undotbs1_jh38ld9z_.dbf

  /u01/app/oracle/oradata/OMFCDB1/C6A44DD9E86F6A1DE0534D00000ACC39/datafile/o1_mf_users_jh38lhc8_.dbf

  11 rows selected.

  SQL>
  ```
11. Exit SQL*Plus.

  ```
  EXIT
  ```

## Task 5: Restore your environment
To restore you environment, delete DUPCDB1 and OMFCDB1 and disable ARCHIVELOG mode on CDB1.
1. Use DBCA to delete DUPCDB1.

  ```
  $ $ORACLE_HOME/bin/dbca -silent -deleteDatabase -sourceDB DUPCDB1.livelabs.oraclevcn.com -sid DUPCDB1 -sysPassword Ora4U_1234

  [WARNING] [DBT-19202] The Database Configuration Assistant will delete the Oracle instances and datafiles for your database. All information in the database will be destroyed.
  Prepare for db operation
  32% complete
  Connecting to database
  35% complete
  39% complete
  42% complete
  45% complete
  48% complete
  52% complete
  65% complete
  Updating network configuration files
  68% complete
  Deleting instance and datafiles
  84% complete
  100% complete
  Database deletion completed.
  Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/DUPCDB1/DUPCDB10.log" for further details.
  ```
2. Use DBCA to delete OMFCDB1.

  ```
  $ $ORACLE_HOME/bin/dbca -silent -deleteDatabase -sourceDB OMFCDB1.livelabs.oraclevcn.com -sid OMFCDB1 -sysPassword Ora4U_1234

  [WARNING] [DBT-19202] The Database Configuration Assistant will delete the Oracle instances and datafiles for your database. All information in the database will be destroyed.

  Prepare for db operation

  32% complete

  Connecting to database

  35% complete

  39% complete

  42% complete

  45% complete

  48% complete

  52% complete

  65% complete

  Updating network configuration files

  68% complete

  Deleting instance and datafiles

  84% complete

  100% complete

  Database deletion completed.

  Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/OMFCDB1/OMFCDB10.log" for further details.

  ```

3.  Replace the modified `tnsnames.ora` and `listener.ora` files with the originals. You can find the originals in the `~/labs/19cnf` directory.

4. Set the environment variable to CDB1.
```
$ . oraenv
CDB1
```
5. Disable ARCHIVELOG mode on CDB1.
```
$HOME/labs/19cnf/disable_ARCHIVELOG.sh
```
6. Remove the /u01/app/oracle/recovery_area/DUPCDB1 directory.
```
$ rm -rfv /u01/app/oracle/recovery_area/DUPCDB1
```

7.  Remove the /u01/app/oracle/recovery_area/OMFCDB1 directory.
```
$ rm -rfv /u01/app/oracle/recovery_area/OMFCDB1
```
## Task 7: To disable ARCHIVELOG mode on CDB1:

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
- [dbca -createDuplicateDB command](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/creating-and-configuring-an-oracle-database.html#GUID-7F4B1A64-5B08-425A-A62E-854542B3FD4E)

- [Oracle Managed Files](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/using-oracle-managed-files.html#GUID-4A3C4616-0D81-4BBA-8EAD-FCAA8AD5C15A)



## Acknowledgements
* **Primary Author: Dominique Jeunot's, Consulting User Assistance Developer**
* **Last Updated By: Blake Hendricks, Solutions Engineer, 7/21/21**
