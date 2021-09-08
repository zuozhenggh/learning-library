# Synchronize Autonomous Database with Data Catalog

## Introduction

Autonomous Database can leverage the Data Catalog metadata to dramatically simplify management for access to your data lake's object storage. By synchronizing with Data Catalog metadata, Autonomous Database automatically creates external tables for each logical entity harvested by Data Catalog. These external tables are defined in database schemas that are created and fully managed by the metadata synchronization process. You can immediately query data without having to manually derive the schema for external data sources and manually create external tables.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:
* Access the ADB SQL Worksheet
* Connect your ADB instance to your Data Catalog instance
* Synchronize your ADB instance with your Data Catalog instance
* Query the generated log, schemas, and external tables

### Prerequisites

This lab assumes you have:
* An Oracle account
* Completed all previous labs successfully

## Task 1: Gather Information About your Data Catalog Instance

In this task, you'll gather information about the Data Catalog instance which you will need in the next task. Save this information in a text editor of your choice such as Notepad in Windows so that you can easily copy and paste this information.

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator that you already used in this workshop, if you are not already logged in. On the **Sign In** page, select your tenancy if needed, enter your username and password, and then click **Sign In**. The Oracle **Cloud Console** Home page is displayed.

2. Open the **Navigation** menu and click **Analytics & AI**. Under **Data Lake**, click **Data Catalog**. In the list of Data Catalog instances, search for your **training-dcat-instance**. In the row for the instance, click the **Actions** button, and then select **Copy OCID** from the context menu. Next, paste that OCID to an editor or a file, so that you can easily retrieve it later in this task.

    ![](./images/dcat-ocid.png " ")

3.   To find your own _region-identifier_, from the **Console**, click the **Region** drop-down list, and then click **Manage Regions**.

    ![](./images/manage-regions.png " ")

    The **Infrastructure Regions** page is displayed. In the **Region** section, your Home Region to which you are subscribed is displayed along with your **Region Identifier**, `ca-montreal-1`, in our example:

   ![](./images/region-identifier.png " ")

4. Open the **Navigation** menu and click **Storage**. Under **Object Storage and Archive Storage**, click **Buckets**.

    ![](./images/buckets.png " ")


5. On the **Buckets** page, click the **`moviestream_gold`** link in the **Name** column.

    ![](./images/click-moviestream-gold.png " ")

6. On the **moviestream_gold** **Bucket Detail** page, scroll-down to the **Objects** section.

    ![](./images/bucket-details.png " ")

7. Click **`customer_contact.csv`**, click the **Actions** icon, and then click **View Object Details** from the context menu.

    ![](./images/view-object-details.png " ")

8. In the **Object Details** panel, in the **URL Path (URI)** field, copy the URL to and including the **/o** such as the following in our example:
**`https://objectstorage.ca-montreal-1.oraclecloud.com/n/oraclebigdatadb/b/moviestream_gold/o`**

    ![](./images/url.png " ")

9. Open the **Navigation** menu and click **Identity & Security**. Under **Identity**, click **Compartments**. In the list of compartments, search for your **training-dcat-compartment**. In the row for the compartment, in the **OCID** column, hover over the **OCID** link and then click **Copy**. The status changes from **Copy** to **Copied**. Next, paste that OCID to an editor or a file, so that you can retrieve it later in this task.

    ![](./images/compartment-ocid.png " ")


## Task 2: Access the Autonomous Database SQL Worksheet

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator. You will complete all the labs in this workshop using this Cloud Administrator.
See [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm) in the _Oracle Cloud Infrastructure_ documentation.

2. On the **Sign In** page, select your tenancy, enter your username and password, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

3. Open the **Navigation** menu and click **Oracle Database**. Under **Oracle Database**, click **Autonomous Database**.

4. On the **Autonomous Databases** page, click your **DB-DCAT Integration** ADB that you provisioned earlier.

5. On the **Autonomous Database Details** page, click the **Tools** tab. In the **Database Actions** card, click **Open Database Actions**.

   ![](./images/open-database-actions.png " ")

6. On the **Database Actions** Sign in page, enter **`admin`** in the **Username** field, and then click **Next**.

   ![](./images/enter-admin-user.png " ")

    > **Note:** The **`admin`** username is not case sensitive.  

7. Enter **`Training4ADB`** in the **Password** field, and then click **Sign in**.

    > **Note:** The password is case sensitive. If you chose a different password for the **`admin`** user in the **Setup the Workshop Environment** lab, use that password instead of **`TrainingADB`**.

   ![](./images/enter-password.png " ")

   The **Database Actions Launchpad** Home page is displayed.

   ![](./images/launchpad.png " ")

