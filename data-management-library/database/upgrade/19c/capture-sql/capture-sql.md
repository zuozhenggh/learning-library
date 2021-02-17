# Query Your Data

## Introduction

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

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

In order to collect SQL Statements directly from AWR (Automatic Workload Repository) you’ll call a SQL script which:

    Creates a SQL Tuning Set (STS)
    Populates the STS with SQL information stored in AWR

The script is stored in /home/oracle/scripts:

    capture_awr.sql

In your open SQL*plus session connected to UPGR run:

@/home/oracle/scripts/capture_awr.sql

The number of statements in SQL Tuning Set “STS_CaptureAWR” will be displayed.
Collect Statements from Cursor Cache

You can also collect statements directly from the Cursor Cache. This is more resource intense but helpful in case of OLTP applications. Be careful when you poll the cursor cache too frequently.

This procedure:

    Creates a SQL Tuning Set (STS)
    Populates the STS with SQL statements/information from the cursor cache
    It will poll the cursor cache for 240 seconds every 10 seconds

The script is stored in /home/oracle/scripts:

    capture_cc.sql

You have used it already when you ran HammerDB before.
Hence, no need to run it again.

@/home/oracle/scripts/capture_cc.sql —don’t run it again!!!

The number of statements in SQL Tuning Set “STS_CaptureCursorCache” will be displayed.

But now check, how many statements you’ve collected in each SQL Tuning Set:

select name, owner, statement_count from dba_sqlset;
Export AWR

Especially when you migrate databases, exporting and preserving the AWR is important. When you upgrade, the AWR will stay in the database. This exercise is only done for protection but not necessary for the flow of the lab.

Export the AWR with:

@?/rdbms/admin/awrextr.sql

Databases in this Workload Repository schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   DB Id     DB Name	  Host
------------ ------------ ------------
* 72245725   UPGR	  localhost.lo
			  caldomain


The default database id is the local one: '72245725'.  To use this
database id, press  to continue, otherwise enter an alternative.

Enter value for dbid:

Hit RETURN.

Using 72245725 for Database ID


Specify the number of days of snapshots to choose from
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Entering the number of days (n) will result in the most recent
(n) days of snapshots being listed.  Pressing  without
specifying a number lists all completed snapshots.


Enter value for num_days:

Type: 2
Hit RETURN.

Enter value for num_days: 2

Listing the last 2 days of Completed Snapshots

DB Name        Snap Id	  Snap Started
------------ --------- ------------------
UPGR		   110 20 Feb 2020 22:12
		   111 20 Feb 2020 22:39
		   112 20 Feb 2020 22:40


Specify the Begin and End Snapshot Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for begin_snap:

Type: 110 <= Your snapshot number may be different
Hit RETURN.

Specify the Begin and End Snapshot Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for begin_snap: 110
Begin Snapshot Id specified: 110

Enter value for end_snap:

Type: 112 <= Your snapshot number may be different
Hit RETURN.

End   Snapshot Id specified: 112


Specify the Directory Name
~~~~~~~~~~~~~~~~~~~~~~~~~~


Directory Name		       Directory Path
------------------------------ -------------------------------------------------
DATA_PUMP_DIR		       /u01/app/oracle/admin/UPGR/dpdump/
ORACLE_OCM_CONFIG_DIR	       /u01/app/oracle/product/11.2.0.4/ccr/hosts/localhost.localdomain/state
ORACLE_OCM_CONFIG_DIR2	       /u01/app/oracle/product/11.2.0.4/ccr/state
PREUPGRADE_DIR		       /u01/app/oracle/cfgtoollogs/UPGR/preupgrade
XMLDIR			       /u01/app/oracle/product/11.2.0.4/rdbms/xml



Choose a Directory Name from the above list (case-sensitive).

Enter value for directory_name:

Type: DATA_PUMP_DIR
Hit RETURN

Enter value for directory_name: DATA_PUMP_DIR

Using the dump directory: DATA_PUMP_DIR

Specify the Name of the Extract Dump File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The prefix for the default dump file name is awrdat_64_71.
To use this name, press  to continue, otherwise enter
an alternative.

Enter value for file_name:

Hit RETURN

Using the dump file prefix: awrdat_64_71
|
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|  The AWR extract dump file will be located
|  in the following directory/file:
|   /u01/app/oracle/product/UPGR/dpdump/
|   awrdat_110_112.dmp
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|
|  *** AWR Extract Started ...
|
|  This operation will take a few moments. The
|  progress of the AWR extract operation can be
|  monitored in the following directory/file:
|   /u01/app/oracle/product/UPGR/dpdump/
|   awrdat_110_112.log 
| End of AWR Extract

This will take now a few minutes.

Exit from SQL*Plus:

exit

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
