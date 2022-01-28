# Synchronize Autonomous Database with Data Catalog

## Introduction

Autonomous Database can leverage the Data Catalog metadata to dramatically simplify management for access to your data lake's object storage. By synchronizing with Data Catalog metadata, Autonomous Database automatically creates external tables for each logical entity harvested by Data Catalog. These external tables are defined in database schemas that are created and fully managed by the metadata synchronization process. You can immediately query data without having to manually derive the schema for external data sources and manually create external tables.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:
* Access the ADB SQL Worksheet
* Initialize the lab
* Connect your ADB instance to your Data Catalog instance
* Synchronize your ADB instance with your Data Catalog instance
* Query the generated log, schemas, and external tables

### Prerequisites  
This lab assumes that you have successfully completed all of the preceding labs in the **Contents** menu.


## Task 1: Access the Autonomous Database SQL Worksheet

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator. You will complete all the labs in this workshop using this Cloud Administrator.

2. On the **Sign In** page, select your tenancy, enter your username and password, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

3. Open the **Navigation** menu and click **Oracle Database**. Under **Oracle Database**, click **Autonomous Database**.

4. On the **Autonomous Databases** page, click your **DB-DCAT Integration** ADB that you provisioned earlier.

5. On the **Autonomous Database Details** page, click the **Tools** tab.

   ![](./images/click-tools.png " ")

6. On the **Tools** tab, in the **Database Actions** card, click **Open Database Actions**.

   ![](./images/click-database-actions.png " ")

7. On the **Database Actions** sign-in page, enter **`admin`** in the **Username** field, and then click **Next**.

   ![](./images/enter-username.png " ")

8. Enter **Training4ADB** in the **Password** field, and then click **Sign in**.

   ![](./images/enter-password.png " ")

   The **Database Actions Launchpad** Home page is displayed.

   ![](./images/launchpad.png " ")


9. In the **Development** section, click the **SQL** card. The **SQL Worksheet** is displayed.   

    ![](./images/start-sql-worksheet.png " ")

    > **Note:** In the remaining tasks in this lab, you will use the SQL Worksheet to run the necessary SQL statements to:
    * Initialize the lab to create the necessary structures such as the `moviestream` schema.
    * Connect to your Data Catalog instance from ADB and query its assets.
    * Synchronize your ADB instance with your Data Catalog instance.


## Task 2: Initialize the Lab

Create and run the PL/SQL procedures to initialize the lab before you synchronize ADB and Data Catalog.  

1. Copy and paste the following script into your SQL Worksheet, and then click the **Run Script (F5)** icon in the Worksheet toolbar.

    ```
    <copy>
    -- Click F5 to run all the scripts at once
    -- drop this table with the lab listings

    drop table moviestream_labs; -- may fail if hasn't been defined

    -- Create the MOVIESTREAM_LABS table that allows you to query all of the labs and their associated scripts

    begin
    dbms_cloud.create_external_table(table_name => 'moviestream_labs',
                file_uri_list => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/c4u04/b/moviestream_scripts/o/prerequisites/dcat-labs.json',                
                format => '{"skipheaders":"0", "delimiter":"\n", "ignoreblanklines":"true"}',
                column_list => 'doc varchar2(30000)'
    );
    end;
    /

    -- Define the scripts found in the labs table.
    declare
    b_plsql_script blob;            -- binary object
    v_plsql_script varchar2(32000); -- converted to varchar
    uri_scripts varchar2(2000) := 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/c4u04/b/moviestream_scripts/o/prerequisites'; -- location of the scripts
    uri varchar2(2000);
    begin

    -- Run a query to get each lab and then create the procedures that generate the output
    for lab_rec in (
      select  json_value (doc, '$.lab_num' returning number) as lab_num,
        json_value (doc, '$.title' returning varchar2(500)) as title,
        json_value (doc, '$.script' returning varchar2(100)) as proc        
        from moviestream_labs ml
        where json_value (doc, '$.script' returning varchar2(100))  is not null
        order by 1 asc
        )
    loop
    -- The plsql procedure DDL is contained in a file in object store
    -- Create the procedure
    dbms_output.put_line(lab_rec.title);
    dbms_output.put_line('....downloading plsql procedure ' || lab_rec.proc);

    -- download the script into this binary variable        
    uri := uri_scripts || '/' || lab_rec.proc || '.sql';

    dbms_output.put_line('....the full uri is ' || uri);        
    b_plsql_script := dbms_cloud.get_object(object_uri => uri);

    dbms_output.put_line('....creating plsql procedure ' || lab_rec.proc);
    -- convert the blob to a varchar2 and then create the procedure
    v_plsql_script :=  utl_raw.cast_to_varchar2( b_plsql_script );

    -- generate the procedure
    execute immediate v_plsql_script;

    end loop lab_rec;  

    execute immediate 'grant execute on moviestream_write to public';

    exception
        when others then
            dbms_output.put_line('Unable to setup prequisite scripts.');
            dbms_output.put_line('You will need to run thru each of the labs');
            dbms_output.put_line('');
            dbms_output.put_line(sqlerrm);
    end;
    /
    begin
      run_lab_prereq(10);
    end;
    /
    </copy>
    ```


    >**Note:** It may take a few minutes to run this script as it is performing many initialization steps. Once the script completes successfully, the **`MOVIESTREAM`** user is created and initialized. You will login to Oracle Machine Learning (OML) in the next lab using this new user to perform many queries.

    ![](./images/initialize.png " ")

    The output is displayed in the **Script Output** section at the bottom of the SQL Worksheet.

    ![](./images/initialize-output.png " ")

