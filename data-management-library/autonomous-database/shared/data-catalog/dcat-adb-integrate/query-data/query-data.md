# Query Data Across ADB and the Data Lake Using OML

## Introduction

In this lab, you will use the Oracle Machine Learning Notebooks (OML) to query joined data from both the Data Warehouse and the Data Lake; i.e. the data from the three Oracle Object Storage buckets that you setup in this workshop. See [OML Notebooks documentation](https://docs.oracle.com/en/database/oracle/machine-learning/oml-notebooks/index.html).

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
- Access Oracle Machine Learning Notebooks provided with Oracle Autonomous Database
- Import and review the imported notebook

### Prerequisites

This lab assumes you have:
* An Oracle account
* Completed all previous labs successfully
* Import the required notebook

## Task 1: Access Oracle Machine Learning Notebooks

You can import, create, and work with notebooks in Oracle Machine Learning Notebooks. You can access Oracle Machine Learning Notebooks from Autonomous Database.

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator. You will complete all the labs in this workshop using this Cloud Administrator.
See [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm) in the _Oracle Cloud Infrastructure_ documentation.

2. On the **Sign In** page, select your tenancy, enter your username and password, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

3. Open the **Navigation** menu and click **Oracle Database**. Under **Oracle Database**, click **Autonomous Database**.

4. On the **Autonomous Databases** page, make sure **`training-dcat-compartment`** is selected in the **Compartment** drop-down list in the **List Scope** section, and then click your **DB-DCAT Integration** ADB that you provisioned earlier.

5. On the **Autonomous Database Details** page, click **Service Console**. In the **Database Actions** card, click **Open Database Actions**.

   ![](./images/service-console.png " ")

6. On the **Service Console** page, click the **Development** on the left.

    ![](./images/development-link.png " ")

7. On the **Development** page, scroll-down to and click the **Oracle Machine Learning Notebooks** card.

    ![](./images/oml-card.png " ")

8. On the **SIGN IN** page, enter **`moviestream`** in the **Username** field, your assigned password such as **`Training4ADB`** in the **Password** field, and then click **Sign In**.

   ![](./images/login-moviestream.png " ")

   The **Oracle Machine Learning** Home page is displayed.

   ![](./images/oml-home.png " ")


## Task 2: Import a Notebook

1. On the **Oracle Machine Learning** Home page, in the **Quick Actions** section, click the **Notebooks**. The **Notebooks** page is displayed.    

    ![](./images/notebooks-page.png " ")

2. Click **Import**. The **Open** dialog box is displayed.

3. Copy following URL to the notebook and paste it in the **File name** field. Make sure that the **JSON file (*.json)** type is selected in the second drop-down field, and then click **Open**.

    ```
    <copy>
    https://objectstorage.us-phoenix-1.oraclecloud.com/p/asZnZNzK6aAz_cTEoRQ9I00x37oyGkhgrv24vd_SGap2joxi3FvuEHdZsux2itTj/n/adwc4pm/b/moviestream_scripts/o/Notebook-Data%20Lake%20Accelerator.json
    </copy>
    ```

    ![](./images/open-dialog.png " ")

    If the import is successful, a notification is displayed at the top and the **`Data Lake Accelerator`** notebook is displayed in the list of available notebooks on **Notebooks** page.

    ![](./images/notebook-imported.png " ")

4. Open the imported notebook. On the **Notebooks** page, click the **Data Lake Accelerator** notebook. The notebook is displayed in notebook **Editor**.

    ![](./images/notebook-displayed.png " ")


## Task 3: Set the Interpreter Bindings for the Imported Notebook

An interpreter is a plug-in that allows you to use a specific data processing language backend. To display and visualize data using SQL in a notebook paragraph, that data must be fetched from the database; therefore, you must bind a notebook to an interpreter to fetch data from the database or any data source. A default set of interpreter bindings is available. Paragraphs using the **SQL** **`%sql`** and **PL/SQL** **`%script`** interpreters allow you to invoke Oracle SQL and PL/SQL statements, respectively. The interpreter binding order that is set for a notebook applies to all the paragraphs in that notebook. However, you can override the interpreter binding for SQL and PL/SQL interpreters for any specific paragraph in the notebook.

>**Note:** For the Zeppelin Notebooks in Oracle Machine Learning, you use the sql and pl/sql interpreters within an Oracle Database interpreter group and the md (MarkDown) interpreter for plain text formatting syntax so that it can be converted to HTML.

1. Click on the gear icon on the top right. The **Settings** panel is displayed. The list of available interpreters is displayed in the **Interpreter binding** section.

    ![](./images/settings-panel.png " ")

2. Select at least one of the interpreters that indicate **%sql (default), %script, %python**. You can move the interpreters to change their order and bring the one you prefer to the top. The first interpreter in the list is the default. Click and drag the **trainingadb_medium %sql (default), %script, %python** interpreter to the top of the list to make it the default. Click **Save** to save your changes. See [About Interpreter Bindings and Notebooks](https://docs.oracle.com/en/database/oracle/machine-learning/oml-notebooks/omlug/interpreters-and-notebooks.html).

    ![](./images/reorder-interpreter.png " ")

    The notebook is re-displayed.

## Task 4: Review and Run the Imported Notebook    

1. Run the entire notebook by clicking the **Run all paragraphs** icon on the Notebook toolbar at the top of the page next to the notebook's name.

    ![](./images/run-notebook.png " ")

    The **Run all** confirmation message box is displayed. Click **OK**.

    ![](./images/run-all.png " ")

    > **Note:** When a paragraph executes successfully, its status changes from READY to FINSIHED.

2. When all the paragraphs in the note are finished, review each paragraph and examine its output.     

    ![](./images/run-finished.png " ")

## Learn More

* [OML Notebooks documentation](https://docs.oracle.com/en/database/oracle/machine-learning/oml-notebooks/index.html)
* [Oracle Database documentation](https://docs.oracle.com/en/database/oracle/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Using Oracle Autonomous Database on Shared Exadata Infrastructure](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/index.html)


## Acknowledgements

* **Author:** Lauran Serhal, Principal User Assistance Developer, Oracle Database and Big Data
* **Contributor:** Marty Gubar, Product Manager, Server Technologies    
* **Last Updated By/Date:** Lauran Serhal, October 2021
