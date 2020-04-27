
<!-- Updated March, 2020 -->

# OML - Using SQL Scripts

## Introduction

In this lab, you will be using the Oracle Machine Learning (OML) SQL notebook application provided with your Autonomous Data Warehouse. This browser-based application provides a web interface to run SQL queries and scripts, which can be grouped together within a notebook. Notebooks can be used to build single reports, collections of reports, and even dashboards. OML provides a simple way to share workbooks, and collections of workbooks, with other OML users.

### Objectives

-   Learn how to create OML Users
-   Learn how to run a SQL Statement
-   Learn how to share notebooks
-   Learn how to create and run SQL scripts

### Required Artifacts

-   This lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Public Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.

## STEP 13: Getting Started with SQL Scripts

1. Log out from user OMLUSER2 and log in as OMLUSER1.
The “Run SQL Statement” link on the home page allows you to run a single query in a paragraph. To be able to run scripts you can use the “Create a SQL Script” link on the home page.

2. On the OML home page, click **Create a SQL Script** link within the **Quick Actions** panel.

    ![](./images/Picture700-45.png " ")

3. A new **SQL scratchpad** will be created with the **%script** identifier already selected, this identifier allows you to run multiple SQL statements.

    ![](./images/Picture700-46.png " ")

Notice that the script paragraph does not have any menus to control the display and formatting of the output. You can, however, use SQL SET commands to control how data is formatted for display.

## STEP 14: Creating and Running a SQL Script

In this section we are going to use a script from a SQL pattern matching tutorial, <a href="https://livesql.oracle.com/apex/livesql/file/tutorial_EWB8G5JBSHAGM9FB2GL4V5CAQ.html" target="\_blank">Sessionization with MATCH\_RECOGNIZE and JSON</a>, on the free Oracle <a href="http://livesql.oracle.com/" target="\_blank">livesql.oracle.com</a> site. This script shows how to use the SQL pattern matching **MATCH\_RECOGNIZE** feature for sessionization analysis based on **JSON** web log files.

1. Copy and paste <a href="./files/Sessionization_with_MATCH_RECOGNIZE_and_JSON.txt" target="\_blank">this code snippet</a> into the **%script** paragraph. After pasting the above code into the script paragraph it should look something like this:

    ![](./images/Picture700-47.png " ")

2. You can then run the script/paragraph and the output will appear below the code that makes up the script.

    ![](./images/Picture700-19.png " ")

3. The result should look something like this:

    ![](./images/Picture700-48.png " ")

## Want to Learn More?

Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/create-dashboards.html#GUID-56831078-BBF0-4418-81BB-D03D221B17E9) for documentation on creating dashboards, reports, and notebooks with an autonomous database.

## Acknowledgements

- **Author** - Nilay Panchal, ADB Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Richard Green, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
