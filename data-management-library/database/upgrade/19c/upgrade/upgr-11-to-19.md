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

n this part of the Lab you will upgrade the UPGR database from Oracle 11.2.0.4 to Oracle 19c. You can find detailed steps including the output for a Multitenant upgrade here for your information only in case you can’t complete the lab here.

In earlier version of the lab we did ask you to do a manual command line upgrade. This time you will use the AutoUpgrade and upgrade your UPGR database unattended.
Index

    1. Preparation
    2. ANALYZE Phase
    3. DEPLOY Phase

1. Preparation

The only task you’ll have to do when using the AutoUpgrade: You need to prepare a config file for the database(s).
The environment variable $OH19 is created only for your convenience. It points always to the Oracle 19c Home.

. upgr
java -jar $OH19/rdbms/admin/autoupgrade.jar -create_sample_file config

This tells you that the sample file has been created at:

Created sample configuration file /home/oracle/scripts/sample_config.cfg

You will need to edit it – and then pass it to the AutoUpgrade utility.

Created sample configuration file /home/oracle/sample_config.cfg

Open the file /home/oracle/sample_config.cfg in your preferred editor (text or graph mode)

    Text mode:

    vi /home/oracle/scripts/sample_config.cfg
    Graphical mode:

    kwrite /home/oracle/scripts/sample_config.cfg &

Adjust the following things:
Generated standard config.cfg 	Make the following adjustments:

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
upg1.upgrade_node=hol1.localdomain
upg1.target_version=19
#upg1.run_utlrp=yes
#upg1.timezone_upg=yes

	

#Global configurations
#Autoupgrade's global directory, ...
#temp files created and other ...
#send here
global.autoupg_log_dir=/home/oracle/upg_logs

#
# Database number 1 
# 
upg1.dbname=UPGR
upg1.start_time=NOW
upg1.source_home=/u01/app/oracle/product/11.2.0.4
upg1.target_home=/u01/app/oracle/product/19
upg1.sid=UPGR
upg1.log_dir=/home/oracle/logs
upg1.upgrade_node=localhost
upg1.target_version=19
upg1.restoration=no

Then save the file and name it as UPGR.cfg in /home/oracle/scripts.

If you saved it under its original name, sample_config.cfg, rename it as shown below:

mv /home/oracle/scripts/sample_config.cfg /home/oracle/scripts/UPGR.cfg
2. ANALYZE Phase

It is best practice to run AutoUpgrade in analyze mode at first. Once the analyze phase is passed without issues, the database can be upgraded automatically (the below command is a one-line command!).

. upgr
java -jar $OH19/rdbms/admin/autoupgrade.jar -config /home/oracle/scripts/UPGR.cfg -mode analyze

You will see this output:

Autoupgrade tool launched with default options
+--------------------------------+
| Starting AutoUpgrade execution |
+--------------------------------+
1 databases will be analyzed
Type 'help' to list console commands
upg>

You can monitor the analyze phase in the upg> job console with:

lsj

status -job 100

Shortly after, the console will reply:

upg> Job 100 completed

------------------- Final Summary --------------------
Number of databases            [ 1 ]

Jobs finished successfully     [1]
Jobs failed                    [0]
Jobs pending                   [0]
------------- JOBS FINISHED SUCCESSFULLY -------------
Job 100 FOR UPGR

The database can be upgraded automatically.
3. Upgrade

When you initiate the upgrade with -mode deploy, the tool will repeat the analyze phase, but add the fixups, upgrade and postupgrade steps.

java -jar $OH19/rdbms/admin/autoupgrade.jar -config /home/oracle/scripts/UPGR.cfg -mode deploy

You will see this output:

Autoupgrade tool launched with default options
+--------------------------------+
| Starting AutoUpgrade execution |
+--------------------------------+
1 databases will be processed
Type 'help' to list console commands
upg>

At this point you can monitor the upgrade now – enlarge the xterm‘s width a bit to see no line wraps.

Type help on the upg> job console to see an overview of available commands.

help

upg> help
exit                          // To close and exit
help                          // Displays help
lsj [(-r|-f|-p|-e) | -n ]     // list jobs by status up to n elements.
	-f Filter by finished jobs.
	-r Filter by running jobs.
	-e Filter by jobs with errors.
	-p Filter by jobs being prepared.
	-n  Display up to n jobs.
