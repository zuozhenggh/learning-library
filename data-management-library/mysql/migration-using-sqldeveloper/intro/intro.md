# Introduction

## About this Workshop

If you are considering moving your on-premise MySQL database to the cloud and in the process, also wants to migrate the database to Oracle Database, this workshop will guide you how to do it easily. 
Following these step-by-step instructions, you can easily perform MySQL to Oracle Autonomous Database (ADB) migration using Oracle SQL Developer v 21.2. If you need to learn more this topic, you can refer to this blog: Need to Migrate MySQL Database to Oracle ADB ?


Estimated Workshop Time: 1hr 

![Oracle SQL Developer icon](images/sqldv.jpg " ")

Oracle SQL Developer GUI - Migration Configured 
![Oracle SQL Developer UI](images/sqldevUI.jpg " ")


Oracle SQL Developer is a free, integrated development environment (IDE) that simplifies the development and management of Oracle Database in both traditional and Cloud deployments. If you have basic understanding of MySQL, Oracle Cloud and Autonomous Database, it will be useful to perform all of the steps in this document. However, even if you’re coming from MySQL background only, using this workshop you can complete the migration easily. 

#### References in this Workshop

The main Oracle document for this migration can be found at the following link, which has been referenced in this post in some places. Wherever I have mentioned “From Doc”, the text is copied from following document and referenced as-is. [SQL Developer: Migrating Third-Party Databases](https://docs.oracle.com/en/database/oracle/sql-developer/21.2/rptug/migrating-third-party-databases.html)




### Objectives


In this workshop, you will learn how to:
* Download Latest Version & Install
* Create Connections for the Target (ADB) database
* Load MySQL JDBC Driver and Source Connection
* Create User for Migration Repository
* Create Migration Connection
* Create Migration Repository
* Complete Migration with the Wizard

### Prerequisites 

For this post, it is assumed that you already have following in place:

1. Source: MySQL database on-premise, with the necessary network access to target ADB instance as well as Oracle SQL Developer instance. And also database credentials to the source schemas/objects, which needs to be migrated.

2. Target: ATP (Autonomous Transactions Processing) instance setup in the OCI cloud, with all the required credentials for users, schema and object creation (eg Admin user) along with OCI network settings for connectivity and database wallet file. We will use this database for Migraiton repository as well. If you need help with creating sample ATP database, you can refer to this post: [Creating an Autonomous Transaction Processing (ATP) Database](https://blogs.oracle.com/weblogicserver/post/creating-an-autonomous-transaction-processing-atp-database).  Or you can follow next lab: Prerequisites Setup - Create ADB for Target (Optional if you already have ADB instance). At this stage, you just need to have running ATP instance. You can equally run this migration with ADW. 

3. An environment, usually your laptop or another instance in OCI (Oracle Cloud Infrastructure), where you will install and run Oracle SQL Developer. We will follow windows based installation. If you want to set up in OCI instance, you can [create Windows instance](https://docs.oracle.com/en-us/iaas/Content/GSG/Reference/overviewworkflowforWindows.htm) and [RDP from your laptop/desktop](https://blogs.oracle.com/pcoe/post/enable-windows-instance-access-via-rdp-on-oracle-compute-cloud-service) (for remote desktop sharing). Or you can also follow next lab: Prerequisites Setup - Create Windows VM to run Oracle SQL Developer (Optional, if you plan to install SQL Developer into your laptop).

4. All above 3 environments should have network connectivity among each other, including allowing the required ports for the respective databases. Ideally, a VCN for ADB and SQL Developer instances in OCI and a VPN connectivity to MySQL on-premises. 

*Let's get Started!*

Click on the next lab in this workshop to get started.

## Learn More

Ready to learn more?
* [Need to Migrate MySQL Database to Oracle ADB ?](http://docs.oracle.com)
* Visit our documentation for the latest versions of [Autonomous Database](https://docs.oracle.com/en/cloud/paas/atp-cloud/index.html), [SQL Developer](https://docs.oracle.com/en/database/oracle/sql-developer/21.2/index.html) and [MySQL](https://dev.mysql.com/doc/)
* Try one of our [LiveLabs](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/home?session=110185877771466)
* [SQL Developer FAQ](https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=170592697647624&id=2345874.1&_afrWindowMode=0&_adf.ctrl-state=u1oixgz95_4) from Oracle Support site 
* [Forum for Oracle SQL Developer](https://community.oracle.com/tech/developers/categories/sql_developer)
* [Migration Planning and Methodology](https://www.oracle.com/database/technologies/migration/mig-planning.html)
* [SQL Developer Product Page](https://www.oracle.com/database/technologies/appdev/sqldeveloper-landing.html)
* [MySQL Workbench - Database Migration](https://www.mysql.com/products/workbench/migrate/)


## Acknowledgements
* **Author** - Muhammad Shuja, ODP
* **Last Updated By/Date** - Muhammad Shuja, December 2021
