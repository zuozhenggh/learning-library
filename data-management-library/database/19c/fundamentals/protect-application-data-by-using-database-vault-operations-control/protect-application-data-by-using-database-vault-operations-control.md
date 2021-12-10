# Protect Application Data by using Database Vault Operations Control

## Introduction
In Oracle Database 19c, Oracle Database Vault provides command rules and realms to protect sensitive data from users with system privileges and object privileges (mandatory realms). A command rule controls whether a particular SQL command can be executed for a given circumstance. A realm can prevent a user from accessing protected objects if the user is not authorized in the realm. This protection requires the creation and configuration of command rules or realms.

Starting in Oracle Database 19c, Oracle Database Vault provides an extra layer of protection on the database objects. Database Vault Operations Control creates a wall between common users in databases and the customer database data that resides in the associated PDBs. Database Vault Operations Control prevents common users from accessing application local data that resides in PDBs. The capability allows you to store sensitive data for your business applications and manage the database without having to access the sensitive data in PDBs.

In this lab, you will learn how to use Database Vault Operations Control to automatically restrict common users from accessing PDB local data in autonomous, regular Cloud, or on-premise environments.

Estimated Time: 25 minutes

### Objectives

In this lab, you will:

- Prepare the environment
- Create a table in the PDB
- Configure & enable Database Vault in the CDB root
- Enable Database Vault Operations
- Test Database Vault Operations Control
- Complete administrative tasks in PDBs
- Add users in an exception list
- Clean up environment

### Prerequisites

This lab assumes you have:
- Obtained and signed in to your `workshop-installed` compute instance

## Task 1: Prepare the environment

To prepare your environment, enable `ARCHIVELOG` mode on CDB1 and CDB2, verify that the default listener is started, and verify that PDB1 has sample data. CDB1, PDB1, and CDB2 all use the default listener.

1. Open a terminal window on the desktop and set the Oracle environment variables. At the prompt, enter **CDB1**.

    ```
    $ <copy>. oraenv</copy>
    CDB1
    ```

2. Use the Listener Control Utility to verify whether the default listener (LISTENER) is started. Look for `status READY` for CDB1, PDB1, and CDB2 in the Services Summary.

    ```
    LSNRCTL> <copy>lsnrctl status</copy>

    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 19-AUG-2021 19:34:04

    Copyright (c) 1991, 2021, Oracle.  All rights reserved.

    Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=workshop-installed.livelabs.oraclevcn.com)(PORT=1521)))
    STATUS of the LISTENER
    ------------------------
    Alias                     LISTENER
    Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
    Start Date                19-AUG-2021 18:58:56
    Uptime                    0 days 0 hr. 35 min. 8 sec
    Trace Level               off
    Security                  ON: Local OS Authentication
    SNMP                      OFF
    Listener Parameter File   /u01/app/oracle/product/19c/dbhome_1/network/admin/listener.ora
    Listener Log File         /u01/app/oracle/diag/tnslsnr/workshop-installed/listener/alert/log.xml
    Listening Endpoints Summary...
      (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=workshop-installed.livelabs.oraclevcn.com)(PORT=1521)))
      (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
      (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=workshop-installed.livelabs.oraclevcn.com)(PORT=5504))(Security=(my_wallet_directory=/u01/app/oracle/product/19c/dbhome_1/admin/CDB1/xdb_wallet))(Presentation=HTTP)(Session=RAW))
      (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=workshop-installed.livelabs.oraclevcn.com)(PORT=5500))(Security=(my_wallet_directory=/u01/app/oracle/product/19c/dbhome_1/admin/CDB1/xdb_wallet))(Presentation=HTTP)(Session=RAW))
      (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=workshop-installed.livelabs.oraclevcn.com)(PORT=5501))(Security=(my_wallet_directory=/u01/app/oracle/product/19c/dbhome_1/admin/CDB2/xdb_wallet))(Presentation=HTTP)(Session=RAW))
    Services Summary...
    Service "CDB1.livelabs.oraclevcn.com" has 1 instance(s).
      Instance "CDB1", status READY, has 1 handler(s) for this service...
    Service "CDB1XDB.livelabs.oraclevcn.com" has 1 instance(s).
      Instance "CDB1", status READY, has 1 handler(s) for this service...
    Service "CDB2.livelabs.oraclevcn.com" has 1 instance(s).
      Instance "CDB2", status READY, has 1 handler(s) for this service...
    Service "CDB2XDB.livelabs.oraclevcn.com" has 1 instance(s).
      Instance "CDB2", status READY, has 1 handler(s) for this service...
    Service "c9d86333ac737d59e0536800000ad4f1.livelabs.oraclevcn.com" has 1 instance(s).
      Instance "CDB1", status READY, has 1 handler(s) for this service...
    Service "pdb1.livelabs.oraclevcn.com" has 1 instance(s).
      Instance "CDB1", status READY, has 1 handler(s) for this service...
    The command completed successfully
    ```

