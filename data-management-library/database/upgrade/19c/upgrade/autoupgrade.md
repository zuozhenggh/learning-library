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

You did use the AutoUpgrade already. So this exercise is OPTIONAL.

In this OPTIONAL part of the lab you will upgrade two other databases

You can upgrade Oracle 11.2.0.4 databases and newer to:

    Oracle 12.2.0.1 with Release Update January 2019 or newer
    Oracle 18.5.0 or newer
    Oracle 19.5.0 or newer

Index

    1. Preparation
    2. Generate and edit the config file
    3. Analyze Mode
    4. Deploy Mode

1. Preparation

The database DB12 needs to be started at first.

. db12
sqlplus / as sysdba

startup
exit
2. Generate and edit the config file

java -jar $OH19/rdbms/admin/autoupgrade.jar -create_sample_file config

This will create a sample config file. You will need to edit it – and then pass it to the AutoUpgrade utility.

Created sample configuration file /home/oracle/scripts/sample_config.cfg

Open the file /home/oracle/scripts/sample_config.cfg in your preferred editor and adjust the following things:
Generated config.cfg 	Make the following adjustments:

#Global configurations
#Autoupgrade's global directory, ...
#temp files created and other ...
#send here
global.autoupg_log_dir=/default/...

#
# Database number 1 
#
upg1.dbname=employee
upg1.start_time=NOW
upg1.source_home=/u01/...
upg1.target_home=/u01/...
upg1.sid=emp
upg1.log_dir=/scratch/auto
upg1.upgrade_node=node1
upg1.target_version=19.1
#upg1.run_utlrp=yes
#upg1.timezone_upg=yes

	

#Global configurations
#Autoupgrade's global directory, ...
#temp files created and other ...
#send here
global.autoupg_log_dir=/home/oracle/logs


#
# Database number 1 
#
upg1.dbname=DB12
upg1.start_time=NOW
upg1.source_home=/u01/app/oracle/product/12.2.0.1
upg1.target_home=/u01/app/oracle/product/19
upg1.sid=DB12
upg1.log_dir=/home/oracle/logs
upg1.upgrade_node=localhost
upg1.target_version=19
upg1.restoration=no

Then save the file as config.cfg to /home/oracle/scripts.

If you don’t want to edit the file by yourself, there’s a config file for DB12 stored already:

/home/oracle/scripts/DB12.cfg

Just ensure that you adjust the below calls to call DB12.cfg instead of config.cfg.
3. Analyze

You could run the autoupgrade directly, but it is best practice to run an analyze at first. Once the analyze phase is passed without issues, the database can be upgraded automatically.

java -jar $OH19/rdbms/admin/autoupgrade.jar -config /home/oracle/scripts/config.cfg -mode analyze

You will see this output:

Autoupgrade tool launched with default options
+--------------------------------+
| Starting AutoUpgrade execution |
+--------------------------------+
1 databases will be analyzed
Type 'help' to list console commands
upg> Job 100 completed
------------------- Final Summary --------------------
Number of databases            [ 1 ]

Jobs finished successfully     [1]
Jobs failed                    [0]
Jobs pending                   [0]
------------- JOBS FINISHED SUCCESSFULLY -------------
Job 100 FOR DB12

The database can be upgraded automatically.
4. Deploy mode

When you initiate the upgrade now with -mode deploy, the tool will repeat the analyze phase, but add the fixups, upgrade and postupgrade steps.

java -jar $OH19/rdbms/admin/autoupgrade.jar -config /home/oracle/scripts/config.cfg -mode deploy

You will see this output:

Autoupgrade tool launched with default options
+--------------------------------+
| Starting AutoUpgrade execution |
+--------------------------------+
1 databases will be processed
Type 'help' to list console commands
upg>

At this point you can monitor the upgrade now – enlarge the xterm’s width a bit to see no line wraps.
The most important commands are:

    lsj – this lists the job number and overview information about each active job

        upg> lsj
        +----+-------+---------+---------+-------+--------------+--------+--------+-------+
        |Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|MESSAGE|
        +----+-------+---------+---------+-------+--------------+--------+--------+-------+
        | 101|   DB12|DBUPGRADE|EXECUTING|RUNNING|19/05/12 21:44|     N/A|21:46:38|Running|
        +----+-------+---------+---------+-------+--------------+--------+--------+-------+

    status -job <number> – this gives you more information about a specific job

You can also monitor the logs in /home/oracle/logs/DB12/101. In the ./dbupgrade subdirectory you will find the usual upgrade logs of each worker.

Depending on your hardware, the upgrade will take 20-45 minutes. You don’t have to wait for the next step but instead can progress with Plugin UPGR into CDB2.

Execute the lsj command a while later:

upg> lsj
+----+-------+---------+---------+-------+--------------+--------+--------+------------+
|Job#|DB_NAME|    STAGE|OPERATION| STATUS|    START_TIME|END_TIME| UPDATED|     MESSAGE|
+----+-------+---------+---------+-------+--------------+--------+--------+------------+
| 101|   DB12|DBUPGRADE|EXECUTING|RUNNING|19/05/12 21:44|     N/A|21:59:10|39%Upgraded |
+----+-------+---------+---------+-------+--------------+--------+--------+------------+

The AutoUpgrade utility will complete also the recompilation, the time zone change and update password file, spfile and /etc/oratab.

The final output will look like this:

upg> Job 101 completed
------------------- Final Summary --------------------
Number of databases            [ 1 ]

Jobs finished successfully     [1]
Jobs failed                    [0]
Jobs pending                   [0]
------------- JOBS FINISHED SUCCESSFULLY -------------
Job 101 FOR DB12

Compatible Change

As a final step, as the upgrade completed successfully, you should adjust the COMPATIBLE parameter. It does not affect the Optimizer behavior:

alter system set COMPATIBLE='19.0.0' scope=spfile;
shutdown immediate
startup
exit

Congratulations – you upgraded the DB12 database successfully with the new AutoUpgrade to Oracle 19c.


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
