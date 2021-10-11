# HIGH AVAILABILITY - MYSQL INNODB CLUSTER

7c) MySQL InnoDB Cluster 
Objectives: To create a 3 nodes MySQL InnoDB Cluster as Single Primary and have a trial on the MySQL Shell to configure and operate.  Using MySQL Router to test for Server routing and test for Failover.
•	Configure InnoDB Cluster in single primary
•	Configure mysql router
•	Test client connection with MySQL Router, read/write and read only
•	Simulate a crash of primary instance
## Introduction

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes


### Objectives



In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites 



This lab assumes you have:
* An Oracle account
* All previous labs successfully completed

**NOTE:** 
- MySQL InnoDB cluster require at least 3 instances (refer to schema in the first part of the lab guide)
- the source instance (on server) will be the primary
- the replicated instance (on server) will be first secondary
- the third instance (not yet installed) server will be installed on serverB
- Please remember that in production you need different servers to exclude single point of failures



## Task 1: Concise Step Description


1.	Please remember that servers communication use full FQDN. To help you in later configuration, write here your environment. Be aware that subnets and domain names are different between instances
To find out FQDN on our lab machines you can use the following command

shell> hostname

ServerA FQDN

ServerB FQDN
This is for the LAB only.  Practically in production deployment, instances deployment should be on its own VM.  And the port number should be the same for easy configuration.
Production Recommended Deployment : Minimal 3 Instances 
Instance	FQDN	Port	Private IP
Primary
(prev. Source)	Student###-serverB	3307	10.0.0.___
Secondary-1
(prev. Replica)	Student###-serverA	3307	10.0.0.___
Secondary-2	Student###-serverB	3308	Same as primary

2.	Verify data model compatibility with Group replication requirements
On ServerB:
    a.	Connect to instance

    shell-primary> mysql -uroot -p -h127.0.0.1 -P3307
    ```
    <copy>exit</copy>
    ```
    b.	Search non InnoDB tables and if there are you must change them. For this lab just drop them

    mysql-primary> SELECT table_schema, table_name, engine, table_rows, (index_length+data_length)/1024/1024 AS sizeMB FROM information_schema.tables WHERE engine != 'innodb' AND table_schema NOT IN ('information_schema', 'mysql', 'performance_schema');
    ```
    <copy>exit</copy>
    ```
    c.	Search InnoDB tables without primary or unique key. In production you have to fix, here it's enough that you drop them

    **mysql-primary>** 
     ```
    <copy> select tables.table_schema, tables.table_name, tables.engine, tables.table_rows
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
    and tables.table_type = 'BASE TABLE' and engine='InnoDB';</copy>
    ```
    mysql-primary> DROP TABLE world.jtest;

    ```
    <copy>exit</copy>
    ```
    mysql-primary> DROP TABLE world. city_part;

    ```
    <copy>exit</copy>
    ```
 
2.	On ServerA : To create a cluster we need 3 nodes. We use now source as PRIMARY and replication server as first SECONDARY (we call it now secondary-1). Thanks to replication, instance on secondary-1 it's ready for cluster. Now just stop replication on replica/secondary-1

    a.	Connect with administrative account

    shell-secondary-1> mysql -uroot -p -h127.0.0.1 -P3307

    ```
    <copy>exit</copy>
    ```
    b.	Stop and remove the replication and the server is ready to be used

    mysql-secondary-1> stop slave;
    
    ```
    <copy>exit</copy>
    ```
    mysql-secondary-1> reset slave;
    
    ```
    <copy>exit</copy>
    ```
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

    ```
    <copy>exit</copy>
    ```
    b.	Please have a look of /mysql02/etc/my.cnf content. Because there are other, we need to change server-id, mysql ports and references to the new folders

    shell> cat /mysql02/etc/my.cnf

    ```
    <copy>exit</copy>
    ```
    c.	Verify that new instance is up and running

    shell-secondary2> netstat -an | grep 3308

    ```
    <copy>exit</copy>
    ```
    d.	Login to verify that the instance is accessible and empty

    shell-secondary2> mysql -uadmin -p -h127.0.0.1 -P 3308

    ```
    <copy>exit</copy>
    ```
    mysql-secondary2> SHOW DATABASES;

    ```
    <copy>exit</copy>
    ```
    mysql-secondary2> exit

    ```
    <copy>exit</copy>
    ```

