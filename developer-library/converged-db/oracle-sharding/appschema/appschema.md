# Eshop App schema & Code Snippet

## Introduction   
This eShop application is developed on NodeJS, HTML code by using mainly JSON/SODA tables for non-relational and some regular relational tables.

In the Oracle database, JSON documents can be stored inside relational tables. The tables themselves act as JSON collections and each row is a JSON document. Within each row one field of type BLOB, CLOB, or OSON.

Although Oracle provides support for JSON operators in order to create, work with, and retrieve JSON documents, the SODA (Simple Oracle Document Access) interface is also supported. SODA acts as a layer on top of table access allowing a more intuitive interface for working with JSON documents.

*Estimated Lab Time*: 20 Minutes

### Objectives
In this lab, you will:
* Understand application code.
* Understand application connectivity.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

## **STEP 1**: Application code Snippet (Node JS, HTML, etc)

1. Create Sharded table for use by JSON/SODA

    ```
    <copy>
    CREATE SHARDED TABLE "REVIEWS"
	( "REVID" VARCHAR2(255 BYTE) NOT NULL ENABLE,
	"SKU" VARCHAR2(255 BYTE) NOT NULL ENABLE, 
	"JSON_TEXT" CLOB,
	"SENTI_SCORE" NUMBER(4,0),
	CHECK ("JSON_TEXT" is json strict) ENABLE,
	CONSTRAINT  pk_reviews PRIMARY KEY (SKU,REVID), 
	CONSTRAINT  fk_reviews_parent FOREIGN KEY (SKU)
	REFERENCES PRODUCTS (SKU) ENABLE
	)
	PARTITION BY REFERENCE (fk_reviews_parent);

    </copy>
    ```

2. Create SODA Map across all shards:

    ```
    <copy>
    create or replace procedure COLLECTION_PROC_REVIEWS AS
	METADATA varchar2(8000);
	COL SODA_COLLECTION_T;
	begin
	METADATA := '{"tableName":"REVIEWS",
	"keyColumn":{"name":"REVID","assignmentMethod":"CLIENT"},
	"contentColumn":{"name":"JSON_TEXT","sqlType":"CLOB"},
	"readOnly":false}';
 	-- Create a collection using "map" mode, based on the table we've created above 	and specified in
 	-- the custom metadata under "tableName" field.
	COL := 	dbms_soda.create_collection('REVIEWS',METADATA,DBMS_SODA.CREATE_MODE_MAP);
	end ;
	/

	exec sys.exec_shard_plsql('collection_proc_reviews()',4+1); 
    
    </copy>
    ```

## **STEP 2**: Application Connection Details

In Oracle Sharding, database query and DML requests are routed to the shards in two main ways, depending on whether a sharding key is supplied with the request. These two routing methods are called **proxy routing** and **direct routing. **

**Proxy Routing:** Queries that need data from multiple shards, and queries that do not specify a sharding key, cannot be routed directly by the application. Those queries require a proxy to route requests between the application and the shards. Proxy routing is handled by the shard catalog query coordinator. 

Example: Database connection details:

			module.exports = 

			{
               sharding: {

      			  user: 'SHARDUSERTEST',

       			 password: 'oracle',

      			  connectString: '10.0.20.102:1521/cat1pdb',

        				poolMin: 10,

        				poolMax: 10,

        				poolIncrement: 0

  			  }

**Direct Routing:** You can connect directly to the shards to execute queries and DML by providing a sharding key with the database request. Direct routing is the preferred way of accessing shards to achieve better performance, among other benefits.

Example: Database connection details by passing a sharding key:

			connection = await oracledb.getConnection({

            			 user: 'SHARDUSERTEST',

             			password: 'oracle',

             			connectString: '10.0.20.101:1521/oltp_rw_products.shardcatalog1.oradbcloud',

              			shardingKey:[docmt.PRODUCT_ID]

            			  });

For more details for the eShop code snippet click [here] (https://github.com/nishakau/ShardingSampleCode.git)

## Learn More

- [Oracle JSON Developers Guide 19c] (https://docs.oracle.com/en/database/oracle/oracle-database/19/adjsn/index.html)
- [Introduction to SODA] (https://docs.oracle.com/en/database/oracle/simple-oracle-document-access/adsdi/overview-soda.html#GUID-BE42F8D3-B86B-43B4-B2A3-5760A4DF79FB)

## Rate this Workshop
When you are finished don't forget to rate this workshop!  We rely on this feedback to help us improve and refine our LiveLabs catalog.  Follow the steps to submit your rating.

1.  Go back to your **workshop homepage** in LiveLabs by searching for your workshop and clicking the Launch button.
2.  Click on the **Brown Button** to re-access the workshop  

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/images/workshop-homepage-2.png " ")

3.  Click **Rate this workshop**

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/images/rate-this-workshop.png " ")

If you selected the **Green Button** for this workshop and still have an active reservation, you can also rate by going to My Reservations -> Launch Workshop.

## Acknowledgements
* **Authors** - Shailesh Dwivedi, Database Sharding PM , Vice President
* **Contributors** - Alex Kovuru, Nishant Kaushik, Ashish Kumar, Priya Dhuriya, Richard Delval, Param Saini,Jyoti Verma, Virginia Beecher, Rodrigo Fuentes
* **Last Updated By/Date** - Alex Kovuru, Principal Solution Engineer - June 2021
