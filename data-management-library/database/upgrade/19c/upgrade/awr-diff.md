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

n this part of the lab you will create AWR diff reports. Those reports give you a first indication about issues you may see (or performance improvements). It is important to compare periods which had roughly the same load and duration.

Index

    1. Generate Load
    2. AWR Diff Report

1. Generate Load

. upgr19
cd /home/oracle/scripts
sqlplus / as sysdba

At first, create an AWR snapshot BEFOREload, then AFTERload, and note down the snapshot numbers again.

@/home/oracle/scripts/snap.sql

Please NOTE down the snapshot number.

Now run the HammerDB load again as you did in:
https://mikedietrichde.com/hands-on-lab/hol-19c-load/

=> =>

=>

 

 

 

Once finished, create another AWR snapshot.

@/home/oracle/scripts/snap.sql

Please NOTE down the snapshot number.
AWR Diff Report

In the AWR Diff Report you will compare a snapshot period BEFORE upgrade to a snapshot period AFTER upgrade.

Call the AWR Diff script:

@?/rdbms/admin/awrddrpt.sql

And then interactively:

SQL> @?/rdbms/admin/awrddrpt.sql

Specify the Report Type
~~~~~~~~~~~~~~~~~~~~~~~
Would you like an HTML report, or a plain text report?
Enter 'html' for an HTML report, or 'text' for plain text
Defaults to 'html'
Enter value for report_type:

Hit RETURN

Instances in this Workload Repository schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DB Id      Inst Num	DB Name      Instance	  Host
------------ ---------- ---------    ----------   ------
* 72245725	 1	UPGR	     UPGR	  localhost.lo

Database Id and Instance Number for the First Pair of Snapshots
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Using	72245725 for Database Id for the first pair of snapshots
Using	       1 for Instance Number for the first pair of snapshots


Specify the number of days of snapshots to choose from
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Entering the number of days (n) will result in the most recent
(n) days of snapshots being listed.  Pressing  without
specifying a number lists all completed snapshots.


Enter value for num_days:

Type: 2
Hit RETURN

Now you need to define the first snapshot interval – please fill in the snapshot IDs you have noted down during the first HammerDB run:

Enter value for num_days: 2

Listing the last 2 days of Completed Snapshots
Instance     DB Name	  Snap Id	Snap Started	Snap Level
------------ ------------ ---------- ------------------ ----------

UPGR	     UPGR		110  20 Feb 2020 22:12	  1
				111  20 Feb 2020 22:39	  1
				112  20 Feb 2020 22:40	  1
				113  21 Feb 2020 00:05	  1
				114  21 Feb 2020 00:15	  1


Specify the First Pair of Begin and End Snapshot Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for begin_snap:

Type: 110 <== Your actual snapshot ID may be different – please check your notes!
Hit RETURN

  110
First Begin Snapshot Id specified: 110

Enter value for end_snap: 111
First End   Snapshot Id specified:

Type: 111 <== Your actual snapshot ID may be different – please check your notes!
Hit RETURN

 111




Instances in this Workload Repository schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DB Id      Inst Num	DB Name      Instance	  Host
------------ ---------- ---------    ----------   ------
* 72245725	 1	UPGR	     UPGR	  localhost.lo




Database Id and Instance Number for the Second Pair of Snapshots
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Using	72245725 for Database Id for the second pair of snapshots
Using	       1 for Instance Number for the second pair of snapshots


Specify the number of days of snapshots to choose from
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Entering the number of days (n) will result in the most recent
(n) days of snapshots being listed.  Pressing  without
specifying a number lists all completed snapshots.


Enter value for num_days2:

Type: 2
Hit RETURN

2

Listing the last day's Completed Snapshots
UPGR	     UPGR		110  20 Feb 2020 22:12	  1
				111  20 Feb 2020 22:39	  1
				112  20 Feb 2020 22:40	  1
				113  21 Feb 2020 00:05	  1
				114  21 Feb 2020 00:15	  1


Specify the Second Pair of Begin and End Snapshot Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for begin_snap2:

Type: 113 <== Your actual snapshot ID may be different – please check your notes!
Hit RETURN

 113

Enter value for end_snap2:

Type: 114 <== Your actual snapshot ID may be different – please check your notes!
Hit RETURN

 114



Specify the Report Name
~~~~~~~~~~~~~~~~~~~~~~~
The default report file name is awrdiff_1_110_1_113.html	To use this name,
press  to continue, otherwise enter an alternative.

Enter value for report_name:

Enter awrdiff and hit RETURN

<<< Wait until the HTML output has been generated >>>

exit

In your xterm start Mozilla Firefox with the awr diff report:

firefox /home/oracle/scripts/awrdiff*.html &

Compare things such as Wait Events etc. Watch out for significant divergence between the two runs, for instance the different redo sizes per run.

Browse also through the SQL statistics and see if you find remarkable differences between the two runs.

Overall, you won’t see any significant differences. The purpose of this lab exercise is simply that you recognize and remember how easy AWR Diff Reports can be generated when you have comparable workloads in your testing environments.


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
