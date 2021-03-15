# Generate Application Load

## Introduction

In this part you’ll generate application load on the UPGR database before upgrade. You will use an external load tool, HammerDB.  In a later stage we’ll compare statements and overall performance before/after upgrade.  You can use your own load scripts as well.

Estimated Lab Time: n minutes

### About AWR Snapshots
The Automatic Workload Repository (AWR) collects, processes, and maintains performance statistics for problem detection and self-tuning purposes. This data is both in memory and stored in the database. The gathered data can be displayed in both reports and views.

The statistics collected and processed by AWR include:
- Object statistics that determine both access and usage statistics of database segments
- Time model statistics based on time usage for activities, displayed in the V$SYS_TIME_MODEL and V$SESS_TIME_MODEL views
- Some of the system and session statistics collected in the V$SYSSTAT and V$SESSTAT views
- SQL statements that are producing the highest load on the system, based on criteria such as elapsed time and CPU time
- ASH statistics, representing the history of recent sessions activity

Snapshots are sets of historical data for specific time periods that are used for performance comparisons by ADDM. By default, Oracle Database automatically generates snapshots of the performance data once every hour and retains the statistics in the workload repository for 8 days. You can also manually create snapshots. In this lab we will manually create snapshots.

### Objectives

In this lab, you will:
* Generate an AWR snapshot
* Start HammerDB
* Load Driver Script and start virtual users
* Capture sql, load test and monitor
* Generate another AWR snapshot

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## **STEP 1**: Generate an AWR snapshot

1. Login to the Oracle Cloud
2. Start VNC
3. Open an xterm by double-clicking on the TERMINAL icon
4. Switch the environment to . upgr, change to /home/oracle/scripts and start SQL*Plus:

    ````
    <copy>
    . upgr
    cd /home/oracle/scripts
    sqlplus / as sysdba
    </copy>
    ````

5.  Execute snap.sql which generates an AWR snapshot.  Please NOTE down the snapshot number (e.g.: 110)

    ````
    <copy>
    startup
    @/home/oracle/scripts/snap.sql
    </copy>
    ````

6. Don’t exit from the xterm. Leave SQL*Plus open.

## **Step 2**: Start HammerDB

1. Double-Click on the HammerDB icon on the desktop to start Hammer DB

## **Step 3**: Load Driver Script and start Virtual Users

1. Click on the triangle “TPC-C“:
2. Open the Driver Script setup with a Click:
3. Then Double-Click on the Load option.
4. This will populate the script window with the driver script (ignore the error messages in the script window):
5. Click on Virtual Users.  Now Double-Click on Create – you should see then 3 Virtual Users being started below the script window:

## **Step 4**: Capture SQL, Load Test and Monitor

Please start the following script in your SQL*plus window. With this script you’ll capture now all SQL Statements directly from cursor cache while HammerDB is running and generating load on your database.

1. Run the capture script. The capture is scheduled for 240 seconds. It polls the cache every 10 seconds.

   
    ````
    <copy>
    @/home/oracle/scripts/capture_cc.sql
    </copy>
    ````

2. Start TPC-C Load Test and Monitor the progress by double clicking on the Run icon:

3. Click on the Graph / Transaction Counter icon in the top menu icon bar. You’ll see that the script window changes now waiting for data.

4. It takes a few seconds, then you’ll see the performance charts and the transactions-per-minute (tpm). The load run usually takes 2-3 minutes until it completes:

5. Note the Complete=1 per Virtual User underneath the graph.  We will use this load only to generate some statements.

6. Finally Exit HammerDB:

 
## **Step 5**: Generate another AWR snapshot

Please WAIT until the capture_cc.sql scripts returns control back to you – DON’T CTRL-C it!

1. In the existing sqlplus create another AWR snapshot once the command prompt is visible execute the sql script below.  Please NOTE down the snapshot number (e.g. 111).

    ````
    <copy>
    @/home/oracle/scripts/snap.sql
    </copy>
    ````

## Additional Information

You can modify the standard parameters in either the GUI tool or as defaults in config.xml located in:
/home/oracle/HammerDB-3.3

You may now [proceed to the next lab](#next).

## Learn More

* [HammerDB](https://www.hammerdb.com/)
* [AWR Snapshots](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgdba/gathering-database-statistics.html#GUID-144711F9-85AE-4281-B548-3E01280F9A56)

## Acknowledgements
* **Author** - Mike Dietrich, Database Product Management
* **Contributors** -  Roy Swonger, Database Product Management
* **Last Updated By/Date** - Kay Malcolm, February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
