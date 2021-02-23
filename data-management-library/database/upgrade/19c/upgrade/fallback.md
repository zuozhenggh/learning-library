# Query Your Data

## Introduction

In the Fallback Strategies part of our Hands-On Lab you will explore different Fallback Strategies. For this exercise you will use the FTEX database, an Oracle 11.2.0.4 database.

We divide the Fallback Strategies for database upgrades basically in two areas:

    Protection for issues during upgrade
    Protection for issues after upgrade

In each section you will be able to try two different fallback techniques.

Generally it is very important to take some considerations.
Considerations

HOL 19c Fallback Strategies

You’ll have to protect your environment for issues during, but also after the upgrade. And of course you’ll have to consider and maintain the Service Level Agreements about fallback requirements in seconds, minutes, hours or days. In addition it is very important to be aware that some of the fallback strategies won’t allow to change COMPATIBLE. This means, you will need extra downtime to change COMPATIBLE afterwards as it requires a restart of the database(s).

The minimum COMPATIBLE setting in Oracle Database 19c is “11.0.0“. Keep COMPATIBLE at 3 digits. The default COMPATIBLE setting in Oracle Database 19c is “19.0.0".

We won’t cover RMAN Online Backups as we assume that everybody is doing RMAN backups anyways. And we won’t cover Oracle GoldenGate as this would go beyond the lab possibilities. We may add this in a later stage.

Estimated Lab Time: n minutes

### About Product/Technology
Enter background information here..

### Objectives

*List objectives for the lab - if this is the intro lab, list objectives for the workshop*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

