# Clone a PDB from a Remote CDB by Using DBCA in Silent Mode

## Introduction
Starting in Oracle Database 19c, you can use the Oracle Database Configuration Assistant (DBCA) tool to create a clone of a PDB that resides in a remote CDB (a different CDB than the one in which you are creating the clone). To do this, you use the `-createPluggableDatabase` command in DBCA with the new parameter called `-createFromRemotePDB`. In this lab, you clone PDB1 from CDB1 as PDB2 in CDB2.
>Before you can clone a PDB to another CDB, you need to put your CDBs into ARCHIVELOG mode.

Estimated Lab Time: 30 minutes

### Objectives

Learn how to do the following:

- Enable `ARCHIVELOG` mode for CDB1 and CDB2
- Verify that the listeners for CDB1 and CDB2 are started
- Verify that PDB1 has sample data before cloning
- Create a common user and grant it privileges
- Use DBCA to clone a remote PDB from a CDB
- Verify that PDB1 is cloned and that `HR.EMPLOYEES` exists in PDB2
- Reset your environment

### Prerequisites

Before you start, be sure that you have done the following:

- Obtained an Oracle Cloud account
- Signed in to Oracle Cloud Infrastructure
- Created SSH keys in Cloud Shell
- Obtained and signed in to your workshop-installed compute instance. If not, see Lab 4- Obtain a Compute Image with Oracle Database 19c Installed

## **TASK 1**: Enable ARCHIVELOG mode on CDB1 and CDB2

1. Open a terminal window.  

2. Run the `enable_ARCHIVELOG.sh` script and enter CDB1 at the prompt to enable `ARCHIVELOG` mode on CDB1.
The error  message at the beginning of the script is expected if the CDB is already shut down. You can ignore it.

    ```
    $ <copy>$HOME/labs/19cnf/enable_ARCHIVELOG.sh</copy>
    ORACLE_SID = [CDB1] ? CDB1
    ```

3. Run the `enable_ARCHIVELOG.sh` script and enter CDB2 at the prompt to enable `ARCHIVELOG` mode on CDB2.

    ```
    $ <copy>$HOME/labs/19cnf/enable_ARCHIVELOG.sh</copy>
    ORACLE_SID = [CDB1] ? CDB2
    ```

## **TASK 2**: Verify that the listeners for CDB1 and CDB2 are started
1. Enter listener control and check that the listeners are started for CDB1, PDB1 and CDB2.
Look for 'status READY' for each service in the Service Summary.
    ```
    $ <copy>lsnrctl</copy>

    LSNRCTL> <copy>status LISTCDB1</copy>
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
    LSNCRTL> <copy>status LISTCDB2</copy>
    ```
    ```
    Services Summary...
    Service "CDB2.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB2", status READY, has 1 handler(s) for this service...
    Service "CDB2XDB.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB2", status READY, has 1 handler(s) for this service...
    The command completed successfully
    ```

2. Start the listeners, if your listeners are not ready. Skip this task if your listeners are already started.

    ```
    LSNRCTL> <copy>start LISTCDB1</copy>

    LSNRCTL> <copy>start LISTCDB2</copy>
    ```

3. Exit the listener control.

    ```
    LSNRCTL> exit
    ```

## **TASK 3**: Verify that PDB1 has sample data before cloning
1. Ensure the environment variable is set to CDB1. Enter CDB1 at the prompt.

    ```
    $ <copy>. oraenv</copy>
    ORACLE_SID = [ORCL] ? CDB1
    ```

2. Connect to the CDB1 using SQL*Plus.

    ```
    $ <copy>sqlplus /as sysdba</copy>
    ```

3. Open PDB1 to connect to it.

    ```
    SQL> <copy>alter pluggable database PDB1 open;</copy>

    Pluggable database altered.

    SQL> <copy>alter session set container = PDB1;</copy>

    Session altered.
    ```

4. Verify that PDB1 contains the `HR.EMPLOYEES` table. After cloning PDB1 on CDB2, the new PDB should contain `HR.EMPLOYEES` as PDB1 did. We will check for this in later tasks. This result should show 107.

    ```
    SQL> <copy>SELECT count(*) FROM HR.EMPLOYEES;</copy>

      COUNT(*)
    ----------
          107
    ```
## **TASK 4**: Create a common user and grant it privileges to clone a database
1. Connect to CDB1 as `SYS`.

    ```
    SQL> <copy>CONNECT sys/Ora4U_1234@CDB1 as sysdba</copy>
    Connected.
    ```
