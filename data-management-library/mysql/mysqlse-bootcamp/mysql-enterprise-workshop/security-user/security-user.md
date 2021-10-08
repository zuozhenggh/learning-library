# SECURITY - MYSQL USERS

## Introduction

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Time: -- minutes

### About <Product/Technology> (Optional)
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than to sections/paragraphs, please utilize the "Learn More" section.

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Task 1: Concise Step Description
3a) Users management
Objective: explore user creation and privileges
Server: 
•	serverA as client
•	serverB as server
Notes: 
•	use two shell, one per server
•	Write here your linux Private IP on student###-serverB 

serverA  PRIVATE ip: ___________________________________ (client_ip)

serverB  PRIVATE ip: ___________________________________ (server_ip)



1.	Connect to your mysql-advanced with administrative user

shell> mysql -uroot -p -h 127.0.0.1 -P 3307

a.	Create a new user and restrict the user to your “serverA” IP

mysql> CREATE USER 'appuser'@<client_ip> IDENTIFIED BY 'Welcome1!';

mysql> GRANT ALL PRIVILEGES ON world.* TO 'appuser'@<client_ip>;

mysql> SHOW GRANTS FOR 'appuser'@<client_ip>;

2.	Open a new SSH connection on serverA and from there connect to mysql-advanced with appuser

a.	Install mysql client 

shell> sudo yum install /workshop/linux/client/*.rpm

b.	connect to mysql-advanced with appuser

shell> mysql -u appuser -p -h <server_ip> -P 3307

c.	Run a select on the tables e.g. 

mysql> USE world;

mysql> SELECT * FROM city;

3.	Switch to the administrative connection revoke privilege on city to appuser

mysql> REVOKE SELECT ON world.* FROM 'appuser'@<client_ip>;

mysql> SHOW GRANTS FOR 'appuser'@<client_ip>;

4.	Repeat the select on appuser connection for the user. There is a difference?

	mysql> SELECT * FROM city; 

5.	Close and reopen the appuser connection for the user, then repeat above commands. There is a difference? 

	mysql> exit
	
shell> mysql -u appuser -p -h <server_ip> -P 3307

mysql> USE world; 
	
mysql> SELECT * FROM city; 

6.	Switch to the administrative connection revoke ‘USAGE’ privilege using and administrative connection and verify (tip: this privilege can’t be revoked…)

mysql> REVOKE USAGE ON *.* FROM 'appuser'@<client_ip>;

mysql> SHOW GRANTS FOR 'appuser'@<client_ip>;

7.	Using the administrative connection revoke all privileges using and administrative connection and verify
mysql> REVOKE ALL PRIVILEGES ON *.* FROM 'appuser'@<client_ip>;

mysql> SHOW GRANTS FOR 'appuser'@<client_ip>;
   
8.	Close and reopen appuser session, do you see schemas?

9.	Using the administrative connection restore user privileges to reuse it in next labs
mysql> GRANT ALL PRIVILEGES ON world.* TO 'appuser'@<client_ip>;

10.	Using the administrative connection, what are your password settings?
mysql> SHOW VARIABLES LIKE 'validate_password%';

11.	Try to set unsecure passwords for appuser
mysql> alter user 'appuser'@<client_ip> identified by 'appuser';

mysql> alter user 'appuser'@<client_ip> identified by 'Welcome';

mysql> alter user 'appuser'@<client_ip>identified by 'We1!';

12.	Expire the password for appuser
mysql> alter user 'appuser'@<client_ip> PASSWORD EXPIRE;

13.	Close and reopen connection to mysql-advanced and try to submit a command. What changed?
shell> mysql –u appuser -p -h <server_ip> -P 3307

mysql> SHOW DATABASES;

mysql> alter user 'appuser'@<client_ip> identified by 'Welcome1!'

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
