# Configure Database and GoldenGate Users

## Introduction
In this lab we will setup the required database and GoldenGate replication users.

*Estimated Lab Time*:  60 minutes

### Lab Architecture
![](./images/ggmicroservicesarchitecture.png " ")

### Objectives
Understanding how to prepare and setup an Oracle Database for replication and define users for replication. Users are created using scripts that populate the multitenant environment with required Oracle Users while applying aliases to be used by GoldenGate. The Databases used in this lab are identified using the SOE schema in source and targets.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

In this lab we will setup GoldenGate Microservices

## **STEP 0**: Running your Lab
### Login to Host using SSH Key based authentication

Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
  - Authentication OS User - “*opc*”
  - Authentication method - *SSH RSA Key*
  - OS User – “*oracle*”.

1. First login as “*opc*” using your SSH Private Key

2. Then sudo to “*oracle*”. E.g.

    ```
    <copy>sudo su - oracle</copy>
    ```

## **STEP 1:** Start the Oracle Database 19c (19.1) and Listener
1.	Start the database

    ```
    <copy>
    cd ~/Desktop/Scripts/HOL/Lab1  
    sh ./startup.sh
    </copy>
    ```

2. Enable the database for GoldenGate replication.

    ```
    <copy>alter system set enable_goldengate_replication=true scope=both;</copy>
    ```

    ![](./images/z2.png " ")

    In the next steps we will enable Archive Log on the database. This will require you to shut down the database and restart it.

4. Shutdown the database.

    ```
    <copy>shutdown immediate;</copy>
    ```

    ![](./images/z3.png " ")

5. Start the database up in mount mode.

    ```
    <copy>startup mount;</copy>
    ```

    ![](./images/z4.png " ")

6. Enable Archive Log mode.

    ```
    <copy>alter database archivelog;</copy>
    ```

    ![](./images/z5.png " ")

7. Open the database.

    ```
    <copy>alter database open;</copy>
    ```

    ![](./images/z6.png " ")

8.	Open the all Pluggable Databases

    ```
    <copy>alter pluggable database all open read write;</copy>
    ```

9. Enable Minimal Supplemental Logging for the database and perform a log switch.

    ```
    <copy>
    alter database add supplemental log data;
    alter system switch logfile;
    </copy>
    ```

## **STEP 2:** Create the GoldenGate users needed at the Container Database and Pluggable Database Layers
1. From SQL*Plus run the following SQL statements to create the Common User within the Container Database (CDB).

    ```
    <copy>
    create user c##ggate identified by ggate quota unlimited on USERS account unlock;
    grant connect, dba, resource to c##ggate;

    begin
    SYS.DBMS_GOLDENGATE_AUTH.GRANT_ADMIN_PRIVILEGE('C##GGATE', container=>'ALL');
    end;
    /
    </copy>
    ```

2. From SQL*Plus, run the following SQL statements to create the GoldenGate users for the Pluggable database (PDB)

    ```
    <copy>
    alter session set container = oggoow19;
    grant connect, dba to c##ggate;
    create user GGATE identified by ggate quota unlimited on USERS account unlock;
    grant connect, dba to ggate;
    alter session set container = oggoow191;
    grant connect, dba to c##ggate;
    create user GGATE identified by ggate quota unlimited on USERS account unlock;
    grant connect, dba to ggate;
    exit
    </copy>
    ```

## Summary
Oracle GoldenGate offers high-performance, fault-tolerant, easy-to-use, and flexible real- time data streaming platform for big data environments. It easily extends customers’ real-time data
integration architectures to big data systems without impacting the performance of the source systems and enables timely business insight for better decision making.

You may now *proceed to the next lab*.

## Learn More

* [GoldenGate Microservices](https://docs.oracle.com/en/middleware/goldengate/core/19.1/understanding/getting-started-oracle-goldengate.html#GUID-F317FD3B-5078-47BA-A4EC-8A138C36BD59)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration, November 2020
* **Contributors** - Zia Khan
* **Last Updated By/Date** - Brian Elliott, November 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
