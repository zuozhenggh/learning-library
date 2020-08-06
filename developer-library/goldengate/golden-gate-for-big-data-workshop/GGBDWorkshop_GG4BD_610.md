# Lab 6 -  MySQL --> Kafka (Json format)

![](images/600/image601_1.png)

## Before You Begin

### Introduction
In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmphadop’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat
process ‘rkafka’ will read the remote trail files, act as a producer and write the messages to an auto- created topic for each table in the source database.


### Objectives
- GoldenGate replication from **MySQL to Kafka **

### Time to Complete
Approximately 60 minutes

## Before You Begin
For the Lab terminal session:
su - ggadmin

If already at a Unix prompt, you can access the Lab Menu by typing the alias ‘labmenu’
The following Lab Menu will be displayed, select R to reset the lab environment, then select 6 (this step may take a couple of minutes).

Review the overview notes on the following screen, then select Q to quit. These online notes have been provided so you can cut/paste file names to another session, to avoid typos.

![](images/600/Lab6Menu.png)

------

##  Configuration
   The above step will copy the GoldenGate configuration files to the GG Home directories, under ./dirprm. The workshop facilitator will review the content of each of these files to understand how GoldenGate is being configured.

1)	view /u01/gg4mysql/dirprm/create_mysql_to_hadoop_gg_procs.oby
2)	Optionally view these files, same as in previous lab:
/u01/gg4mysql/dirprm/mgr.prm
/u01/gg4mysql/dirprm/extmysql.prm
/u01/gg4mysql/dirprm/pmpmysql.prm
3)	view /u01/gg4hadoop123010/dirprm/create_kafka_replicat.oby
4)	view /u01/gg4hadoop123010/dirprm/rkafka.prm
5)	view /u01/gg4hadoop123010/dirprm/rkafka.properties
6)	view /u01/gg4hadoop123010/dirprm/custom_kafka_producer.properties

First we will start the GG manager process on both the source and target. Start 2 terminal sessions, connect to ggadmin/oracle (then click Q to get to a prompt). Keep these sessions open for the rest of this lab.


In the first session, go to the GG Home for MySQL, and start the manager process. You can either cd to the directory, or call the alias ggmysql:

![](images/600/image6xx_1.png)

In the second session, go to the GG Home for Hadoop, and start the manager process. You can either cd to the directory, or call the alias gghadoop:

![](images/600/image6xx_1.png)

In the GG for MySQL ggsci session, we will create and start the GG extract process:

![](images/600/image6xx_1.png)

![](images/600/image6xx_1.png)

Now that the source side is setup, let’s configure GG on the target side (Kafka).

In the GG for Hadoop session, you’ll need to modify the Kafka properties by removing the ‘---‘ from the highlighted values:

![](images/600/image6xx_1.png)

Now create the Kafka replicat process:

![](images/600/image6xx_1.png)

****Before we start the GG Kafka replicat process, we need to start the Kafka Broker. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

![](images/600/image6xx_1.png)

Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

![](images/600/image6xx_1.png)

Now that GG processes have been created and the Kafka Broker has been started, let’s start the GG replicat for Kafka. Go back to the GG Home for Hadoop ggsci session:

![](images/600/image6xx_1.png)

Now go back to the previous session, where you ran ‘showtopics’; we’ll load some data on the MySQL database ‘ggsource’ and GG will extract and write it to the Kafka topics.

![](images/600/image6xx_1.png)

Also take a look at the Kafka schema files created by GG, it’s created in the ./dirdef directory in the GG Home for Hadoop:

![](images/600/image6xx_1.png)


Next we’ll apply more DML to the source, then we’ll consume the emp topic, and see the additional data get appended to the topic. Run this from another session, since the consumetopic command runs in the foreground, and outputs the results. Start a new session, connect to ggadmin/oracle (then click Q to get to a prompt):

![](images/600/image6xx_1.png)

Now go back to the previous session, and run the DML script:

![](images/600/image6xx_1.png)

Now go back to the session running ‘consumetopic gg2kafka_json.emp’, you should see the new messages written to the emp topics. Scroll up to see "op_type":"U" or "D". For Updates, GG will write the before and after image of the operation

![](images/600/image6xx_1.png)

Let’s confirm that GG replicated the data that it captured. In the GG for Hadoop home

![](images/600/image6xx_1.png)

In summary, you loaded data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process
‘pmphadop’ routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘rkafka’ read the remote trail files, acted as a producer and wrote the messages to an auto-created topic for each table in the source database.

End of Lab 6.

## Acknowledgements

 - ** Authors ** - Brian Elliott
 - ** Contributors ** - Brian Elliott
 - ** Team ** - Data Integration Team
 - ** Last Updated By ** - Brian Elliott
 - ** Expiration Date ** – July 2021