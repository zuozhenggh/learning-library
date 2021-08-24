# Migration

## Introduction

We Up to now we have created all of the necessary resources using Terraform in OCI. It is now time to prepare the Target Database, the Autonomous database. 

*Estimated lab time*: 10 minutes

### Objectives

In this lab, we will configure _**two extract**_ processes at the source database and _**two replicat**_ processes at the target database:
* An extract for **changed data capture**. This process will start be capturing changes and this will create some files called trail files, those will be used after initial load finished. We will call it **the primary extract** during this workshop.
* An Initial-Load extract. While changes are being captured by the first extract process, the migration step needs a special type of extract process. Basically it captures data from specified list of tables and later will be loaded into target database tables using a System Change Number (SCN). 

We will also configure _**two replicat**_ processes at the target database:
-	An extract for **changed data capture**. This process will start be capturing changes and this will create some files called trail files. We will call it **the primary replicat** during this workshop.
-	An Initial-Load replicat. This will use to copy the existing contents of one or more tables from the source to the target database using file to replicat method.



1. An extract for **changed data capture**, This process will start be capturing changes and this will create some files called trail files. It is responsible for change data capture defined by it’s registration SCN. We will call it **the primary extract** during this workshop.

2. We will connect to source database and retrieve the oldest System Change Number (SCN). This will be used as the instantiation SCN. 

3. An Initial-Load extract. While changes are being captured by the primary extract process, the migration step needs a special type of extract process. Basically data will be captured from specified list of tables and later will be loaded into target database tables using the instantiation SCN. 

4. The first replicat, the initial-load replicat will be created. This is responsible for populating the target database using extracted data by initial-load extract.

5. The second replicat for **changed data**. Once the initial-load replicat completes, we will create a replicat process for applying change data to the target database. We will call it **the primary replicat** during this workshop. The instantiation SCN is used to create the primary Replicat, once the initial load replication is complete.



We will do the below tasks: 
* Add the extracts and replicats processes
* Add transaction data and a checkpoint table
* Capture System Change Number (SCN) from the source database
* Configure continuous replication and do the migration

### Prerequisites

* This lab assumes that you completed all preceding labs.

## **Step 1**: Log in to GoldenGate deployment 

1. Click the left-top hamburger icon, navigate to **Oracle Database** and choose **GoldenGate**. The page will list all available GoldenGate deployment. Click on HOL_GG_Service, this is what terraform has been created in the first lab.

	![](/images/3.goldengate.png)

2. Then click on **Launch Console** button, this will open in a new tab.

	![](/images/3.goldengate_0.png)

3. On the OCI GoldenGate Deployment Console sign in page, please provide **oggadmin** in User Name and password is **CloudStars#123**, then sign in.

	![](/images/3.goldengate_1.png)

	You successfully have signed in GoldenGate Deployment Console.

## **Step 2**: Source database configuration

1.  You should be seeing the empty Administration dashboard. Let's configure our source and target database for the extract and replication processes. Open the hamburger menu on the top-left corner, choose **Configuration**.

	![](/images/3.goldengate_config.png)

2. You can see that our Source and Target databases have been added here already, it is because we did database registration in the first lab using Terraform automation. Click on **Connect to database. source12** icon:

	![](/images/3.goldengate_config_source.png)

3. Scroll down to the **Checkpoint** and click on **+** icon, then provide `ggadmin.chkpt` and **SUBMIT**. 

	![](/images/3.goldengate_config_source_0.png)

	The checkpoint table contains the data necessary for tracking the progress of capture process from source database's transactions. 

4. Now let's add trandata for HR schema, right below the checkpoint, find **TRANDATA Information**. Make sure you choose **Schema** option then click on **+** icon. In the configuration window, for the **Schema Name** provide `HR` then click **SUBMIT**. 

	![](/images/3.goldengate_config_source_trandata.png)

