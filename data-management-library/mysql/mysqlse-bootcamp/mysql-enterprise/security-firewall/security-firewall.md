# SECURITY - MYSQL ENTERPRISE FIREWALL

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
3c) MySQL Enterprise Firewall
Objective: Firewall in action…
Server: serverB
Notes:
•	References
o	https://dev.mysql.com/doc/refman/8.0/en/firewall-installation.html



1.	Install MySQL Enterprise Firewall on mysql-advanced using CLI (you can’t install on mysql-gpl, why? 

________________________________________________________________________

shell> mysql -uadmin -p -P3307 -h127.0.0.1 < /mysql/mysql-latest/share/linux_install_firewall.sql

2.	Connect to the instance with administrative account first SSH connection - administrative
shell> mysql -uroot -p -P3307 -h127.0.0.1
mysql> SHOW GLOBAL VARIABLES LIKE 'mysql_firewall_mode';

mysql> SHOW GLOBAL STATUS LIKE "firewall%";

3.	Create a new user 'fwtest' and assign full privileges to database world

mysql> CREATE USER 'fwtest'@'%' IDENTIFIED BY 'Welcome1!';

mysql> GRANT ALL PRIVILEGES ON world.* TO 'fwtest'@'%';

4.	Now we set firewall in recording mode, to create a white list and verify that allowlist is empty

mysql> CALL mysql.sp_set_firewall_mode('fwtest@%', 'RECORDING');

mysql> SELECT * FROM mysql.firewall_users;

mysql> SELECT * FROM mysql.firewall_whitelist;

5.	Open a second SSH connection (don't close the administrative one) and use it to connect as “fwtest” and submit some commands
shell> mysql -ufwtest -p -P3307 -h127.0.0.1
mysql> USE world;

mysql> SELECT * FROM city limit 25;

mysql> SELECT Code, Name, Region FROM country WHERE population > 200000;

6.	Administrative connection: Return to admin session (first SSH connection terminal) and verify that there are now rules in allowlist (noticed that we interrogate temporary rules from information schema) 

mysql> SELECT * FROM information_schema.mysql_firewall_whitelist;

7.	Administrative connection: switch Firewall mode from 'recording' to 'protecting' and verify the presence of rules in allowlist

mysql> CALL mysql.sp_set_firewall_mode('fwtest@%', 'PROTECTING');

mysql> SELECT * FROM mysql.firewall_whitelist;

8.	fwtest connection: run these commands. Which one’s work? Which ones fail and why?

mysql> USE world;

mysql> SELECT * FROM city limit 25;

mysql> SELECT Code, Name, Region FROM country WHERE population > 200000;

mysql> SELECT * FROM countrylanguage;

mysql> SELECT Code, Name, Region FROM country WHERE population > 500000;

mysql> SELECT Code, Name, Region FROM country WHERE population > 200000 or 1=1;

9.	Administrative connection: set firewall in detecting mode in your 

mysql> CALL mysql.sp_set_firewall_mode('fwtest@%', 'DETECTING');

mysql> SET GLOBAL log_error_verbosity=3;

10.	fwtest connection: Repeat a blocked command (it works? Why? ___________________)
mysql> SELECT Code, Name, Region FROM world.country WHERE population > 200000 or 1=1;

mysql> exit

11.	Search the error in the error log
shell> grep "MY-011191" /mysql/log/err_log.log

12.	Administrative connection: disable firewall for the user Check the Status of Firewall on the command line. Disabling firewall doesn't delete rules.
mysql> CALL mysql.sp_set_firewall_mode('fwtest@%', 'OFF');

mysql> SELECT MODE FROM INFORMATION_SCHEMA.MYSQL_FIREWALL_USERS WHERE USERHOST = 'fwtest@%';

mysql> SELECT RULE FROM INFORMATION_SCHEMA.MYSQL_FIREWALL_WHITELIST WHERE USERHOST = 'fwtest@%';

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
