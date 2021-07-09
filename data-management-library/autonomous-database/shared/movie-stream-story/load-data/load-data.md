# Loading data from object storage using Data Tools (& API)

## Introduction

This lab takes you through the steps needed to link to, and load, data from the MovieStream data lake on Oracle Object Store into an Oracle autonomous database instance in preparation for exploration and analysis.

You can load data into your autonomous database (Autonomous Data Warehouse [ADW] or Autonomous Transaction Processing [ATP]) using Oracle Database tools, as well as Oracle and 3rd party data integration tools. You can load data:

+ from files in your local device,
+ from tables in remote databases, or
+ from files stored in cloud-based object storage (Oracle, S3, Azure, Google)

> **Note:** While this lab uses ADW, the steps are identical for loading data into an ATP database.

Estimated Time: 30 minutes

### Objectives <optional>


-   Learn how to define Object Store credentials for your autonomous database
-   Learn how to load data from the Object Store
-   Learn how to troubleshoot data loads


## **Step 1**: Configure the Object Storage Connection

1. In your ADW database's details page, click the Tools tab. Click **Open Database Actions**

	  ![Click on Tools, then Database Actions](images/launchdbactions.png)

2. On the login screen, enter the username MOVIEWORK, then click the blue **Next** button.

3. Enter the password for the MOVIEWORK user you set up in the previous lab.

4. Under **Data Tools**, click on **DATA LOAD**

    ![Click DATA LOAD](images/dataload.png)

5. In the **Explore and Connect** section, click on **CLOUD LOCATIONS** to set up the connection from your autonomous database to Object Store.

    ![Click CLOUD LOCATIONS](images/cloudlocations.png)

5. Click on **+Add Cloud Storage** in the top right of your screen.

-   In the **Name** field, enter 'MovieStream Data Lake'
-   Leave the Cloud Store selected as **Oracle**
-   Copy and paste the following URI into the URI + Bucket field:

> https://objectstorage.us-ashburn-1.oraclecloud.com/n/adwc4pm/b/moviestream_gold/o

-   Select **No Credential** as this is a public bucket
-   Click on the **Test** button to test the connection. Then click **Save**.


## **Step 2:** Link to your source files, creating External Tables in the database

1. Now, to load or link data from this newly configured cloud storage, click on the **Data Load** link in the top left of your screen.

    ![Click on Data Load](images/backtodataload.png)

2. Under **What do you want to do with your data?** select **LINK DATA**, and under **Where is your data?** select **CLOUD STORAGE**, then click **Next**

    ![Select Link Data, then Cloud Storage](images/linkdata.png)

3. Up to here... problem because folders are not supported.


    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy></copy>.</copy>
    ```

4. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file></copy>
  ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
