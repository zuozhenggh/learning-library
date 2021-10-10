# MYSQL BACKUP - ENTERPRISE BACKUP

## Introduction

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### About <Product/Technology> (Optional)
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than to sections/paragraphs, please utilize the "Learn More" section.

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is necessary to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Task 1: Concise Step Description
6b) MySQL Enterprise Backup
Objective: explore how mysqlbackup works
Server: serverB
Notes:
•	We work now with mysql-advanced instance. [ student###-serverB:3307 ]
•	References:
o	https://dev.mysql.com/doc/mysql-enterprise-backup/8.0/en/mysqlbackup.tasks.html
o	https://dev.mysql.com/doc/mysql-enterprise-backup/8.0/en/mysqlbackup.privileges.html



1.	MySQL Enterprise Backup is now available inside MySQL Enterprise Distributions like a tool, so you don’t have to install it.

2.	Create directories to store backups
shell> sudo mkdir -p /backupdir/full

shell> sudo mkdir /backupdir/compressed

shell> sudo chown -R mysqluser:mysqlgrp /backupdir

shell> sudo chmod 770 -R /backupdir

3.	Create a user in mysql-advanced with grants options for backup. To simplify user creations we have a script with minimal grants for this user (see the manual for additional privileges required for specific features like TTS, SBT integration, encrypted). You can also have a look on the privileges opening the file /workshop/support/mysqlbackup_user_grants.sql

shell> mysql -uroot -p -h127.0.0.1 -P3307

mysql> CREATE USER 'mysqlbackup'@'%' IDENTIFIED BY 'Welcome1!';

mysql> source /workshop/support/mysqlbackup_user_grants.sql;

mysql> exit

4.	Create a full backup (be careful with copy&paste!). 

shell> sudo /mysql/mysql-latest/bin/mysqlbackup --port=3307 --host=127.0.0.1 --protocol=tcp --user=mysqlbackup --password --backup-dir=/backupdir/full backup-and-apply-log

5.	Create a second backup with compression (be careful with copy&paste!)

shell> sudo /mysql/mysql-latest/bin/mysqlbackup --port=3307 --host=127.0.0.1 --protocol=tcp --user=mysqlbackup --password --backup-dir=/backupdir/compressed --compress backup-and-apply-log

6.	Because these backups are created with sudo, change the permissions

shell> sudo chown -R mysqluser:mysqlgrp /backupdir/full

shell> sudo chown -R mysqluser:mysqlgrp /backupdir/compressed

7.	Have a look of the content of the backup folders

shell> cd /backupdir/full

shell> ls -l

shell> cd /backupdir/compressed

shell> ls -l

8.	Check the size of the two backups, the one uncompressed and the one compressed

shell> cd /backupdir

shell> du -sh *

9.	Restore
a.	Stop the server

shell> sudo systemctl stop mysqld-advanced	

b.	(destroy time!) empty datadir and binary log dir
shell> sudo rm -rf /mysql/binlog/* /mysql/data/*
	
c.	Restore the backup (be careful with copy&paste!)

shell> sudo /mysql/mysql-latest/bin/mysqlbackup --defaults-file=/mysql/etc/my.cnf --backup-dir=/backupdir/full/ --datadir=/mysql/data --log-bin=/mysql/binlog/binlog copy-back

d.	Set ownership
shell> sudo chown -R mysqluser:mysqlgrp /mysql/data /mysql/binlog

shell> sudo chmod -R 750 /mysql/data /mysql/binlog


e.	Start the server

shell> sudo systemctl start mysqld-advanced

a.	verify that content is still there

shell> mysql -uroot -p -h127.0.0.1 -P3307

mysql> SHOW DATABASES;


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
