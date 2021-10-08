# INSTALL - MYSQL SHELL

## Introduction

Installation of MySQL 8 (Community) on Oracle Linux 7. Because by default RedHat install MariaDB so, we update the repository to install the original MySQL. ...

Estimated Time: -- minutes

### About <Product/Technology> (Optional)
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than to sections/paragraphs, please utilize the "Learn More" section.

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Install MySQL Community
* Objective 2
* Objective 3

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Task 1: Install MySQL Community

2d) MySQL Shell: the new client
Objective: Execute MySQL Shell and explore the interface: 
•	help
•	settings
•	test an extension: reporting
•	command mode
Server: serverB
Note: to close the MySQL Shell you can the commands “\q” or “\exit”

1.	Install Mysql Shell, a new client that can be used in devOps organizations (you’ll learn more about it during the course)

shell> sudo yum install /workshop/linux/mysql-shell-commercial-8.0.25-1.1.el7.x86_64.rpm 

2.	Launch MySQL shell
	shell> mysqlsh
3.	Discover the command auto-completion feature, type \h and press TAB twice 
	MySQL JS > \h [tab] [tab]
4.	Check the available options. Add the letter “e” to “\h” and press TAB again to see that the command will automatically complete for you. Press enter and explore the help menu
	MySQL JS > \he [tab]
5.	Activate the command history autosave in MySQL shell
MySQL Shell comes with the option of automatically saving the history of command disabled by default. Therefore we need to check and to activate it.
a.	Show settings and look for history.autoSave
	MySQL JS > shell.options
b.	activate autosave history
	MySQL JS > \option --persist history.autoSave=1
6.	Close and reopen the session and in the new one use the arrow up key to verify that the data from previous session are available

MySQL JS > \exit
shell> mysqlsh
7.	MySQL Shell can be used as SQL client
a.	Connect to the newly installed mysql-advanced instance. Enter the password when requested and press enter. When the prompt asks to save the password choose No and press Enter.

MySQL JS > \c admin@127.0.0.1:3307

b.	Switch to SQL mode
	
MySQL … JS > \sql

8.	Now you can submit SQL commands

MySQL … SQL > show databases;

MySQL … SQL > SELECT * FROM world.city LIMIT 10;

9.	But MySQL Shell has also nice features. Here we see one of them: reporting.
If you want to execute a command continuously use the command “query” (default refresh time: 5 seconds). 
To exit from reporting press CTRL+C

MySQL … SQL > \watch query show processlist;

MySQL … SQL > \watch query --interval=2 show processlist;

10.	Switch to Python command mode, then Javascript command mode, check how prompt change
	
MySQL … SQL > \py
MySQL … Py > \js
11.	Exit from MySQL Shell with “\q” or “\exit”
MySQL … JS > \q
12.	Command line connection from MySQL Client and MySQL Shell are similar (just specify  “--sql”). Try these

shell> mysql -uroot -p -h127.0.0.1 -P3307

mysql> SHOW DATABASES;

mysql> exit

shell> mysqlsh --sql -uroot -p -h127.0.0.1 -P3307

MySQL … SQL > SHOW DATABASES;

MySQL … SQL > \exit

13.	From now on, if you like, the labs may be completed with MySQL Shell instead of classic mysql client.


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
