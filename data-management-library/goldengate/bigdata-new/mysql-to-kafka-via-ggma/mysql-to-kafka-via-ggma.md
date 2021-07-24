# MySql to Kafka via GGMA for BigData

## Introduction
This workshop will show you how to  ***Replicate from  mysql to kafka***.
In this lab we will load data in MySQL database ‘ggsource’, GG extract process ‘extmysql’ will capture the changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repkafka’ will read the remote trail files, act as a producer and write the messages to an auto- created topic for each table in the source database.

*Estimated Workshop Time*: 60 minutes
#### Lab Architecture

![](./images/0.jpg " ")


### About Mysql to Kafka via GGMA for BigData

### Objectives
-  GoldenGate Microservices for BigData 
-  Replicating from mysql to kafka through GGMA  

### Prerequisites
This Workshop assumes you have:
- A Free Tier, Paid or LiveWorkshops Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Workshop: Generate SSH Keys
    - Workshop: Prepare Setup
    - Workshop: Environment Setup


## **STEP 0:** Running your Lab
### Login to Host using SSH Key based authentication
Refer to *Lab Environment Setup* for detailed instructions relevant to your SSH client type (e.g. Putty on Windows or Native such as terminal on Mac OS):
  - Authentication OS User - “*opc*”
  - Authentication method - *SSH RSA Key*
  - OS User – “*ggadmin*”.

1. First login as “*opc*” using your SSH Private Key

2. Then sudo to “*ggadmin*”. E.g.

```
    <copy>sudo su - ggadmin</copy>
```
![](./images/1.png" ")

3. Reset the lab by selecting ***R*** in the option

```
    <copy>R</copy>
```
![](./images/2.png" ")

## **STEP 1**: GoldenGate Configuration for MySQL as Source
1. Select Option **2** ,to deploy GoldenGate Configuration for MySQL(Source)

Option ***2*** will copy all the parameter files to ***dirprm*** folder under goldengate home

![](./images/3.png" ")

2. Once Deployment completed, then select **Q** to quit the labmenu   and start the mananger

To quit the Lab Menu:
```
    <copy>Q</copy>
```
Switch to GoldenGate command mode:
```
    <copy>
    cd /u01/gg4mysql
    ./ggsci

    </copy>
```
To start the manager:
```
    <copy>start mgr</copy>
```
![](./images/4.png" ")

3. Execute the obey file to create the GoldenGate process.Obey file contains all the commands to create GoldenGate process
```
    <copy>obey ./dirprm/create_mysql_gg_procs.oby</copy>
```
![](./images/5.png" ")
Sample Output:
![](./images/6.png" ")

4. Start all GoldenGate process.Start with wildcard '*' will start all the GoldenGate process
```
    <copy>
    info all

    start *
    </copy>
```
![](./images/8.png" ")


 Source deployment completed!

## **STEP 2**: GoldenGate Configuration for Kafka as Target
1. Login to GoldenGate for BigData console 

    Replace IP Address with livelab server generated IP
```
    <copy>http://IP Address:16001/?root=account</copy>
```
Enter username as ***oggadmin***

```
    <copy>oggadmin</copy>
```
Enter Password as ***Wel_Come1***
```
    <copy>Wel_Come1</copy>
```
![](./images/9.png" ")
2. Click on '***+***' to create replicat process for target ***Kafka***
![](./images/10.png" ")

3. Click ***Next*** to navigate to **Replicat Options**. We are selecting ***CLassic replicat*** as Replicat type for the workshop
![](./images/11.png" ")

4. Enter process name as ***REPKAFKA***.Process Name ***REPKAFKA*** will  be 8 character user defined
```
    <copy>REPKAFKA</copy>
```
![](./images/12.png" ")
5. Update Trail Name and Trail Subdirectory as shown below

Trail Name ***rt*** is generated from goldengate for mysql
Trail Name:
```
    <copy>rt</copy>
```
Trail Subdirectory:
```
    <copy>/u01/gg4mysql/dirdat</copy>
```
![](./images/13.png" ")
6. Choose target as ***kafka*** from the top-down menu.

![](./images/14.png" ")
7. Click ***Next*** To navigate **parameter** tab.
![](./images/15.png" ")
8. Kindly review the parameter contents and mapping conditions,click ***Next***
![](./images/16.png" ")
9. Kindly replace the content of the property file with a below code and click ***Create and Run***
```
<copy>
# Properties file for Replicat rtest
#Kafka Handler Template
gg.handlerlist=kafkahandler
gg.handler.kafkahandler.type=kafka
#TODO: Set the name of the Kafka producer properties file.
gg.handler.kafkahandler.kafkaProducerConfigFile=custom_kafka_producer.properties
#TODO: Set the template for resolving the topic name.
gg.handler.kafkahandler.topicMappingTemplate=${tablename}
gg.handler.kafkahandler.keyMappingTemplate=${primaryKeys}
gg.handler.kafkahandler.mode=op
gg.handler.kafkahandler.format=json
gg.handler.kafkahandler.format.metaColumnsTemplate=${objectname[table]},${optype[op_type]},${timestamp[op_ts]},${currenttimestamp[current_ts]},${position[pos]}
#TODO: Set the location of the Kafka client libraries.
gg.classpath=/home/ggadmin/kafka_2.13-2.8.0/libs/*
jvm.bootoptions=-Xmx512m -Xms32m
</copy>
``` 

![](./images/20.png" ")
10. Replicat ***REPKAFKA*** creation completed. Green tick mark will shows Replicat ***REPKAFKA*** up and running
![](./images/21.png" ")
11. Load the data to source database MySql.Kindly open a new putty session,choose ***Q*** to quit the lab menu and load the data to MySql database through command ***loadsource***.
```
<copy>
loadsource
</copy>
```


![](./images/23.png" ")

12. Validating the data replicated by ***REPKAFKA*** through **statastics**.Kindly switch to GoldenGate for Bigdata console and click on ***Action*** to choose ***Details*** from top-down menu
![](./images/24.png" ")
13. Click on the tab Statastics tab to view stats of the kafka message
![](./images/25.png" ")

14.  Viewing the content of the ***kafka topics***
```
<copy>
consumetopic emp
</copy>
```

![](./images/26.png" ")

## Summary
In summary, you loaded data in MySQL database `‘ggsource’`, GG extract process `‘extmysql’` captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process `‘pmpmysql’` routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process `‘repkafka’` read the remote trail files, acted as a producer and wrote the messages to an auto-created topic for each table in the source database.



## Learn More

* [Oracle GoldenGate for Big Data 21c | Oracle](https://docs.oracle.com/en/middleware/goldengate/big-data/21.1/index.html)

## Acknowledgements
* **Author** - Madhu Kumar S, Data Integration Team, Oracle, July 2021
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, July 2021