4.	On serverB: Now we can create the cluster. We can do it from any server.
    a.	Connect with SSH on primary and open the MySQL Shell

    shell-primary> mysqlsh

    ```
    <copy>exit</copy>
    ```
    b.	Check the instance configuration

    MySQL JS >

    ```
    <copy>
    dba.checkInstanceConfiguration('admin@student###-serverB:3307')
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
    }</copy>
    ```
    MySQL JS > dba.configureInstance('admin@student###-serverB:3307')
    
    ```
    <copy>exit</copy>
    ```
 ![Image alt text](images/ha-replicate-create-1.png)

    c.	Just to be sure, re-check the instance configuration and verify that you receive an "ok" message

    MySQL JS > dba.checkInstanceConfiguration('admin@student###-serverB:3307')
    
    ```
    <copy>exit</copy>
    ```
The instance 'primary:3307' is valid for InnoDB cluster usage.

{
    "status": "ok"
}


    d.	Connect to the instance and create the cluster.    
    MySQL JS > \connect admin@student###-serverB:3307

    ```
    <copy>exit</copy>
    ```
    MySQL JS > var cluster = dba.createCluster('testCluster')

    ```
    <copy>exit</copy>
    ```
 ![Image alt text](images/ha-replicate-create-2.png)
 
 5.	Verify cluster status (why "Cluster is NOT tolerant to any failures" ?)
MySQL JS > cluster.status()
 ![Image alt text](images/ha-replicate-create-3.png)

6.	Add the second server to the cluster (running on “serverA”)
    a.	Check the instance configuration, and probably it produces the same error as the first ‘primary:3307’

    MySQL JS > dba.checkInstanceConfiguration('admin@student###-serverA:3307')

    ```
    <copy>exit</copy>
    ```
    b.	Use MySQL Shell to fix issues
    MySQL JS > dba.configureInstance('admin@student###-serverA:3307')
    
    ```
    <copy>exit</copy>
    ```
    c.	Add the instance to the cluster
    MySQL JS > cluster.addInstance('admin@student###-serverA:3307')
    
    ```
    <copy>exit</copy>
    ```
    ![Image alt text](images/ha-replicate-create-4.png)

    d.	Verify cluster status
    MySQL JS > cluster.status()
    
    ```
    <copy>exit</copy>
    ```
 ![Image alt text](images/ha-replicate-create-5.png)

20.	Now we add the third node to cluster

    a.	Check the instance configuration

    MySQL JS > dba.checkInstanceConfiguration('admin@student###-serverB:3308')
    
    ```
    <copy>exit</copy>
    ```
 ![Image alt text](images/ha-replicate-create-6.png)

    b.	If there are issues (we missed something…), read the messages and fix with
    MySQL JS > dba.configureInstance('admin@student###-serverB:3308')
    
    ```
    <copy>exit</copy>
    ```
    c.	Add the last instance to the cluster
    MySQL JS > cluster.addInstance('admin@student###-serverB:3308')
    
    ```
    <copy>exit</copy>
    ```
    d.	Because the instance is empty, we receive an alert. We use now the clone plugin
    ![Image alt text](images/ha-replicate-create-7.png)

    e.	Type ‘C’ and confirm. This start the clone process
    ![Image alt text](images/ha-replicate-create-8.png)

    2.	Verify cluster status, now with all three servers
    MySQL JS > cluster.status()
    
    ```
    <copy>exit</copy>
    ```
    ![Image alt text](images/ha-replicate-create-8.png)

3.	Verify the new status. How do you recognize the Primary server?

4.	On serverB: Exit from MySQL Shell and install MySQL Router via rpm package (if you like mysqlrouter can be installed on serverA with the same steps)