5. You will see **Successfully added Trandata!** notification when you click on a bell icon located at left-top corner

	![](/images/3.goldengate_config_source_trandata_notification.png)

	However you can verify it by your choice, enter **HR** in the search field and click on the search icon.

	![](/images/3.goldengate_config_source_trandata_check.png)

	The result will verify that you have prepared 7 tables for trandata instantiation in HR schema. This is necessary steps for the source database.

## **Step 3**: Target database configuration

1.  It is time to configure the target database. Similar to **Step 2**, from the available databases, click on **Connect to database. target19** icon:

	![](/images/3.goldengate_config_target.png)

3. Scroll down to the **Checkpoint** and click on **+** icon, then provide `ggadmin.chkpt` and **SUBMIT**. 

	![](/images/3.goldengate_config_target_0.png)

	The checkpoint table contains the data necessary for tracking the progress of the Replicat as it applies transactions to the target system. Regardless of the Replicat that is being used, it is best practice to enable the checkpoint table for the target system.

4. Now let's go back to the Administration server overview, open the hamburger menu on the top-left corner, choose **Overview**

## **Step 4**: Configure the primary extract at the source database.

1. This is the first and primary extract, or should I say continuous extract is started first to initiate change data capture. In the administration server, click the **+** icon for adding the extract.

	![](/images/3.goldengate_ext_0.png)

2. On the Add Extract page, select **Integrated Extract**, and then click Next.

	![](/images/3.goldengate_ext_1.png)

3. In **Process Name**, please provide `EXTPRIM` as it is our primary extract, and then click Next.

	![](/images/3.goldengate_ext_2.png)

4. Scroll down to **Source Database Credential**, then click on the **Credentials Domain** drop-down list and choose **OracleGoldenGate**. In the **Credential Alias**, choose **source12** from the drop-down list. Click **Next** button.

	![](/images/3.goldengate_ext_3.png)

5. GoldenGate Service created a draft parameter file for your convenience. Add the below line after the last line of the existing draft parameter:

	```
	<copy>
	MAP HR.COUNTRIES, TARGET HR.COUNTRIES;
	MAP HR.DEPARTMENTS, TARGET HR.DEPARTMENTS;
	MAP HR.EMPLOYEES, TARGET HR.EMPLOYEES;
	MAP HR.JOBS, TARGET HR.JOBS;
	MAP HR.JOB_HISTORY, TARGET HR.JOB_HISTORY;
	MAP HR.LOCATIONS, TARGET HR.LOCATIONS;
	MAP HR.REGIONS, TARGET HR.REGIONS;
	</copy>
	```

	Parameter file should be looking like the below image.

	![](/images/3.goldengate_ext_4.png)

6. Make sure everything is correct until this stage. Click **Create and Run** to start our extract.

	![](/images/3.goldengate_ext_5.png)

## **Step 5**: Get the SCN of the source database

1. Remember that we copied the terraform output? Go and find the IP address of `Source_DB_Public_IP` from your note and connect to source database using sqlplus connection. Copy the below line, and modify it with your IP address, then open your cloud-shell and run.
	
	```
	<copy>
	sqlplus ggadmin/GG##lab12345@ip_address_source_database:1521/ORCL
	 </copy>
	```
	
	_**NOTE:** Make sure you replace with your source IP address for successful connection.

2. You will be successfully connected to your source database, then run the below command to get the SCN:

	```
	<copy>
	SELECT MIN(SCN) AS INSTANTIATION_SCN FROM 
	(SELECT MIN(START_SCN) AS SCN FROM V$TRANSACTION UNION All 
	SELECT CURRENT_SCN FROM V$DATABASE);
	</copy>
	```

3. Copy the SCN output! The below image shows successful output. In this workshop, SCN is **1667664**. We will also use this in the last step.

	![](/images/3.goldengate_ext_scn.PNG)

## **Step 6**: Configure the initial-load extract at the source database.