2. View the status of the script execution. Copy and paste the following code into your SQL Worksheet, and then click the **Run Script (F5)** icon in the Worksheet toolbar.

    ```
    <copy>
    select *
    from moviestream_log order by 1;
    </copy>
    ```

    ![](./images/log-output.png " ")

3. Set the password for the **`MOVIESTREAM`** user.  You will log in as this user to run queries. , and then click the **Run Script (F5)** icon in the Worksheet toolbar.

    >**Note:** Substitute **``<secure password``>** with your own secured password that you will remember for later use such as **`Training4ADB`**.

    ```
    <copy>
    alter user moviestream identified by "<secure password>";
    </copy>
    ```
    ![](./images/change-password.png " ")

## Task 3: Connect to Data Catalog

1. Disconnect (initialize) from Data Catalog, if already connected, by using the **`dbms_dcat.unset_data_catalog_conn`** PL/SQL package procedure. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Click the **Run Script (F5)** icon in the Worksheet toolbar. This procedure removes an existing Data Catalog connections. It drops all of the protected schemas and external tables that were created as part of your previous synchronizations; however, it does not remove the metadata in Data Catalog. You should perform this action only when you no longer plan on using Data Catalog and the external tables that are derived, or if you want to start the entire process from the beginning.

    ```
    <copy>
    exec dbms_dcat.unset_data_catalog_conn;
    </copy>
    ```
    If you are not connected to Data Catalog, an **ORA-20008: No data catalog connections found. ORA-06512** message is displayed in the **Script Output** tab at the bottom of the worksheet.

    ![](./images/unset-data-catalog.png " ")

    If you were connected to Data Catalog, you are now disconnected, and the following message is displayed.

    ![](./images/disconnect-data-catalog.png " ")

