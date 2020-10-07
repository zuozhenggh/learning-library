#  MySQL --> Cassandra

## Introduction

In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rcass’ will read the remote trail files, create the Cassandra tables and write the data to those tables.

*Estimated Lab Time*:  60 minutes

#### Lab Architecture

 ![](./images/image701_1.png " ")

![](./mysql-to-cassandra/terminal2.png " ")

### Objectives
- Explore replication of GoldenGate from **MySQL to Cassandra**

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: Installation

## Steps
If at a terminal session:

````
<copy>$ ssh opc@xxx.xxx.xx.xx</copy>
````
Use Public IP allocated from LiveLabs

**Note: PLEASE USE ‘ggadmin’ USER FOR ALL THE LABS**
    
````    
    <copy>sudo su – ggadmin</copy>
````

## **STEP 1**: Explore GoldenGate MySQL to Cassandra

1. If already at a Unix prompt, you can always access the Lab Menu by typing the alias ‘labmenu’

````
<copy>labmenu</copy>
````
The following Lab Menu will be displayed

**By default ggadmin will automatically start in the labmenu**

  ![](./images/menu1006.png " ")

1. select **R** to reset the lab environment, then select **7**, then select **Q** to quit
Review the overview notes on the following screen, . These online notes have been provided to allow cut/paste file names to another session, to avoid typos.

1. The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. 

view these files, same as in previous lab:

````
<copy> cd /u01/gg4mysql/dirprm</copy>
````
````
<copy>view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby</copy>
````
````
<copy>view /u01/gg4mysql/dirprm/mgr.prm</copy>
````
````
<copy>view /u01/gg4mysql/dirprm/extmysql.prm</copy>
````
````
<copy>view /u01/gg4mysql/dirprm/pmpmysql.prm</copy>
````
````
<copy> cd /u01/gg4hadoop123010/dirprm</copy>
````
````
<copy>view /u01/gg4hadoop123010/dirprm/create_cassandra_replicat.oby</copy>
````
````
<copy>view /u01/gg4hadoop123010/dirprm/rcass.prm</copy>
````
````
<copy>view /u01/gg4hadoop123010/dirprm/rcass.properties</copy>
````
4. Start the GG manager process on both the source and target. Start two terminal sessions and connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.

## **STEP 2**: Cassandra Configuration

1. First task is to start the Cassandra database server. Open a new ssh session, run the alias as shown below and leave this running until you are done
````
  <copy>startcass</copy>
````
## **STEP 3**: Explore GoldenGate MySql Source 

1. Open another ssh session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql

  ![](./images/f3.png " ")

````
<copy>cd /u01/gg4mysql</copy>
````
````
<copy>./ggsci</copy>
````
````
<copy>info all</copy>	
````
````
<copy>start mgr</copy>	
````
````
<copy>info all</copy>
````

## **STEP 4**: GoldenGate Cassandra Target

1. In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

  ![](./images/f4.png " ")
````
<copy>cd /u01/gg4hadoop123010</copy>
````
````
<copy>./ggsci</copy>
````
````
<copy>info all</copy>
````
````
<copy>start mgr</copy>	
````
````
<copy>info all</copy>	
````
````
<copy>exit</copy> 
````
## **STEP 5**: GoldenGate MySql Source Configuration
1. In the GG for MySQL ggsci session, we will create and start the GG extract process:

  ![](./images/f5.png " ")

````
<copy>cd /u01/gg4mysql</copy>
````
````
<copy>./ggsci</copy>
````
````
<copy>info all</copy>
````
````
<copy>start mgr</copy>	
````
````
<copy>obey ./dirprm/create_mysql_to_hadoop_gg_procs.oby</copy>
````
````
<copy>info all</copy>	
````
````
<copy>start *</copy>
````
**Starts ALL parameter files**
````
<copy>exit</copy> 
````

## **STEP 6**: GoldenGate Cassandra Target Configuration

1. Now that the source side is setup, let us configure GG on the target side (for Cassandra).

2. In the GG for Hadoop session, you will need to modify the Cassandra properties by **removing the ‘---‘ prefixes** from the highlighted values:

  ![](./images/f6.png " ")
  ![](./images/f7.png " ")

````
<copy>cd /u01/gg4hadoop123010</copy>
````
````
<copy>cd dirprm</copy>
````
````
<copy>vi rcass.properties</copy>
````

````
<copy>---cassandra</copy>
````
````
<copy>---CREATE,ADD,DROP</copy>
````
## **STEP 7**: GoldenGate Target Replication Configuration

1. Now create and start the Cassandra replicat process:

  ![](./images/f8.png " ")

````
<copy>cd ..</copy>
````
````
<copy>./ggsci	</copy>
````
````
<copy>info all</copy>		
````
````
<copy>obey ./dirprm/create_cassandra_replicat.oby</copy>	
````
````
<copy>info all</copy>	
````
````
<copy>start rcass</copy>	
````
````
<copy>info all</copy>
````

## **STEP 8**: Cassandra Replication

1. Now that GG processes have been created and started on both the source and target, we need to create the Cassandra Keyspace before loading data. A Cassandra Keyspace is equivalent to a database or schema in relational databases. This step can be done at anytime, and is not dependant on GG.

**Open another ssh session - labmenu - Q to exit**

NOTE: If you re-run this lab later, you can run ‘dropcasskeyspace’ to drop the Cassandra keyspace – and then recreate with the alias below.

  ![](./images/f9.png " ")
````
  <copy>createcasskeyspace</copy>
````
2. Let us check to see if any tables exist in the ggtarget2cass Cassandra keyspace. The expected result is an error “unconfigured table …” – since the tables have not been created by GG yet. That will be done when GG encounters the first transaction for a new table.

  ![](./images/f10.png " ")
````
  <copy>cassselect</copy>
````
3. We will load some data on the MySQL database ‘ggsource’ and GG will extract the data, create the Cassandra tables, and write the data to the Cassandra target tables.

4.  Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

  ![](./images/f11.png " ")
````
<copy>mysqlselect</copy>
````
````
<copy>loadsource</copy>
````
````
<copy>mysqlselect</copy>
````

5. Starting with GG version 12.3.0.1.0, GG automatically creates the Cassandra tables. Let us take a look at the contents of the tables:

  ![](./images/f12.png " ")
  ![](./images/f13.png " ")

````
<copy>cassselect</copy>
````
6. Now we will apply some changes to the source database

  ![](./images/f14.png " ")
````
  <copy>dmlsource</copy>
````
7. Next we will do a count of the Cassandra tables to see if the changes were applied as expected. You can also do a cassselect to see all the data

  ![](./images/f15.png " ")
  ![](./images/f16.png " ")
````
  <copy>casscount</copy> 
````
8. Let us confirm using GG to see statistics about data that was replicated In a GG Home for Hadoop session

  ![](./images/f17.png " ")
  ![](./images/f18.png " ")
````
  <copy>./ggsci</copy>
````
````
<copy>stats rcass total</copy> 
````

In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rcass’ read the remote trail files, created the Cassandra tables and wrote the data to those tables.

You may now *proceed to the next lab*.

## Learn More

* [Oracle GoldenGate for Big Data 19c | Oracle](https://www.oracle.com/middleware/data-integration/goldengate/big-data/)

## Acknowledgements
* **Author** - Brian Elliott, Data Integration Team, Oracle, August 2020
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Brian Elliott, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.




