# Validating Peoplesoft Schema Objects on ADB-S

## Introduction

This lab walks you through the steps to validate PeopleSoft schema objects on ADB-S

Estimated Lab Time: 5 minutes


### Objectives

In this lab, you will:
* Validate PeopleSoft schema objects after MV2ADB job successful completion


### Prerequisties
* Oracle user login access and SQL access on the on-premise PeopleSoft database system
* SQL Access using ADMIN user on the PeopleSoft ADB-S database.


## Task 1: Source On-Premise Peoplesoft Objects count

* Login as Oracle user and connect to the sqlplus prompt by entering the below SQL command

    ```
    [oracle@pscs92dmo-lnxdb-2 ~] sqlplus / as sysdba
    SQL*Plus: Release 19.0.0.0.0 - Production on Thu Apr 22 13:21:00 2021
    Version 19.10.0.0.0
    Copyright (c) 1982, 2020, Oracle. All rights reserved.
    Enter password:
    Last Successful login time: Thu Apr 22 2021 12:51:40 +00:00
    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.5.0.0.0

    SQL>alter session set container=pspdb;
    Session altered

    SQL> col owner format a20;
    SQL> select owner, object_type, count(*) from all_objects where owner in ('PS','PEOPLE','SYSADM') group by owner, object_type order by 1,2;

    ```
    Output of the above command from on-premise Peoplesoft database is below

    ![](./images/source-db.png "")


## Task 2: Peoplesoft Schema objects count on ADB-S

* Login as root user to the source Peopleoft database system and connect to the ADB-S database and execute the below SQL commands to verify the count of Peoplesoft schema objects

    ```
    [oracle@pscs92dmo-lnxdb-2 ~] sqlplus admin@psadb_high
    SQL*Plus: Release 19.0.0.0.0 - Production on Thu Apr 22 13:21:00 2021
    Version 19.10.0.0.0
    Copyright (c) 1982, 2020, Oracle. All rights reserved.
    Enter password:
    Last Successful login time: Thu Apr 22 2021 12:51:40 +00:00
    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.5.0.0.0

        
    SQL> col owner format a20;
    SQL> select owner, object_type, count(*) from all_objects where owner in ('PS','PEOPLE','SYSADM') group by owner, object_type order by 1,2;

    ```
    Output of the above command from an ADB-S Peoplesoft database is below

    ![](./images/target-db.png "")



You may now **proceed to the next lab.**

## Acknowledgments
* **Authors** - Deepak Kumar M, PeopleSoft Architect
* **Contributors** - Deepak Kumar M, PeopleSoft Architect
* **Last Updated By/Date** - Deepak Kumar M, PeopleSoft Architect, Aug 2021





## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.



