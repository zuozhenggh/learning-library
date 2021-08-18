# Relocate a PDB to a Remote CDB by using DBCA in Silent Mode

## Introduction
Starting in Oracle Database 19c, you can use the Oracle Database Configuration Assistant (DBCA) tool to relocate a PDB that resides in a remote CDB (a different CDB than the one to which you are relocating). To do this, you use the new `-relocatePDB` command in DBCA. In this lab, you relocate PDB1 from CDB1 to CDB2.

>**Note:** Before you can relocate a PDB from one CDB to another, you need to put your CDBs into `ARCHIVELOG` mode.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:

- Enable `ARCHIVELOG` mode for CDB1 and CDB2
- Verify that the listeners for CDB1 and CDB2 are started
- Verify that PDB1 has sample data
- Create a common user and grant it privileges
- Use DBCA in silent mode to relocate PDB1 from CDB1 to CDB2
- Verify that PDB1 is relocated to CDB2 and that the `HR.EMPLOYEES` table still exists in PDB1
- Relocate PDB1 back to CDB1
- Reset your environment

### Prerequisites

This lab assumes you have:
- Obtained and signed in to your `workshop-installed` compute instance. If not, see the lab called **Obtain a Compute Image with Oracle Database 19c Installed**.

## Task 1: Enable `ARCHIVELOG` mode on CDB1 and CDB2

1. On your compute instance, open a terminal window.  

2. Run the `enable_ARCHIVELOG.sh` script and enter **CDB1** at the prompt to enable `ARCHIVELOG` mode on CDB1. The error  message at the beginning of the script is expected if the CDB is already shut down. You can ignore it.

    ```
    $ <copy>$HOME/labs/19cnf/enable_ARCHIVELOG.sh</copy>
    CDB1
    ```

3. Run the `enable_ARCHIVELOG.sh` script again, and this time, enter **CDB2** at the prompt to enable `ARCHIVELOG` mode on CDB2.

    ```
    $ <copy>$HOME/labs/19cnf/enable_ARCHIVELOG.sh</copy>
    CDB2
    ```

## Task 2: Verify that the listeners for CDB1 and CDB2 are started and ready

1. Start the Listener Control Utility.

    ```
    $ <copy>lsnrctl</copy>
    ```

2. Check that LISTENER_CDB1 is started. Look for `status READY` for CDB1 and PDB1 in the Service Summary.

    ```
    LSNRCTL> <copy>status LISTENER_CDB1</copy>

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

3. Check that LISTENER_CDB2 is started. Look for `status READY` for CDB2.

    ```
    LSNRCTL> <copy>status LISTENER_CDB2</copy>

    Services Summary...
    Service "CDB2.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB2", status READY, has 1 handler(s) for this service...
    Service "CDB2XDB.livelabs.oraclevcn.com" has 1 instance(s).
    Instance "CDB2", status READY, has 1 handler(s) for this service...
    The command completed successfully
    ```

4. If the listeners are not started, you can start them by entering the following commands.

    ```
    LSNRCTL> <copy>start LISTENER_CDB1</copy>
    LSNRCTL> <copy>start LISTENER_CDB2</copy>
    ```

5. Exit the Listener Control Utility.

    ```
    LSNRCTL> <copy>exit</copy>
    ```


## Task 3: Verify that PDB1 has sample data

1. Ensure the environment variable is set to CDB1. Enter CDB1 at the prompt.

    ```
    $ <copy>. oraenv</copy>
    CDB1
    ```

2. Connect to CDB1 using SQL*Plus.

    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

3. Open PDB1.

    ```
    SQL> <copy>alter pluggable database PDB1 open;</copy>
    Pluggable database altered.
    ```

4. Connect to PDB1.

    ```
    SQL> <copy>alter session set container = PDB1;</copy>
    Session altered.
    ```

5. Query the `HR.EMPLOYEES` table. The results show that the table exists and has 107 rows.

    After relocating PDB1 to CDB2, it should still contain `HR.EMPLOYEES` as it originally did. We will check for this in a later step.

    ```
    SQL> <copy>SELECT count(*) FROM HR.EMPLOYEES;</copy>

      COUNT(*)
    ----------
            107
    ```

## Task 4: Create a common user and grant it privileges

A common user is a database user that has the same identity in the `root` container and in every existing and future pluggable database (PDB). Every common user can connect to and perform operations within the `root` and within any PDB in which it has privileges. In this task, we create a user called `c##remote_user`, which we will later specify in the `-relocatePDB` command as the database link user of the remote PDB.

