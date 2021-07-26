# Relocate a PDB to a Remote CDB by using DBCA in Silent Mode

## Introduction
Starting in Oracle Database 19c, you can use the Oracle Database Configuration Assistant (DBCA) tool to relocate a PDB that resides in a remote CDB (a different CDB than the one to which you are relocating). To do this, you use the new `-relocatePDB` command in DBCA. In this lab, you relocate PDB1 from CDB1 to CDB2.
>Before you can relocate a PDB from one CDB to another, you need to put your CDBs into ARCHIVELOG mode.

Estimated Lab Time: 30 minutes

### Objectives

Learn how to do the following:

- Enable `ARCHIVELOG` mode foro CDB1 and CDB2
- Verify that the listeners for CDB1 and CDB2 are started
- Verify that PDB1 has sample data before relocating
- Create a common user and grant it privileges
- Use DBCA to relocate a remote PDB from a CDB to another CDB
- Verify that PDB1 is relocated and that `HR.EMPLOYEES` still exists
- Relocate PDB1 back to CDB1

### Prerequisites

Before you start, be sure that you have done the following:

- Obtained an Oracle Cloud account
- Signed in to Oracle Cloud Infrastructure
- Created SSH keys in Cloud Shell
- Obtained and signed in to your workshop-installed compute instance. If not, see Lab 4- Obtain a Compute Image with Oracle Database 19c Installed

## **STEP 1**: Enable ARCHIVELOG mode on CDB1 and CDB2

1. Open a terminal window.  

2. Run the `enable_ARCHIVELOG.sh` script and enter CDB1 at the prompt to enable `ARCHIVELOG` mode on CDB1.
>The error  message at the beginning of the script is expected if the CDB is already shut down. You can ignore it.

    ```
    $ $HOME/labs/19cnf/enable_ARCHIVELOG.sh
    ORACLE_SID = [CDB1] ? CDB1
    ```

3. Run the `enable_ARCHIVELOG.sh` script and enter CDB2 at the prompt to enable `ARCHIVELOG` mode on CDB2.

    ```
    $ $HOME/labs/19cnf/enable_ARCHIVELOG.sh
    ORACLE_SID = [CDB1] ? CDB2
    ```

## **STEP 2**: Verify that the listeners for CDB1 and CDB2 are started
1. Enter listener control and check that the listeners are started for CDB1, PDB1 and CDB2.
Look for 'status READY' for each service in the Service Summary.
    ```
    $ lsnrctl

    LSNRCTL> status LISTCDB1
    ```
    ```
    Services Summary...
    Service "CDB1.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB1", status READY, has 1 handler(s) for this service...
    Service "CDB1XDB.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB1", status READY, has 1 handler(s) for this service...
    Service "c6a44dd9e86f6a1de0534d00000acc39.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB1", status READY, has 1 handler(s) for this service...
    Service "pdb1.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB1", status READY, has 1 handler(s) for this service...
    The command completed successfully
    ```
    Check the status of listener for CDB2.
    ```
    LSNCRTL> status LISTCDB2
    ```
    ```
    Services Summary...
    Service "CDB2.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB2", status READY, has 1 handler(s) for this service...
    Service "CDB2XDB.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB2", status READY, has 1 handler(s) for this service...
    The command completed successfully
    ```

2. Start the listeners, if your listeners are not ready. Skip this step if your listeners are already started.  
    ```
    LSNRCTL> start LISTCDB1

    LSNRCTL> start LISTCDB2
    ```

3. Exit the listener control.
    ```
    LSNRCTL> exit
    ```

## **STEP 3**: Verify that PDB1 has sample data before relocating
1. Ensure the environment variable is set to CDB1. Enter CDB1 at the prompt.
    ```
    $ . oraenv
    ORACLE_SID = [ORCL] ? CDB1
    ```

2. Connect to CDB1 using SQL*Plus.
    ```
    $ sqlplus / as sysdba
    ```