5.	MySQL JS > \q

    ```
    <copy>exit</copy>
    ```
    shell> sudo yum -y install /workshop/linux/mysql-router-commercial-8.0.25-1.1.el7.x86_64.rpm 
    
    ```
    <copy>exit</copy>
    ```
6.	On serverB: Configure MySQL Router
    shell> sudo mysqlrouter --bootstrap admin@student###-serverB:3307 --user=mysqlrouter

    ```
    <copy>exit</copy>
    ```
7.	Have a look on the output. 

Read/Write Connections port: _____________

Read/Only Connections: __________________


8.	On serverB: Start MySQL Router 
shell> sudo mysqlrouter &
9.	Test the connection with a mysql client connect to 6446 port (read/write). 
To which server are you currently connected? ______________________
Can you change the content? _____________________
    shell> mysql -uadmin -p -h127.0.0.1 -P6446 

    ```
    <copy>exit</copy>
    ```
    mysql> SELECT @@hostname, @@port;
    
    ```
    <copy>exit</copy>
    ```
    mysql> use newdb;
    
    ```
    <copy>exit</copy>
    ```
    mysql> SHOW TABLES;
    
    ```
    <copy>exit</copy>
    ```
    mysql> CREATE TABLE newtable (c1 int primary key);
    
    ```
    <copy>exit</copy>
    ```
    mysql> INSERT INTO newtable VALUES(1);
    
    ```
    <copy>exit</copy>
    ```
    mysql> INSERT INTO newtable VALUES(2);
    
    ```
    <copy>exit</copy>
    ```
    mysql> SELECT * from newtable;
    
    ```
    <copy>exit</copy>
    ```
    mysql> exit
    
    ```
    <copy>exit</copy>
    ```

10.	The second port of MySQL Router is used for read only sessions. Close session and re open on port 6447 (read only port).
To which server are you currently connected? ______________________
Can you change the content? _____________________

shell> mysql -uadmin -p -h127.0.0.1 -P6447 

    ```
    <copy>exit</copy>
    ```
mysql> SELECT @@hostname, @@port;

    ```
    <copy>exit</copy>
    ```
mysql> use newdb;

    ```
    <copy>exit</copy>
    ```
mysql> SELECT * from newtable;

    ```
    <copy>exit</copy>
    ```
mysql> INSERT INTO newtable VALUES(3);

    ```
    <copy>exit</copy>
    ```
mysql> show variables like '%read_only';

11.	On ServerB: Now we test failover when a crash happens to primary node.

a.	Connect to primary instance and keep this session open!!!

shell> mysql -uadmin -p -h127.0.0.1 -P6446 

    ```
    <copy>exit</copy>
    ```
mysql> SELECT @@hostname, @@port;

    ```
    <copy>exit</copy>
    ```
b.	Open a second SSH connection and simulate a crash killing primary instance. To do so retrieve process ID with one of these commands

shell> cat /mysql/data/student*.pid 

    ```
    <copy>exit</copy>
    ```
c.	the kill the process of primary instance to simulate a crash

shell> sudo kill -9 <process id from previous step>

d.	Return to mysql connection previously opened and verify if it works (first command fails, second works, why?)

mysql> SELECT @@hostname, @@port;

    ```
    <copy>exit</copy>
    ```
mysql> SELECT @@hostname, @@port;

    ```
    <copy>exit</copy>
    ```
mysql> INSERT INTO newdb.newtable VALUES(30);

    ```
    <copy>exit</copy>
    ```
mysql> SELECT * from newdb.newtable;

12.	From the shell where you killed the instance use MySQL Shell to verify cluster status (of course connect to a living instance)

shell> mysqlsh

    ```
    <copy>exit</copy>
    ```
MySQL JS > \c admin@student###-serverA:3307

    ```
    <copy>exit</copy>
    ```
MySQL JS > var cluster = dba.getCluster('testCluster')

    ```
    <copy>exit</copy>
    ```
MySQL JS > cluster.status()

    ```
    <copy>exit</copy>
    ```
13.	Optional: restart "crashed" instance and verify with MySQL Shell how it changes the status
MySQL JS > cluster.status()

    ```
    <copy>exit</copy>
    ```
## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
