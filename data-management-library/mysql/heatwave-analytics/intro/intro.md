MySQL Database Service powered by HeatWave and Oracle Analytics Cloud

This workshop will walk you through the process to deploy and configure MySQL Database Service & HeatWave to run Analytics workloads in Oracle Cloud. 
 
HeatWave is a new, integrated, high-performance analytics engine for MySQL Database Service. HeatWave accelerates MySQL performance by 400X for analytics queries, scales out to thousands of cores, and is 2.7X faster at one-third the cost of Amazon Redshift. MySQL Database Service, with HeatWave, is the only service that enables database admins and app developers to run OLTP and OLAP workloads directly from their MySQL database, eliminating the need for complex, time-consuming, and expensive data movement and integration with a separate analytics database. The service is optimized for and exclusively available in Oracle Cloud Infrastructure (OCI). For more information about HeatWave, check this **[Link!](https://www.oracle.com/ie/mysql/heatwave/)**
 
At the end of the workshop you will be able to run some queries on a sample dataset loaded into MySQL Database Service and compare the execution times with and without HeatWave. Prepare yourself to be surprised! 
 

![](./images/Intro.png)


**Objectives:**

-	Learn how to deploy MySQL Database Service (MDS) DB System with HeatWave.
-	Learn how to enable an HeatWave cluster to MDS DB System.
-	Learn how to import data into MDS from an external data source.
-	Understand how tables are loaded to HeatWave.
-	Learn how to run queries on MDS leveraging or not HeatWave.
-   Create your own Analytics dashboards on your MDS SB System.



**Prerequisites:**
-  This workshop requires an Oracle Public Cloud account. You may use a paid cloud account or a trial cloud account.
-  A Cloud tenancy where you have a compartment provisioned in.
  


**Workshop Overview**

**[Get Started: Sign Up for your Oracle Cloud Free Tier](signup/signup.md)**

- Create Your Free Trial Account
- Sign in to Your Account
  

## Lab 1 - Infrastructure Configuration 

**Key Objectives:**
 
-	Create a Virtual Cloud Network and allow traffic through MySQL Database Service port
-	Create a compute instance as a bastion host
-	Connect to the bastion host, install MySQL Shell and download the workshop dataset
-   Create an Oracle Analytics Cloud instance


**[Click here for Lab 1](/infrastructure/infrastructure.md)**


## Lab 2 - Create MySQL DB System (MDS) with HeatWave 

**Key Objectives:**

-  Create an Instance of MySQL in the Cloud
-  Add HeatWave cluster to MySQL Database Service

  
**[Click here for Lab 2](/dbmds/dbmds.md)**


## Lab 3 – Run queries leveraging HeatWave
 
**Key Objectives:**

-  Import data into MDS and load tables to HeatWave
-  Execute queries leveraging HeatWave and compare the query execution time with and without HeatWave enabled
  
**[Click here for Lab 3](/heatwave/heatwave.md)**


## Lab 4 – Use Analytics Cloud on MySQL Database Service powered by HeatWave

**Key Objectives:**

- Learn how to create your Analytics dashboards using Oracle Analytics Cloud on MySQL Database Service powered by HeatWave


**[Click here for Lab 4](/analytics/analytics.md)**