*Use this section to describe any prerequisites, including Oracle Cloud accounts, set up requirements, etc.*

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Item no 2 with url - [URL Text](https://www.oracle.com).

*This is the "fold" - below items are collapsed by default*

## **STEP 1**: title

Protection for issues during upgradeHOL 19c - Fallback - Issues During the Upgrade

In this part you’ll use two techniques to protect your database for issues happening during the upgrade. Or simply, if you’d like to test multiple times.

You will evaluate two options: Partial Offline Backups and Guaranteed Restore Points.

HOL 19c - Fallback - Issues During the Upgrade
1. Partial Offline Backup

A partial offline backup is used for protection against failures during the upgrade or for testing purposes to avoid the restoration of an entire database environment. You can change the COMPATIBLE parameter if you want with this technique. But don’t do it in the lab now as you’ll use two techniques in parallel.

    Very large databases where restoring just a small piece of the database is faster than an entire restore
    Databases who are – on purpose – in NOARCHIVELOG mode, hence you can’t do an online backup and restore
    Standard Edition databases where you can’t use Guaranteed Restore Points

For a Partial Offline Backup as fallback strategy, you’ll have to put all your user and data tablespaces into read-only mode, then create an offline backup of the “heart” of your database.

You’ll do the following exercises with the FTEX database in the Hands-On Lab.

    At first, set the USERS tablespace read-only and then SHUTDOWN the database:
    .

    . ftex
    sqlplus / as sysdba

    startup
    alter tablespace USERS read only;
    insert into SYSTEM.TRACKING_TAB values (1,'partial offline backup');
    commit;
    shutdown immediate
    exit
    Then copy the “heart of the database” to a backup location
    Execute the “backupFTEX.sh” script:
    .

    . /home/oracle/scripts/backupFTEX.sh

    ##
    ## This is for INFORMATION only 
    ## Don't execute - this is all done by the copyFTEX.sh above
    ## --
    ## The script copies redologs, controlfiles and all files for UNDO, TEMP, SYSTEM and SYSAUX
    ## to: /home/oracle/fast_recovery_area/FTEX/bck

    cp /u02/oradata/FTEX/*.log /home/oracle/FTEX/bck
    cp /u02/oradata/FTEX/*.ctl /home/oracle/FTEX/bck
    cp /u02/oradata/FTEX/sys*.dbf /home/oracle/FTEX/bck
    cp /u02/oradata/FTEX/temp*.dbf /home/oracle/FTEX/bck
    cp /u02/oradata/FTEX/undo*.dbf /home/oracle/FTEX/bck

    Startup the database in 19c and upgrade it
    .

    cd $ORACLE_HOME/dbs
    . ftex19
    cp spfileFTEX.ora $ORACLE_HOME/dbs
    cp orapwFTEX $ORACLE_HOME/dbs
    sqlplus / as sysdba

    startup upgrade
    exit

    dbupgrade -l /home/oracle/logs
    After 2-3 minutes, CTRL-C the upgrade and try the fallback
    .
    Once the upgrade is running, wait until the first phases have been completed, then hit:

    CTRL+C

    ...
    **************   Catproc Procedures   **************
    Parallel Phase #:13   [FTEX] Files:94   Time: 12s
    Restart  Phase #:14   [FTEX] Files:1    Time: 0s
    Parallel Phase #:15   [FTEX] Files:117  Time: 20s
    Restart  Phase #:16   [FTEX] Files:1    Time: 1s
    Serial   Phase #:17   [FTEX] Files:17   Time: 3s
    Restart  Phase #:18   [FTEX] Files:1    Time: 0s
    *****************   Catproc Views   ****************
    Parallel Phase #:19   [FTEX] Files:32 ^Ccatcon::catcon_HandleSigINT: Signal INT was received.

    The upgrade failed.
    Now first of all, try out the RESUME of the upgrade driver:

    dbupgrade -R -l /home/oracle/logs

    The upgrade should start from where it had been stopped.

    *******Upgrade being restarted on database FTEX from failed phase 19*******

    ------------------------------------------------------
    Phases [19-108]         Start Time:[2018_08_03 15:24:17]
    ------------------------------------------------------
       Time: 2s
    *****************   Catproc Views   ****************
    Parallel Phase #:19   [FTEX] Files:32   Time: 31s
    Restart  Phase #:20   [FTEX] Files:1    Time: 0s
    Serial   Phase #:21   [FTEX] Files:3    Time: 19s
    Restart  Phase #:22   [FTEX] Files:1    Time: 0s

    Let the upgrade fail a second time:

    CTRL+C

    Restart  Phase #:20   [FTEX] Files:1    Time: 0s
    Serial   Phase #:21   [FTEX] Files:3    Time: 19s
    Restart  Phase #:22   [FTEX] Files:1    Time: 0s
    Parallel Phase #:23   [FTEX] Files:24   Time: 283s
    Restart  Phase #:24   [FTEX] Files:1    Time: 1s
    Parallel Phase #:25   [FTEX] Files:12 ^Ccatcon::catcon_HandleSigINT: Signal INT was received.

    Then SHUTDOWN the database and RESTORE it.
    Check the content of the TRACKING_TAB:

    sqlplus / as sysdba

    shutdown immediate
    exit

    . /home/oracle/scripts/restoreFTEX.sh
    . ftex
    sqlplus / as sysdba

    startup
    select * from TRACKING_TAB;
    exit

Now you completed the first exercise.

You can watch the video as well:

2. Flashback to a Guaranteed Restore Point

By far the best and most simple technique to protect your databases are Guaranteed Restore Points. But it can only used when the following requirements are all met:

    Database must be in ARCHIVELOG mode
    Enterprise Edition database (or XE or PE)
    Don’t change COMPATIBLE

This is the overview on how to fallback with a guaranteed restore point GRP1 which allows you to flashback your database – many times.

    Turn on ARCHIVELOG mode:
    .

    . ftex
    sqlplus / as sysdba

    shutdown immediate;
    startup mount
    alter database archivelog;
    alter database open;
    archive log list
    Set a Guaranteed Restore Point
    .

    insert into SYSTEM.TRACKING_TAB values (2,'guaranteed restore point');
    commit;
    create restore point GRP1 guarantee flashback database;
    shutdown immediate
    exit
    Switch to the 19c environment and upgrade the FTEX database:
    .

    . ftex19
    sqlplus / as sysdba

    startup upgrade
    exit

    dbupgrade -l /home/oracle/logs -n 2

    This will now take 15-30 minutes depending on your hardware equipment.

    If you don’t want to wait so long, you can CTRL-C the upgrade at any point, and FLASHBACK to the restore point without taking the second one. u .

     

    sqlplus / as sysdba

    @?/rdbms/admin/utlrp.sql
    @/u01/app/oracle/cfgtoollogs/FTEX/preupgrade/postupgrade_fixups.sql
    insert into SYSTEM.TRACKING_TAB values (3,'upgrade completed');
    commit;
    select * from TRACKING_TAB;
    Set a new GRP and then flashback to the GRP to before-upgrade. The FLASHBACK DATABASE happens in the new environment, the OPEN of the database (in this case READ ONLY – alternative would be OPEN RESETLOGS) in the source environment:
    .

    create restore point GRP2 guarantee flashback database;
    shutdown immediate
    startup mount
    flashback database to restore point GRP1;
    shutdown immediate
    exit

    . ftex
    sqlplus / as sysdba

    startup open read only;
    select * from TRACKING_TAB;

    Do you recognize that the database has been flashed back to “before upgrade” in less than a minute? You could open it RESETLOGS and repeat the upgrade.
    But FLASHBACK DATABASE works in all directions, backwards and forward (even though forward may take a bit longer now):
    .

    shutdown immediate
    exit

    . ftex19
    sqlplus / as sysdba

    startup mount
    flashback database to restore point GRP2;
    alter database open resetlogs;
    select * from TRACKING_TAB;

    Even though you opened the database with OPEN RESETLOGS you can repeat the FLASHBACK DATABASE operations as often as you’d like.
    Take also note of the components which exist now in the database:
    .

    select COMP_ID, STATUS from DBA_REGISTRY order by COMP_ID;
    Clean up and drop the restore points as otherwise at some point you’ll run out of archive space. In addition you’ll turn off ARCHIVELOG mode now as we won’t need it for the next exercises:
    .

    drop restore point GRP1;
    drop restore point GRP2;
    shutdown immediate
    startup mount
    alter database noarchivelog;
    alter database open;
    archive log list
    exit

You successfully completed the second part of the Fallback Strategies lab.

Finally you may please watch the Youtube video as well:


Protection for issues after upgrade
HOL 19c - Fallback - Issues After Upgrade

In this part you’ll use again two techniques to protect your database, but this time for issues happening after the upgrade. You can call this also “Downgrade“.
1. Downgrade with a Full Database Export and Import
HOL 19c - Fallback - Issues After Upgrade

For this part you’ll just start the export from the 19c database after upgrading.

    Run the full database export:
    .

    . ftex19
    sqlplus / as sysdba

    insert into SYSTEM.TRACKING_TAB values (4,'full export downgrade');
    commit;
    select * from TRACKING_TAB;
    exit

    expdp system/oracle DIRECTORY=EXP18 DUMPFILE=down.dmp LOGFILE=down.log VERSION=12.2 FULL=Y REUSE_DUMPFILES=Y EXCLUDE=STATISTICS LOGTIME=ALL

    The important part is that the VERSION parameter tells Data Pump to create an export in the format a database of “VERSION” will understand.
    In this case you will downgrade into a 12.2 Pluggable Database. You need to create the PDB first.
    .

    . cdb1
    sqlplus / as sysdba

    startup
    create pluggable database PDB3 admin user adm identified by adm file_name_convert=('pdbseed','pdb3');
    alter pluggable database PDB3 open;
    create directory IMP18 as '/home/oracle/IMP';
    grant read, write on directory IMP18 to public;
    exit

    impdp system/oracle@PDB3 DIRECTORY=IMP18 DUMPFILE=down.dmp LOGFILE=impdown.log LOGTIME=ALL

This was a quick exercise. Of course it would take longer the more data and objects your database contains. Especially LOB data types can be crucial.
2. Downgrade with the downgrade scripts

HOL 19c - Fallback - Issues After Upgrade

In this final exercise you’ll use a powerful technique, the database downgrade with downgrade scripts.

    Set a marker in the database
    .

    . ftex19
    sqlplus / as sysdba

    insert into SYSTEM.TRACKING_TAB values (5,'database downgrade');
    commit;
    Run the downgrade script
    .

    shutdown immediate
    startup downgrade
    set echo on termout on serveroutput on timing on
    spool /home/oracle/logs/downgrade.log
    @?/rdbms/admin/catdwgrd.sql
    shutdown immediate
    exit
    Switch to the source environment and start he bootstrap reload script
    .

    . ftex
    sqlplus / as sysdba

    startup upgrade
    set echo on termout on timing on
    spool /home/oracle/logs/relod.log
    @?/rdbms/admin/catrelod.sql
    shutdown immediate
    Final steps and checks
    .

    startup
    @?/rdbms/admin/utlrp.sql
    select * from TRACKING_TAB;
    select count(*) from DBA_OBJECTS where STATUS=’INVALID’;
    select COMP_ID, STATUS from DBA_REGISTRY order by COMP_ID;

    The downgrade should have removed the XDB component as well. Did it?

You can watch an entire database downgrade in this short video as well:


You may now [proceed to the next lab](#next).

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
