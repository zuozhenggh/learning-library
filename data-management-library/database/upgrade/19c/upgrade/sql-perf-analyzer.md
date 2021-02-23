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

In this section of the Hands-On Lab you will use the SQL Performance Analyzer (SPA) which is part of Real Application Testing (RAT). You will compare statements collected before upgrade to a simulation of these statements after upgrade. You will use the SQL Tuning Sets collected earlier in the lab.

SQL Performance Analyzer

You have collected SQL statements from the first load of HammerDB earlier in this lab into two SQL Tuning Sets:

    STS_CaptureAWR
    STS_CaptureCursorCache

You will “test execute” now the statements of one of the SQL Tuning Sets (you can do both if time allows) and generate a comparison report.

At first, check how many statements you collected in the SQL Tuning Sets:

. upgr19
cd /home/oracle/scripts
sqlplus / as sysdba

Run this query:

select count(*), sqlset_name from dba_sqlset_statements group by sqlset_name order by 2;

Then start a completely scripted SQL Performance Analyzer run. It will:

    Convert the information from STS_CaptureAWR into the right format
    Simulate the execution of all statements in STS_CaptureAWR
    Compare before/after
    Report on the results – in this case based on CPU_TIME and ELAPSED_TIME
    There are more metrics available. See an overview here.

You will do two simulations using different comparison metrics for both, CPU_TIME and ELAPSED_TIME.

Start the an initial run for CPU_TIME with the script:

@/home/oracle/scripts/spa_cpu.sql

Afterwards generate the HTML Report containing the results:

@/home/oracle/scripts/spa_report_cpu.sql

Then repeat this for ELAPSED_TIME:

@/home/oracle/scripts/spa_elapsed.sql

Finally generate the HTML Report containing the results:

@/home/oracle/scripts/spa_report_elapsed.sql
exit

There will be now two html files in /home/oracle/scripts. Open them with Firefox:

cd /home/oracle/scripts
firefox compare_spa_* &

First of all, see the different comparison metrics in the report’s header:

 

*** This screenshot is just an example – you may see a very different report ***

You may recognize regressed statements and statements with plan changes (rightmost column):

But you may recognize also that the statements NOT marked in GREEN have been improved drastically, too.

Why are they not marked GREEN, too? The reason is the THRESHOLD of 2% I set:

You can change this value in the script /home/oracle/scripts/spa_elapsed.sql:

 

The statement in the screen shot is slightly better than before measured.

Now click on the first statement, 7m5h0wf6stq0q, and check the plan differences:

Scroll down to the two plans, BEFORE and AFTER:

“BATCHED” access means that the database retrieves a few row ids from the index, and then attempts to access rows in block order to improve the clustering and reduce the number of times that the database must access a block. This makes it run faster.

Feel free to check other examples in the report, too.

But this demonstrates that it is not always a good advice to deny plan changes as part of an upgrade. I repeated the ELAPSED run but set:

alter session set optimizer_features_enable=’11.2.0.4′;
@/home/oracle/scripts/spa_elapsed.sql

Then I regenerate the HTML Report containing the results:

@/home/oracle/scripts/spa_report_elapsed.sql
exit

And I open it with Firefox:

cd /home/oracle/scripts
firefox compare_spa_* &

Now there is no plane change, there is still an improvement as 19c seems to do something different internally. But we basically “lost” the improvement partially be using old optimizer parametrization.

The idea of such SPA runs is to accept the better plans and identify and cure the ones which are misbehaving.

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
