## Introduction
This Lab walks you through the steps to keep your Oracle Database software up-to-date.
Estimated Lab Time: 15 minutes

### Objectives

*List objectives for the lab - if this is the intro lab, list objectives for the workshop*

In this lab, you will:
* Uninstall Oracle Database

## **STEP 1**: Uninstall Oracle Database
If you want to remove an Oracle software installation, you can use the deinstallation tool to completely uninstall the software from your computer.

1. Log on to your computer as a member of the administrative group that is authorized to deinstall Oracle Database software.

2. Open a terminal and change the current working directory to ORACLE_HOME. The ORACLE_HOME is by default set to your installation directory.
```
<copy>
$ export ORACLE_HOME=/scratch/u01/app/oracle/product/21.0.0/dbhome_1
$ cd $ORACLE_HOME
</copy>
```
3. Invoke the deinstallation tool by using this command:
```
<copy>
$ $ORACLE_HOME/deinstall/deinstall
</copy>
```
**OUTPUT**
```
<copy>
Checking for required files and bootstrapping ...
Please wait ...
Location of logs /tmp/deinstall_2020-10-13_11-50-04-PM/logs/

############ ORACLE DECONFIG TOOL START ############

######################### DECONFIG CHECK OPERATION START #########################
## [START] Install check configuration ##

Checking for existence of the Oracle home location /scratch/u01/app/oracle/product/21.0.0/dbhome_1
Oracle Home type selected for deinstall is: Oracle Single Instance Database
Oracle Base selected for deinstall is: /scratch/u01/app/oracle
Checking for existence of central inventory location /scratch/u01/app/oraInventory

## [END] Install check configuration ##

Network Configuration check config START

Network de-configuration trace file location: /scratch/u01/app/oraInventory/logs/netdc_check2020-10-13_11-46-24PM.log

</copy>
```

4. In the terminal, when prompted to enter the instance listeners that you want to de-configure, accept the default value by pressing **Enter**.
```
<copy>
Specify all Single Instance listeners that are to be de-configured. Enter .(dot) to deselect all. [LISTENER]: Enter
</copy>
```
**OUTPUT**
```
<copy>
Network Configuration check config END

Database Check Configuration START

Database de-configuration trace file location: /scratch/u01/app/oraInventory/logs/databasedc_check2020-10-13_11-46-24PM.log

</copy>
```
5. In the terminal, when prompted to enter the database names that are configured in this Oracle home, accept the default value by pressing **Enter**.
```
<copy>
Use comma as separator when specifying list of values as input
Specify the list of database names that are configured in this Oracle home [orcl]: Enter
</copy>
```
**OUTPUT**
```
<copy>
###### For Database 'orcl' ######

Single Instance Database
The diagnostic destination location of the database: /scratch/u01/app/oracle/diag/rdbms/orcl
Storage type used by the Database: FS
Database file location: /scratch/u01/app/oracle/oradata/ORCL
Fast recovery area location: Does not exist
database spfile location: /scratch/u01/app/oracle/dbs/spfileorcl.ora

</copy>
```
6. In the terminal, when prompted to modify the details of the discovered database, accept the default by pressing **Enter**.
```
<copy>
The details of database(s) orcl have been discovered automatically.
Do you still want to modify the details of orcl database(s)? [n]: Enter
</copy>
```
**OUTPUT**
```
<copy>
Database Check Configuration END
Oracle Configuration Manager check START
OCM check log file location : /tmp/deinstall2019-05-05_09-32-20AM/logs//ocm_check8037.log
Oracle Configuration Manager check END

######################### DECONFIG CHECK OPERATION END #########################

####################### DECONFIG CHECK OPERATION SUMMARY #######################
Oracle Home selected for deinstall is: /scratch/u01/app/oracle/product/21.0.0
Inventory Location where the Oracle home registered is: /scratch/u01/app/oraInventory
Following Single Instance listener(s) will be de-configured: LISTENER
The following databases were selected for de-configuration. The databases will be deleted and will not be useful upon de-configuration : orcl
Database unique name : orcl
Storage used : FS
Do you want to continue (y - yes, n - no)? [n]: y
A log of this session will be written to: '/scratch/u01/app/oraInventory/logs/deinstall_deconfig2020-10-13_11-50-04-PM.out'
Any error messages from this session will be written to: '/scratch/u01/app/oraInventory/logs/deinstall_deconfig2020-10-13_11-50-04-PM.err'
</copy>
```

7. In the terminal, enter **y**, when asked if you want to continue.
```
<copy>
Do you want to continue (y - yes, n - no)? [n]: y
</copy>
```


8. The Oracle software is successfully uninstalled.

*At the conclusion of the lab add this statement:*
You may proceed to the next lab.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Sayantani Ghosh, Principal UA Developer>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