1. Connect to CDB1 as the `SYS` user.

    ```
    SQL> <copy>CONNECT sys/Ora4U_1234@CDB1 as sysdba</copy>
    Connected.
    ```

2. Create a common user named `c##remote_user` in CDB1.

    ```
    SQL> <copy>CREATE USER c##remote_user IDENTIFIED BY Ora4U_1234 CONTAINER=ALL;</copy>
    User created.
    ```

3. Grant the user the necessary privileges to create PDBs.

    ```
    SQL> <copy>GRANT create session, create pluggable database, sysoper TO c##remote_user CONTAINER=ALL;</copy>
    Grant succeeded.
    ```

4. Exit SQL*Plus.

    ```
    SQL> <copy>exit</copy>
    ```

## Task 5: Use DBCA in silent mode to relocate PDB1 from CDB1 to CDB2

1. Run the `-relocatePDB` command in DBCA in silent mode to relocate PDB1 from CDB1 to CDB2.

    ```
    $ <copy>dbca -silent \
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
    -pdbName PDB1</copy>

    Create pluggable database using relocate PDB operation
    100% complete
    Pluggable database "PDB1" plugged successfully.
    Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDB2/PDB1/CDB2.log" for further details.
    ```

2. Review the relocating log.

    ```
    $ <copy>cat /u01/app/oracle/cfgtoollogs/dbca/CDB2/PDB1/CDB2.log</copy>
    ```

## Task 6: Verify that PDB1 is relocated to CDB2 and that the `HR.EMPLOYEES` table still exists in PDB1

1. Set the environment variable to CDB2. Enter **CDB2** at the prompt.

    ```
    $ <copy>. oraenv</copy>
    CDB2
    ```

2. Connect to CDB2 as the `SYS` user.

    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

3. Display the list of PDBs in CDB2 to verify that PDB1 exists.

    ```
    SQL> <copy>show pdbs</copy>

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ------ ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO
    ```

4. Connect to PDB1 in CDB2.

    ```
    SQL> <copy>alter session set container = PDB1;</copy>
    Session altered.
    ```

5. Check that PDB1 still contains the `HR.EMPLOYEES` table with 107 rows. This command helps us verify that PDB1 is relocated with its data to CDB2.

    ```
    SQL> <copy>SELECT count(*) FROM hr.employees;</copy>

    COUNT(*)
    ----------
           107
    ```

6. Exit SQL*Plus.

    ```
    SQL> exit
    ```

## Task 7: Relocate PDB1 back to CDB1

1. Try to run the `-relocatePDB` command in DBCA in silent mode to relocate PDB1 from CDB2 back to CDB1. You should get an error about the database link user.

    ```
    $ <copy>dbca -silent \
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
    -pdbName PDB1</copy>

    [FATAL] [DBT-19404] Specified database link user (C##REMOTE_USER) does not exist in the database(CDB2).

    ACTION: Specify an existing database link user.
    ```

2. Question: Why did you get an error when trying to relocate PDB1 back to CDB1?

    Answer: In preparation for the first relocation (PDB1 moving to CDB2), we created the database link user only on CDB1 because at that time, it was considered the remote CDB. But now, you are trying to move PDB1 back to CDB1, and CDB2 is considered the remote CDB. To fix the problem, you need to create the remote user in CDB2 too.

3. Set the environment variable to CDB2. Enter **CDB2** at the prompt.

    ```
    $ <copy>. oraenv</copy>
    CDB2
    ```