2. Define the following substitution variables, for repeated use in this task by using the SQL\*Plus **`DEFINE`** command. The variables will hold the necessary details for the Data Catalog connection such as the Data Catalog credential name, Data Catalog OCID, Compartment OCID, Home Region, and Data Asset key. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet.        
_**Important:** Don't run the code yet. Complete the next step first where you will replace some of the place holders between the ' ' with the actual values that you saved in your local **`workshop-resources.txt`** text file in **Lab 1 Task 3** in this workshop_.

    ```
    <copy>
    define tenancy_ocid ='enter-your-tenancy-ocid'
    define dcat_region='enter-your-region-identifier'
    define dcat_compartment = 'enter-your-compartment-ocid'
    define dcat_ocid = 'enter-your-data-catalog-ocid'
    define dcat_sandbox_asset_key='enter-your-data-catalog-data-asset-key'  
    define dcat_credential = 'OCI$RESOURCE_PRINCIPAL'
    define obj_credential = 'OCI$RESOURCE_PRINCIPAL'
    define uri_root = 'https://objectstorage.us-ashburn-1.oraclecloud.com/p/WCoFAtux8IG4EPHU9TCBrsXbd6EQzqhF3-QVXEqROKeGgsbJPeIJnLZYHMhkiA7I/n/c4u04/b/moviestream_sandbox/o'
    define user_ocid = 'enter-your-own-user-ocid'
    </copy>
    ```

    >**Note:** For the **`uri_root`** value above, make sure the url ends with _**/o**_ and not with an extra **/** such as _**/o/**_ to avoid an error message later in step 6.

3. Open your local **`workshop-resources.txt`** text file, if it's not already open.

    ![](./images/workshop-resources-values.png " ")


4. Replace the values of the **`tenancy_ocid`**, **`dcat_region`**, **`dcat_compartment`**, **`dcat_ocid`**, **`dcat_sandbox_asset_key`**, and **`user_ocid`** in the `DEFINE` statements in your SQL Worksheet with your own values that you have identified in **`workshop-resources.txt`** text file. Once you are done, place the cursor on any line of code, and then click the **Run Script (F5)** icon in the Worksheet toolbar. The result is displayed in the **Script Output** tab at the bottom of the worksheet.

    ![](./images/define-variables.png " ")

5. Enable Resource Principal to access Oracle Cloud Infrastructure Resources for the ADB instance. This creates the credential **`OCI$RESOURCE_PRINCIPAL`**. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Place the cursor on any line of code, and then click the **Run Script (F5)** icon in the Worksheet toolbar. The result is displayed in the **Script Output** tab at the bottom of the worksheet.

    ```
    <copy>
    exec dbms_cloud_admin.enable_resource_principal();
    exec dbms_cloud_admin.enable_resource_principal('MOVIESTREAM');
    </copy>
    ```

    ![](./images/enable-resource-principal.png " ")

    >**Note:** You can use an Oracle Cloud Infrastructure Resource Principal with Autonomous Database. You or your tenancy administrator define the Oracle Cloud Infrastructure policies and a dynamic group that allows you to access Oracle Cloud Infrastructure resources with a resource principal. You do not need to create a credential object. Autonomous Database creates and secures the resource principal credentials you use to access the specified Oracle Cloud Infrastructure resources. See [Use Resource Principal to Access Oracle Cloud Infrastructure Resources](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/resource-principal.html#GUID-E283804C-F266-4DFB-A9CF-B098A21E496A)

5. Confirm that the resource principal was enabled. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Place the cursor on any line of code, and then click the **Run Statement** icon in the Worksheet toolbar. The result is displayed in the **Query Result** tab at the bottom of the worksheet.

    ```
    <copy>
    select *
    from all_credentials;
    </copy>
    ```

    ![](./images/query-resource-principal.png " ")


6. Query the Object Storage bucket to ensure that the resource principal and privilege work. Use the `list_objects` function to list objects in the specified location on object storage, **`moviestream_sandbox`** bucket in our example (specified earlier using the `uri_root` variable). The results include the object names and additional metadata about the objects such as size, checksum, creation timestamp, and the last modification timestamp. Click **Copy** to copy and paste the following code into the SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar. The result is displayed in the **Query Result** tab at the bottom of the worksheet.

    ```
    <copy>
    select *
    from dbms_cloud.list_objects('&obj_credential', '&uri_root/');
    </copy>
    ```

    The **`moviestream_sandbox`** bucket contains a **`potential_churners`** data set and potentially other data sets created by data scientists. This bucket is used by multiple workshops that capture the results of experiments. Therefore, your result might not precisely match the following screen capture.

    ![](./images/query-bucket.png " ")

    Here's the one logical data entity in the **`moviestream_sandbox`** bucket as seen in Data Catalog, **`potential_churners`**.

    ![](./images/sandbox-bucket-dcat.png " ")

    This was harvested from the **`moviestream_sandbox`** public Oracle Object Storage bucket which contains one single folder, **`potential_churners`**.

    ![](./images/sandbox-bucket-storage.png " ")    

7. Set the credentials to use with Data Catalog and Object Storage. The **`set_data_catalog_credential`** procedure sets the Data Catalog access credential that is used for all access to the Data Catalog. The **`set_object_store_credential`** procedure sets the credential that is used by the external tables for accessing the Object Storage. Changing the Object Storage access credential alters all existing synced tables to use the new credential. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Place the cursor on any line of code, and then click the **Run Script (F5)** icon in the Worksheet toolbar. The result is displayed in the **Script Output** tab at the bottom of the worksheet.

    ```
    <copy>
    exec dbms_dcat.set_data_catalog_credential(credential_name => '&dcat_credential');
    exec dbms_dcat.set_object_store_credential(credential_name => '&obj_credential');
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

9. Query your current Data Catalog connections and review the the DCAT ocid, its compartment, and the credentials that are used to access Oracle Object Storage and Data Catalog. Click **Copy** to copy the following code, and then paste it into the SQL Worksheet. Click the **Run Statement** icon in the Worksheet toolbar. The result is displayed in the **Query Result** tab at the bottom of the worksheet. For detailed information, see [Managing the Data Catalog Connection](https://docs-uat.us.oracle.com/en/cloud/paas/exadata-express-cloud/adbst/ref-managing-data-catalog-connection.html#GUID-BC3357A1-6F0E-4AEC-814E-71DB3E7BB63D).

    ```
    <copy>
    select *
    from all_dcat_connections;
    </copy>
    ```

    The connection to your `training-dcat-instance` Data Catalog instance that you created in this workshop is displayed.

    ![](./images/query-dcat-connection.png " ")

    You can use the `describe` SQL*Plus command to get familiar with the columns in the `all_dcat_connections` Data Catalog table:

    ```
    <copy>
    describe all_dcat_connections;
    </copy>
    ```

    ![](./images/dsc-all-dcat-connections.png " ")


## Task 4: Display Data Assets, Folders, and Entities     

1. Display the available data assets in the connected Data Catalog instance. Copy and paste the following script into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar.

    ```
    <copy>
    select *
    from all_dcat_assets;
    </copy>    
    ```

    The row for the only data asset that you created in your Data Catalog instance, **`Data Lake`**, is displayed in the **Query Result** tab.

    ![](./images/view-dcat-assets.png " ")


2. Display all Data Assets folders that were harvested from the **`Data Lake`** data asset. Copy and paste the following script into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar.

    The **`moviestream_sandbox`**, **`moviestream_gold`**, and **`moviestream_landing`** folders are displayed in the **Query Result** tab. Notice the custom business names that you provided for each bucket in an earlier lab: **`Sandbox`**, **`Gold`**, and **`Landing`**. This will make the generated schemas' names a bit shorter.

    ```
    <copy>
    select *
    from all_dcat_folders;
    </copy>
    ```

    ![](./images/view-asset-folders.png " ")

    You can use the `describe` SQL*Plus command to get familiar with the columns in the `all_dcat_folders` Data Catalog table:

    ```
    <copy>
    describe all_dcat_folders;
    </copy>
    ```

    ![](./images/dsc-all-dcat-folders.png " ")


3. Display all the entities in the folders originating from Oracle Object Storage buckets referenced in the **`Data Lake`** data asset.

    ```
    <copy>
    select *
    from all_dcat_entities;
    </copy>
    ```

    ![](./images/view-entities.png " ")

    You can use the `describe` SQL*Plus command to get familiar with the columns in the `all_dcat_entities` Data Catalog table:

    ```
    <copy>
    describe all_dcat_entities;
    </copy>
    ```

    ![](./images/dsc-all-dcat-entities.png " ")


## Task 5: Synchronize Autonomous Database with Data Catalog    

1. Synchronize the **`moviestream_sandbox`** Object Storage Bucket, between Data Catalog and Autonomous Database using the **`dbms_dcat.run_sync`** PL/SQL package procedure. In order to synchronize just one bucket (folder), you'll need the folder's key, `moviestream_sandbox` in this example, and the `Data Lake` data asset key.  

    ```
    <copy>
    select path, display_name, key as folder_key, data_asset_key
    from all_dcat_folders
    where display_name='moviestream_sandbox';
    </copy>
    ```

    ![](./images/folder-asset-keys.png " ")

    To copy a key value, double-click the cell to highlight the value, and then copy and paste it into a text editor of your choice. Copy the values for both `folder_key` and `data_asset_key` which you will need in the next command. In our example, the two key values from the previous query are as follows:

    * **`folder_key`:** `f0264eb7-826c-423e-a305-cde88381239e`
    * **`data_asset_key`:** `b53fecf4-934a-407a-9416-f7e039a75d30`

    ![](./images/copy-folder-key-value.png " ")  

    > **Note:** In later steps, you will synchronize all of the available Object Storage buckets.

2. Copy and paste the following code into your SQL Worksheet. Replace the **`asset_id`** key value shown with your `data_asset_key` value and the **`folder_list`** key value with your `folder_key` value that you copied in the previous step. Click the **Run Script (F5)** icon in the Worksheet toolbar. The result is displayed in the **Script Output** tab at the bottom of the worksheet.


    ```
    <copy>
    begin
    dbms_dcat.run_sync(synced_objects =>
        '{"asset_list": [
            {
                "asset_id":"b53fecf4-934a-407a-9416-f7e039a75d30",
                "folder_list":[
                    "f0264eb7-826c-423e-a305-cde88381239e"
               ]
            }   
        ]}');                    
    end;
    /
    </copy>
    ```

    ![](./images/sync-folder.png " ")

    Earlier in this workshop, you learned that when you perform the synchronization process between your ADB and Data Catalog instances, the schemas and tables are created automatically for you as you saw in the above step. By default, the name of a generated schema will start with **`DCAT$`** concatenated with the data asset's name, **`Data Lake`**, and the folder's (bucket's) name such as **`moviestream_sandbox`**; however, in **Lab 2, Harvest Technical Metadata from Oracle Object Storage**, in **Task 7: Customize the Business Name for the Object Storage Buckets**, you created a business name for each of the three buckets and removed the **`moviestream_`** prefix. For example, the generated schema name for the **`moviestream_sandbox`** as you can see in the above synchronization image is **`DCAT$DATA_LAKE_SANDBOX`** instead of **`DCAT$DATA_LAKE_MOVIESTREAM_SANDBOX`** which is a bit shorter. In this lab, you will also learn how to replace the data asset name in the schema's name with a shorter custom property override of your choice.


3. Review the generated log to identify any issues. The **`logfile_table`** column contains the name of the table containing the full log. Copy and paste the following script into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar.

    ```
    <copy>
    select type, start_time, status, logfile_table
    from user_load_operations
    order by start_time desc;
    </copy>
    ```

    ![](./images/view-log.png " ")

    In our example, there was only one `DCAT_SYNC` synchronization operation performed. If you have more than one log files generated, query the most recent log file table. Using the `order by start_time desc` clause displays the most recent log file first. In our example, the most recent (and only) log table name is `DBMS_DCAT$1_LOG`.

4. Review the full log. Copy and paste the following script into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar. Substitute the log table name with your own log table name that you identified in the previous step.

    ```
    <copy>
    select *
    from DBMS_DCAT$1_LOG
    order by log_timestamp desc;
    </copy>
    ```

    ![](./images/log-details-query.png " ")

    The results are displayed in the **Query Result** tab.

    ![](./images/log-details.png " ")

    >**Note:** The external table name that is created automatically, is **`DCAT$`** followed by the data asset name,**`Data_Lake`** (blank space replaced with an underscore character), followed by the business name for the Object Storage bucket that you specified earlier, **`sandbox`** (instead of moviestream_sandbox), followed by logical entity name, **`potential_churners`**.

    ![](./images/logical-entity.png " ")


5. Query the available Data Catalog instance entities from within ADB. Copy and paste the following query into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar.

    ```
    <copy>
    select oracle_schema_name, oracle_table_name
    from dcat_entities;
    </copy>
    ```

    The schema and external table names are displayed.

    ![](./images/schema-and-table-names.png " ")

    The synchronization process creates schemas and external tables based on the Data Catalog data assets and logical entities. The name of the schema is displayed in the **`oracle_schema_name`** column and the name of the generated external table is displayed in the **`oracle_table_name`** column.


6. Describe the **`all_dcat_entities`** table that you will use in the next step to get familiar with its columns. Copy and paste the following query into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar.

    ```
    <copy>
    describe all_dcat_entities
    </copy>
    ```

    ![](./images/desc-all_dcat_entities.png " ")


7. Display the Object Storage bucket folder name, logical (data) entity name, schema name, and external table name from the `all_dcat_entities` and `dcat_entities` tables. Copy and paste the following query into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar.

    ```
    <copy>
    select a.folder_name,
       a.display_name,
       a.business_name,
       a.description,
       lower(d.oracle_schema_name),
       lower(d.oracle_table_name)
    from all_dcat_entities a, dcat_entities d
    where a.data_asset_key = d.asset_key
    and a.key = d.entity_key
    order by 1,2;
    </copy>
    ```

    ![](./images/custom-query.png " ")

    >**Note:** The result shows the information for only one of the three Object Storage buckets, **`moviestream_sandbox`** because earlier, you performed the synchronization process only on this bucket and not the other two buckets. In the next task in this lab, you will synchronize all assets.

8. Query the first nine rows of the `potential_churners` external table. Copy and paste the following script into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar.

    ```
    <copy>
    select *
    from dcat$data_lake_sandbox.potential_churners
    where rownum < 10;
    </copy>
    ```

    ![](./images/potential-churners.png " ")


## Task 6: Provide a Custom Property Override for the Schema Name

In this task, you provide a custom property override for the schema name to use a short prefix instead of the data asset name as part of the generated schema name. By default, the name of a generated schema will start with the keyword **`DCAT$`** concatenated with the **data asset's name** and the **Object Storage folder's name** as follows:

![](./images/schema-format.png " ")

As you already learned in this lab, the generated schema name for your `moviestream_sandbox` Oracle Object Storage bucket uses the `Data Lake` data asset name as part of the schema name as follows:

![](./images/schema-format-example.png " ")

However, in **Lab 2: Harvest Technical Metadata from Oracle Object Storage**, in **Task 7: Customize the Business Name for the Object Storage Buckets**, you customized the business names for each of the three Oracle Object Storage buckets that you use in this workshop to make the generated schema names a bit shorter. You removed the **`moviestream_`** prefix from the name of each bucket. For example, you changed the business name for the **`moviestream_sandbox`** bucket to **`Sandbox`**; therefore, the schema name format that you saw already is as follows:

![](./images/schema-format-business-name.png " ")

You will do one last customization to shorten the generated schemas' names a bit more. You will use a custom property override, **`obj`** (can be any prefix) that will be used instead of the actual data asset name, **`Data Lake`**, when you run the synchronization process. The generated schema name would be as follows for the `Sandbox` bucket.

![](./images/schema-and-business-exmaple.png " ")

1. Open the **Navigation** menu and click **Analytics & AI**. Under **Data Lake**, select **Data Catalog**. On the **Data Catalog Overview** page, click **Go to Data Catalogs**.

2. On the **Data Catalogs** page, click the **`training-dcat-instance`** Data Catalog instance link.

    ![](./images/dcat-instance.png " ")

3. On the **`training-dcat-instance`** **Home** page, click **Browse Data Assets** in the **Quick Actions** tile.

    ![](./images/browse-data-assets.png " ")

4. If you only have the one Data Asset created in this workshop, the **Oracle Object Storage: Data Lake** page is displayed.

5. In the **Summary** tab, in the **DBMS_DCAT** tile, click **Edit**.

    ![](./images/click-edit-dbms-dcat.png " ")

    > **Note:** The **DBMS_DCAT** tile will only be displayed after you connect ADB to Data Catalog.

6. In the **Edit DBMS_DCAT** dialog box, enter **`obj`** custom in the **Oracle-Db-Schema-Prefix** field, and then click **Save Changes**. This value will be used as the prefix to the schemas' that are generated by the synchronization process which is covered in the next lab. If you don't provide a prefix here, then the data asset name, **`Data Lake`**, will be used in schemas' names.

    ![](./images/edit-dbms-dcat-dialog.png " ")

    The new prefix is displayed.

    ![](./images/dbms-dcat-dialog-edited.png " ")


## Task 7: Synchronize All Data Assets in Data Catalog

So far in this lab, you synchronized only the **`moviestream_sandbox`** Object Storage Bucket. In this task, you will synchronize all of the data assets folders.

1. Copy and paste the following code into your SQL Worksheet, and then click the **Run Script (F5)** icon in the Worksheet toolbar.

    ```
    <copy>
    begin
      dbms_dcat.run_sync('{"asset_list":["*"]}');
    end;  
    /
    </copy>
    ```

    The synchronization can take few minutes to complete. When it is completed successfully, the output is displayed at the bottom of the SQL Worksheet.

    ![](./images/synch-output.png " ")  

    >**Note:** You can automate the sync operation by using the following procedure which will check for new objects in Data Catalog every 3 minutes. In this workshop, we will not use this procedure because we know that our Data Catalog will not be updated.

    ```
    begin
       dbms_dcat.create_sync_job (
         synced_objects => '{"asset_list":["*"]}',          
         repeat_interval => 'FREQ=MINUTELY;INTERVAL=3;'
       );
    end;
    /
    ```

2. Access to the automatically generated tables by the synchronization process is secure.  You need to grant access to users/roles. Autonomous Databases come with a predefined database role named **`DWROLE`**. This role provides the common privileges for a database developer or data scientist to perform real-time analytics. Grant the select on tables privilege to the data warehouse role using the `grant_select_on_dcat_tables` custom procedure. This procedure grants READ access on the Data Catalog sourced tables to the `dwrole` role. See [Manage User Privileges on Autonomous Database - Connecting with a Client Tool](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/manage-users-privileges.html#GUID-50450FAD-9769-4CF7-B0D1-EC14B465B873)


    ```
    <copy>
    exec grant_select_on_dcat_tables('dwrole');
    </copy>
    ```

    ![](./images/grant-to-dwrole.png " ")

3. Query the generated schemas and external tables after your synchronization. Copy and paste the following query into your SQL Worksheet, and then click the **Run Statement** icon in the Worksheet toolbar.

    ```
    <copy>
    select oracle_schema_name, oracle_table_name
    from dcat_entities;
    </copy>
    ```

    The schema and external table names are displayed. The generated schemas names now uses the **`obj`** custom property override that you provided instead of the actual data asset name, `Data Lake`.

    ![](./images/schema-and-table-names-2.png " ")


You may now proceed to the next lab.

## Learn More

* [Using Oracle Autonomous Database on Shared Exadata Infrastructure](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/index.html)
* [Connect with Built-in Oracle Database Actions](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/sql-developer-web.html#GUID-102845D9-6855-4944-8937-5C688939610F)
* [DBMS_DCAT Package](https://docs-uat.us.oracle.com/en/cloud/paas/exadata-express-cloud/adbst/ref-dbms_dcat-package.html#GUID-4D927F21-E856-437B-B42F-727A2C02BE8D)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Get Started with Data Catalog](https://docs.oracle.com/en-us/iaas/data-catalog/using/index.htm)
* [Data Catalog Overview](https://docs.oracle.com/en-us/iaas/data-catalog/using/overview.htm)


## Acknowledgements

* **Author:** Lauran Serhal, Principal User Assistance Developer, Oracle Database and Big Data     
* **Contributor:** Marty Gubar, Product Manager, Server Technologies
* **Last Updated By/Date:** Lauran Serhal, October 2021