lsr                           // Displays the restoration queue
lsa                           // Displays the abort queue
tasks                         // Displays the tasks running
clear                         // Clears the terminal
resume -job                   // Restarts a previous job that was running
status [-job  [-long]]        // Lists all the jobs or a specific job
restore -job                  // Restores the database to its state prior to the upgrade
restore all_failed            // Restores all failed jobs to their previous states prior to the upgrade
logs                          // Displays all the log locations
abort -job                    // Aborts the specified job
h[ist]                        // Displays the command line history
/[]                           // Executes the command specified from the history. The default is the last command

The most important commands are:

        lsj – this lists the job number and overview information about each active job.
        Please note that the job number has now changed for the -mode deploy run.

    lsj

    upg> lsj
    +----+-------+---------+---------+--------+--------------+--------+--------+-------------+
    |Job#|DB_NAME|    STAGE|OPERATION|  STATUS|    START_TIME|END_TIME| UPDATED|      MESSAGE|
    +----+-------+---------+---------+--------+--------------+--------+--------+-------------+
    | 101|   UPGR|PREFIXUPS|EXECUTING| RUNNING|19/10/17 23:15|     N/A|23:15:28|Remaining 3/3|
    +----+-------+---------+---------+--------+--------------+--------+--------+-------------+
    Total jobs 2

    status -job <number> – this gives you more information about a specific job.
    It displays you also where the log files are located.

        status -job 101

        upg> status -job 101
        Progress
        -----------------------------------
        Start time:      19/10/17 23:16
        Elapsed (min):   1
        End time:        N/A
        Last update:     2019-10-17T23:16:58.468
        Stage:           PREFIXUPS
        Operation:       EXECUTING
        Status:          RUNNING
        Pending stages:  6
        Stage summary: 
            SETUP             <1 min 
            PREUPGRADE        <1 min 
            PRECHECKS         <1 min 
            GRP               <1 min 
            PREFIXUPS         <1 min (IN PROGRESS)

        Job Logs Locations
        -----------------------------------
        Logs Base:    /home/oracle/upg_logs/UPGR
        Job logs:     /home/oracle/upg_logs/UPGR/101
        Stage logs:   /home/oracle/upg_logs/UPGR/101/prefixups
        TimeZone:     /home/oracle/upg_logs/UPGR/temp

        Additional information
        -----------------------------------
        Details:
        +--------+----------------+-------+
        |DATABASE|           FIXUP| STATUS|
        +--------+----------------+-------+
        |    UPGR|DICTIONARY_STATS|STARTED|
        +--------+----------------+-------+

        Error Details:
        None

    logs – displays the logs folder

        logs

        Autoupgrade logs folder [/home/oracle/upg_logs/cfgtoollogs/upgrade/auto/config_files]
        logs folder [UPGR][/home/oracle/upg_logs/UPGR]
        Please open a second xterm tab and go to the logs folder.

        cd /home/oracle/upg_logs/UPGR/101

        Explore the subdirectories, especially /home/oracle/upg_logs/UPGR/101 and below.
        Check the /home/oracle/upg_logs/UPGR/101/prechecks subdirectory. It contains an HTML file with the preupgrade check overview:

        cd prechecks
        firefox upgr_preupgrade.html &

        Check also the preupgrade.log within the same directory:

        more upgr_preupgrade.log
        Now change the directoy and see whether the dbupgrade directory has been created. This usually takes up to 4 minutes until the prechecks and fixups have been completed. You will find the 4 upgrade worker’s logs in cd /home/oracle/upg_logs/UPGR/101/dbupgrade.These 4 subdirectories get created before dbupgrade:

        prechecks
        prefixups
        preupgrade
        drain

        You can tail -f especially the main worker’s (ending with 0) log to display the upgrade progress.

        cd ../dbupgrade
        tail -f catupgrd*0.log

        Interrupt the tail command with CTRL+C.

Depending on the hardware, the upgrade will take about 25-35 minutes. You don’t have to wait but instead we will do some exercises now with the AutoUpgrade tool.
The upgrade will take between 20-40 minutes to complete.

upg> Job 101 completed
------------------- Final Summary --------------------
Number of databases            [ 1 ]

Jobs finished successfully     [1]
Jobs failed                    [0]
Jobs pending                   [0]
------------- JOBS FINISHED SUCCESSFULLY -------------
Job 101 FOR UPGR

Congratulations – you upgraded the UPGR database successfully from Oracle 11.2.0.4 to Oracle 19c.


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