A common user is a database user that has the same identity in the `root` container and in every existing and future pluggable database (PDB). Every common user can connect to and perform operations within the `root`, and within any PDB in which it has privileges. In this task, we create user called c##remote_user, which we will later specify in the `-createPluggableDatabase` command as the database link user of the remote PDB.

2. Create a common user named c##remote_user in CDB1.

    ```
    SQL> <copy>CREATE USER c##remote_user IDENTIFIED BY Ora4U_1234 CONTAINER=ALL;</copy>
    User created.
    ```

3. Grant the user the necessary privileges for creating a new PDB.

    ```
    SQL> <copy>GRANT create session, create pluggable database TO c##remote_user CONTAINER=ALL;</copy>
    Grant succeeded.
    ```

4. Quit SQL session.

    ```
    SQL> exit
    ```

## **TASK 5**: Use DBCA to clone a remote PDB from a CDB
>In this section, you use DBCA in silent mode to clone PDB1 on CDB2 as PDB2.<

1. Run the `-createPluggableDatabase` command in DBCA in silent mode to clone PDB1 on CDB2 as PDB2.

    ```
    $ <copy>dbca -silent \
    -createPluggableDatabase \
    -pdbName PDB2 \
    -sourceDB CDB2 \
    -createFromRemotePDB \
    -remotePDBName PDB1 \
    -remoteDBConnString CDB1 \
    -remoteDBSYSDBAUserName SYS \
    -remoteDBSYSDBAUserPassword Ora4U_1234 \
    -dbLinkUsername c##remote_user \
    -dbLinkUserPassword Ora4U_1234</copy>

    Create pluggable database using remote clone operation
    100% complete
    Pluggable database "PDB2" plugged successfully.
    Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDB2/PDB2/CDB2.log" for further details.
    ```

2. Review the cloning log.

    ```
    $ <copy>cat /u01/app/oracle/cfgtoollogs/dbca/CDB2/PDB2/CDB2.log</copy>
    ```

## **TASK 6**: Verify that PDB1 is cloned and that HR.EMPLOYEES exists in PDB2.
1. Set the environment variable to CDB2. Enter CDB2 at the prompt.

    ```
    $ <copy>. oraenv</copy>
    ORACLE_SID = [CDB1] ? CDB2
    ```

2. Connect to SQL*Plus.

    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

2. Display the list of PDBs in CDB2 to verify that PDB2 exists.

    ```
    SQL> <copy>show pdbs</copy>

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ------ ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB2                           READ WRITE NO
    ```

3. Change the session environment from CDB2 to PDB2.

    ```
    SQL> <copy>alter session set container = PDB2;</copy>

    Session altered.
    ```

4. Check that PDB2 contains the `HR.EMPLOYEES` table. This command helps us verify that PDB2 is a clone of PDB1 and its contents. This result should also show 107.

    ```
    SQL> <copy>SELECT count(*) FROM HR.EMPLOYEES;</copy>

    COUNT(*)
    ----------
           107
    ```

5. Exit the session.

    ```
    SQL> exit
    ```

## **TASK 7**: Reset your environment
1. Delete PDB2.

    ```
    $ <copy>$ORACLE_HOME/bin/dbca -silent -deletePluggableDatabase -sourceDB CDB2 -pdbName PDB2</copy>
    ```

## **TASK 8**: Disable ARCHIVELOG mode for CDB1 and CDB2.
1. Run the `disable_ARCHIVELOG.sh` script and enter CDB1 at the prompt to disable `ARCHIVELOG` mode on CDB1.

    ```
    $ <copy>$HOME/labs/19cnf/disable_ARCHIVELOG.sh</copy>
    ORACLE_SID = [CDB1] ? CDB1
    ```

2. Run the `disable_ARCHIVELOG.sh` script and enter CDB2 at the prompt to disable `ARCHIVELOG` mode on CDB2.

    ```
    $ <copy>$HOME/labs/19cnf/disable_ARCHIVELOG.sh</copy>
    ORACLE_SID = [CDB1] ? CDB2
    ```

## Learn More

- [New Features in Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)
- [`createPluggableDatabase` command Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/creating-and-configuring-an-oracle-database.html#GUID-6EDDC43D-9BD6-4096-8192-7E548B826360)
- [Cloning a PDB or non-CDB](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/cloning-a-pdb.html#GUID-05702CEB-A43C-452C-8081-4CA68DDA8007)

## Acknowledgements

- **Author**- Dominique Jeunot, Consulting User Assistance Developer
- **Last Updated By/Date** - Kherington Barley, Austin Specialist Hub, July 2021
