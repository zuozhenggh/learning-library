# Configure Extract Processes

## Introduction

With Oracle GoldenGate Classic for PostgreSQL, you can perform initial loads and capture transactional data from supported PostgreSQL versions. You can replicate the data to a PostgreSQL database or other supported Oracle GoldenGate targets, such as an Oracle Database. 

*Estimated lab time*: 30 minutes

### Objectives

We have created a source database and pre-loaded it with some sample data during lab 1 using terraform script. 

In this lab, we will configure _**three extract**_ processes within Oracle Goldengate classic deployment for PostgreSQL.

-	An extract for **changed data capture**. Exttab process will start capturing changes and this will create some files called trails.
-	An extract for **sending those captured files** to GG Microservices. Extdmp will be pumping trail files.
-	An Initial-Load extract. While changes are being captured, the migration step needs a special type of extract and replicat process, this is cold data. Usually, after the initial load finishes, we will be applying the captured changed rows during the initial load.

	![](/images/general.gif)

### Prerequisites

* This lab assumes that you completed all preceding labs.

## **Step 1**: Connect to Microservices Instance

1. We need to enable network access to Microservices from our Goldengate Classic instance. Without adding the ports to the Microservices' firewall, it would cause failure in the next step. Let's make a console connection to the Microservices instance, copy the IP address of `OGG_Microservices_Public_ip` from your note and connect using:

	**`ssh opc@your_microservice_ip_address -i ~/.ssh/oci`**

2. Once you are there run the below commands, which will add the necessary ports:

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

## **Step 2**: Access to Goldengate Classic Instance

1. Oracle GoldenGate Classic for Non-Oracle (PostgreSQL) allows you to quickly access the GoldenGate Service Command Interface (GGCSI) and is preconfigured with a running Manager process. Copy the IP address of `OGG_PGSQL_Public_ip` from your note and connect using:

	**`ssh opc@your_ogg_pgsql_ip_address -i ~/.ssh/oci`**

## **Step 3**: Run GGSCI 

1. After logging in to the compute node, you need to make sure your Goldengate environment knows about the current odbc driver. Execute the following commands separately in your cloud-shell:

	```
	export ODBCINI=/home/opc/postgresql/odbc.ini

	cd /usr/local/bin/
	```

2. Then run the below command to start GGSCI to start:

	```
	./ggsci
	```

	![](/images/gg_pg_config_2.gif)

## **Step 4**: Create Goldengate Directories 

1. We need to create our work directories in GoldenGate before we start working. The below command creates the default directories within the Oracle GoldenGate home directory. When you are in GGSCI console, run the below command to create your directories.

	```
	CREATE SUBDIRS
	```

## **Step 5**: Edit Goldengate Manager Port

1. We need to set the manager’s port to start the Goldengate manager process. To do so, issue:

	```
	EDIT PARAMS MGR
	```

2. It will open the parameter file of the manager process and enter the below port value and save it.

	```
	PORT 7809
	```
	_**NOTE:** Editing uses **vi** editor, you have to press key **i** to edit and press **:wq** keys then **hit enter** for save & quit._

## **Step 6**: Start Goldengate Manager

1. Now start Goldengate manager process by issuing the below command:

	```START MGR```

2. You can check manager status by issuing **`INFO MGR`** command.

	![](/images/gg_pg_config_3.gif)

## **Step 7**: Connect to Source DB

1. Run the following command to log into the database from Goldengate instance:

	**```DBLOGIN sourcedb PostgreSQL USERID postgres PASSWORD postgres```**

2. You should be able to see below information saying *Successfully Logged into database*

	![](/images/gg_pg_dblogin.png)

	Now you are logged into the source database from GGSCI console, which means you are ready to proceed. Remember that we need to create three extract processes and we have five tables in the source PostgreSQL database.

## **Step 8**: Enabling Supplemental Logging

1. After logging into the source database, you must enable supplemental logging on the source schema for change data capture. The following commands are used to enable supplemental logging at the table level.

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

## **Step 9**: Registering EXTTAR

Oracle GoldenGate needs to register an extract with the database replication slot before adding the extract process. Let's begin to create the first extract process, which is continuous replication in the usual migration and replication project scenario. _**Ensure that you are connected to SourceDB using the DBLOGIN command **_ before doing the next steps.

1. First register your extract: 

	```
	register extract exttar
	```

	![](/images/gg_pg_exttar_0.png)

2. Then edit extract configuration with:

	```
	edit params exttar
	```

	![](/images/gg_pg_exttar_1.png)

3. Insert below as your exttar parameter and save:

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

	_**NOTE:** Editing uses **vi** editor, you have to press key **i** to edit and press **:wq** keys then **hit enter** for save & quit._