3. If the default listener is not started, start it now.

    ```
    $ <copy>lsnrctl start</copy>
    ```

4. Connect to CDB1 as the `SYS` user.

    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

6. Open PDB1. If PDB1 is already open, the results will say so; otherwise, PDB1 is opened.

    ```
    SQL> <copy>alter pluggable database PDB1 open;</copy>

    Pluggable database altered.
    ```

7. Connect to PDB1.

    ```
    SQL> <copy>alter session set container = PDB1;</copy>

    Session altered.
    ```

## Task 2: Create a table in the PDB

1. Check that the user `SYS` is available in PDB1.

    ```
    SQL> <copy>show con_name</copy>

    CON_NAME
    ------------------------------
    PDB1  
    ```

2. Query the `HR.EMPLOYEES` table. The results show that the table exists and has 107 rows.

    ```
    SQL> <copy>SELECT count(*) FROM HR.EMPLOYEES;</copy>

      COUNT(*)
    ----------
          107
    ```

3. Verify that neither Oracle Database Vault nor Database Vault Operations Control is configured in PDB1.

    ```
    SQL> <copy>SELECT * FROM dba_dv_status;</copy>

    NAME                           STATUS
    ------------------------------ --------------
    DV_APP_PROTECTION              NOT CONFIGURED
    DV_CONFIGURE_STATUS            FALSE
    DV_ENABLE_STATUS               FALSE
    ```
DV_APP_PROTECTION status of NOT CONFIGURED means that Operations Control is not configured.

## Task 3: Configure and enable Database Vault in the CDB root

In this task, you will configure Database Vault at the CDB root level, ensuring that the `DV_OWNER` role is granted locally in the CDB root to the common Oracle Database Vault owner, `C##SEC_ADMIN`. Granting `DV_OWNER` locally prevents the CDB common user with `DV_OWNER` from changing containers or logging into PDBs with this role and changing customer DV controls.

1. Log in to the CDB root as `SYS`

    ```
    <SQL> <copy>connect sys/Ora4U_1234 as sysdba</copy>
    ```

2. Execute the `drop_create_user_sec_admin.sql` script that creates the Database Vault `C##SEC_ADMIN` owner and the Database Vault `C##ACCTS_ADMIN` account manager in the CDB root. Update the passwords in the SQL script, if necessary.

    ```
    <SQL> <copy>@drop_create_user_sec_admin.sql</copy>
    ```

3. Reconnect to CDB root after previous script forces exit from SQL*Plus.

    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

    Verify that container is CDB root.

    ```
    <SQL> <copy>show con_name</copy>
    ```

4. Configure Database Vault at the CDB root level ensuring that the `DV_OWNER` role is granted locally in the CDB root to the common Oracle Database Vault owner, `C##SEC_ADMIN`.

    ```
    <SQL> <copy>exec DVSYS.CONFIGURE_DV ( dvowner_uname =>'c##sec_admin',-
                                         dvacctmgr_uname =>'c##accts_admin', -
                                         force_local_dvowner => TRUE)</copy>
    ```

