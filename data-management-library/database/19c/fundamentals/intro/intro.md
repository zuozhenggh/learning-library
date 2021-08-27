# Introduction

## About Oracle Database 19c

Oracle Database 19c provides the most advanced SQL engine on the planet. It complies with the latest ISO SQL standard, making it not only the most comprehensive database but also the most open one. It supports highly sophisticated analytics alongside and with no impact on OLTP workloads, eliminating the need to develop and orchestrate complex, fragile, and inconsistent data movement between different specialized data stores. Oracle’s SQL engine ships with integrated machine learning algorithms and allows developers to easily apply them on the data directly, hence moving the computation to the data—rather than having to pull the data out of the database and perform the calculation within the application. Using this capability, developers can create real-time prediction models directly on the data itself and act on insights more quickly and easily than ever before.

[](youtube:LcsPSJrZDrI)

Oracle Database 19c supports fully consistent data with ACID transaction guarantees and consistent queries. This greatly simplifies application development compared to NoSQL stores. Native JSON support makes up a cornerstone for flexible schema support and Internet of Things (IoT)workloads, enabling developers to simply load JSON documents into the database natively and analyze them later on, with the full power of Oracle SQL. Oracle’s PL/SQL engine is yet another powerful tool for bringing computations to the data and providing an easy and standardized interface to them via simple SQL function or procedure calls. Interfaces such as REST allow for easy communication and integration with Oracle Database. These can be created automatically on top of tables, as well as stored procedures, giving developers the flexibility on how and what data to expose to consuming services.

Extend this with the move to autonomy provided by Oracle Autonomous Database, a self-driving, self-securing, and self-repairing approach where the database itself decides on the steps to perform for the best of the user's workload or data. Machine learning algorithms are used to help the database to decide how to tune a workload, how to secure the data, and how to take countermeasures to preserve the agreed-on SLA levels.

With the Oracle Autonomous Database, developers can fully concentrate on the applications they write and the business’s requirements, rather than having to think about the data tier. And to make this even easier the Oracle Autonomous Database environment can be provisioned in minutes with a few simple clicks or an API call to the Oracle Cloud.

## About the Oracle Database 19c New Features Workshop

This workshop lets you try out new features in Oracle Database 19c. All of the labs are independent of each other, so you don't need to do them in any particular order. If needed, a lab starts with instructions on how to prepare your environment, and ends with instructions on how to restore your environment back to its original state. For most lab steps, you enter a command in the Terminal window. For database actions, you use SQL*Plus.

> **Note**: Currently, we have a set of labs that cover general database overall enhancements. Over time, more labs will be added to this workshop.

### General Database Overall Enhancement Labs

The following labs are available:

- Install Oracle Database 19c with Automatic Root Script Execution
- Clone a PDB by Using DBCA in Silent Mode
- Relocate a PDB by Using DBCA in Silent Mode
- Duplicate a CDB by Using DBCA in Silent Mode
- Decrease the Transportable Tablespace (TTS) Import and Export Time
- Omit the Column Encryption Attribute During Import
- Use RMAN to Connect to a PDB to Use the Recovery Catalog
- Explore Automatic Deletion of Flashback Logs

## About Your Workshop Environment

During the workshop, you use two Linux compute instances named `workshop-staged` and `workshop-installed`. Both compute instances have a noVNC desktop, which provides an easy-to-use interface.

- The `workshop-staged` compute instance has the Oracle Database 19c installer files (release 19.12) staged on it. Only the **Install Oracle Database 19c with Automatic Root Script Execution** lab uses this compute instance. The rest of the labs use the `workshop-installed` compute instance.
- The `workshop-installed` compute instance has Oracle Database 19c (release 19.12) already installed on it with two CDBs (CDB1 and CDB2). CDB1 has one pluggable database named PDB1 with sample data. CDB2 has no PDBs. CDB1, PDB1, and CDB2 are configured to use the default listener, which is called LISTENER. The listener and the database instances are configured to automatically start on boot. Lab files are stored in the `/home/oracle/labs/19cnf` directory.

On both compute instances, you work as the `oracle` user (password is `Ora4U_1234`).

## Troubleshooting the `workshop-staged` compute instance

If you made an error while installing the database during the **Install Oracle Database 19c with Automatic Root Script Execution** lab, you cannot easily undo the changes made to the compute instance. It is fastest to obtain a fresh `workshop-staged` compute instance and try the lab again.

## Troubleshooting the `workshop-installed` compute instance

### Start the default listener

In the event that you are unable to connect to CDB1, PDB1, or CDB2 on your `workshop-installed` compute instance, you can do the following to check the status of the default listener and start it if needed:

1. Use the Listener Control Utility to verify whether the default listener is started. Look for `status READY` for CDB1, PDB1, and CDB2 in the Services Summary.

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

2. If the default listener is not started, run the following command to start it.

    ```
    LSNRCTL> <copy>lsnrctl start</copy>
    ```

### Restore your lab files

In the event that you accidentally changed one or more of your lab files on your `workshop-installed` compute instance and need to restore them, you can follow these steps:

1. Open a terminal window.

2. Change to the `~/labs/19cnf` directory.

    ```
    $ <copy>cd ~/labs/19cnf</copy>
    ```

3. Unzip the `19cnf-lab-files.zip` file and replace the files in the directory.

    ```
    $ <copy>unzip -o 19cnf-lab-files.zip</copy>
    ```

4. Set the execute permission on all of the lab files.

    ```
    $ <copy>chmod -R +x ~/labs/19cnf</copy>
    ```


## Acknowledgements

- **Author**- Jody Glover, Principal User Assistance Developer, Database Development
- **Last Updated By/Date** - Jody Glover, Database team, August 27 2021
