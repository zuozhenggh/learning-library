# Handle Operations on Oracle-Managed and User-Managed Tablespaces Encrypted</copy>

## Introduction

This 15-minute tutorial shows you how to handle operations on the metadata and data of Oracle-managed and user-managed tablespaces when the Transparent Data Encryption (TDE) keystore is closed.

In Oracle Database 19c, you must close the TDE keystore to disallow operations on encrypted tablespaces. The behavior when the keystore is closed does not depend on the type of tablespace being accessed. Operations on user-managed tablespaces or Oracle-managed tablespaces like SYSTEM, SYSAUX, UNDO, and TEMP tablespaces raise the ORA-28365 "wallet is not open" error.

Estimated Time: 15 minutes

### Objectives
- Prepare the CDB to Use TDE
- Encrypt Oracle-managed and User-managed Tablespaces
- Handle Encrypted Data in Oracle-managed and User-managed Tablespaces When Keystore is Closed
- Clean Up the Environment

### Prerequisites
- Oracle Database 19c installed
- A container database (CDB): `CDB1` with `PDB1`

## Prepare your environment

1. Open a terminal window on the desktop.

2. Set the Oracle environment variables. At the prompt, enter **CDB1**.

    ```
    $ <copy>. oraenv</copy>
    CDB1
    ```

## Task 1: Prepare the CDB to use TDE
1. Make the directory for the CDB1 with tde_wallet
  ```
  <copy>mkdir -p /u01/app/oracle/admin/CDB1/tde_wallet</copy>
  ```
2. Log in to ORCL as SYS with the SYSDBA administrative privilege.
  ```
  <copy><copy>sqlplus / AS SYSDBA</copy>
  ```
3. Create the keystore for the CDB in /u01/app/oracle/admin/CDB1/tde_wallet
  ```
  <copy>ADMINISTER KEY MANAGEMENT CREATE KEYSTORE '/u01/app/oracle/admin/CDB1/tde_wallet' IDENTIFIED BY password;</copy>

  ```
Try adding this using gedit to $ORACLE_HOME/network/admin/sqlnet.ora if you run into `ORA-28367: wallet does not exist`.
  ```
  <copy>
  WALLET_LOCATION=
    (SOURCE=
      (METHOD=file)
      (METHOD_DATA=
         (DIRECTORY=/u01/app/oracle/admin/CDB1/tde_wallet)
         [(PKCS11=FALSE)]))</copy>
   ```
4. Open the keystore.
  ```
  <copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY password CONTAINER=ALL;</copy>
  ```
5. Set the TDE master encryption key.
  ```
  <copy>ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY password WITH BACKUP CONTAINER=ALL;</copy>
  ```
6. Create a user-managed tablespace.
  ```
  <copy>CREATE TABLESPACE omtbs DATAFILE '/u01/app/oracle/oradata/CDB1/omts01.dbf' SIZE 10M;</copy>
  ```
7. Check that the tablespaces are not encrypted.
  ```
  <copy>SELECT tablespace_name, encrypted FROM dba_tablespaces;</copy>

  TABLESPACE_NAME   ENC
  ----------------- ---
  SYSTEM            NO
  SYSAUX            NO
  UNDOTBS1          NO
  TEMP              NO
  USERS             NO
  OMTBS             NO
  ```

## Task 2: Encrypt Oracle-managed and user-managed tablespaces
In this section, you close the keystore and see which operations on Oracle-managed tablespaces and user-managed tablespaces can be handled on the metadata and data.

1. Close the keystore.
  ```
  <copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE IDENTIFIED BY password CONTAINER = ALL;</copy>
  ```
2. Switch one of the Oracle-managed tablespaces to encryption.
  ```
  <copy>ALTER TABLESPACE system ENCRYPTION USING 'AES192' ENCRYPT;</copy>
  ALTER TABLESPACE system ENCRYPTION USING 'AES192' ENCRYPT
  *
  ERROR at line 1:
  ORA-28365: wallet is not open
  ```
