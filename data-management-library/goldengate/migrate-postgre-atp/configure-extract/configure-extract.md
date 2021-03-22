# Configure extract processes

## Introduction

With Oracle GoldenGate Classic for PosgreSQL, you can perform initial loads and capture transactional data from supported PostgreSQL versions and replicate the data to a PostgreSQL database or other supported Oracle GoldenGate targets, such as an Oracle Database. 

*Estimated lab time*: 30 minutes

### Objectives

We had created source database and pre-loaded with some sample data in it during lab-1 using terraform script. 

In this lab 3, we will configure extract processes in Oracle Goldengate classic deployment for PostgreSQL.

-	An extract for changed data capture. Exttab process will start capturing changes and this will create some files called trails.
-	An extract for sending those capture to GG Microservices. Extdmp will be pumping trail files.
-	An Initial-Load extract. While changes are being captured, migration step needs special type of extract and replicat process, this is is cold data. Usually after initial load finishes, we start applying changed data while initial load happens.

	![](/images/general.gif)

## **Step 1**: Connect to your Microservices instance and configure Firewall

1. We need to enable network access to Microservices from our Classic deployment. Without adding ports to Microservices' firewall would cause you failure in next steps. Let's make console connection to microservice, copy ip address of `OGG_Microservices_Public_ip` from your note and connect using:

	**`ssh opc@your_microservice_ip_address -i ~/.ssh/oci`**

2. Once you are there run below commands, which will add ports and take them in effect.

	```
	<copy>
	sudo firewall-cmd --zone=public --permanent --add-port=9011-9014/tcp

	sudo firewall-cmd --zone=public --permanent --add-port=9021-9024/tcp

	sudo firewall-cmd --zone=public --permanent --add-port=443/tcp

	sudo firewall-cmd --zone=public --permanent --add-port=80/tcp

	sudo firewall-cmd --zone=public --permanent --add-port=7809-7810/tcp

	sudo firewall-cmd --reload
	</copy>
	```

3. Exit from this instance with command **`exit`** and go back to your cloud-shell.


## **Step 2**: Access to Goldengate classic instance

1. Oracle GoldenGate Classic for Non-Oracle (PostgreSQL) allows you to quickly access the GoldenGate Service Command Interface (GGCSI) and is preconfigured with a running Manager process. Copy ip address of `OGG_PGSQL_Public_ip` from your note and connect using:

	**`ssh opc@your_ogg_pgsql_ip_address -i ~/.ssh/oci`**

## **Step 3**: Run GGSCI 

1. After logging in to the compute node, you need to make sure your Goldengate environment knows about current odbc driver, execute the following commands separately in your cloud-shell:

	```
	export ODBCINI=/home/opc/postgresql/odbc.ini

	cd /usr/local/bin/
	```

2. Then run below command to start GGSCI to start:

	```
	./ggsci
	```

	![](/images/gg_pg_config_2.gif)

## **Step 4**: Create Goldengate work directories 

1. We need to create our work directories in GoldenGate before we start working. Command creates the default directories within the Oracle GoldenGate home directory. When you are in GGSCI console, issue below command to create your directories.

	```
	CREATE SUBDIRS
	```

## **Step 5**: Edit Goldengate Manager Port

1. We need to set manager’s port to start Goldengate manager process. To do so, issue:

	```
	EDIT PARAMS MGR
	```

2. It will open parameter file of manager process and enter and save.

	```
	PORT 7809
	```
_**NOTE:** Editing uses **vi** editor, you have to press key **i** to edit and press **:wq** keys then **hit enter** for save & quit._

## **Step 6**: Start Goldengate Manager

1. Now start Goldengate manager process by issuing below command:

	```START MGR```

2. You can check if manager status by issueing **`INFO MGR`** command.

	![](/images/gg_pg_config_3.gif)

## **Step 7**: Connect to Source DB

1. Run the following command to log into the database from Goldengate instance:

	**```DBLOGIN sourcedb PostgreSQL USERID postgres PASSWORD postgres```**

2. You should be able to see below information saying *Successfully Logged into database*

	![](/images/gg_pg_dblogin.png)

Now you are logged into source database from GGSCI console, which means you are ready to proceed. Remember that we need to create three extract processes and we have five tables in source database.

## **Step 8**: Enabling Supplemental Logging

1. After logging to the source database, you must enable supplemental logging on the source schema for change data capture. 
The following commands are used to enable supplemental logging at table level.


	```
	<copy>
	add trandata public."Countries"

	add trandata public."Cities"

	add trandata public."Parkings"

	add trandata public."ParkingData"

	add trandata public."PaymentData"
	</copy>
	```

	![](/images/gg_pg_trandata.png)


## **Step 9**: Registering a EXTTAR

Oracle GoldenGate needs to register the extract with the database replication slot, before adding extract process in Goldengate. 
_**Ensure that you are connected to SourceDB using the DBLOGIN command.**_

Let's begin to create the first extract process, which is continuous replication in usual migration and replication project scenario.


1. First register your extract: 

	```register extract exttar```

![](/images/gg_pg_exttar_0.png)

2. Then edit extract configuration with **`edit params exttar`**. 

	![](/images/gg_pg_exttar_1.png)

3. Insert below as your exttar parameter:
	```
	EXTRACT exttar
	SOURCEDB PostgreSQL USERID postgres PASSWORD postgres
	EXTTRAIL ./dirdat/pd
	TABLE public."Countries";
	TABLE public."Cities";
	TABLE public."Parkings";
	TABLE public."PaymentData";
	TABLE public."ParkingData";
	```
and save!

_**NOTE:** Editing uses **vi** editor, you have to press key **i** to edit and press **:wq** keys then **hit enter** for save & quit._

