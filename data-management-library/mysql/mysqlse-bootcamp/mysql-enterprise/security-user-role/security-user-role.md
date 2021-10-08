# SECURITY - MYSQL USER ROLES

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
3b) MySQL Roles
Objective: Discover and Configure roles
Server: serverB
1.	Reconnect as root to create a new user

shell> mysql -u admin -p -h 127.0.0.1 -P 3307

mysql> CREATE USER 'appuser2'@'%' IDENTIFIED BY 'Welcome1!';

mysql> SHOW GRANTS FOR 'appuser2'@'%';

2.	Now create a new role and grant it to the new user

mysql> CREATE ROLE 'app_read';
	
mysql> GRANT SELECT ON world.* TO 'app_read';

	mysql> GRANT 'app_read' TO 'appuser2'@'%';

	mysql> SHOW GRANTS FOR 'appuser2'@'%';

3.	Reconnect as appuser2 and submit some commands (you receive errors, why?)

shell> mysql -u appuser2 -p -h 127.0.0.1 -P 3307

mysql> SHOW DATABASES; 

mysql> SELECT COUNT(*) FROM world.city;

mysql> SELECT current_role();

4.	Set the role for the user and repeat above commands

mysql> SET ROLE ALL;

mysql> SELECT current_role();

mysql> SHOW DATABASES; 

mysql> SELECT COUNT(*) FROM world.city;

5.	We can also assign a default role to don’t ask to set one after every login (you can use user or administrative session)

mysql> ALTER USER 'appuser2'@'%' DEFAULT ROLE 'app_read';


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
