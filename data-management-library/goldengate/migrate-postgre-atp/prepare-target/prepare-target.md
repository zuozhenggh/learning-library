# Prepare Target ATP

## Introduction

We so far created all of necessary resources using terraform in OCI. It is now time to prepare Target Database, ATP. 

### Objectives

We need to create our target tables for our GG migration and enable GGADMIN for replication to Autonomous database.

## **Step 1**: Open SQL developer web 

1. Go to top left hamburger icon, navigate to **Autonomous Transaction Processing** and click on **HOL Target ATP** database.

	![](/images/2.atp.PNG)

2. In **Tools** tab, where you will see **Database Actions**, click on **Open Database Actions**. You may need to enable pop-up your browser if it doesn't open anything.

	![](/images/2.atp_1.PNG)

3. A new sign-in page opens, enter **ADMIN** in Username, when it asks you to enter password, which is in terraform output. Go and copy, then paste here.

	![](/images/sql_dev_1.png)

4. In the **DEVELOPMENT** section, click on **SQL**. 


## **Step 2**: Create target tables

1. Let's create our target tables for migration. Please download target table creation script **[from here](./files/CreateTables.sql)**.  Open this file link and choose **RAW** then save it as CreateTables.sql file. Make sure to save these with correct extension **.sql** not txt!

2. SQL Developer Web opens a worksheet tab, where you execute queries. Drag your downloaded **CreateTables.sql** file and drop in the worksheet area. Then run create statements.

	![](/images/sql_dev_2.png)

There should have **5** tables created after script execution.


## **Step 3**: Enable GGADMIN 

1. Now let's unlock and change the password for the pre-created Oracle GoldenGate user (ggadmin) in Autonomous Database. Enable GGADMIN by running following query:

	```
	<copy>
	alter user ggadmin identified by "GG##lab12345" account unlock;
	</copy>
	```

	![](/images/sql_dev_3.png)

2. Let's check whether the parameter `enable_goldengate_replicaton` is set to true. 

	```
	select * from v$parameter where name = 'enable_goldengate_replication';
	``` 

3. If value is FALSE, then modify the parameter,this is only applicable to older ATP version.:

	```
	alter system set enable_goldengate_replication = true scope=both;
	``` 

	![](/images/sql_dev_4.png)

We successfully enabled GGADMIN in our target Autonomous Database and created target table structures. 

**This concludes this lab. You may now [proceed to the next lab](#next).**

## Acknowledgements

* **Author** - Bilegt Bat-Ochir " Senior Solution Engineer"
* **Contributors** - John Craig "Technology Strategy Program Manager", Patrick Agreiter "Senior Solution Engineer"
* **Last Updated By/Date** - Bilegt Bat-Ochir 3/22/2021