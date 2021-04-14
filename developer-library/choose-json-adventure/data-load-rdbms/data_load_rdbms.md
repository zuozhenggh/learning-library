# Loading JSON into the Autonomous Database Part 1: Relational

## Introduction

In this lab you will use the SQL Developer Web browser-based tool, connect to your Database and load JSON data into relational tables. You will then work with this data to understand how it is accessed and stored.

Estimated Lab Time: 30-45 minutes

### Objectives

- Load JSON data into relational tables
- Understand how Oracle stores JSON data in relations tables
- Work with the JSON data with SQL

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- You have completed the user setups steps.

### **STEP 1**: Loading Data in a Relational Table

1. After logging into Database Actions in the previous section, we come to the Getting Started/Database Actions Overview page. Start by clicking the SQL tile.

    ![Database Actions Home Page, Click SQL tile](./images/sdw-15.png)

**If this is your first time accessing the SQL Worksheet, you will be presented with a guided tour. Complete the tour or click the X in any tour popup window to quit the tour.**

2. We are now ready to load data into the database. For this task, we will use the Data Loading tab in the SQL Worksheet.

    ![Click Data Loading Tab on SQL Worksheet](./images/sdw-16.png)

3. Start by clicking the Data Loading area; the center of the gray dotted-line box.

    ![Click the Center of the Data Loading Tab Area](./images/sdw-17.png)

4. The Upload Data into New Table model will appear.

    ![To upload a file, Drag into the File Load Modal or Click Select File and use the OS File Browser](./images/sdw-18.png)

5. We are going to use some sample data to load data into the database and create a table at the same time. Start by downloading this file

    **(right-click and download the file with the following link)**

    [1980's Artifacts](https://some_url/artifacts1980.json)

6. Once on your desktop, drag the file into the Upload Data into New Table model. You can also click the Select Files button and find where you downloaded it via your operating system's file browser.

    ![Click the Next Button](./images/sdw-19.png)

7. The modal will then give you a preview of what the data will look like in an Oracle table. Go ahead and click the Next button on the bottom right of the modal.

    ![View Data Preview and then Click Next Button](./images/sdw-20.png)

    On the following step of the data loading modal, we can see the name of the table we are going to create as well as the column and data types for the table.

    ![Data Column Layout from uploaded file](./images/sdw-21.png)

8. We need a Primary Key for our table. Here, we can use the ID column. Just click the PK checkbox for the ID row.

    ![Click the PK checkbox for the ID Column](./images/sdw-22.png)

9. For embedded JSON arrays, we need to set the column type to CLOB (JSON). 

    ![JSON Arrays in a Column](./images/sdw-23.png)

    Use the **Column Type** dropdown for the STARRING column and select **CLOB (JSON)**. 

    ![Change Column Type](./images/sdw-24.png)

    We will work with these arrays later in this lab.

10. Click Next on the bottom right of the modal when done.

    ![Next button on modal](./images/sdw-25.png)

11. On the last step of the modal, we can see the DDL (Data Definition Language) for creating the table, table name and if you scroll down, the column mappings.

    ![The Data Definition Language preview for the table and data](./images/sdw-26.png)

12. When you are done taking a look, click the Finish button in the lower right of the modal.

    ![Click Finish in the Data Loading Modal](./images/sdw-27.png)

    The Data Loader will now process the file by creating a table and loading the JSON file data into that table. 

    ![Data Will Load Into the Database indicated by the Uploading Data Modal](./images/sdw-28.png)

    Once its done, you will see a row in the Data Loading tab that indicates how many rows were uploaded, if any failed and the table name.

    ![Row indicating data load is finished in the Data Loading Tab of the SQL Worksheet](./images/sdw-29.png)

13. We can take a look at our newly created table and the data in it by using the navigator on the left of the SQL Worksheet. Just right click the table name and select Open from the pop up menu.

    ![Using the navigator on the left of the SQL Worksheet, we can see out new table](./images/sdw-30.png)

14. In the slider that has come out from the right of the page, we can look at the data definition, triggers, constraints and even the data itself.

    ![Click the Data option to view the table data](./images/sdw-31.png)

### **STEP 2**: Working with JSON Data in a Relational Table

XXX









## Acknowledgements

- **Authors** - Jeff Smith, Beda Hammerschmidt and Brian Spendolini
- **Last Updated By/Date** - April 2021
- **Workshop Expiry Date** - April 2022