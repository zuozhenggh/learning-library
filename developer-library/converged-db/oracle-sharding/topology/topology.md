# Exploring Sharding Topology

## Introduction   
The **sharded database topology** is described by the sharding metadata in the shard catalog database. GDSCTL is used to configure the sharded database topology

Like SQL*Plus, **GDSCTL** is a command-line utility with which you can configure, deploy, monitor, and manage an Oracle Sharding sharded database.
You can run GDSCTL remotely from a different server or laptop to configure and deploy a sharded database topology, and then monitor and manage your sharded database. 
Run the commands from a shard director host because the GDSCTL command line interface is installed there as part of the shard director (global service manager) installation.


*Estimated Lab Time*: 20 Minutes

 ![](./images/topology.JPG " ")  

As shown in the diagram above, the sharded database is deployed as multiple containers all running within the same Compute VM. 


### Objectives
In this lab, you will:
* Setup the environment for JSON lab.
* Connect the Oracle SQL developer to Insert and Update the JSON Data into Oracle Database by using JSON Function.
* Learn about the JSON functions.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

***Note:***  All the scripts for this lab are stored in the **`/u01/workshop/json`** folder and run as the **oracle** user.

## **STEP 0**: Sharding Overview & Architecture

Oracle Sharding is a feature of Oracle Database that lets you automatically distribute and replicate data across a pool of Oracle databases that share no hardware or software. Oracle Sharding provides the best features and capabilities of mature RDBMS and NoSQL databases.

![](./images/arch.JPG " ")  

**Core Components of the Oracle Sharding Architecture**

1. **Partitions, Tablespaces and Chunks:** Distribution of partitions across shards is achieved by creating partitions in tablespaces that reside on different shards.
   
2. **Tablespace Sets:** Oracle Sharding creates and manages tablespaces as a unit called a TABLESPACE SET.

3. **Sharding Methods:** The following topics discuss sharding methods supported by Oracle Sharding, how to choose a method, and how to use subpartitioning.

4. **Sharded Database Schema Objects:** To obtain the benefits of sharding, the schema of a sharded database should be designed in a way that maximizes the number of database requests executed on a single shard. The following topics define and illustrate the schema objects that form a sharded database to inform your design.

**Sharding Components**

1. **Shard Director:** Shard directors are network listeners that enable high performance connection routing based on a sharding key.
   
2. **Global Service:** A global service is a database service that is use to access data in a sharded database.
   
3. **Shard Catalog:** A shard catalog is an Oracle Database that supports automated shard deployment, centralized management of a sharded database, and multi-shard queries.
   
4. **Sharded Database and Shards:** A sharded database is a collection of shards.


**Sharded database schema objects**

To obtain the benefits of sharding, the schema of a sharded database should be designed in a way that maximizes the number of database requests executed on a single shard. The following topics define and illustrate the schema objects that form a sharded database to inform your design.

**Sharded Tables:** A database table is split up across the shards, so that each shard contains the table with the same columns, but a different subset of rows. A table split up in this manner is called a sharded table.

**Sharded Table Family:** A sharded table family is a set of tables that are sharded in the same way. Often there is a parent-child relationship between database tables with a referential constraint in a child table (foreign key) referring to the primary key of the parent table.

**Duplicated Tables:** In Oracle Sharding a table with the same contents in each shard is called a duplicated table.

**Non-Table Objects Created on All Shards:** In addition to duplicated tables, other schema objects, such as users, roles, views, indexes, synonyms, functions, procedures, and packages, and non-schema database objects, such as tablespaces, tablespace sets, directories, and contexts, can be created on all shards.

## **STEP 1**: Check for containers in your VM.

1. Open a terminal window and sudo to the user **root**

    ```
    <copy>
    docker ps -a
    </copy>
    ```

## **STEP 2**: Connect to Shard director

A **shard director** is a specific implementation of a global service manager that acts as a regional listener for clients that connect to a sharded database. The director maintains a current topology map of the sharded database. Based on the sharding key passed during a connection request, the director routes the connections to the appropriate shard. The key capabilities of shard directors are as follows.

