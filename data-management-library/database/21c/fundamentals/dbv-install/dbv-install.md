# Installing Oracle Database Vault

## Introduction
This lab shows how to install or reinstall Oracle Database Vault in a CDB by using Database Configuration Assistant (DBCA).

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


## **STEP 1:** Ensure Database Vault is not installed

Before starting the reinstallation of Database Vault, use the [Practice: Deinstalling Oracle Database Vault](https://confluence.oci.oraclecorp.com/display/DB21CNEWFT/Practice%3A+Deinstalling+Oracle+Database+Vault) in case Database Vault is already installed.

## **STEP 2:** Use DBCA to reinstall or install Database Vault in the CDB

- Before running the command, replace the password in the command below for both the DV owner and the DV account manager. Ensure that the DV owner and DV account manager accounts do not exist in the CDB root.

  
  ```
  
  $ <copy>$ORACLE_HOME/bin/dbca -silent -configureDatabase -sourceDB CDB21 -dvConfiguration true -olsConfiguration true -dvUserName c##dvo -dvUserPassword <i>password</i> -dvAccountManagerName c##dvacctmgr -dvAccountManagerPassword <i>password</i> </copy>
  
  Enter password for the TDE wallet: <i> password </i>
  
  [WARNING] [DBT-16002] The database will be restarted in order to configure the chosen options.
  
  Prepare for db operation
  
  22% complete
  
  Preparing to Configure Database
  
  24% complete
  
  29% complete
  
  38% complete
  
  40% complete
  
  44% complete
  
  Oracle Database Vault
  
  89% complete
  
  Completing Database Configuration
  
  100% complete
  
  The database configuration has completed successfully.
  
  Look at the log file "/u01/app/oracle/cfgtoollogs/dbca/CDB21/CDB212.log" for further details.
  
  $
  
  ```

- Connect to the CDB root as `C##DVO` to verify the status of Database Vault. 

  
  ```
  
  $ <copy>sqlplus c##dvo</copy>
  
  Enter password: <i><copy>password</copy></i>
  
  SQL> <copy>SELECT * FROM DVSYS.DBA_DV_STATUS;</copy>
  
  NAME                STATUS
  
  ------------------- --------------
  
  DV_CONFIGURE_STATUS TRUE
  
  DV_ENABLE_STATUS    TRUE
  
  DV_APP_PROTECTION   NOT CONFIGURED
  
  SQL> <copy>SELECT * FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';</copy>
  
  PARAMETER                 VALUE   CON_ID
  
  ------------------------- ------- ------
  
  Oracle Database Vault     TRUE         0
  
  SQL>
  
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