5. Observe the Oracle Database Vault status in the CDB root. Oracle Database Vault is configured but Database Vault Operations Control is not configured.

    ```
    <SQL> <copy>SELECT * FROM dba_dv_status;</copy>

    NAME                     STATUS
    ------------------------ --------------
    DV_APP_PROTECTION        NOT CONFIGURED
    DV_CONFIGURE_STATUS      TRUE
    DV_ENABLE_STATUS         FALSE
    ```

6. Log in to PDB1.

    ```
    <SQL> <copy>CONNECT sys/Ora4U_1234@PDB1 as sysdba</copy>
    Connected.
    ```

7. Observe the Oracle Database Vault status in PDB1.

    ```
    <SQL> <copy>SELECT * FROM dba_dv_status;</copy>

    NAME                     STATUS
    ------------------------ --------------
    DV_APP_PROTECTION        NOT CONFIGURED
    DV_CONFIGURE_STATUS      FALSE
    DV_ENABLE_STATUS         FALSE
    ```

8. Check that the user SYS can still count the `HR.EMPLOYEES` table rows.

    ```
    <SQL> <copy>SELECT count(*) FROM HR.EMPLOYEES;</copy>

    COUNT(*)
    ----------
          107
    ```

## Task 4: Enable Database Vault Operations Control

1. In the CDB root, login as `C##ACCTS_ADMIN` and create a common user to grant the CREATE SESSION and SELECT ANY TABLE privileges.

    ```
    <SQL> <copy>CONNECT c##accts_admin/Ora4U_1234</copy>
    ```
    ```
    <SQL> <copy>CREATE USER c##common IDENTIFIED BY Ora4U_1234 CONTAINER=ALL;</copy>
    ```

2. Grant the CREATE SESSION and SELECT ANY TABLE privileges to the common user.

    ```
    <SQL> <copy> CONNECT / as sysdba</copy>
    ```
    ```
    <SQL> <copy>GRANT create session, select any table TO c##common CONTAINER=ALL;</copy>
    ```

3. Connect to PDB1 as the common user. Verify that the common user can query the `HR.EMPLOYEES` table.

    ```
    SQL> <copy>CONNECT c##common/Ora4U_1234@PDB1</copy>
    ```
    ```
    <SQL> <copy>SELECT count(*) FROM hr.employees;</copy>

    COUNT(*)
    ----------
           107
    ```

4. Enable Database Vault Operations Control in the CDB root. An error should occur when running this command because the Database Vault is not enabled in the CDB root. The next step will show how to first enable Oracle Database Vault in the CDB root.

    ```
    SQL> <copy>CONNECT / as sysdba</copy>
    ```
    ```
    <SQL> <copy>EXEC dvsys.dbms_macadm.enable_app_protection</copy>
    BEGIN dvsys.dbms_macadm.enable_app_protection; END;
    *
    ERROR at line 1:
    ORA-47503: Database Vault is not enabled in CDB$ROOT or application root.
    ORA-06512: at "DVSYS.DBMS_MACADM", line 2811
    ORA-06512: at line 1
    ```

5. Log in to CDB1 as the Oracle Database Vault owner, `C##SEC_ADMIN`, and enable Oracle Database Vault in CDB1.

    ```
    SQL> <copy>CONNECT c##sec_admin/Ora4U_1234@CDB1</copy>
    ```
    ```
    <SQL> <copy>EXEC dvsys.dbms_macadm.enable_dv</copy>
    ```

6. Restart the database instance to enforce DV configuration and enabling.

    ```
    SQL> <copy>CONNECT / as sysdba</copy>
    ```
    ```
    SQL> <copy>shutdown immediate</copy>
    ```
    ```
    SQL> <copy>startup</copy>
    ```
  If the PDB1 is not automatically opened, then manually open it.
    ```
    <SQL> <copy>ALTER PLUGGABLE DATABASE PDB1 OPEN;</copy>
    ```

