# HIGH AVAILABILITY - MYSQL INNODB CLUSTER

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

(optional) Step 1 opening paragraph.

1. Sub step 1

	![Image alt text](images/sample1.png)

2. Sub step 2

  ![Image alt text](images/sample1.png)

4. Example with inline navigation icon ![Image alt text](images/sample2.png) click **Navigation**.

5. Example with bold **text**.

   If you add another paragraph, add 3 spaces before the line.

## Task 1: Concise Step Description
7c) MySQL InnoDB Cluster 
Objectives: To create a 3 nodes MySQL InnoDB Cluster as Single Primary and have a trial on the MySQL Shell to configure and operate.  Using MySQL Router to test for Server routing and test for Failover.
•	Configure InnoDB Cluster in single primary
•	Configure mysql router
•	Test client connection with MySQL Router, read/write and read only
•	Simulate a crash of primary instance

NOTE: 
•	MySQL InnoDB cluster require at least 3 instances (refer to schema in the first part of the lab guide)
o	the source instance (on server) will be the primary
o	the replicated instance (on server) will be first secondary
o	the third instance (not yet installed) server will be installed on serverB
•	Please remember that in production you need different servers to exclude single point of failures




1.	Please remember that servers communication use full FQDN. To help you in later configuration, write here your environment. Be aware that subnets and domain names are different between instances
To find out FQDN on our lab machines you can use the following command

shell> hostname

ServerA FQDN _____________________________________

ServerB FQDN _____________________________________
This is for the LAB only.  Practically in production deployment, instances deployment should be on its own VM.  And the port number should be the same for easy configuration.
Production Recommended Deployment : Minimal 3 Instances 
Instance	FQDN	Port	Private IP
Primary
(prev. Source)	Student###-serverB	3307	10.0.0.___
Secondary-1
(prev. Replica)	Student###-serverA	3307	10.0.0.___
Secondary-2	Student###-serverB	3308	Same as primary

1.	Verify data model compatibility with Group replication requirements
On ServerB:
a.	Connect to instance

shell-primary> mysql -uroot -p -h127.0.0.1 -P3307

b.	Search non InnoDB tables and if there are you must change them. For this lab just drop them

mysql-primary> SELECT table_schema, table_name, engine, table_rows, (index_length+data_length)/1024/1024 AS sizeMB FROM information_schema.tables WHERE engine != 'innodb' AND table_schema NOT IN ('information_schema', 'mysql', 'performance_schema');

c.	Search InnoDB tables without primary or unique key. In production you have to fix, here it's enough that you drop them

mysql-primary> select tables.table_schema, tables.table_name, tables.engine, tables.table_rows
from information_schema.tables
left join (
select table_schema, table_name
from information_schema.statistics
group by table_schema, table_name, index_name
having
sum(
case
when non_unique = 0
and nullable != 'YES' then 1
else 0
end
) = count(*)
) puks
on tables.table_schema = puks.table_schema
and tables.table_name = puks.table_name
where puks.table_name is null
and tables.table_type = 'BASE TABLE' and engine='InnoDB';

mysql-primary> DROP TABLE world.jtest;

mysql-primary> DROP TABLE world. city_part;

 
2.	On ServerA : To create a cluster we need 3 nodes. We use now source as PRIMARY and replication server as first SECONDARY (we call it now secondary-1). Thanks to replication, instance on secondary-1 it's ready for cluster. Now just stop replication on replica/secondary-1

a.	Connect with administrative account

shell-secondary-1> mysql -uroot -p -h127.0.0.1 -P3307

b.	Stop and remove the replication and the server is ready to be used

mysql-secondary-1> stop slave;
mysql-secondary-1> reset slave;
3.	Now we need a third instance, we create a new one on serverB
Note : IN PRODUCTION USE THREE DIFFERENT SERVERS TO EXCLUDE SINGLE POINT OF FAILURES !

On ServerB: Prepare an empty instance inside /mysql02/ that be used as a clone of the primary one. 

Because it’s just a duplicate of the command that you already did in detailed installation, we provide you a script that do it for you. The script
	Crate a copy of /mysql structure inside /mysql02
	Create a symbolic link to binaries in /mysql/
	Create a my.cnf customized for the new structure and on different port (3308)
	Initialize the database
	Start the new instance
	Set root password
	Create admin user
	Install required plugins
a.	Please run the script (be careful with copy&paste)

shell> /workshop/support/lab7c-MySQL_InnoDB_Cluster___Prepare_secondary-2.sh

b.	Please have a look of /mysql02/etc/my.cnf content. Because there are other, we need to change server-id, mysql ports and references to the new folders

shell> cat /mysql02/etc/my.cnf

c.	Verify that new instance is up and running

shell-secondary2> netstat -an | grep 3308

d.	Login to verify that the instance is accessible and empty

shell-secondary2> mysql -uadmin -p -h127.0.0.1 -P 3308

mysql-secondary2> SHOW DATABASES;

mysql-secondary2> exit


4.	On serverB: Now we can create the cluster. We can do it from any server.
a.	Connect with SSH on primary and open the MySQL Shell

shell-primary> mysqlsh

b.	Check the instance configuration

