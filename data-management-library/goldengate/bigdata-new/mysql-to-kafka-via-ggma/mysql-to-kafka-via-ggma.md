# MySql to Kafka via GGMA for BigData

## Introduction
This workshop will demonstrate how to  ***Replicate from  mysql to kafka***.
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

2. Once Deployment is completed. Select **Q** to quit the labmenu  and start the mananger

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
3. Execute the obey file to create the GoldenGate process. Obey file contains all the commands to create GoldenGate process:

 
    ```
    <copy>obey ./dirprm/create_mysql_gg_procs.oby</copy>
    ```

    ![](./images/5.png" ")
Sample Output:
![](./images/6.png" ")

4. Start all GoldenGate processes. Start with wildcard '*' will start all the GoldenGate processes:
    ```
    <copy>
    info all

    start *
    </copy>
    ```
![](./images/8.png" ")




## Summary
In summary, you loaded data in MySQL database `‘ggsource’`, GG extract process `‘extmysql’` captured the changes from the MySQL binary logs and wrote them to the local trail file. The pump process `‘pmpmysql’` routed the data from the local trail (on the source) to the remote trail (on the target). The replicat process `‘repkafka’` read the remote trail files, acted as a producer and wrote the messages to an auto-created topic for each table in the source database.



## Learn More

* [Oracle GoldenGate for Big Data 21c | Oracle](https://docs.oracle.com/en/middleware/goldengate/big-data/21.1/index.html)

## Acknowledgements
* **Author** - Madhu Kumar S, Data Integration Team, Oracle, July 2021
* **Contributors** - Meghana Banka, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, Master Principal Solutions Architect, NA Technology, July 2021