7. Verify the Oracle Database Vault status in the CDB root. The result should show that the Oracle Database Vault is configured and enabled but Database Vault Operations Control is still not configured.

    ```
    <SQL> <copy>SELECT * FROM dba_dv_status;</copy>

    NAME                     STATUS
    ------------------------ --------------
    DV_APP_PROTECTION        NOT CONFIGURED
    DV_CONFIGURE_STATUS      TRUE
    DV_ENABLE_STATUS         TRUE
    ```

8. Log in to the CDB root as the common account with the `DV_OWNER` role to enable Database Vault Operations Control, even if the `DV_OWNER` role has been granted locally.

    ```
    <SQL> <copy>CONNECT c##sec_admin/Ora4U_1234</copy>
    ```
    ```
    <SQL> <copy>EXEC dvsys.dbms_macadm.enable_app_protection</copy>
    ```

9. Verify the Oracle Database Vault Operations Control status in the CDB root.

    ```
    <SQL> <copy>CONNECT / as sysdba</copy>
    ```
    ```
    <SQL> <copy>SELECT * FROM dba_dv_status;</copy>

    NAME                     STATUS
    ------------------------ --------------
    DV_APP_PROTECTION        ENABLED
    DV_CONFIGURE_STATUS      TRUE
    DV_ENABLE_STATUS         TRUE
    ```

10. Verify the Oracle Database Vault Operations Control status in PDB1.
    ```
    <SQL> <copy>CONNECT sys/Ora4U_1234@PDB1 as sysdba</copy>
    ```
    ```
    <SQL> <copy>SELECT * FROM dba_dv_status;</copy>

    NAME                     STATUS
    ------------------------ --------------
    DV_APP_PROTECTION        ENABLED
    DV_CONFIGURE_STATUS      FALSE
    DV_ENABLE_STATUS         FALSE
    ```

Observe that Oracle Database Vault Operations Control is enabled at the PDB level with its status inherited from the CDB root. Oracle Database Vault is not required to be configured and enabled in PDBs, but must be configured and enabled at the CDB root level.

## Task 5: Test Database Vault Operations Control

1. Connect to PDB1 as the common user. Verify that the common user cannot query the `HR.EMPLOYEES` table due to insufficient privileges.

    ```
    <SQL> <copy>CONNECT c##common/Ora4U_1234@PDB1</copy>
    ```
    ```
    <SQL> <copy>SELECT * FROM hr.employees;</copy>
    SELECT * FROM hr.employees
                 *
    ERROR at line 1:
    ORA-01031: insufficient privileges
    ```
## Task 6: Complete administrative tasks in PDBs

In this task, you back up the PDB although Oracle Database Vault Operations Control is enabled. Because database patching, backing up, restoring, and upgrading do not touch customer schemas, DBAs and privileged common users can still run tools as `SYSDBA` to patch, backup, restore, and upgrade the database (with `DV_PATCH_ADMIN` granted commonly in the CDB root).

1. Grant the `SYSDBA` privilege to the common user in PDB1.

    ```
    <SQL> <copy>CONNECT sys/Ora4U_1234@PDB1 as sysdba</copy>
    ```
    ```
    <SQL> <copy>GRANT sysdba TO c##common;</copy>
    ```
2. Quit the session.

    ```
    <SQL> <copy>exit</copy>
    ```

3. Use RMAN to back up PDB1. Connect as the common user to PDB1.

    ```
    $ <copy>rman target c##common@PDB1/Ora4U_1234</copy>
    ```
    ```
    <rman> <copy>BACKUP DATABASE;</copy>
    ```
Although common users cannot query application data in PDBs, they can still complete administrative tasks for which they are granted privileges.

4. Quit the RMAN session.
    ```
    <rman> <copy>exit</copy>
    ```

## Task 7: Add users in an exception list to allow them operations in PDBs

In this task, you will maintain the exception list of common users and packages so that the tasks that need to be completed by common users can be completed despite the Database Vault Operations Control enabled. These common users are automation accounts, not used by humans.