4. Connect to CDB2 as the `SYS` user.

    ```
    $ <copy>sqlplus sys/Ora4U_1234@CDB2 as sysdba</copy>
    ```

5. Create a common user named `c##remote_user` in CDB2.

    ```
    SQL> <copy>CREATE USER c##remote_user IDENTIFIED BY Ora4U_1234 CONTAINER=ALL;</copy>
    User created.
    ```

6. Grant `c##remote_user` the necessary privileges for creating a new PDB.

    ```
    SQL> <copy>GRANT create session, create pluggable database, sysoper TO c##remote_user CONTAINER=ALL;</copy>
    Grant succeeded.
    ```

7. Exit SQL*Plus.

    ```
    SQL> <copy>exit</copy>
    ```

8. Rerun the `-relocatePDB` command in DBCA in silent mode to relocate PDB1 from CDB2 back to CDB1. This time you shouldn't get any error messages.

    ```
    $ <copy>dbca -silent \
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
    -pdbName PDB1</copy>

    Create pluggable database using relocate PDB operation
    100% complete
    Pluggable database "PDB1" plugged successfully.
    Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDB1/PDB1/CDB1.log" for further details.
    ```

9. Set the environment variable to CDB1. Enter **CDB1** at the prompt.

    ```
    $ <copy>. oraenv</copy>
    CDB1
    ```

10. Connect to CDB1 as the `SYS` user.

    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

11. Display the list of PDBs in CDB1 to verify that PDB1 exists.

    ```
    SQL> <copy>show pdbs</copy>

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ------ ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 PDB1                           READ WRITE NO
    ```

12. Exit SQL*Plus.

    ```
    SQL> <copy>exit</copy>
    ```

## Task 8: Reset your environment

1. Run the `disable_ARCHIVELOG.sh` script and enter **CDB1** at the prompt to disable `ARCHIVELOG` mode on CDB1.

    ```
    $ <copy>$HOME/labs/19cnf/disable_ARCHIVELOG.sh</copy>
    CDB1
    ```

2. Run the `disable_ARCHIVELOG.sh` script again, and this time, enter **CDB2** at the prompt to disable `ARCHIVELOG` mode on CDB2.

    ```
    $ <copy>$HOME/labs/19cnf/disable_ARCHIVELOG.sh</copy>
  CDB2
    ```

4. Set the environment variable to CDB1. At the prompt, enter **CDB1**.

    ```
    $ <copy>. oraenv</copy>
    CDB1
    ```

5. Connect to CDB1 as the `SYS` user.

    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

6. Drop the common user named `c##remote_user` that you created earlier.

    ```
    SQL> <copy>DROP USER c##remote_user CASCADE;</copy>
    User dropped.
    ```

7. Exit SQL*Plus.

    ```
    SQL> <copy>exit</copy>
    ```

8. Set the environment variable to CDB2. At the prompt, enter **CDB2**.

    ```
    $ <copy>. oraenv</copy>
    CDB2
    ```

9. Connect to CDB2 as the `SYS` user.

    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

10. Drop the common user named `c##remote_user` that you created earlier.

    ```
    SQL> <copy>DROP USER c##remote_user CASCADE;</copy>
    User dropped.
    ```

11. Exit SQL*Plus.

    ```
    SQL> <copy>exit</copy>
    ```

## Learn More

- [New Features in Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)
- [DBCA Silent Mode Commands](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/creating-and-configuring-an-oracle-database.html#GUID-EC3C396B-6FFB-4957-BC73-1BE8F4FD852E)
- [Relocating a PDB](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/relocating-a-pdb.html#GUID-75519361-3DA2-4558-A7E5-64BC16FAFC7D)

## Acknowledgements

- **Author**- Dominique Jeunot, Consulting User Assistance Developer
- **Technical Contributor** - Jody Glover, Consulting User Assistance Developer
- **Last Updated By/Date** - Kherington Barley, Austin Specialist Hub, August 13 2021
