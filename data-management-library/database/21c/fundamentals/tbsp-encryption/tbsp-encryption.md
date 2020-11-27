# Setting the Default Tablespace Encryption Algorithm

## Introduction
This lab shows how the passwords in the password files in Oracle Database 21c are case-sensitive. In earlier Oracle Database releases, password files by default retain their original case-insensitive verifiers. The parameter to enable or disable password file case sensitivity `IGNORECASE` is removed. All passwords in new password files are case-sensitive.

### About Product/Technology
Until Oracle Database 21c, only the set operator UNION could be combined with ALL. Oracle Database 21c introduces two set operators, MINUS ALL (same as EXCEPT ALL) and INTERSECT ALL.

 ![Set Operators](images/set-operators.png "Set Operators")

- The 1st and 2nd statements use the EXCEPT operator to return only unique rows returned by the 1st query but not the 2nd.  
- The 3rd and 4th statements combine results from two queries using EXCEPT ALL reteruning only rows returned by the 1st query but not the 2nd even if not unique.
- The 5th and 6th statement combines results from 2 queries using INTERSECT ALL returning only unique rows returned by both queries.


Estimated Lab Time: XX minutes

### Objectives
In this lab, you will:
* Setup the environment
* Test the set operator with the EXCEPT clause
* Test the set operator with the EXCEPT ALL clause
* Test the set operator with the INTERSECT clause
* Test the set operator with the INTERSECT ALL clause

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a VCN
* Lab: Create an OCI VM Database
* Lab: 21c Setup


## Step 1 : Set the default tablespace encryption algorithm

- Connect to the CDB root and display the default tablespace encryption algorithm.

  
  ```
  
  $ <copy>sqlplus / AS SYSDBA</copy>
  
  Connected to:
  
  Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production
  
  Version 21.2.0.0.0
  
  SQL> <copy>SHOW PARAMETER TABLESPACE_ENCRYPTION_DEFAULT_ALGORITHM</copy>
  
  NAME                                       TYPE   VALUE
  
  ------------------------------------------ ------ -----------------------
  
  tablespace_encryption_default_algorithm    string AES128
  
  SQL>
  
  ```

- Change the tablespace encryption algorithm.

  
  ```
  
  SQL> <copy>ALTER SYSTEM SET TABLESPACE_ENCRYPTION_DEFAULT_ALGORITHM=AES192;</copy>
  
  System altered.
  
  SQL> <copy>EXIT</copy>
  
  $
  
  ```

- Connect to the PDB and create a new tablespace in `PDBTEST`. Before creating the tablespace, open the wallet. Execute the `/home/oracle/labs/M104780GC10/wallet.sh` shell script.

  
  ```
  
  $ <copy>/home/oracle/labs/M104780GC10/wallet.sh</copy>
  
  ...
  
  SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY <i>password</i> container=all;
  
  keystore altered.
  
  SQL> ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY <i>password</i> WITH BACKUP CONTAINER=ALL;
  
  keystore altered.
  
  SQL> exit
  
  $
  
  ```
  
  ```
  
  $ <copy>sqlplus sys@PDB21 AS SYSDBA</copy>
  
  Enter password: <b><i>password</i></b>
  
  Connected.
  
  SQL> <copy>CREATE TABLESPACE tbstest DATAFILE 'test01.dbf' SIZE 2M;</copy>
  
  Tablespace created.
  
  SQL>
  
  ```

## Step 2 : Verify the tablespace encryption algorithm used 

```

SQL> <copy>SELECT name, encryptionalg 
              FROM v$tablespace t, v$encrypted_tablespaces v 
              WHERE t.ts#=v.ts#;</copy>

NAME                           ENCRYPT
------------------------------ -------
USERS                          AES128
TBSTEST                        AES192

SQL> <copy>EXIT</copy>

$

```

You may now [proceed to the next lab](#next).

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  Kay Malcolm, Database Product Management

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