1. Let's go back to the GoldenGate deployment console. In the administration server, click the **+** icon for adding the extract. This is the second and initial-load extract, which will extract all rows in tables into a file.

	![](/images/3.goldengate_ext_6.png)


2. On the Add Extract page, select **Initial Load Extract**, and then click Next.

	![](/images/3.goldengate_ext_7.png)

3. In **Process Name**, please provide `INITLOAD` as since this initial load extract, and then click Next.

	![](/images/3.goldengate_ext_8.png)

4. Open a notepad, and replace xxxxxx in the below parameter with your SCN output:

	```
	<copy>
	USERIDALIAS source12 DOMAIN OracleGoldenGate
	ExtFile ix Megabytes 2000 Purge
	TABLE HR.*, SQLPredicate "As Of SCN xxxxxxx";
	</copy>
	```

5. Then modify the initload parameter file, it should be looking like the below image. 

	![](/images/3.goldengate_ext_9.png)

6. Make sure everything is correct until this stage. Click **Create and Run** to start our extract.

	![](/images/3.goldengate_ext_5.png)

7. In the overview dashboard, you should see **INITLOAD** extract is stopped. Click on **Action** button, choose **Details**. Initial-load takes only matter of seconds to finish sample 7 tables. You can see actual extract process details in the **Report** tab. Please refer to the below recording for your reference of this step.

	![](/images/3.goldengate_initial_load.gif)

## **Step 7**: Configure the initial-load replicat at the target database.

1. The apply process for initial load replication is very easy and simple to configure. There are four types of Replicats supported by the GoldenGate Services. On the overview page, go to Replicat part and click on **+** to create our replicat process.

	![](/images/3.goldengate_repload_0.png)

2. We will choose **Non-Integrated Replicat** for initial load, click **Next**. In non-integrated mode, the Replicat process uses standard SQL to apply data directly to the target tables. In our case, the number of records in the source database is small and we don't need to run in parallel, therefore it will suffice.

	![](/images/3.goldengate_repload_1.png)

3. Provide a name for the replicat process, for example, **REPLOAD**, because this will be our initial-load replicat process.

	![](/images/3.goldengate_repload_2_1.png)

4. Scroll down to **Credentials Domain**, choose **OracleGoldenGate** from drop-down list. In the **Credential Alias**, choose **target19** from the drop-down list.

	![](/images/3.goldengate_repload_2_2.png)

5. Scroll below and find **Trail Name**, add _**ix**_ as trail name in the field. Because we configured the **INITLOAD** process with this name, so it _**cannot**_ be a random trail name.

	![](/images/3.goldengate_repload_2_3.png)

6. Choose a **Checkpoint Table** from the drop-down list. It is **GGADMIN.CHKPT** in our case. Review everything then click **Next**

	![](/images/3.goldengate_repload_2_4.png)

7. GoldenGate Service created a draft parameter file, replace the below line from the existing draft parameter:

	```MAP *.*, TARGET *.*``` 
	
	with the following lines:

	```
	<copy>
	MAP HR.REGIONS, TARGET HR.REGIONS;
	MAP HR.COUNTRIES, TARGET HR.COUNTRIES;
	MAP HR.LOCATIONS, TARGET HR.LOCATIONS;
	MAP HR.JOBS, TARGET HR.JOBS;
	MAP HR.JOB_HISTORY, TARGET HR.JOB_HISTORY;
	MAP HR.EMPLOYEES, TARGET HR.EMPLOYEES;
	MAP HR.DEPARTMENTS, TARGET HR.DEPARTMENTS;
	</copy>
	```

	Correct parameter file should be looking like the below image.

	![](/images/3.goldengate_repload_3.png)

8. Click **Create and Run** to start our replicat.

	![](/images/3.goldengate_ext_5.png)

## **Step 8**: Run update statement at the source database.

1. Okay, now let's make some changes in the source database to make this migration closer to real-life scenario. Open your cloud-shell and run the below to enter the work directory.

	```
	<copy>
	cd ~/oci_gg_cloud_service
	</copy>
	```