8. In the **Development** section, click the **SQL** card. The **SQL Worksheet** is displayed.   

    ![](./images/start-sql-worksheet.png " ")

    > **Note:** In the remaining tasks in this lab, you will use the SQL Worksheet to run the necessary SQL statements to:
    * Connect to your Data Catalog instance from ADB and query its assets.
    * Synchronize your ADB instance with your Data Catalog instance.
    * Query the generated logs, schemas and external tables.


## Task 3: Connect to Data Catalog

1. Disconnect (initialize) from Data Catalog, if already connected, by using the **`dbms_dcat.unset_data_catalog_conn`** PL/SQL package procedure. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Click the **Run Statement** icon in the Worksheet toolbar. This procedure removes an existing Data Catalog connections. It drops all of the protected schemas and external tables that were created as part of your previous synchronizations; however, it does not remove the metadata in Data Catalog. You should perform this action only when you no longer plan on using Data Catalog and the external tables that are derived, or if you want to start the entire process from the beginning.

    ```
    <copy>
    exec dbms_dcat.unset_data_catalog_conn;
    </copy>
    ```
    If you are not connected to Data Catalog, an **ORA-20008: No data catalog connections found. ORA-06512** message is displayed in the **Script Output** tab at the bottom of the worksheet.

    ![](./images/unset-data-catalog.png " ")

