# Lab 3 -  MySQL --> HDFS (delimited text format)
(Hadoop, Hive, Pig, Spark, Oracle R)

![](images/300/image300_1.png)

## Introduction
In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rhdfs’ will read the remote trail files, and write the data to the HDFS target directory
/user/ggtarget/hdfs/

### Objectives
- GoldenGate replication from **MySQL to HDFS**

For the Lab:
User ID: ggadmin
Password: oracle

### Time to Complete
Approximately 30 minutes

If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’

## Before You Begin
For the Lab terminal session:

![](images/300/Lab3Menu.png)

The following Lab Menu will be displayed, select R to reset the lab environment, then select 3 (this step may take a couple of minutes, or longer if you have allocated less than 8GB to the VM).
Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.

is already done in the env script for this workshop)
1)	/create_hdfs_replicat.oby
2)	view /u01/gg4hadoop123010/dirprm/rhdfs.prm
3)	view /u01/gg4hadoop123010/dirprm/rhdfs.properties

First we will start the GG manager process on both the source and target. Start 2 putty sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.

In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:

![](images/300/image3xx_1.png)

In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

![](images/300/image3xx_1.png)

In the GG for MySQL ggsci session, we will create and start the GG extract process:

![](images/300/image3xx_1.png)

![](images/300/image3xx_1.png)

Now that the source side is setup, let’s configure GG on the target side (HDFS).

In the GG for Hadoop session, you’ll need to modify the HDFS properties by removing the ‘---‘ from the highlighted values:

![](images/300/image3xx_1.png)


Now create and start the HDFS replicat process:

![](images/300/image3xx_1.png)

![](images/300/image3xx_1.png)

Now that GG processes have been created and started on both the source and target, let’s take a look at what’s in the HDFS directory – it should be empty. Then we’ll load some data on the MySQL database
‘ggsource’ and GG will extract and write it to the HDFS target. GG will create a subdirectory for each table in the base directory /user/ggtarget.
Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt)::

![](images/300/image3xx_1.png)

Call the following alias to apply updates/deletes to the emp table:
dmlsource	-- this will apply 3 inserts, 1 delete and 2 updates to the emp table

Print the contents of the 3 files:
hdfscat	-- this alias will run hdfs dfs -cat /user/ggtarget/hdfs/*/*

You should see the additional delete (D) and update (U) operations in the emp file:

![](images/300/image3xx_1.png)

In summary, we loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rhdfs’ read the remote trail file, and wrote the data to the HDFS target directory
/user/ggtarget/hdfs/*.

Let’s confirm that GG replicated the data that it captured. Go back to the MySQL ggsci session and execute the following commands to see what data GG has processed, and do the same in the Hadoop ggsci session:
In MySQL ggsci session window:

![](images/300/image3xx_1.png)

![](images/300/image3xx_1.png)

In Hadoop ggsci session window:

![](images/300/image3xx_1.png)

![](images/300/image3xx_1.png)

The stats command displays the statistics of the data that GoldenGate processed (grouped by insert/update/deletes). Counts should match between source and target.
You can also see the files created by GG from Hue: http://127.0.0.1:8888/
Login to Hue: cloudera/cloudera
Click on File Browser (Manage HDFS) > Navigate to /user/ggtarget/hdfs…

![](images/300/image3xx_1.png)

![](images/300/image3xx_1.png)

![](images/300/image3xx_1.png)

End of Lab 3.

## Acknowledgements

  ** Authors ** - Brian Elliott, Zia Khan
  ** Contributors ** - Brian Elliott, Zia Khan
  ** Team ** - Data Integration Team
  ** Last Updated By ** - Brian Elliott, Zia Khan
  ** Expiration Date ** – July 2021