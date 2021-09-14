# Prepare Target ATP

## Introduction

Up to now we have created all of the necessary resources using Terraform in OCI. It is now time to prepare the Target Database, the Autonomous database. 

*Estimated time*: 10 minutes

### Objectives

We need to create our target tables for our GoldenGate migration and enable GGADMIN for replication to the Autonomous Database.

### Prerequisites

* This lab assumes that you completed all preceding labs.

## **Task 1**: Open SQL Developer Web 

1. Go to the top-left hamburger icon, navigate to **Oracle Database** and choose **Autonomous Transaction Processing**. It will show you all available ATP workload type databases. Click on **Target ATP** database.

	![](/images/2.atp.PNG)

2. In **Tools** tab, where you will see **Database Actions**, click on **Open Database Actions**. You may need to enable a pop-up in your browser if it doesn't open anything.

	![](/images/2.atp_1.PNG)

3. A new sign-in page opens, enter **ADMIN** in Username, when it asks you to enter the password, which is in the terraform output. Go and copy, then paste here.

	![](/images/sql_dev_1.png)

4. In the **DEVELOPMENT** section, click on **SQL**. 

	![](/images/sql_dev_5.png)

## **Task 2**: Create Target Tables

1. Let's create our target tables for migration. Please download the target table creation script **[from here](./files/CreateTables.sql)**. Make sure to save these with the correct extension **.sql** not txt!

2. SQL Developer Web opens a worksheet tab, where you execute queries. Drag your downloaded **CreateTables.sql** file and drop it in the worksheet area. Then run create statements.

	![](/images/sql_dev_2.png)

	There should have **7** tables created after script execution.

## **Task 3**: Enable GGADMIN 

1. Now let's continue to unlock and change the password for Oracle GoldenGate user (ggadmin) in the Autonomous Database. Enable GGADMIN by running the following query.

	```
	<copy>
	alter user ggadmin identified by "GG##lab12345" account unlock;
	</copy>
	```

	![](/images/sql_dev_3.png)

2. Let's check whether the parameter `enable_goldengate_replicaton` is set to true. 

	```
	<copy>
	select * from v$parameter where name = 'enable_goldengate_replication';
	</copy>
	```

	![](/images/sql_dev_4.png)

	We successfully enabled GGADMIN in our target Autonomous Database and created target HR database table structures. 

**This concludes this lab. You may now [proceed to the next lab](#next).**

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - Tsengel Ikhbayar - GenO Lift Implementation
* **Last Updated By/Date** - Bilegt Bat-Ochir 9/1/2021