4. To create your extract process issue below commands:

	```
	add extract exttar, tranlog, begin now

	add exttrail ./dirdat/pd, extract exttar
	```

	![](/images/gg_pg_exttar_2.png)

5. Confirm everything is correct then start this extract by issuing the below command:

	```
	start exttar
	```

	![](/images/gg_pg_exttar_3.png)

6. After completing this, you should be able to check the status of the extract with **`info all`** command and the result should show the **RUNNING** state.

	![](/images/gg_pg_exttar.png)

	This process is capturing change data from your source database. As it was mentioned earlier, this is a necessary step for a continuous replication or a zero downtime migration project. 

	Changes are now being captured live and at some point during this process you will need to do the initial load to your target database. As soon as the initial load process as finished and you have loaded to target database, you need to start applying the captured data.

	Once you are satisfied with source and target databases data quality, you can do cut over and point your application connections to your target database.

## **Step 10**: Registering EXTDMP

Now changes are being captured from the source database and we need to send them to GG microservices in order to apply to the target database. Therefore we need another process, which acts as an extract but sends existing trail files to GG microservices. _**Ensure that you are connected to the source database using the DBLOGIN command**_ before doing the next steps.

1. Again, register your extdmp extract:

	```
	register extract extdmp
	```

	![](/images/gg_pg_extdmp_0.png)

2. Similar to previous step, edit extract configuration with the below:

	```
	edit params extdmp
	```

	![](/images/gg_pg_extdmp_1.png)

3. Insert below as your extdmp parameter, and **make sure** you must change _**ip address**_ with your GG Microservice's IP Address! Why? Because we will send extracted records to Microservice.

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

	_**NOTE**: Editing uses **vi** editor, so you have to press **i** for editing the file, when you are done press **:wq** then **hit enter** for save & quit._

4. To create your extract process, issue the below commands:

	```
	add extract extdmp, exttrailsource ./dirdat/pd

	add rmttrail pd, extract extdmp, megabytes 50
	```

	![](/images/gg_pg_extdmp_2.png)

5. Confirm everything is correct then start this extract by issuing below command:

	```
	start extdmp
	```

	![](/images/gg_pg_extdmp_3.png)

6. After completing this, you should be able to see the status of the extract with **`info all`** command and the result should show you **RUNNING** state.

	![](/images/gg_pg_extdmp.png)

	EXTTAR process is capturing your changes at your source database, however, it is only locally kept in the Goldengate instance.

	EXTDMP process is then pumping the captured trail files to Goldengate Microservices instance. 
	
	We will check if this is working properly in the next lab. These two processes are preparation for change synchronization for continuous replication.


## **Step 11**: Registering INITLOAD

Up to now, we created 2 extract processes that are now capturing changes and shipping to the Goldengate Microservices instance. However, we have not yet loaded our static data directly from our source objects to a target database. This specific process is called Initial-load. Steps are similar to the previous extract processes. _**Ensure that you are connected to the source database using the DBLOGIN command**_ before doing the next steps.

1. Register your initial load:

	```
	register extract init
	```

	![](/images/gg_pg_initload_0.png)

2. To edit initial load configuration, issue below:

	```
	edit params init
	```

	![](/images/gg_pg_initload_1.png)

3. Insert the below as your initial load parameter, and **make sure** you must change _**ip address**_ with your GG Microservice's IP Address! Why? Because we will send extracted records to Microservice.

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

4. After that add your initial load process. The extract process captures a current set of static data directly from the source objects in preparation for an initial load to another database. SOURCEISTABLE type does not use checkpoints.

	```
	add extract init, sourceistable
	```

	![](/images/gg_pg_initload_2.png)

5. Confirm everything is correct then start the initial load by issuing the below command: 

	```
	start init
	```

	![](/images/gg_pg_initload_3.png)

6. You can see status of this special type of extract process with **`info init`**.

	![](/images/gg_pg_initload.png)

	Note that the number of records is 10000 and the status is already STOPPED. Because our sample data has only 5 tables and a few records, the initial load will take only a few seconds.

7. You can see more information about extract process with:

	```
	view report init
	```

	![](/images/gg_pg_initload_report.png)

	This is a good way to investigate your Goldengate process result. You can see some statistics at the end of this report

**This concludes this lab. You may now [proceed to the last lab](#next).**


## Acknowledgements

* **Author** - Bilegt Bat-Ochir " Senior Solution Engineer"
* **Contributors** - John Craig "Technology Strategy Program Manager", Patrick Agreiter "Senior Solution Engineer"
* **Last Updated By/Date** - Bilegt Bat-Ochir 3/22/2021