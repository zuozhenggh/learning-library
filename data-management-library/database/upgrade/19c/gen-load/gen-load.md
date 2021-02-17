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

In this part of the Hands-On Lab we will generate some application load on the UPGR database. We’ll use an external load tool, HammerDB. The lab has version 3.3 installed. Documentation for HammerDB can be found here. You can use your own load scripts as well when you run the lab by yourself.
1. Generate an AWR snapshot

Open an xterm – double-click on the TERMINAL icon:

Then switch the environment to . upgr, change to /home/oracle/scripts and start SQL*Plus:

. upgr
cd /home/oracle/scripts
sqlplus / as sysdba

Execute snap.sql which generates an AWR snapshot:

startup
@/home/oracle/scripts/snap.sql

Please NOTE down the snapshot number (e.g.: 110)

Don’t exit from the xterm. Leave SQL*Plus open.
2. Start HammerDB

Double-Click on the HammerDB icon on the desktop:

3. Load Driver Script and start Virtual Users

Click on the triangle “TPC-C“:

 

Open the Driver Script setup with a Click:

 

Then Double-Click on the Load option.


This will populate the script window with the driver script (ignore the error messages in the script window):

 

Click on Virtual Users:

 

Now Double-Click on Create – you should see then 3 Virtual Users being started below the script window:

4. Capture SQL from Cursor Cache

Please start the following script in your SQL*plus window. With this script you’ll capture now all SQL Statements directly from cursor cache while HammerDB is running and generating load on your database:

@/home/oracle/scripts/capture_cc.sql

The capture is scheduled for 240 seconds. It polls the cache every 10 seconds.
5. Start TPC-C Load Test and Monitor the progress

Double-Click on the Run icon:

 

Then Click on the Graph / Transaction Counter icon in the top menu icon bar:

You’ll see that the script window changes now waiting for data.
It takes a few seconds, then you’ll see the performance charts and the transactions-per-minute (tpm):

 

The load run usually takes 2-3 minutes until it completes:

 

Note the Complete=1 per Virtual User underneath the graph.

We will use this load only to generate some statements.
6. Close HammerDB

Finally Exit HammerDB:

 
7. Generate another AWR snapshot

Please WAIT until the capture_cc.sql scripts returns control back to you – DON’T CTRL-C it!

In the existing sqlplus create another AWR snapshot once the command prompt is visible:

@/home/oracle/scripts/snap.sql

Please NOTE down the snapshot number (e.g. 111).
Additional Information

You can modify the standard parameters in either the GUI tool or as defaults in config.xml located in:
/home/oracle/HammerDB-3.3

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
