# Setup HeatWave Clusters in MySQL Database System 
![INTRO](./images/00_mds_heatwave_2.png " ") 


## Introduction

In this hands-on workshop, you will be introduced to MySQL Database Service (MDS), a powerful union between MySQL Enterprise Edition and Oracle Cloud Infrastructure. You will learn how to create and use MySQL Database Service with HeatWave in a secure Oracle Cloud Infrastructure environment.

Estimated Lab Time: 20 minutes


### Objectives

In this lab, you will be guided through the following tasks:

- Add a HeatWave Cluster to MySQL Database System
- Load Airportdb Data into HeatWave


### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell
- Completed Lab 2

## Task 1: Add a HeatWave Cluster to MDS-HW MySQL Database System

1. You will create a HeatWave cluster comprise of a MySQL DB System node and two or more HeatWave nodes. The MySQL DB System node includes a plugin that is responsible for cluster management, loading data into the HeatWave cluster, query scheduling, and returning query result.

    ![Connect](./images/10addheat00.png " ")

2. Open the navigation menu  Databases > MySQL > DB Systems
3. Choose the root Compartment. A list of DB Systems is displayed. 
    ![Connect](./images/10addheat01.png " ")
4. In the list of DB Systems, click on the **MDS-HW** Ssystem. click the “More Action” -> “Add HeatWave Cluster”.
    ![Connect](./images/10addheat02.png " ")
6. On the “Add HeatWave Cluster” dialog, select “MySQL.HeatWave.VM.Standard.E3” shape

6. Click “Estimate Node Count” button
    ![Connect](./images/10addheat03.png " ")
7. On the “Estimate Node Count” page, click “Generate Estimate”. This will trigger the auto
provisioning advisor to sample the data stored in InnoDB and based on machine learning
algorithm, it will predict the number of nodes needed.
    ![Connect](./images/10addheat04.png " ")

8. Once the estimations are calculated, it shows list of database schemas in MySQL node. If
you expand the schema and select different tables, you will see the estimated memory
required in the Summary box, There is s Load Command (analytics_load) generated in the text box window, which will change based on the selection of databases/tables

9. Select the airportdb schema and click “Apply Node Count Estimate” to apply the node count
    ![Connect](./images/10addheat05.png " ")

10. Click “Add HeatWave Cluster” to create the HeatWave cluster
    ![Connect](./images/10addheat06.png " ")
11. HeatWave creation will take about 10 minutes. From the DB display page scroll down to the Resources section. Click on the **HeatWave** link. Your completed HeatWave Cluster Information section will look like this:
    ![Connect](./images/10addheat07.png " ")

## Task 2: Load airportdb Data into HeatWave Cluster
1. If not already connected with SSH, on Command Line, connect to the Cloud Shell

2. On command Line, connect to MySQL using the MySQL Shell client tool with th following command:

    ```
    <copy>mysqlsh admin@127.0.0.1</copy>
    ```

3. Change the MySQL Shell execution mode to SQL and run the following Auto Parallel Load command to load the airportdb tables into HeatWave.

    ```
    <copy>\sql</copy>
    ```

    ```
    <copy>CALL sys.heatwave_load(JSON_ARRAY('airportdb'), NULL);</copy>
    ```
4. The compled load cluster screen should look like this:

    ![Connect](./images/11loadcluster01.png " ")

5.	Verify that the tables are loaded in the HeatWave cluster. Loaded tables have an AVAIL_RPDGSTABSTATE load status.

    ```
    <copy>USE performance_schema;</copy>
    ```
    ```
    <copy>SELECT NAME, LOAD_STATUS FROM rpd_tables,rpd_table_id WHERE rpd_tables.ID = rpd_table_id.ID;</copy>
    ```
    ![Connect](./images/11loadcluster02.png " ")

## Learn More

* [Oracle Cloud Infrastructure MySQL Database Service Documentation ](https://docs.cloud.oracle.com/en-us/iaas/mysql-database)
* [MySQL Database Documentation](https://www.mysql.com)
## Acknowledgements
* **Author** - Perside Foster, MySQL Solution Engineering 
* **Contributors** - Mandy Pang, MySQL Principal Product Manager,  Priscila Galvao, MySQL Solution Engineering, Nick Mader, MySQL Global Channel Enablement & Strategy Manager
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, September 2021
