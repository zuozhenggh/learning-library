# How do I create a Query Service project?
Duration: 5 minutes

**Query Service** is a native OCI query service that is scalable, performant, server-less, and database-less. You can use it to access Oracle Object Storage data using Oracle SQL without requiring you to create or maintain a database. You are only charged for the queries that you submit.

### Prerequisites
* An Oracle Cloud Account.
* An optional compartment for your Query Service project and resources.
* An OCI Data Catalog instance that contains at least one Oracle Object Storage data asset that have been harvested to generate the logical data entities that will be used by Query Service. For detailed instructions on creating a Data Catalog data asset and harvesting it, see **Lab 2: Harvest Technical Metadata from Oracle Object Storage** in the [Access the Data Lake using Autonomous Database and Data Catalog](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=877&clear=180&session=103071880685237) Livelabs workshop. Alternatively, you can create a new Data Catalog instance when you create your Query Service project.

* The required policies to allow access to the Data Catalog instance, Oracle Object Storage, and Query Service projects.

## Create a Query Service Project

A Query Service project is a collection of tables, worksheets, and queries related to a common theme or task. Every Query Service project is associated with a single Data Catalog instance that you specify when you create the project. Every project will have a small Autonomous Database (ADB) instance that is provisioned for you automatically. This ADB instance contains the schemas and external table definitions that are derived (synchronized) from the Data Catalog instance logical entities that you choose when you create the project.

1. Sign in to the Oracle Cloud Infrastructure Console using your tenancy, username, and password. For the **Query Service Limited Availability (LA) release**, click the following link to navigate to the [Query Service Console](https://cloud.oracle.com/sql-queryservice?region=us-ashburn-1) (https://cloud.oracle.com/sql-queryservice?region=us-ashburn-1).

2. On the **Query Service Projects** page, click **Create Project**.

3. In the **Create Query Service project** panel, specify the following:
    * **Name:** Accept the default name.
    * **Create in compartment:** Select the compartment where you'd like to create this project. Click the **Create In Compartment** drop-down list and start typing the compartment's name in the **Search compartments** text field. Once you see your compartment, click it. In this example, we selected the **`training-query-service`** compartment.

      ![train is entered in the Search box and the training-query-service compartment is displayed and selected.](./images/create-in-compartment.png " ")

    * **Project Description:** Enter an optional description.
    * **Connect Data Catalog:** Select the compartment that contains the Data Catalog instance to which you want to connect from the drop-down list. Click the **Change Compartment** link to search for Data Catalog instance if it's in a different compartment. In this example, we selected the **`query-service-sandbox`** compartment which contains a data catalog named **DataLake**. This instance contains a data asset that was harvested from three Oracle Object Storage buckets. Logical data entities were harvested from each of the three buckets.

        + **moviestream\_sandbox**
        + **moviestream\_landing**
        + **moviestream_gold**

        When you create a Query Service project, you must choose a Data Catalog instance. When the project is created, Query Service creates an ADB instance associated with the project and synchronizes automatically with the Data Catalog instance. It synchronizes (links) the metadata in ADB with your Data Catalog instance and creates schemas that correspond to your harvested data assets and external tables in those schemas that correspond to the logical entities in the Data Catalog instance.  

    >**Note:** If you don't have a Data Catalog instance, click **Create Data Catalog** in the **Create Query Service project** panel to create a new one. Next, complete the fields in the **Create Data Catalog** panel. For detailed information on how to create and harvest a data asset from Oracle Object Storage buckets, see **Lab 2: Harvest Technical Metadata from Oracle Object Storage** in the [Access the Data Lake using Autonomous Database and Data Catalog](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=877&clear=180&session=103071880685237) Livelabs workshop.

      ![The Create Data Catalog in the Create Query Service project panel is selected which displays the Create Data Catalog panel.](./images/create-dcat-qs.png " ")

    * **Create Policy:** The **Query Service LA** release doesn't support creating the required policies using this section. You must create the policies manually; however, you can click **Create Policy** to view the required policies that you need to create. This is covered in the **How do I create the required policies for Query Service projects?** workshop sprint that you can select from the **Contents** menu on the left.  

      ![The completed Create Query Service project panel is displayed.](./images/create-qs-project.png " ")

      You can click the **Show Advanced Options** to configure and limit the project level settings using the **Configure Project-level Settings** section.

      ![The default Configure Project-level Settings section is displayed.](./images/project-level-settings.png " ")

4. Click **Create Project**. The initial state of the project is **CREATING**. When the project is created successfully, its state changes to **ACTIVE** and it is displayed in the **Query Service Projects** page.   

    ![The newly created Query Service project is displayed with an Active state.](./images/new-qs-project.png " ")

5. To view the project's details page, click the project's name link in the **Name** column.

    ![The new Query Service project detail is displayed.](./images/project-detail.png " ")

    You can use this page to do the following:

    * On the top of the page, you can access the **Query Editor**, edit the project, download database wallet, and use the **More Actions** drop-down list to add tags, create database password, delete the project, and open the Analytics Cloud.
    * In the middle of the page, you can click the appropriate tabs to display the project's information, project settings, and tags.
    * The **Resources** section provides information about tables in selected schemas, past query executions in the Query Editor, and work requests such as the CREATE PROJECT when you create a project.
    * The **worksheets** section displays any worksheets that you have saved previously.

    >**Note:** To return to the **Query Service Projects** page, click the **Projects** link in the breadcrumbs.

6. From the **Query Service Projects** page, you can also click the **Data Catalog** name link to display the details of the Data Catalog instance that you used with the project.

    ![The Data Catalog instance page is displayed.](./images/view-data-catalog.png " ")  

    >**Note:** To return to the **Query Service Projects** page, click your browser's Back button.

7. From the **Query Service Projects** page, you can also click **Query Editor** to display the Query Editor where you can use Oracle SQL to query your data from Oracle Object Storage buckets.

8. Finally, you can click the **Actions** button (three vertical dots) in the row for your Query Service project to display the Context menu and perform a variety of tasks.

    ![The Query Service project, its Actions button, and the Context menu are highlighted.](./images/actions-menu.png " ")  


## Learn More

* [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm).
* [Data Catalog Documentation](https://docs.oracle.com/en-us/iaas/data-catalog/home.htm)
* [Data Catalog Policies](https://docs.oracle.com/en-us/iaas/data-catalog/using/policies.htm)
* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Access the Data Lake using Autonomous Database and Data Catalog Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=877)
