# How do I query data in Query Service?
Duration: 15 minutes

You will use Query Editor in Query Service to query data using standard Oracle SQL.

### Prerequisites
* An Oracle Cloud Account.
* A Data Catalog instance.
* A Query Service project.
* The required policies to allow access to the Data Catalog instance, Oracle Object Storage, and Query Service projects.

## Query Data in Query Service Using the Query editor

### **About the Automatically Created Schemas in Query Service**  

Query Service contains the following schemas:

+ **DCAT$:** Schemas whose name starts with **DCAT$** concatenated with the **Data Catalog data asset name**, an **_** (underscore) , followed by the **Object Storage bucket's name**. Those are created by Query Service as part of the automatic synchronization process between your Data Catalog instance and the ADB instance provisioned for your Query Service project.
+ **PROJECT:** You can connect to this schema using **SQLNet** connections such as JDBC and SQL*Plus. You can then create Query service Project tables manually in this schema and run queries against those tables. It is also the Database User that the service uses to run queries submitted through the OCI Interface (UI/SDK/CLI).
+ **PROJECT$:** This schema contains the tables that Query Service creates and manages.
+ **MOVIESTREAM_DEMO:** A sample schema that is available with Query Service.

### **The DCAT$ Schemas**

When Query Service creates your project, it provisions an ADB instance for the project and synchronizes it automatically with the Data Catalog instance associated with the project (which you specified when you created the project). As part of the synchronization process, Query Service creates schemas that correspond to your harvested data assets and creates external tables in those schemas that correspond to the logical entities. It creates one schema for each Oracle Object Storage bucket. By default, the name of a generated schema in Query Service starts with the keyword **`DCAT$`** concatenated with the **data asset name**, an **_** (underscore) , followed by the **Object Storage bucket's name**.

![A box displays the default schema name format as DCAT$<data-asset-name>_<bucket-name>.](./images/schema-format.png " ")

In this workshop, we specified a Data Catalog instance named **DataLake** when we created a new project. This instance contains an Oracle Object Storage data asset named **DataLake** that was harvested from the following three Oracle Object Storage buckets. Logical data entities were derived from the buckets: **moviestream\_sandbox**, **moviestream\_landing**, and **moviestream_gold**.
For details, see the [Access the Data Lake using Autonomous Database and Data Catalog](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=877&clear=180&session=103071880685237) Livelabs workshop.
<!--
For example, the generated schema name for the **`moviestream_sandbox`** Oracle Object Storage bucket uses the **`DataLake`** data asset name and the bucket name as part of the schema name as follows:

![A box displays DCAT$DATALAKE_MOVIESTREAM_SANDBOX.](./images/sandbox-schema.png " ")    

-->

Therefore, the three schemas that were created by the Data Catalog synchronization process in this workshop are:
  + **DCAT$DATALAKE_MOVIESTREAM\_SANDBOX**
  + **DCAT$DATALAKE_MOVIESTREAM\_LANDING**
  + **DCAT$DATALAKE_MOVIESTREAM\_GOLD**

### **About the Automatically Generated External Tables**

As part of the synchronization process, Query Service also creates schemas that correspond to your harvested data assets. It also creates external tables in those schemas that correspond to the logical entities in each bucket that were derived from the Oracle Object Storage buckets in your Data Catalog instance. In our example, the **moviestream\_sandbox** Oracle Object Storage bucket from our Data Catalog instance contains three logical data entities; therefore, Query Service created three external tables in the **DCAT$DATALAKE_MOVIESTREAM\_SANDBOX** schema which correspond to the three derived logical data entities: **CUSTOMER\_PROMOTIONS**, **MOVIESTREAM\_CHURN**, **POTENTIAL\_CHURNERS**.

![External tables in the schema.](./images/sandbox-tables.png " ")

>**Note:** The names of your generated Data Catalog schemas and external tables depend on the names of your own data asset and Object Storage buckets.

<!--
![Data catalog logical entities for the MOVIESTREAM_SANDBOX bucket.](./images/dcat-sandbox.png " ")    
-->

<!-- Comments -->

<!--
>**Note:** In Data Catalog, you can provide a custom property override for the schema name that will generated. In addition, you can customize the business names for each of the three Oracle Object Storage buckets that you use in this workshop. For example, instead of using the Data Asset name in the generated schema name, you can provide a shorter name such as **obj** (for Object Storage). Similarly, instead of using the buckets name as part of the generated schema name, you provide a shorter business name for the bucket. For example, instead of having long schema names in queries such as **DCAT$DATALAKE_MOVIESTREAM\_SANDBOX**, you can have a shorter name for the generated schema such as **DCAT$OBJ_SANDBOX**. For detailed information, see the [Access the Data Lake using Autonomous Database and Data Catalog](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=877&clear=180&session=103071880685237) Livelabs workshop.
-->