2. Define the following substitution variables, for repeated use in this task by using the SQL\*Plus **`DEFINE`** command. The variables will hold the necessary details for the Data Catalog connection such as the Data Catalog credential name, Data Catalog OCID, Compartment OCID, Home Region, and Data Asset key. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. **_Don't run the code yet. Complete the next step first._**

    ```
    <copy>
    define dcat_credential = 'OCI$RESOURCE_PRINCIPAL`
    define dcat_ocid = 'enter-your-dcat-ocid-here'
    define dcat_region='enter-your-region-identifier-here'
    define uri_root = 'Enter the url to the moviestream_gold Object Storage bucket'
    </copy>
    ```

    ![](./images/dcat-connection-details.png " ")


3. Replace the values of the **`dcat_ocid`**, **`dcat_region`**, and **`uri_root`** with the values that you have identified in **Task 1: Gather Information About your Data Catalog Instance** in this lab. Place the cursor on any line of code, and then click the **Run Script (F5)** icon in the Worksheet toolbar. The result is displayed in the **Script Output** tab at the bottom of the worksheet.

    ![](./images/define-variables.png " ")

4. Enable Resource Principal to access Oracle Cloud Infrastructure Resources for the ADB instance. This creates the credential **`OCI$RESOURCE_PRINCIPAL`**. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Place the cursor on any line of code, and then click the **Run Script (F5)** icon in the Worksheet toolbar. The result is displayed in the **Script Output** tab at the bottom of the worksheet.

    ```
    <copy>
    exec dbms_cloud_admin.enable_resource_principal();
    </copy>
    ```

    ![](./images/enable-resource-principal.png " ")

    >**Note:** You can use an Oracle Cloud Infrastructure Resource Principal with Autonomous Database. You or your tenancy administrator define the Oracle Cloud Infrastructure policies and a dynamic group that allows you to access Oracle Cloud Infrastructure resources with a resource principal. You do not need to create a credential object. Autonomous Database creates and secures the resource principal credentials you use to access the specified Oracle Cloud Infrastructure resources. See [Use Resource Principal to Access Oracle Cloud Infrastructure Resources](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/resource-principal.html#GUID-E283804C-F266-4DFB-A9CF-B098A21E496A)

5. Confirm that the resource principal was enabled. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Place the cursor on any line of code, and then click the **Run Statement** icon in the Worksheet toolbar. The result is displayed in the **Query Result** tab at the bottom of the worksheet.

    ```
    <copy>
    select *
    from dba_credentials
    where credential_name='OCI$RESOURCE_PRINCIPAL' and owner='ADMIN';
    </copy>
    ```

    ![](./images/query-resource-principal.png " ")


6. Query the Object Storage bucket to ensure that the resource principal and privilege work. Use the `list_objects` function to list objects in the specified location on object storage, **`moviestream_gold`** bucket in our example. The results include the object names and additional metadata about the objects such as size, checksum, creation timestamp, and the last modification timestamp. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Place the cursor on any line of code, and then click the **Run Statement** icon in the Worksheet toolbar. The result is displayed in the **Query Result** tab at the bottom of the worksheet.

    ```
    <copy>
    select *
    from dbms_cloud.list_objects('&oci_credential', '&uri_root/');
    </copy>
    ```

    ![](./images/query-bucket.png " ")


7. Set the credentials to use with Data Catalog and Object Storage. The **`set_data_catalog_credential`** procedure sets the Data Catalog access credential that is used for all access to the Data Catalog. The **`set_object_store_credential`** procedure sets the credential that is used by the external tables for accessing the Object Storage. Changing the Object Storage access credential alters all existing synced tables to use the new credential. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Place the cursor on any line of code, and then click the **Run Script (F5)** icon in the Worksheet toolbar. The result is displayed in the **Script Output** tab at the bottom of the worksheet.

    ```
    <copy>
    exec dbms_dcat.set_data_catalog_credential(credential_name => '&oci_credential');
    exec dbms_dcat.set_object_store_credential(credential_name => '&oci_credential');
    </copy>
    ```

    ![](./images/set-credentials.png " ")

8. Create a connection to your Data Catalog instance using the `set_data_catalog_conn` procedure. This is required to synchronize the metadata with Data Catalog. An Autonomous Database instance can connect to a single Data Catalog instance. You only need to call this procedure once to set the connection. See [SET\_DATA\_CATALOG\_CONN Procedure](https://docs-uat.us.oracle.com/en/cloud/paas/exadata-express-cloud/adbst/ref-managing-data-catalog-connection.html#GUID-7734C568-076C-4BC5-A157-6DE11F548D2B). The credentials must have access to your Data Catalog Asset and the data in the **`moviestream_landing`** and **`moviestream_gold`** Oracle Object Storage buckets that you use in this workshop. Click **Copy** to copy the following code, paste it into the SQL Worksheet, and then click the **Run Script (F5)** icon in the Worksheet toolbar. This could take a couple of minutes.

    ```
    <copy>
    begin
    dbms_dcat.set_data_catalog_conn (
    region => '&dcat_region',
    catalog_id => '&dcat_ocid');
    end;
    /
    </copy>
    ```

    ![](./images/connect-dcat.png " ")

    >**Note:** The above code references the substitution variables that you defined in step 1 by preceding the name of the variables by one **_`&`_**. When SQL*Plus encounters a substitution variable in a command, it executes the command as though it contained the value of the substitution variable, rather than the variable itself.

9. Review your current Data Catalog connections. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Click the **Run Statement** icon in the Worksheet toolbar. The result is displayed in the **Query Result** tab at the bottom of the worksheet. For detailed information, see [Managing the Data Catalog Connection](https://docs-uat.us.oracle.com/en/cloud/paas/exadata-express-cloud/adbst/ref-managing-data-catalog-connection.html#GUID-BC3357A1-6F0E-4AEC-814E-71DB3E7BB63D).

    ```
    <copy>
    select *
    from all_dcat_connections;
    </copy>
    ```

    ![](./images/query-dcat-connection.png " ")


## Task 4: Display Data Assets, Folders, and Entities     

1. Display all of Data Assets in the connected Data Catalog instance. Copy the following code, paste it into the SQL Worksheet, place the cursor on the line of code, and then click the **Run Statement** icon.

    ```
    <copy>
    select *
    from all_dcat_assets;
    </copy>    
    ```

    The row for the **`Oracle Object Storage Data Asset`** Data Asset that you created in Data Catalog is displayed in the **Query Result** tab.

    ![](./images/view-dcat-assets.png " ")


2. Display all Data Assets folders that were harvested from the **`Oracle Object Storage Data Asset`** Data Asset. Copy the following code, paste it into the SQL Worksheet, place the cursor on the line of code, and then click the **Run Statement** icon.

    The **`moviestream_gold`** and **`moviestream_landing`** folders are displayed in the **Query Result** tab.

    ```
    <copy>
    select *
    from all_dcat_folders;
    </copy>
    ```

    ![](./images/view-asset-folders.png " ")

3. Display all the entities in the folders originating from Oracle Object Storage buckets referenced in the **`Oracle Object Storage Data Asset`** Data Asset.

    ```
    <copy>
    select *
    from all_dcat_entities;
    </copy>
    ```

    ![](./images/view-entities.png " ")


## Task 5: Synchronize Autonomous Database with Data Catalog    

1. Synchronize Data Catalog with Autonomous Database using the **`dbms_dcat.run_sync`** PL/SQL package procedure. Synchronize all of the available Data Assets in your Data Catalog instance.

    ```
    <copy>
    exec dbms_dcat.run_sync('{"asset_list":["*"]}');
    </copy>
    ```

    ![](./images/synch-adb-dcat.png " ")

2. If the synchronization is successful, view the generated log to see if there were any errors.

    ```
    <copy>
    select * from dcat_log order by start_time desc;
    </copy>
    ```

    ![](./images/view-log.png " ")

3. Display the created schemas and tables.

    ```
    <copy>
    select *
    from dcat_schemas;
    </copy>
    ```

    ![](./images/view-schemas-tables.png " ")

    > **Note:** By default, the names of the generated schemas start with **`OCI$`**, followed by the Data Asset name, followed by the Bucket name. Those names can be long; however, you can update those long names in Data Catalog. Display the appropriate **Data Asset** and click **Edit**. In the **Edit Data Asset** panel, update the **Name** and **Description** fields as desired, and then click **Save Changes**.

4. The generated table and column names are derived from the respective Logical Entity and its attributes. You can update the Business Name which also updates the names in ADB. In addition, you can use the Oracle Database custom properties in Data Catalog to update data types and names.

    ```
    <copy>
    select oracle_schema_name,
           oracle_table_name
    from dcat_entities;
    </copy>
    ```

    ![](./images/view-asset-folders.png " ")


5. Query the **`genre`** and **`movie`** external tables.

    ```
    <copy>
    select *
    from oci$phx_gold.genre;
    /
    select *
    from oci$phx_gold.movie;
    </copy>
    ```

    ![](./images/add-image.png " ")

6. Load the **`oci$phx_gold.genre`** data that will be queried frequently into a new database table named **`genre`**.

    ```
    <copy>
    create table genre as
    select *
    from oci$phx_gold.genre;
    </copy>
    ```

    ![](./images/add-image.png " ")

7.  Load the **`oci$phx_gold.movie`** data that will be queried frequently into a new database table named **`movie`**. The **`oci$phx_gold.movie`** data is in JSON format.

    ```
    <copy>
    create table movie as
        select
            cast(m.doc.movie_id as number) as movie_id,
            cast(m.doc.title as varchar2(200 byte)) as title,   
            cast(m.doc.budget as number) as budget,
            cast(m.doc.gross as number) gross,
            cast(m.doc.list_price as number) as list_price,
            cast(m.doc.genre as varchar2(4000)) as genres,
            cast(m.doc.sku as varchar2(30 byte)) as sku,   
            cast(m.doc.year as number) as year,
            to_date(m.doc.opening_date, ''YYYY-MM-DD'') as opening_date,
            cast(m.doc.views as number) as views,
            cast(m.doc.cast as varchar2(4000 byte)) as cast,
            cast(m.doc.crew as varchar2(4000 byte)) as crew,
            cast(m.doc.studio as varchar2(4000 byte)) as studio,
            cast(m.doc.main_subject as varchar2(4000 byte)) as main_subject,
            cast(m.doc.awards as varchar2(4000 byte)) as awards,
            cast(m.doc.nominations as varchar2(4000 byte)) as nominations,
            cast(m.doc.runtime as number) as runtime,
            substr(cast(m.doc.summary as varchar2(4000 byte)),1, 4000) as summary
        from oci$phx_gold.movie m;
        </copy>
    ```

    ![](./images/add-image.png " ")

You may now proceed to the next lab.

## Learn More

* [Using Oracle Autonomous Database on Shared Exadata Infrastructure](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/index.html)
* [Connect with Built-in Oracle Database Actions](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/sql-developer-web.html#GUID-102845D9-6855-4944-8937-5C688939610F)
* [DBMS_DCAT Package](https://docs-uat.us.oracle.com/en/cloud/paas/exadata-express-cloud/adbst/ref-dbms_dcat-package.html#GUID-4D927F21-E856-437B-B42F-727A2C02BE8D)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Get Started with Data Catalog](https://docs.oracle.com/en-us/iaas/data-catalog/using/index.htm)
* [Data Catalog Overview](https://docs.oracle.com/en-us/iaas/data-catalog/using/overview.htm)


## Acknowledgements
* **Author:** Lauran Serhal, Principal UA Developer, Oracle Database and Big Data User Assistance
* **Contributor:** Martin Gubar, Director, Product Management Autonomous Database / Cloud SQL    
* **Last Updated By/Date:** Lauran Serhal, September 2021
