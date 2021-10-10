# MYSQL BACKUP - LOGICAL BACKUP (MYSQLDUMP)

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
6a) MySQL logical backup (mysqldump)
Objective: explore how mysqldump works
Server: serverB
Notes:
•	We work now with mysql-advanced instance.
•	Reference:
o	https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html

1.	Create the export folder

shell> sudo mkdir -p /mysql/exports

shell> sudo chown mysqluser:mysqlgrp /mysql/exports/

shell> sudo chmod 770 /mysql/exports/

2.	Export all the data with mysqldump
shell> mysqldump -uroot -p -h127.0.0.1 -P3307 --single-transaction --events --routines --flush-logs --all-databases > /mysql/exports/full.sql

3.	Watch the content of the file /mysql/exports/full.sql

4.	Export employees database

shell> mysqldump -uroot -p -h127.0.0.1 -P3307 --single-transaction --set-gtid-purged=OFF employees > /mysql/exports/employees.sql

5.	Drop employees database

shell> mysql -uroot -p -h127.0.0.1 -P3307

mysql> DROP DATABASE employees;

mysql> show databases;

6.	Import the employees database

mysql> CREATE DATABASE employees;

mysql> exit

shell> mysql -uroot -p -h127.0.0.1 -P3307 employees < /mysql/exports/employees.sql

7.	Confirm database employees exist
shell> mysql -uroot -p -h127.0.0.1 -P3307
mysql> show tables in employees;

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