-	Maintain runtime data about sharded database configuration and availability of shards.
-	Measure network latency between its own and other regions.
-	Act as a regional listener for clients to connect to a sharded database.
-	Manage global services.
-	Perform connection load balancing

1. Run in the terminal as **root** user.
    ```
    <copy>
    docker exec -i -t gsm1 /bin/bash
    </copy>
    ```
    ```
    <copy>
    gdsctl
    </copy>
    ```
    
2. Verify sharding topology using the  **CONFIG** command.

    ```
    <copy>
    config
    </copy>
    ```

3. Check list of CDBs in the catalog.

    ```
    <copy>
    config cdb
    </copy>
    ```

4. Check  the detailed status of each shard.

    ```
    <copy>
    config shard -shard orcl1cdb_orcl1pdb
    </copy>
    ```

5. Verify the current shard configuration.

    ```
    <copy>
    config shard
    </copy>
    ```

6.  Use **STATUS** to view locations for shard director (GSM) trace and log files.

    ```
    <copy>
    databases
    </copy>
    ```
    
    ```
    <copy>
    status service
    </copy>
    ```

    ```
    <copy>
    config service
    </copy>
    ```

    ```
    <copy>
    config table family
    </copy>
    ```
    ```
    <copy>
    show ddl
    </copy>
    ```

## **STEP 3**: Connect to Catalog

A **shard catalog** is a special-purpose Oracle Database that is a persistent store for sharded database configuration data and plays a key role in centralized management of a sharded database. All configuration changes, such as adding and removing shards and global services, are initiated on the shard catalog. All DDLs in a sharded database are executed by connecting to the shard catalog.
The shard catalog also contains the master copy of all duplicated tables in a sharded database. The shard catalog uses materialized views to automatically replicate changes to duplicated tables in all shards. The shard catalog database also acts as a query coordinator used to process multi-shard queries and queries that do not specify a sharding key. 
A shard catalog serves following purposes.

-	Serves as an administrative server for entire shareded database
-	Stores a gold copy of the database schema
-	Manages multi-shard queries with a multi-shard query coordinator
-	Stores a gold copy of duplicated table data

1. Run in the terminal as **root** user.

    ```
    <copy>
    docker exec -i -t catalog /bin/bash
    </copy>
    ```
    ```
    <copy>
    gdsctl
    </copy>
    ```

2. Connect to the database as test user.
   
    ```
    <copy>
    sqlplus shardusertest/oracle@CAT1PDB
    </copy>
    ```

    ```
    <copy>
    set pagesize 300;
    set linesize 300; 
    col OBJECT_NAME for a30;
    col Sharding for a30;
    select OBJECT_NAME,SHARDED as Sharding from user_objects where SHARDED='Y' and OBJECT_NAME in ('PRODUCTS','REVIEWS','CUSTOMER','CART');

    </copy>
    ```

     ```
    <copy>
    set heading off;
    select 'PRODUCT', count(*) from products union select 'REVIEWS', count(*) from reviews;

    </copy>
    ```

## **STEP 4**: Connect to Shard 1 Database

Each **shard** in the **sharded database** is an independent Oracle Database instance that hosts subset of a sharded database's data. Shared storage is not required across the shards.

Shards can be hosted anywhere an Oracle database can be hosted. Oracle Sharding supports all of the deployment choices for a shard that you would expect with a single instance or clustered Oracle Database, including on-premises, any cloud platform, Oracle Exadata Database Machine, virtual machines, and so on.


1.  Run in the terminal as **root** user.
    ```
    <copy>
    docker exec -i -t shard1 /bin/bash
    </copy>
    ```

