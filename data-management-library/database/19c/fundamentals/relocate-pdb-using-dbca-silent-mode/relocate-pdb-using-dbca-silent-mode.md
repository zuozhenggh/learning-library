# Relocate a PDB to a Remote CDB by using DBCA in Silent Mode

## Introduction
Starting in Oracle Database 19c, you can use the Oracle Database Configuration Assistant (DBCA) tool to relocate a PDB that resides in a remote CDB (a different CDB than the one in which you are relocating to). To do this, you use the new -relocatePDB command in DBCA. In this lab, you relocate PDB1 from CDB1 to CDB2.

Estimated Lab Time: 30 minutes

### Objectives

Learn how to do the following:

- Enable ARCHIVELOG mode on CDB1 and CDB2
- Prepare the listeners for CDB1 and CDB2 and verify that they are ready
- Prepare the PDB before relocation
- Create a user and grant privileges to relocate a database
- Relocate a remote PDB from a CDB to another CDB
- Check that the PDB1 is relocated and verify that hr.employees still exists
- Reset your environment
- Disable ARCHIVELOG mode for CDB1 and CDB2

### Prerequisites

Before you start, be sure that you have done the following:

- Obtained an Oracle Cloud account
- Signed in to Oracle Cloud Infrastructure
- Created SSH keys in Cloud Shell


## **STEP 1**: Enable ARCHIVELOG mode on CDB1 and CDB2

1. Open a terminal window.  
>The error  message at the beginning of the script is expected if the CDB is already shut down. You can ignore it.

2. Run the enable_ARCHIVELOG.sh script and enter CDB1 at the prompt to enable ARCHIVELOG mode on CDB1.
>The error  message at the beginning of the script is expected if the CDB is already shut down. You can ignore it.

    ```
    $ $HOME/labs/19cnf/enable_ARCHIVELOG.sh
    ORACLE_SID = [CDB1] ? CDB1
    ```

3. Run the enable_ARCHIVELOG.sh script and enter CDB2 at the prompt to enable ARCHIVELOG mode on CDB2.
    ```
    $ $HOME/labs/19cnf/enable_ARCHIVELOG.sh
    ORACLE_SID = [CDB1] ? CDB2
    ```

## **STEP 2**: Prepare the listeners for CDB1 and CDB2 and verify that they are ready
1. Enter listener control and start the listeners.
    ```
    lsnrctl

    LSNRCTL> start LISTCDB1

    LSNRCTL> start LISTCDB2
    ```

2. Check the status of the listeners to ensure that they are ready for CDB1, PDB1 and CDB2.
    ```
    LSNRCTL> status LISTCDB1

    LSNRCTL> status LISTCDB2
    ```

3. Exit the listener control.
    ```
    LSNRCTL> exit
    ```

## **STEP 3**: Prepare the PDB before relocation
1. Ensure the environment variable is set to CDB1. Enter CDB1 at the prompt.
    ```
    $ . oraenv
    ORACLE_SID = [ORCL] ? CDB1
    ```

2. Connect to the CDB1 using SQL*Plus.
    ```
    $ sqlplus /as sysdba
    ```

3. Open PDB1 to enter its environment and change the session environment from CDB1 to PDB1.
    ```
    SQL> alter pluggable database PDB1 open;

    Pluggable database altered.

    SQL> alter session set container = PDB1;

    Session altered.
    ```

4. Verify that PDB1 contains the HR.EMPLOYEES table. After relocating PDB1 to CDB2, it should still contain HR.EMPLOYEES as it originally did. We will check for this in later steps.
    ```
    SQL> SELECT count(*) FROM hr.employees;

      COUNT(*)
    ----------
            107
    ```

## **STEP 4**: Create a user and grant privileges to relocate a database
1. Connect to CDB1 as SYS.
    ```
    SQL> CONNECT sys@CDB1 as sysdba
    Enter password: Ora4U_1234
    ```

