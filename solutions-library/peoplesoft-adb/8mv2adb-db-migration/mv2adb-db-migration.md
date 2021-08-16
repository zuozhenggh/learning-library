# MV2ADB Database migration for PeopleSoft

## Introduction

This lab walks you through the steps to establish connectivity between PeopleSoft on-premise system and Oracle Autonomous Database shared

Estimated Lab Time: 6 hours

### Objectives
In this lab, you will:
* Use MV2ADB to migrate on-premise PeopleSoft database to ADB-S


### Prerequisties
* Root user access on the on-premise PeopleSoft system


## Task: MV2ADB Auto run for one click migration

The migration script will export from your source databases, then import into your Autonomous database using data pump. For more information, refer to the official steps from my Oracle support (MOS) [here](https://support.oracle.com/epmos/faces/DocContentDisplay?_afrLoop=291097898074822&id=2463574.1&_afrWindowMode=0&_adf.ctrl-state=v0102jx12_4).

1.  As root user on  source Peoplesoft on-premise database instance, run the script in AUTO mode.
  
    ```
    cd /opt/mv2adb
    ./mv2adb.bin auto -conf /opt/mv2adb/conf/DBNAME.mv2adb.cfg
    ```
    Below are screenshots from the mv2adb auto run:

    Data pump EXPDP job in progress
    ![](./images/mv2adb-auto.png "")
    ![](./images/mv2adb-auto1.png "")
    ![](./images/mv2adb-auto2.png "")
    
    Datapump Dump File Transfer to Object Storage
    ![](./images/mv2adb-auto3.png "")

    Datapump IMPDP in progress
    ![](./images/mv2adb-auto4.png "")

    Datapump IMPDP Successful completion
    ![](./images/mv2adb-auto5.png "")



You may now **proceed to the next lab.**

## Acknowledgements
* **Authors** - Deepak Kumar M, PeopleSoft Architect
* **Contributors** - Deepak Kumar M, PeopleSoft Architect
* **Last Updated By/Date** - Deepak Kumar M, PeopleSoft Architect, Aug 2021


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.