3. Open PDB1 and connect to it.
    ```
    SQL> alter pluggable database PDB1 open;

    Pluggable database altered.

    SQL> alter session set container = PDB1;

    Session altered.
    ```

4. Verify that PDB1 contains the `HR.EMPLOYEES` table. After relocating PDB1 to CDB2, it should still contain HR.EMPLOYEES as it originally did. We will check for this in later steps. This result should show 107.
    ```
    SQL> SELECT count(*) FROM HR.EMPLOYEES;

      COUNT(*)
    ----------
            107
    ```

## **STEP 4**: Create a common user and grant it privileges to relocate a database
1. Connect to CDB1 as the `SYS` user.
    ```
    SQL> CONNECT sys/Ora4U_1234@CDB1 as sysdba
    Connected.
    ```
A common user is a database user that has the same identity in the `root` container and in every existing and future pluggable database (PDB). Every common user can connect to and perform operations within the `root`, and within any PDB in which it has privileges. In this step, we create user called c##remote_user, which we will later specify in the `-relocatePDB` command as the database link user of the remote PDB.

2. Create a common user named c##remote_user in CDB1.
    ```
    SQL> CREATE USER c##remote_user IDENTIFIED BY Ora4U_1234 CONTAINER=ALL;
    User created.
    ```

3. Grant the user the necessary privileges for creating a new PDB.
    ```
    SQL> GRANT create session, create pluggable database, sysoper TO c##remote_user CONTAINER=ALL;
    Grant succeeded.
    ```

4. Quit session.
    ```
    SQL> exit
    ```

## **STEP 5**: Use DBCA to relocate a remote PDB from a CDB to another CDB
>In this section, you use DBCA in silent mode to relocate PDB1 from CDB1 to CDB2.<

1. Run the `-relocatePDB` command in DBCA in silent mode to relocate PDB1 from CDB1 to CDB2.
    ```
    $ dbca -silent \
    -relocatePDB \
    -remotePDBName PDB1 \
    -remoteDBConnString CDB1 \
    -sysDBAUserName SYSTEM \
    -sysDBAPassword Ora4U_1234 \
    -remoteDBSYSDBAUserName SYS \
    -remoteDBSYSDBAUserPassword Ora4U_1234 \
    -dbLinkUsername c##remote_user \
    -dbLinkUserPassword Ora4U_1234 \
    -sourceDB CDB2 \
    -pdbName PDB1

    Create pluggable database using relocate PDB operation
    100% complete
    Pluggable database "PDB1" plugged successfully.
    Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDB2/PDB1/CDB2.log" for further details.
    ```

2. Review the relocating log.
    ```
    $ cat /u01/app/oracle/cfgtoollogs/dbca/CDB2/PDB1/CDB2.log
    ```

## **STEP 6**: Verify that PDB1 is relocated and that HR.EMPLOYEES still exists
1. Set the environment variable to CDB2. Enter CDB2 at the prompt.
    ```
    $ . oraenv
    ORACLE_SID = [CDB1] ? CDB2
    ```

2. Connect to SQL*Plus.
    ```
    $ sqlplus / as sysdba
    ```

3. Display the list of PDBs in CDB2 to verify that PDB1 is relocated.
    ```
    SQL> show pdbs

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ------ ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO
    ```

4. Connect to PDB1 in CDB2.
    ```
    SQL> alter session set container = PDB1;

    Session altered.
    ```

5. Check that PDB1 still contains the `HR.EMPLOYEES` table. This command helps us verify that PDB1 and its data is relocated to CDB2. This result should also show 107.
    ```
    SQL> SELECT count(*) FROM hr.employees;

    COUNT(*)
    ----------
           107
    ```

6. Exit the session.
    ```
    SQL> exit
    ```

