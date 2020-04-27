
<!-- Updated March, 2020 -->

# Bonus Lab 10:  Using Oracle Machine Learning Notebooks

## Introduction

In this lab, you will be using the Oracle Machine Learning (OML) SQL notebook application provided with your Autonomous Data Warehouse. This browser-based application provides a web interface to run SQL queries and scripts, which can be grouped together within a notebook. Notebooks can be used to build single reports, collections of reports, and even dashboards. OML provides a simple way to share workbooks, and collections of workbooks, with other OML users.

### Objectives

-   Learn how to create OML Users
-   Learn how to run a SQL Statement
-   Learn how to share notebooks
-   Learn how to create and run SQL scripts

### Required Artifacts

-   This lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Public Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.


## STEP 2: Signing In to OML
Explore the OML Home Page.

1. Using the link from your welcome email, from Oracle Global Accounts, you can now sign in to OML. Copy and paste the **application link** from the email into your browser and sign in to OML.

  **Note:** If you have not specified an email address, you can click the **Home** icon on the top right of the Oracle Machine Learning User administration page to go to the OML home page.

    ![](./images/Picture700-11.png " ")

2. Sign in to OML using your new user account, **omluser1**:

    ![](./images/Picture700-12.png " ")

  Once you have successfully signed in to OML, the application home page will be displayed.

## STEP 3: Overview of OML Home Page

1. The grey menu bar at the top left corner of the screen provides links to the main OML menus. The workspace/project and user maintenance menus are at the top right corner.

    ![](./images/Picture700-13.png " ")

2. On the home page, the main focus is the “**Quick Actions**” panel. The main icons in this panel provide shortcuts to the main OML pages for running queries and managing your saved queries.

    ![](./images/Picture700-14.png " ")

3. All your work is automatically saved –  there is no “Save” button when you are writing scripts and/or queries.

## STEP 4: Understanding the Key Concepts

-   What is a Notebook?

    A notebook is a web-based interface for building reports and dashboards using a series of pre-built data visualizations, which can then be shared with other OML users. Each notebook can contain one or more SQL queries and/or SQL scripts. Additional non-query information can be displayed using special markdown tags (an example of these tags will be shown later).

    -   What is a Project?

        A project is a container for organizing your notebooks. You can create multiple projects.

-   What is a Workspace?

    A workspace is an area where you can store your projects. Each workspace can be shared with other users so they can collaborate with you. For collaborating with other users, you can provide different levels of permission such as Viewer, Developer and Manager – these will be covered in more detail later in this lab. You can create multiple workspaces.

## STEP 5: Opening a New SQL Query Scratchpad to Run a SQL Statement

1. From the home page, click the “**Run SQL Statements**” link in the Quick Actions panel to open a new SQL Query Scratchpad.

    ![](./images/Picture700-15.png " ")

2. The following screen should appear:

    ![](./images/Picture700-16.png " ")

3. The white panel below the main title (SQL Query Scratchpad – this name is automatically generated) is an area known as “paragraph”. Within a scratchpad you can have multiple paragraphs. Each paragraph can contain one SQL statement or a SQL script.

    ![](./images/Picture700-17.png " ")

4. In the SQL paragraph area, copy and paste <a href="./files/new_SQL_query_scratchpad.txt" target="\_blank">this code snippet</a>. Your screen should now look like this:

    ![](./images/Picture700-18.png " ")

5. Press the icon shown in the red box to execute the SQL statement and display the results in a tabular format:

    ![](./images/Picture700-19.png " ")

    ![](./images/Picture700-20.png " ")

## STEP 6: Changing the Report Type

1. Using the report menu bar, you can change the table to a graph and/or export the result set to a CSV or TSV file.

    ![](./images/Picture700-21.png " ")

2. When you change the report type to one of the graphs, then a **Settings** link will appear to the right of the menu which allows you to control the layout of columns within the graph.

3. Click the **bar graph** icon to change the output to a bar graph (see below).

    ![](./images/Picture700-22.png " ")

4. Click the **Settings** link to unfold the settings panel for the graph.

    ![](./images/Picture700-23.png " ")

5. To add a column to one of the **Keys**, **Groups** of **Values** panels just drag and drop the column name into the required panel.

6. To remove a column from the Keys, Groups of Values panel just click on the **x** next to the column name displayed in the relevant panel.

## STEP 7: Changing the Layout of the Graph

1. With the graph settings panel visible:

    -   Remove all columns from the both the **Keys** and **Values** panels.

    -   Drag and drop **MONTH** into the Keys panel

    -   Drag and drop **REVENUE** into the Values panel

    -   Drag and drop **AVG\_12M\_REVENUE** into the Values panel

The report should now look like the one shown below.

    ![](./images/Picture700-24.png " ")

## STEP 8: Tidying Up the Report

1. Click the **Settings** link to hide the layout controls.

2. Click the **Hide editor** button which is to the right of the "Run this paragraph" button.

    ![](./images/Picture700-25.png " ")

3. Now only the output is visible.

    ![](./images/Picture700-26.png " ")

## STEP 9: Saving the Scratchpad as a New Notebook

The SQL Scratchpad in the previous section is simply a default type notebook with a system generated name. But we can change the name of the scratchpad we have just created, **SQL Query Scratchpad**.

1. Click on the **Back** link in the top left corner of the Scratchpad window to return to the OML home page.

    ![](./images/Picture700-27.png " ")

2. Notice that in the **Recent Activities** panel there is a potted history of what has happened to your SQL scratchpad “notebook”.

    ![](./images/Picture700-28.png " ")

3. Click **Go to Notebooks** in the **Quick Actions** panel

    ![](./images/Picture700-29.png " ")

4. The **Notebooks** page will be displayed:

    ![](./images/Picture700-30.png " ")

5. Let’s rename our SQL Scratchpad notebook to something more informative. Click on text in the **comments** column to select the scratchpad so we can rename it. After you click, the “SQL Query Scratchpad” will become selected and the menu buttons above will activate.

  ![](./images/Picture700-31.png " ")

  ![](./images/Picture700-32.png " ")

6. Click the **Edit** button to pop-up the settings dialog for this notebook and enter the information as shown in the image below
    (*note that the connection information is read-only because this is managed by Autonomous Data Warehouse*):

    ![](./images/Picture700-33.png " ")

7. Click **OK** to save your notebook. You will see that your SQL Query Scratchpad notebook is now renamed to the new name you specified.

    ![](./images/Picture700-34.png " ")

## Want to Learn More?

Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/create-dashboards.html#GUID-56831078-BBF0-4418-81BB-D03D221B17E9) for documentation on creating dashboards, reports, and notebooks with an autonomous database.

## Acknowledgements

- **Author** - Nilay Panchal, ADB Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Richard Green, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
