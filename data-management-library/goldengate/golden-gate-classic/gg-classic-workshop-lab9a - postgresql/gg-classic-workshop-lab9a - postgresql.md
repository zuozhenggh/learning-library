# Lab 9a - GoldenGate from PostgreSQL

### Introduction

This lab is intended to give you familiarity with how to configure GG for database to database replication. I
In this lab we will load data in MySQL database ‘ggsource’. The GG extract process ‘extmysql’ and will
capture the column changes from MySQL’s binary logs and write them to the local trail file. The pump process ‘pmpmysql’ will route the data from the local trail (on the source) to the remote trail (on the target). The replicat process ‘repmysql’ will read the remote trail files, and apply the changes to the MySQL database ‘ggtarget’

### Objectives
Replication of column conversions from relational source to a relational target using GoldenGate

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Configure GoldenGate

Time to Complete -
Approximately 60 minutes

## **Step 1:** - GoldenGate GoldenGate - PostgreSQL Replication

1. Open a terminal session

![](./images/terminal3.png)

````
 <copy>ssh -i (sshkey) opc@xxx.xxx.xx.xxx</copy>
````
````
<copy>sudo su - oracle</copy>
````

**Waiting For Madhu to Provide**

## Learn More


* [GoldenGate](https://www.oracle.com/middleware/data-integration/goldengate/")

* [GoldenGate with PostgreSQL](https://docs.oracle.com/en/middleware/goldengate/core/19.1/gghdb/using-oracle-goldengate-postgresql.html/")

## Acknowledgements
* **Author** - Madhu Kumar Data Integration Hub October 2020
* **Contributors** - Brian Elliott
* **Last Updated By/Date** - Brian Elliott, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

  