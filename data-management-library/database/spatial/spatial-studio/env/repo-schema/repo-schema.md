# Provision Spatial Studio using Cloud Marketplace

## Introduction

This lab walks though the creation of the database schema to be used for Spatial Studio's metadata repository. This is the schema that will store the work you do in Spatial Studio, such as the definitions of Datasets, Analyses, and Projects. 

Estimated Lab Time: n minutes



### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Access to database SQL Developer Web. 

<!-- *This is the "fold" - below items are collapsed by default*  -->

## **STEP 1**: Create Repo Schema


1. In SQL Developer Web, connect to the Autonomous database to be used for the Spatial Studio repository as the **admin** user

2. Create the schema for the Spatial Studio repository. The schema can have any name, but for consistency with other labs we use the name **studio_repo**. Password requirements for Oracle Autonomous Database is [here](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/manage-users-create.html#GUID-72DFAF2A-C4C3-4FAC-A75B-846CC6EDBA3F). Make note of the pasword you select, as we will use it in later steps.
   
    ```
   <copy>CREATE USER studio_repo
   IDENTIFIED BY <password goes here>;</copy>
    ```

## **STEP 2**: Assign Tablespace Quota

1. Assign default tablespace to Spatial Studio repository schema.  With Autonomous Database you can use tablespace name **data** 
   
    ```
   <copy>ALTER USER studio_repo
   DEFAULT TABLESPACE data;</copy>
    ```

2. Assign tablespace quota to Spatial Studio repository schema. Spatial Studio's metadata occupies a very small amount of storage. So the quota primarily accomodates business data stored in the repo schema. For this lab, a quota value of **250M** is fine. You can also set the value to **unlimited** if you will experiment with other datasets.
   
    ```
   <copy>ALTER USER studio_repo
   QUOTA <quota value> ON data;</copy>
    ```

## **STEP 3**: Grant Permissions    

1. Grant the following permissions to the Spatial Studio repository schema user

```
<copy>
GRANT CONNECT,
      CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE SEQUENCE,
      CREATE PROCEDURE,
      CREATE SYNONYM,
      CREATE TYPE,
      CREATE TRIGGER
TO  studio_repo
</copy>
```

The studio_repo schema is now ready to be used as your Spatial Studio repository.

You may now [proceed to the next lab](#next).


## Acknowledgements
* **Author** - David Lapp, Database Product Management
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