4. To create your extract process issue below commands:

	```
	add extract exttar, tranlog, begin now

	add exttrail ./dirdat/pd, extract exttar
	```

	![](/images/gg_pg_exttar_2.png)

5. Confirm everything is correct then start this extract by issuing below command:
 
	```start exttar```

	![](/images/gg_pg_exttar_3.png)

6. After completing this, you should be able to see status of extract with **`info all`** command and result should show you **RUNNING** state.

	![](/images/gg_pg_exttar.png)

This process is capturing change data from your source database. As it was mentioned earlier, this is necessary step for continuous replication or zero downtime migration project. 

Because changes are being captured in live and meanwhile at some point during this process you need to do initial load to your target database.
As soon as initial load process finished and you loaded, let’s say your warm data at your target database, you need to start applying captured data whilst you were importing. 

Once you are satisfied with source and target databases data quality, you can do cut over and point you application connections to your target database.

## **Step 10**: Registering a EXTDMP

Oracle GoldenGate needs to register the extract with the database replication slot, before adding extract process in Goldengate. 
*Ensure that you are connected to SourceDB using the DBLOGIN command.*

Now changes are being captured from source database and we need to send that to GG microservices, in order to apply at target database. Therefore we need another process, which acts as extract but sends existing trail files to GG microservices.

1. Again, register your extdmp extract:

	```register extract extdmp```

	![](/images/gg_pg_extdmp_0.png)

2. Then edit extract configuration with **`edit params extdmp`** similar to previous step.

	![](/images/gg_pg_extdmp_1.png)

3. Insert below as your extdmp parameter, but **make sure** you change **ip_address** with your GG Microservice's IP Address! Why? Because we will send extracted records to Microservice.

	```
	EXTRACT extdmp
	RMTHOST ip_address, PORT 9023
	RMTTRAIL pd
	PASSTHRU
	TABLE public."Countries";
	TABLE public."Cities";
	TABLE public."Parkings";
	TABLE public."PaymentData";
	TABLE public."ParkingData";
	```

_**NOTE**:Editing uses **vi** editor, so you have to press **i** for editing the file, when you are done press **:wq** then **hit enter** for save & quit._

4. To create your extract process issue below commands:

	```
	add extract extdmp, exttrailsource ./dirdat/pd

	add rmttrail pd, extract extdmp, megabytes 50
	```

	![](/images/gg_pg_extdmp_2.png)

5. Confirm everything is correct then start this extract by issuing below command:
 
	```start extdmp```


	![](/images/gg_pg_extdmp_3.png)

6. After completing this, you should be able to see status of extract with **`info all`** command and result should show you **RUNNING** state.

	![](/images/gg_pg_extdmp.png)

EXTTAR process is capturing your changes at your source database, however it is going nowhere rather than being kept at Goldengate instance.
 
EXTDMP process is then pumping captured trail files to Goldengate Microservices instance. We will check if this is working properly in Lab-4.
These two processes were preparation for change synchronization.


## **Step 11**: Registering a INITLOAD

So far, we created 2 extract processes which are now capturing changes and shipping to Goldengate Microservices instance.

However, we are not yet loaded our static data directly from source objects to target database. This specific process is called Initial-load. Steps are similar to the previous extract processes

1. Again register your initload 

	```register extract init``` 

	![](/images/gg_pg_initload_0.png)

2. To edit initial load configuration, issue below:

	```edit params init```

	![](/images/gg_pg_initload_1.png)

3. Insert below as your initial load parameter, but **make sure** you change **ip_address** with your GG Microservice's IP Address! Why? Because we will send extracted records to Microservice.

	```
	EXTRACT init
	SOURCEDB PostgreSQL USERID postgres PASSWORD postgres
	RMTHOST ip_address, PORT 9023
	RMTFILE il
	TABLE public."Countries";
	TABLE public."Cities";
	TABLE public."Parkings";
	TABLE public."PaymentData";
	TABLE public."ParkingData";
	```

_**NOTE**:Editing uses **vi** editor, so you have to press **i** for editing the file, when you are done press **:wq** then **hit enter** for save & quit._

4. After that add your initial load process:

	```
	add extract init, sourceistable
	```
	
Extract process extracts a current set of static data directly from the source objects in preparation for an initial load to another database. SOURCEISTABLE type does not use checkpoints. 

	![](/images/gg_pg_initload_2.png)

5. Confirm everything is correct then start initial load by issuing below command: 

	```start init``` 

	![](/images/gg_pg_initload_3.png)

6. You can see status of this special type of extract process with **`info init`. **

	![](/images/gg_pg_initload.png)

Note that number of record is 10000 and status is already STOPPED. Because our sample data has only 5 tables and few records, initial load will take only few seconds.

7. You can see more information about extract process with:

	```
	view report init
	```

	![](/images/gg_pg_initload_report.png)

It is good way to investigate your Goldengate process result. I can see some good statistics at the end of this report

**This concludes this lab. You may now [proceed to the last lab](#next).**

## **Rate this Workshop**

Don't forget to rate this workshop!  We rely on this feedback to help us improve and refine our LiveLabs catalog.  Follow the steps to submit your rating.

1.  Go back to your **workshop homepage** in LiveLabs by going back to your workshop and clicking the Launch button.
2.  Click on the **Brown Button** to re-access the workshop  

    ![](/images/workshop-homepage-2.png " ")

3.  Click **Rate this workshop**

    ![](/images/rate-this-workshop.png " ")

## Acknowledgements

* **Author** - Bilegt Bat-Ochir " Senior Solution Engineer"
* **Contributors** - John Craig "Technology Strategy Program Manager", Patrick Agreiter "Senior Solution Engineer"
* **Last Updated By/Date** - Bilegt Bat-Ochir 3/22/2021