2. Create a common user in CDB.
    ```
    SQL> CREATE USER c##remote_user IDENTIFIED BY Ora4U_1234 CONTAINER=ALL;
    ```

3. Grant the user the necessary privileges for creating a new PDB.
    ```
    SQL> GRANT create session, create pluggable database, sysoper TO c##remote_user CONTAINER=ALL;
    ```

4. Quit session.
    ```
    SQL> exit
    ```

## **STEP 5**: Use DBCA to relocate a remote PDB from a CDB to another CDB
>In this section, you use DBCA in silent mode to relocate PDB1 from CDB1 as PDB1 in CDB2.<

1. Launch DBCA in silent mode to relocate PDB1 from CDB1 as PDB1 in CDB2.
    ```
    $ dbca -silent
        -relocatePDB   
          -remotePDBName PDB1
          -remoteDBConnString CDB1
          -sysDBAUserName SYSTEM
          -sysDBAPassword Ora4U_1234
          -remoteDBSYSDBAUserName SYS
          -remoteDBSYSDBAUserPassword Ora4U_1234
          -dbLinkUsername c##remote_user
          -dbLinkUserPassword Ora4U_1234
          -sourceDB CDB2
          -pdbName PDB1
    ```

2. Review the cloning log.
    ```
    $ cat /u01/app/oracle/cfgtoollogs/dbca/CDB2/PDB1/CDB2.log
    ```

## **STEP 6**: Check that the PDB1 is relocated and verify that hr.employees still exists
1. Set the environment variable to CDB2 and connect to SQL*Plus. Enter CDB2 at the prompt.
    ```
    $ . oraenv
    ORACLE_SID = [CDB1] ? CDB2

    $ sqlplus / as sysdba
    ```

2. Display the list of PDBs in CDB2 to verify that PDB1 has been relocated.
    ```
    SQL> show pdbs

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ------ ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO
    ```

3. Change the session environment to PDB1.
    ```
    SQL> alter session set container = PDB1;

    Session altered.
    ```

4. Check that PDB2 contains the HR.EMPLOYEES table as in PDB1. This command helps us verify that PDB1 and its contents were relocated to CDB2.
    ```
    SQL> SELECT count(*) FROM hr.employees;

    COUNT(*)
    ----------
           107
    ```

5. Exit the session.
    ```
    SQL> exit
    ```

## **STEP 7**: Reset your environment
1. Delete PDB1.
    ```
    $ $home/oracle/labs/19cnf/cleanup_PDBs.sh
    ```

2. Reset CDB1 back to it's original state.
    ```
    $ $home/oracle/labs/19cnf/recreate_CDB1.sh
    ```

## **STEP 8**: Disable ARCHIVELOG mode for CDB1 and CDB2
1. Run the disable_ARCHIVELOG.sh script and enter CDB1 at the prompt to disable ARCHIVELOG mode on CDB1.
>The error  message at the beginning of the script is expected if the CDB is already shut down. You can ignore it.

    ```
    $ $HOME/labs/19cnf/disable_ARCHIVELOG.sh
    ORACLE_SID = [CDB1] ? CDB1
    ```

2. Run the diable_ARCHIVELOG.sh script and enter CDB2 at the prompt to disable ARCHIVELOG mode on CDB2.
    ```
    $ $HOME/labs/19cnf/disable_ARCHIVELOG.sh
    ORACLE_SID = [CDB1] ? CDB2
    ```

## Learn More

- [New Features in Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)
- [relocatePDB command Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/creating-and-configuring-an-oracle-database.html#GUID-8DD80A8A-DDE1-471F-8CBB-013D85CFE28F)
- [Relocating a PDB](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/relocating-a-pdb.html#GUID-75519361-3DA2-4558-A7E5-64BC16FAFC7D)

## Acknowledgements

- **Author**- Dominique Jeunot
- **Last Updated By/Date** - Kherington Barley, Austin Specialist Hub, June 2021