## **STEP 7**: Relocate PDB1 back to CDB1
1. Run the `-relocatePDB` command in DBCA in silent mode to relocate PDB1 from CDB2 back to CDB1. You should get an error about the database link user.
    ```
    $ dbca -silent \
    -relocatePDB \
    -remotePDBName PDB1 \
    -remoteDBConnString CDB2 \
    -sysDBAUserName SYS \
    -sysDBAPassword Ora4U_1234 \
    -remoteDBSYSDBAUserName SYSTEM \
    -remoteDBSYSDBAUserPassword Ora4U_1234 \
    -dbLinkUsername c##remote_user \
    -dbLinkUserPassword Ora4U_1234 \
    -sourceDB CDB1 \
    -pdbName PDB1

    [FATAL] [DBT-19404] Specified database link user (C##REMOTE_USER) does not exist in the database(CDB2).

    ACTION: Specify an existing database link user.
    ```

In preparation for the first relocation (PDB1 moving to CDB2), we created the database link user only on CDB1 because at that time, it was considered the remote CDB. But now, you are trying to move PDB1 back to CDB1, and CDB2 is considered the remote CDB. To fix the problem, you need to create the remote user in CDB2 too.

2. Verify that your environment variable is set to CDB2. Enter CDB2 at the prompt.
    ```
    $ . oraenv
    ORACLE_SID = [CDB1] ? CDB2
    ```

3. Connect to CDB2 as the `SYS` user.
    ```
    $ sqlplus sys/Ora4U_1234@CDB2 as sysdba
    ```

4. Create the database link user (C##REMOTE_USER) in CDB2.
    ```
    SQL> CREATE USER c##remote_user IDENTIFIED BY Ora4U_1234 CONTAINER=ALL;
    User created.
    ```

5. Grant C##REMOTE_USER the necessary privileges for creating a new PDB.
    ```
    SQL> GRANT create session, create pluggable database, sysoper TO c##remote_user CONTAINER=ALL;
    Grant succeeded.
    ```

6. Exit SQL*Plus.
    ```
    SQL> exit
    ```

7. Rerun the `-relocatePDB` command in DBCA in silent mode to relocate PDB1 from CDB2 back to CDB1. This time you shouldn't get any error messages.
    ```
    $ dbca -silent \
    -relocatePDB \
    -remotePDBName PDB1 \
    -remoteDBConnString CDB2 \
    -sysDBAUserName SYS \
    -sysDBAPassword Ora4U_1234 \
    -remoteDBSYSDBAUserName SYSTEM \
    -remoteDBSYSDBAUserPassword Ora4U_1234 \
    -dbLinkUsername c##remote_user \
    -dbLinkUserPassword Ora4U_1234 \
    -sourceDB CDB1 \
    -pdbName PDB1

    Create pluggable database using relocate PDB operation

    100% complete

    Pluggable database "PDB1" plugged successfully.

    Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDB1/PDB1/CDB1.log" for further details.
    ```

## **STEP 8**: Disable ARCHIVELOG mode for CDB1 and CDB2
1. Run the `disable_ARCHIVELOG.sh` script and enter CDB1 at the prompt to disable `ARCHIVELOG` mode on CDB1.

    ```
    $ $HOME/labs/19cnf/disable_ARCHIVELOG.sh
    ORACLE_SID = [CDB1] ? CDB1
    ```

2. Run the `disable_ARCHIVELOG.sh` script and enter CDB2 at the prompt to disable `ARCHIVELOG` mode on CDB2.

    ```
    $ $HOME/labs/19cnf/disable_ARCHIVELOG.sh
    ORACLE_SID = [CDB1] ? CDB2
    ```

## Learn More

- [New Features in Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)
- [`relocatePDB` command Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/creating-and-configuring-an-oracle-database.html#GUID-8DD80A8A-DDE1-471F-8CBB-013D85CFE28F)
- [Relocating a PDB](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/relocating-a-pdb.html#GUID-75519361-3DA2-4558-A7E5-64BC16FAFC7D)

## Acknowledgements

- **Author**- Dominique Jeunot, Consulting User Assistance Developer
- **Last Updated By/Date** - Kherington Barley, Austin Specialist Hub, July 2021
