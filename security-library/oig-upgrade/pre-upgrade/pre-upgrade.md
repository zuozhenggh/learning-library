# Pre-Upgrade Requirements

## Introduction

This lab walks you through the pre-upgrade tasks to be performed before upgrading to Oracle Identity Manager 12c such as backing up, cloning your current environment, analyzing Pre-Upgrade Report and verifying that your system meets certified requirements.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:
* Create a Non-SYSDBA User to Run the Upgrade Assistant
* Export OPSS Encryption keys
* Run the Upgrade Assistant to perform Pre-Upgrade readiness check

### Prerequisites

* An Oracle Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported
* SSH Private Key to access the host via SSH
* You have completed Lab 1: Initialize the workshop Environment


## **STEP 1:** Create a non-SYSDBA user

Oracle recommends that you create a non-SYSDBA user called *FMW* to run the Upgrade Assistant. This user has the privileges required to modify schemas, but does not have full administrator privileges.

1. Login to the database and run the *fmw.sql* script

```
<copy>sqlplus / as sysdba</copy>
```
```
SQL> <copy>@/u01/scripts/FMW.sql</copy>
```
```
SQL> <copy>exit</copy>
```

## **STEP 2:** Export and Copy the OPSS Encryption Keys

The following steps are performed to ensure that the encrypted data from 11g (11.1.2.3) OIG is read correctly after the upgrade to 12c (12.2.1.4) OIG. The exported keys will be required by the oneHopUpgrade tool to complete the upgrade process.

1. Export the OPSS encryption key from the Oracle Identity Manager 11g (11.1.2.3) setup

    - Navigate to the *<11g_(11.1.2.3_ORACLE_HOME>/oracle_common/common/bin* location

			<copy>cd /u01/oracle/middleware11g/oracle_common/common/bin</copy>

    - Launch the *wlst.sh* script

			<copy>./wlst.sh</copy>

    - Execute the *exportEncryptionKey* WLST command in the offline mode
        ```
      <copy>exportEncryptionKey('/u01/oracle/middleware11g/user_projects/domains/iam11g_domain/config/fmwconfig/jps-config.xml', '/u01/OPSS_EncryptKey', 'Welcom@123')</copy>
        ```

    - Exit from the WLST
        ```
      <copy>exit ()</copy>      
        ```

        ![](images/1-wlst.PNG)


    - Navigate to the */u01/OPSS_EncryptKey* directory and Verify that the exported encryption key files are created

        ```
        <copy>cd /u01/OPSS_EncryptKey</copy>
        ```
        ```
        <copy>ls -latr</copy>
        ```
    - Copy the .xldatabasekey from the 11g (11.1.2.3) setup location to */u01/OPSS_EncryptKey* directory

        ```
        <copy>cp /u01/oracle/middleware11g/user_projects/domains/iam11g_domain/config/fmwconfig/.xldatabasekey /u01/OPSS_EncryptKey</copy>
        ```

## **STEP 3:** Pre-Upgrade readiness check

1. Run the Upgrade Assistant in readiness mode to perform a pre-upgrade readiness check
  ```
  <copy>cd /u01/oracle/middleware12c/oracle_common/upgrade/bin</copy>
  ```
  ```
  <copy>./ua -readiness</copy>
  ```
  The Upgrade Assistant is launched in readiness mode:

  - Welcome - Click *Next*

  ![](images/2-ua.PNG)

  - Readiness check type - *Domain based*. Browse to the 11g OIM home: */u01/oracle/middleware11g/user_projects/domains/iam11g_domain/*

  ![](images/3-ua.PNG)

  - Component List - Click *Next*

  ![](images/4-ua.PNG)

  - OPSS Schema
  ```
  DBA Username: <copy>FMW</copy>
  DBA Password: <copy>Welcom#123</copy>
  ```

  ![](images/5-ua.PNG)

  - MDS Schema - The same Username and Password is updated automatically - Click *Next*

  ![](images/6-ua.PNG)

  - UMS Schema - The same Username and Password is updated automatically - Click *Next*

  ![](images/7-ua.PNG)

  - SOAINFRA schema - The same Username and Password is updated automatically - Click *Next*

  ![](images/8-ua.PNG)

  - OIM Schema - The same Username and Password is updated automatically - Click *Next*

  ![](images/9-ua.PNG)

  - Readiness Summary - Click *Next*

  - Click on *Finish* and then *Close* the UA once the Readiness check is complete

  ![](images/10-ua.PNG)

## **STEP 4:** Analyzing Pre-Upgrade Report for Oracle Identity Manager (Optional)

The pre-upgrade report utility analyzes your existing Oracle Identity Manager environment, and provides information about the mandatory prerequisites that you must complete before you begin the upgrade. It is important to address all of the issues listed in the pre-upgrade report before you proceed with the upgrade, as the upgrade might fail if the issues are not resolved.
Sample Pre-upgrade reports have already been generated as part of this lab. They can be viewed and analyzed at the */u01/Upgrade_Utils/OIM_preupgrade_reports* directory.

## **STEP 5:** Stop 11g servers and processes

Before you run the Upgrade Assistant to upgrade the schemas, you must shut down all the processes and servers in the 11g OIG domain, including the Administration Server, Node Manager (if you have configured Node Manager), and all Managed Servers.

1. Run the *stopDomain11g.sh* script to stop all 11g servers
```
<copy>cd /u01/scripts</copy>
```
```
<copy>./stopDomain11g.sh</copy>
```
This completes all the pre-upgrade tasks to be performed.

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Keerti R, Brijith TG, Anuj Tripathi
* **Contributors** -  Keerti R, Brijith TG, Anuj Tripathi
* **Last Updated By/Date** - Keerti R/May 2021
* **Workshop (or Lab) Expiry Date** - Never