3. Switch one of the user-managed tablespaces to encryption.
  ```
  <copy>ALTER TABLESPACE omtbs ENCRYPTION USING 'AES192' ENCRYPT;</copy>
  ALTER TABLESPACE omtbs ENCRYPTION USING 'AES192' ENCRYPT
  *
  ERROR at line 1:
  ORA-28365: wallet is not open
  ```
4. Open the keystore.
  ```
  <copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY password CONTAINER = ALL;</copy>
  ```
5. Switch one of the Oracle-managed tablespaces to encryption.
  ```
  <copy>ALTER TABLESPACE system ENCRYPTION 'AES192' ENCRYPT;</copy>
  ```
6. Switch one of the user-managed tablespaces to encryption.
  ```
  <copy>ALTER TABLESPACE omtbs ENCRYPTION 'AES192' ENCRYPT;</copy>
  ```
7. Check that the tablespaces are encrypted.
  ```
  <copy>SELECT tablespace_name, encrypted FROM dba_tablespaces;</copy>

  TABLESPACE_NAME   ENC
  ----------------- ---
  SYSTEM            YES
  SYSAUX            NO
  UNDOTBS1          NO
  TEMP              NO
  USERS             NO
  OMTBS             YES
  ```
## Task 3: Handle encrypted data in Oracle-managed and user-managed tablespaces When keystore is closed
1. Close the keystore.
  ```
  <copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE IDENTIFIED BY password CONTAINER = ALL;</copy>
  ```
2. Change the encryption algorithm in SYSTEM tablespace.
  ```
  <copy>ALTER TABLESPACE system ENCRYPTION USING 'AES128' ENCRYPT;</copy>
  ALTER TABLESPACE system ENCRYPTION USING 'AES128' ENCRYPT
  *
  ERROR at line 1:
  ORA-28365: wallet is not open
  ```
3. Change the encryption algorithm in OMTBS tablespace.
  ```
  <copy>ALTER TABLESPACE omtbs ENCRYPTION USING 'AES128' ENCRYPT;</copy>
  ALTER TABLESPACE omtbs ENCRYPTION USING 'AES128' ENCRYPT
  *
  ERROR at line 1:
  ORA-28365: wallet is not open
  ```
The operation fails because the operation affects the metadata of the Oracle-managed and user-managed tablespaces.
4. Create a table and insert data in the tablespace SYSTEM.
  ```
  <copy>CREATE TABLE system.test (c NUMBER, C2 CHAR(4)) TABLESPACE system;</copy>
  ```
5.
  ```
  <copy>INSERT INTO system.test VALUES (1,'Test');</copy>
  ```
6.
  ```
  <copy>COMMIT;</copy>
  ```
The operation completes because the operation affects only the data of the Oracle-managed tablespace and because the tablespace is an Oracle-managed tablespace.
7. Create a table and insert data in the tablespace OMTBS.
  ```
  <copy>CREATE TABLE system.test2 (c NUMBER, C2 CHAR(4)) TABLESPACE omtbs;</copy>
  CREATE TABLE system.test2
  *
  ERROR at line 1:
  ORA-28365: wallet is not open
  ```
Operations on user-managed tablespaces still raise the ORA-28365 "wallet is not open" error when the CDB root keystore is closed.
The behavior is the same in pluggable databases (PDBs).

## Task 4: Clean up the environment
1. Open the keystore.
  ```
  <copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY password CONTAINER = ALL;</copy>
  ```
2. Drop the SYSTEM.TEST table.
  ```
  <copy>DROP TABLE system.test;</copy>
  ```
3. Drop the user-managed tablespace.
  ```
  <copy>DROP TABLESPACE omtbs INCLUDING CONTENTS AND DATAFILES;</copy>
  ```
4. Decrypt the Oracle-managed tablespaces.
  ```
  <copy>ALTER TABLESPACE system ENCRYPTION DECRYPT;</copy>
  ```
5. Quit the session.<copy>
  ```
  <copy>EXIT</copy>
  ```



## Acknowledgements
- **Last Updated By/Date** - Blake Hendricks, Austin Specialist Hub, November 12 2021