HR application data in PDB1 is very sensitive and should be protected against common users in the CDB. Nevertheless, the `C##REPORT` common user should be able to access some of the HR application information in PDB1 to generate statistics for Human Resources.

1. Log in as the `C##ACCTS_ADMIN` user who has been granted the `DV_ACCTMGR` role to create the common user C##REPORT.

    ```
    $ <copy>sqlplus c##accts_admin/Ora4U_1234</copy>
    ```
    ```
    <SQL> <copy>CREATE USER c##report IDENTIFIED BY Ora4U_1234 CONTAINER=ALL;</copy>
    ```

2. Grant the CREATE SESSION and SELECT ANY TABLE privileges to C##REPORT.

    ```
    <SQL> <copy>CONNECT / as sysdba</copy>
    ```
    ```
    <SQL> <copy>GRANT create session, select any table TO c##report CONTAINER=ALL;</copy>
    ```

3. Log in as the `C##REPORT` user in PDB1 and check if the user can query the application data in PDB1. Error should display as shown below.

    ```
    <SQL> <copy>CONNECT c##report/Ora4U_1234@PDB1</copy>
    ```
    ```
    <SQL> <copy>SELECT count(*) FROM hr.employees;</copy>
    ```
    ```
    SELECT count(*) FROM hr.employees
    *
    ERROR at line 1:
    ORA-01031: insufficient privileges
    ```

The behavior is expected because Oracle Database Vault Operations Control is enabled.

4. Add the user to the exception list of users and packages allowed to access local data in PDB1. This operation can only be completed in the CDB root.

    ```
    <SQL> <copy>CONNECT c##sec_admin/Ora4U_1234</copy>
    ```
    ```
    <SQL> <copy>EXEC dvsys.dbms_macadm.add_app_exception (owner => 'C##REPORT', package_name => '')</copy>
    ```

5. Query the exception list.

    ```
    <SQL> <copy>SELECT * FROM DVSYS.DBA_DV_APP_EXCEPTION;</copy>

    OWNER          PACKAGE
    -------------- --------------
    C##REPORT      %
    ```

Automation accounts frequently have procedure or functions that need to access local data. In this case, include the package name so that only the package name can access local data and not someone who has stolen the credentials and runs SQL statements.

6. Re-connect as the common user in PDB1 and check that the common user can query the application data in PDB1.

    ```
    <SQL> <copy>CONNECT c##report/Ora4U_1234@PDB1</copy>
    ```
    ```
    <SQL> <copy>SELECT count(*) FROM hr.employees;</copy>

    COUNT(*)
    ----------
           107
    ```

## Task 8: Clean up the environment

1. Disable Database Vault Operations Control.

    ```
    <SQL> <copy>CONNECT c##sec_admin/Ora4U_1234</copy>
    ```
    ```
    <SQL> <copy>EXEC dvsys.dbms_macadm.disable_app_protection</copy>
    ```

2. Revoke the SYSDBA privilege from the common user in PDB1.

    ```
    <SQL> <copy>CONNECT sys/Ora4U_1234@PDB1 as sysdba</copy>
    ```
    ```
    <SQL> <copy>REVOKE sysdba FROM c##common;</copy>
    ```

3. Drop the C##COMMON user in the CDB.

    ```
    <SQL> <copy>CONNECT c##accts_admin/Ora4U_1234</copy>
    ```
    ```
    <SQL> <copy>DROP USER c##common CASCADE;</copy>
    ```

4. Drop the C##REPORT user in the CDB.

    ```
    <SQL> <copy>DROP USER c##report CASCADE;</copy>
    ```

5. Quit the session.

    ```
    <SQL> <copy>exit</copy>
    ```

## Learn More

- [New Features in Oracle Database 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/newft/preface.html#GUID-E012DF0F-432D-4C03-A4C8-55420CB185F3)

## Acknowledgements

- **Author**- Dominique Jeunot, Consulting User Assistance Developer
- **Technical Contributor** - Jody Glover, Principal User Assistance Developer
- **Last Updated By/Date** - Kherington Barley, Austin Specialist Hub, November 15 2021