2. Connect to the shard as test user.
   
    ```
    <copy>
    sqlplus SHARDUSERTEST/oracle@PORCL1PDB 
    </copy>
    ```

    ```
    <copy>
    set pagesize 300;
    set linesize 300; 
    col OBJECT_NAME for a30;
    col Sharding for a30;
    select OBJECT_NAME,SHARDED as Sharding from user_objects where SHARDED='Y' and OBJECT_NAME in ('PRODUCTS','REVIEWS','CUSTOMER','CART');
    </copy>
    ```

    ```
    <copy>
    set heading off;
    select 'PRODUCT', count(*) from products union select 'REVIEWS', count(*) from reviews;
    </copy>
    ```
    You can find the difference of the row count between Shard catalog vs shard-DB 			(porcl1cdb_porcl1pdb/ porcl2cdb_porcl2pdb/ porcl3cdb_porcl3pdb).

3. Check the status of the agent.
   
    ```
    <copy>
    schagent -status
    </copy>
    ```

## **STEP 5**: Connect to Shard 2 Database
1.  Run in the terminal as **root** user.

    ```
    <copy>
    docker exec -i -t shard2 /bin/bash
    </copy>
    ```

2. Check the status of the agent.
   
    ```
    <copy>
    schagent -status
    </copy>
    ```

## **STEP 6**: Sharding Methods

The following topics discuss sharding methods supported by Oracle Sharding, how to choose a method, and how to use subpartitioning.
- System-Managed Sharding : System-managed sharding is a sharding method which does not require the user to specify mapping of data to shards. Data is automatically distributed across shards using partitioning by consistent hash. The partitioning algorithm evenly and randomly distributes data across shards.

-	User-Defined Sharding : User-defined sharding lets you explicitly specify the mapping of data to individual shards. It is used when, because of performance, regulatory, or other reasons, certain data needs to be stored on a particular shard, and the administrator needs to have full control over moving data between shards.

-	Composite Sharding : The composite sharding method allows you to create multiple shardspaces for different subsets of data in a table partitioned by consistent hash. A shardspace is set of shards that store data that corresponds to a range or list of key values.

-	Using Subpartitions with Sharding : Because Oracle Sharding is based on table partitioning, all of the subpartitioning methods provided by Oracle Database are also supported for sharding.

In this workshop, we have choosen System-Managed Sharding. Below are sample Sharding configuration table DDLs:

    ```
    <copy>
    CREATE SHARDED TABLE "CUSTOMER_AUTH"
	( "USER_ID" NUMBER NOT NULL ENABLE,
	"EMAIL" VARCHAR2(200 BYTE) NOT NULL ENABLE,
	"PASSWORD" VARCHAR2(100 BYTE) NOT NULL ENABLE,
	PRIMARY KEY ("USER_ID")
	)
    TABLESPACE SET TTTSP_SET_1   PARTITION BY CONSISTENT HASH (USER_ID) PARTITIONS AUTO;

    </copy>
    ```

    ```
    <copy>
    CREATE SHARDED TABLE "PRODUCTS"
       ( "SKU" VARCHAR2(255 BYTE) NOT NULL ENABLE,
         "JSON_TEXT" CLOB,
          CHECK ("JSON_TEXT" is json strict) ENABLE,
          PRIMARY KEY ("SKU")
      ) TABLESPACE SET TTTSP_SET_2 PARTITION BY CONSISTENT HASH (SKU) PARTITIONS AUTO;
    
    </copy>
    ```

## Learn More

- Oracle JSON Documentation ([JSON](https://docs.oracle.com/en/database/oracle/oracle-database/19/adjsn/index.html))

## Rate this Workshop
When you are finished don't forget to rate this workshop!  We rely on this feedback to help us improve and refine our LiveLabs catalog.  Follow the steps to submit your rating.

1.  Go back to your **workshop homepage** in LiveLabs by searching for your workshop and clicking the Launch button.
2.  Click on the **Brown Button** to re-access the workshop  

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/images/workshop-homepage-2.png " ")

3.  Click **Rate this workshop**

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/images/rate-this-workshop.png " ")

If you selected the **Green Button** for this workshop and still have an active reservation, you can also rate by going to My Reservations -> Launch Workshop.

## Acknowledgements
* **Authors** - 
* **Contributors** - 
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, December 2020