### **Use Query Editor to Query Data in Oracle Object Storage Buckets**

1. Sign in to the Oracle Cloud Infrastructure Console using your tenancy, username, and password. For the **Query Service Limited Availability (LA) release**, click the following link to navigate to the [Query Service Console](https://cloud.oracle.com/sql-queryservice?region=us-ashburn-1) (https://cloud.oracle.com/sql-queryservice?region=us-ashburn-1).

2. On the **Query Service Projects** page, in the row for your Query Service project, click **Query Editor**. This is the quickest way to access the Query Editor and start querying tables in the available schemas. Alternatively, you can click the project's name link to display the project's detail page and then click **Query Editor**.

![The Query Editor button on the Query Service projects page is highlighted.](./images/query-editor-button.png " ")  

  The **scratchpad** page is displayed. This is where you enter your SQL queries.

  ![The scratchpad page is displayed.](./images/scratchpad-callouts.png " ")  

### **Components of the scratchpad Worksheet**

1. **Breadcrumbs:** Click **Projects** in the breadcrumbs to return to the **Query Service Projects** page. Click **Worksheets** to view the project details page which shows your saved worksheets.

2. **Select a Schema:** Click this drop-down list to select the schema that contains the tables that you want to query.

3. **Create Table:** This button is enabled only when you select the **PROJECT$** schema.

4. **Tables:** This section displays the tables in the schema that you selected in the **Select a Schema** drop-down list.

5. **Choose Worksheet:** Initially, only the **scratchpad** worksheet is available in this field. When you save your queries as new worksheets, you will be able to select those worksheets from this drop-down list.

6. **Tools buttons:** You can use the buttons in this section to run the SQL query in the scratchpad area, run all SQL queries in the currently selected worksheet, save the worksheet, set the query settings, and delete the worksheet.

7. Enter your SQL queries in the scratchpad area.

8. The **Last Query Result** tab shows the status and output of your query.

9. The **Query Executions** tab displays the queries executed in the currently selected worksheet in the **Choose Worksheet** drop-down list.

Let's query the **CUSTOMER\_CONTACT** external table from the **MOVIESTREAM_DEMO** sample schema that is available with Query Service.

3. Click the **Select a Schema** drop-down list to view the available schemas in your project. Select the **MOVIESTREAM_DEMO** sample schema that is available with Query Service.

  ![Select a Schema drop-down list.](./images/select-schema.png " ")  

4. Use the horizontal scroll bar at the bottom of the **Tables** section to scroll to the right and view the **Actions** icon that is associated with each table.

  ![Actions icon in the Tables section is highlighted.](./images/tables-actions-icons.png " ")  

5. The **Tables** section displays the tables in this sample schema. You can click a table's name link to display its definition. For example, click **CUSTOMER_CONTACT** to display the table's definition. When done, click **Close** to close the table's definition.

  ![Click table link to display its definition.](./images/click-table.png " ")

6. To query a table, click the **Actions** button next to a table such as **CUSTSALES**, and then select **Query** from the Context menu. The SQL query is displayed in the Scratchpad area. Click **Run Query** to run the query. An information box is displayed briefly. In the **Last Query Result** tab, the status of running the query is displayed, initially **In Progress**. When the query is completed successfully, the results are displayed in the **Last Query Result** tab and the status changes to **Succeeded**.  

  ![Select Query from the Actions context menu associated with CUSTSALES.](./images/query-custsales.png " ")

7. To view the status of the current and past query executions, click the **Query Executions** tab.

  ![The Query Executions tab is displayed.](./images/query-executions.png " ")  

8. To view the details of a past query execution from the **Query Executions** tab, click the query's link in the **Name** column.
   The query detail page is displayed. You can use this page to edit the name of the saved query, click the **View Result** link in the **Query Information** tab to view the results of the query. You can also click the **Open Query in Worksheet** to open the query in **Query Editor**. Finally, you can click the **Log Messages** and **Error Messages** links in the **Resources** section on the left to display the log messages and error messages, if any.  

  ![The query detail page is displayed.](./images/query-detail-page.png " ")  

9. Click the **Query Executions** link in the breadcrumbs to return to the scratchpad worksheet. Scratchpad is a temporary worksheet; therefore, SQL queries written in Scratchpad will be lost. You can save your Scratchpad query to a worksheet that you can retrieve at a later time. You can also share the saved worksheet with others. Click **Save**, and then select **Save Worksheet as** from the drop-down list.

  ![The query detail page is displayed.](./images/save-worksheet.png " ")

10. In the **Save Worksheet as** dialog box, enter a meaningful name for the worksheet and then click **Save as**. The saved worksheet is displayed.

    ![The saved worksheet is displayed.](./images/my-custsales-query.png " ")


### **Exploring the Project Detail Page**

1. Click **Projects** in the breadcrumbs to return to the **Query Service Projects** page.

2. Click the project name link to display the project's detail page.

    ![The project name link is highlighted.](./images/project-name-link.png " ")  

3. On the detail page, you can click the **Query Editor** buttons to access the Query Editor. In addition, in the **Worksheets** section, you can click on a worksheet name link to display the queries in the worksheet in Query Editor.

    ![The worksheet detail page is displayed.](./images/project-detail-page.png " ")  

4. The worksheet example contains three queries. To run all three queries, click **Run Worksheet**.

    ![Three queries on the worksheet and run worksheet is highlighted.](./images/run-worksheet.png " ")

5. Three informational messages are displayed briefly about each query about to be executed. When the queries execution is completed successfully, the status of running the worksheet in the **Last Query Result** tab changes from **In Progress** to  **Succeeded**. The **Last Query Result** tab shows the output of the last query executed.

    ![Three queries on the worksheet and run worksheet is highlighted.](./images/last-query-output.png " ")

6. To view the output of all three queries in the worksheet, click the **Query Executions** tab. Next, click the **View Result** link that is associated with a query to view its output. Click the **View Result** link that is associated with the **query-CUSTSALES** to view its output.

    ![The queries' names and view result links are highlighted.](./images/view-results.png " ")

7. Click the **View Result** link that is associated with the **query-CUSTSALES** to view its output.

    ![The query-CUSTSALES and the view result link are highlighted.](./images/query-custsales.png " ")

8. Click **Worksheets** in the breadcrumbs to return to the project's detail page. Click **Edit** to display the **Edit Query Service Project** panel. You can use this panel to edit the project's name, edit or add a description, and edit the project-level settings. When you done with your changes, click **Save Changes**.

    ![The Edit Query Service Project panel is displayed.](./images/edit-project.png " ")

9. In the **Resources** section, click **Tables**. The **Tables** section is displayed. This section was covered in detail earlier in this workshop.

    ![The Tables section is displayed.](./images/tables-section.png " ")

10. In the **Resources** section, click **Query Executions**. The **Query Executions** section is displayed. This section was covered in detail earlier in this workshop.

    ![The Tables section is displayed.](./images/filter-query-executions.png " ")

    >**Note:** You can use the **View Query executions from Worksheet** drop-down list to display all query executions from all of worksheets (default), or choose a specific worksheet.

11. In the **Resources** section, click **Workshop Requests**. The **Workshop Requests** section is displayed. Click one of the **CREATE\_TABLE** links that failed. The **CREATE\_TABLE** page is displayed. By default, the **Log Messages** section is displayed. The messages provides you with important debugging information.

    ![The CREATE_TABLE page is displayed.](./images/create-table-page.png " ")

12. Since this workshop request did fail, click the **Error Messages** link in the **Resources** section to find out more details about the failed job. The error message indicates a problem trying to connect to the tables.  

    ![The CREATE_TABLE page is displayed.](./images/error-message.png " ")


## Learn More

* [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm).
* [Data Catalog Documentation](https://docs.oracle.com/en-us/iaas/data-catalog/home.htm)
* [Data Catalog Policies](https://docs.oracle.com/en-us/iaas/data-catalog/using/policies.htm)
* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Access the Data Lake using Autonomous Database and Data Catalog Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=877)
* [DBMS_DCAT Package](https://docs-uat.us.oracle.com/en/cloud/paas/exadata-express-cloud/adbst/ref-dbms_dcat-package.html#GUID-4D927F21-E856-437B-B42F-727A2C02BE8D)
* [RUN_SYNC Procedure](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/ref-running-synchronizations.html#GUID-C94171B4-6C57-4707-B2D4-51BE0100F967)
* [Using Oracle Autonomous Database on Shared Exadata Infrastructure](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/index.html)
* [Connect with Built-in Oracle Database Actions](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/sql-developer-web.html#GUID-102845D9-6855-4944-8937-5C688939610F)