2. Then run the below, make sure you **replace** with your source IP address. 
	
	```
	<copy>
	sqlplus hr/GG##lab12345@ip_address_source_database:1521/ORCL @update.sql
	</copy>
	```

	This statement updates a row in the countries table and it is already captured by **EXTPRIM** process. We now need to create another replicat to apply those captured changes at source to the target database.

	![](/images/3.goldengate_repcont_update.png)

## **Step 9**: Configure the continuous replicat at the target database.

1. On the overview page, go to Replicat part and click on **+** to create our continuous replicat process.

	![](/images/3.goldengate_repcont_0.png)

2. We will choose **Non-Integrated Replicat** for initial load, click **Next**. 

	![](/images/3.goldengate_repcont_1.png)

3. Provide a name for the replicat process, for example, **REPCONT**, because this will be our continuous replication process.

	![](/images/3.goldengate_repcont_2_1.png)

4. Scroll down to **Credentials Domain**, choose **OracleGoldenGate** from drop-down list. In the **Credential Alias**, choose **target19** from the drop-down list.

	![](/images/3.goldengate_repcont_2_2.png)

5. Scroll below and find **Trail Name**, add _**ex**_ as trail name in the field. Because we defined this in the **EXTPRIM** process, so it _**cannot**_ be a random name.

	![](/images/3.goldengate_repcont_2_3.png)

6. Choose a **Checkpoint Table** from the drop-down list. It is **GGADMIN.CHKPT** in our case. Review everything then click **Next**

	![](/images/3.goldengate_repcont_2_4.png)

7. Again, replace the below line from the existing draft parameter:

	```MAP *.*, TARGET *.*``` 
	
	with the following lines:

	```
	<copy>
	MAP HR.REGIONS, TARGET HR.REGIONS;
	MAP HR.COUNTRIES, TARGET HR.COUNTRIES;
	MAP HR.LOCATIONS, TARGET HR.LOCATIONS;
	MAP HR.JOBS, TARGET HR.JOBS;
	MAP HR.JOB_HISTORY, TARGET HR.JOB_HISTORY;
	MAP HR.EMPLOYEES, TARGET HR.EMPLOYEES;
	MAP HR.DEPARTMENTS, TARGET HR.DEPARTMENTS;
	</copy>
	```

	Correct parameter file should be looking like the below image.

	![](/images/3.goldengate_repcont_3.png)

8. Now do not click run, just choose **Create**. Because we need to add **SCN** to start synchronization.

	![](/images/3.goldengate_repcont_4.png)

9. From the replicats area, find **REPCONT** and click on **Action**. You need to select _**Start with Options**_ here. By doing this, you'd be able provide **SCN** information. Because initial-load process extracted data as of **SCN** that we captured from database then populated our target database. Therefore this replicat **REPCONT** should be running after that **SCN** number, to make sure source and target are consistent.

	![](/images/3.goldengate_repcont_5.png)

10. Choose **After CSN** from Start Point, and provide the SCN you retrieved in Step 6 into the **CSN**. In this workshop case, 1667664 was SCN number I used for the initial-load replicat. Now click **Start**

	![](/images/3.goldengate_repcont_6.png)

	_**NOTE:** We captured System Change Number (SCN) from source database, which increments whenever commit occurs. In GoldenGate terminology Commit Sequence Number (CSN), in fact it identifies a point in time when transaction commits. Different naming, but same concept.

11. You can open the **REPCONT** extract process and navigate to the statistics tab, where you will find if **REPCONT** applied the change data from the **EXTPRIM** process.

	![](/images/3.goldengate_repcont_7.png)

	Congratulations! You have completed this workshop!

	You successfully migrated the Oracle 12c on-premises database to Oracle Autonomous Database in OCI.

**This concludes this lab. You may now [proceed to the next lab](#next).**

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - 
* **Last Updated By/Date** - Bilegt Bat-Ochir 9/1/2021