MySQL JS > dba.checkInstanceConfiguration('admin@student###-serverB:3307')
If the check may return errors, we use MySQL Shell to fix with the command. e.g.
{
    "config_errors": [
        {
            "action": "server_update",
            "current": "CRC32",
            "option": "binlog_checksum",
            "required": "NONE"
        }
    ],
    "status": "error"
}
MySQL JS > dba.configureInstance('admin@student###-serverB:3307')
 ![Image alt text](images/ha-replicate-create-1.png)

c.	Just to be sure, re-check the instance configuration and verify that you receive an "ok" message

MySQL JS > dba.checkInstanceConfiguration('admin@student###-serverB:3307')

The instance 'primary:3307' is valid for InnoDB cluster usage.

{
    "status": "ok"
}


d.	Connect to the instance and create the cluster.    
MySQL JS > \connect admin@student###-serverB:3307
MySQL JS > var cluster = dba.createCluster('testCluster')

 ![Image alt text](images/ha-replicate-create-2.png)
 
 5.	Verify cluster status (why "Cluster is NOT tolerant to any failures" ?)
MySQL JS > cluster.status()
 ![Image alt text](images/ha-replicate-create-3.png)

6.	Add the second server to the cluster (running on “serverA”)
a.	Check the instance configuration, and probably it produces the same error as the first ‘primary:3307’

MySQL JS > dba.checkInstanceConfiguration('admin@student###-serverA:3307')

b.	Use MySQL Shell to fix issues
MySQL JS > dba.configureInstance('admin@student###-serverA:3307')
c.	Add the instance to the cluster
MySQL JS > cluster.addInstance('admin@student###-serverA:3307')
 ![Image alt text](images/ha-replicate-create-4.png)

d.	Verify cluster status
MySQL JS > cluster.status()
 ![Image alt text](images/ha-replicate-create-5.png)

20.	Now we add the third node to cluster

a.	Check the instance configuration

MySQL JS > dba.checkInstanceConfiguration('admin@student###-serverB:3308')
 ![Image alt text](images/ha-replicate-create-6.png)

b.	If there are issues (we missed something…), read the messages and fix with
MySQL JS > dba.configureInstance('admin@student###-serverB:3308')
c.	Add the last instance to the cluster
MySQL JS > cluster.addInstance('admin@student###-serverB:3308')
d.	Because the instance is empty, we receive an alert. We use now the clone plugin
 ![Image alt text](images/ha-replicate-create-7.png)

e.	Type ‘C’ and confirm. This start the clone process
 ![Image alt text](images/ha-replicate-create-8.png)

2.	Verify cluster status, now with all three servers
MySQL JS > cluster.status()
 ![Image alt text](images/ha-replicate-create-8.png)

3.	Verify the new status. How do you recognize the Primary server?

4.	On serverB: Exit from MySQL Shell and install MySQL Router via rpm package (if you like mysqlrouter can be installed on serverA with the same steps)

5.	MySQL JS > \q
shell> sudo yum -y install /workshop/linux/mysql-router-commercial-8.0.25-1.1.el7.x86_64.rpm 
6.	On serverB: Configure MySQL Router
shell> sudo mysqlrouter --bootstrap admin@student###-serverB:3307 --user=mysqlrouter

7.	Have a look on the output. 

Read/Write Connections port: _____________

Read/Only Connections: __________________


8.	On serverB: Start MySQL Router 
shell> sudo mysqlrouter &
9.	Test the connection with a mysql client connect to 6446 port (read/write). 
To which server are you currently connected? ______________________
Can you change the content? _____________________
shell> mysql -uadmin -p -h127.0.0.1 -P6446 
mysql> SELECT @@hostname, @@port;
mysql> use newdb;
mysql> SHOW TABLES;
mysql> CREATE TABLE newtable (c1 int primary key);
mysql> INSERT INTO newtable VALUES(1);
mysql> INSERT INTO newtable VALUES(2);
mysql> SELECT * from newtable;
mysql> exit

10.	The second port of MySQL Router is used for read only sessions. Close session and re open on port 6447 (read only port).
To which server are you currently connected? ______________________
Can you change the content? _____________________

shell> mysql -uadmin -p -h127.0.0.1 -P6447 

mysql> SELECT @@hostname, @@port;

mysql> use newdb;

mysql> SELECT * from newtable;

mysql> INSERT INTO newtable VALUES(3);

mysql> show variables like '%read_only';

11.	On ServerB: Now we test failover when a crash happens to primary node.

a.	Connect to primary instance and keep this session open!!!

shell> mysql -uadmin -p -h127.0.0.1 -P6446 

mysql> SELECT @@hostname, @@port;

b.	Open a second SSH connection and simulate a crash killing primary instance. To do so retrieve process ID with one of these commands

shell> cat /mysql/data/student*.pid 

c.	the kill the process of primary instance to simulate a crash

shell> sudo kill -9 <process id from previous step>

d.	Return to mysql connection previously opened and verify if it works (first command fails, second works, why?)

mysql> SELECT @@hostname, @@port;

mysql> SELECT @@hostname, @@port;

mysql> INSERT INTO newdb.newtable VALUES(30);

mysql> SELECT * from newdb.newtable;

12.	From the shell where you killed the instance use MySQL Shell to verify cluster status (of course connect to a living instance)

shell> mysqlsh

MySQL JS > \c admin@student###-serverA:3307

MySQL JS > var cluster = dba.getCluster('testCluster')
MySQL JS > cluster.status()
13.	Optional: restart "crashed" instance and verify with MySQL Shell how it changes the status
MySQL JS > cluster.status()
## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
