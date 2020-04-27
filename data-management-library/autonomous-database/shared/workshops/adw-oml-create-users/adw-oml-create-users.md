
<!-- Updated March, 2020 -->

# Creating OML Users

## Introduction

In this lab, you will be using the Oracle Machine Learning (OML) SQL notebook application provided with your Autonomous Data Warehouse. This browser-based application provides a web interface to run SQL queries and scripts, which can be grouped together within a notebook. Notebooks can be used to build single reports, collections of reports, and even dashboards. OML provides a simple way to share workbooks, and collections of workbooks, with other OML users.

### Objectives

-   Learn how to create OML Users
-   Learn how to run a SQL Statement
-   Learn how to share notebooks
-   Learn how to create and run SQL scripts

### Required Artifacts

-   This lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Public Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.


## STEP 1: Creating OML Users
The first step is to create two new users.

1. Go back to the Cloud Console and open the details page for your Autonomous Data Warehouse database. Click **Service Console**.

    ![](./images/Picture700-1.png " ")

2. Go to the **Administration** tab and click **Manage Oracle ML Users** to go to the OML user management page - this page will allow
    you to manage OML users.

      ![](./images/Picture700-3.png " ")

**Note** that you do not have to go to this page using the same steps every time, you can bookmark this Oracle ML Notebook Admin URL and access it directly later.

3. Click **Create** to create a new OML user. Note that this will also create a new database user with the same name. This newly created user will be able to use the OML notebook application. Note that you can also enter an email address to send an email confirmation to your user (*for this lab you can use your own personal email address*) when creating the user.

    ![](./images/Picture700-5.png " ")

4. Enter the required information for this user. Name the user  **omluser1**. If you supplied a valid **email address**, a welcome email should arrive within a few minutes to your Inbox. Click  **Create** in the top-right corner of the page to create the user.

    ![](./images/Picture700-7.png " ")

5. Below is the email which each user receives welcoming them to the OML application. It includes a direct link to the OML application for that user, which can be bookmarked.

    ![](./images/Picture700-8.png " ")

6. After you click **Create** you will see that user listed in the Users section.

    ![](./images/Picture700-9.png " ")

7. Using the same steps, create another user named **omluser2**.

    ![](./images/Picture700-10.png " ")

You will use these two users later in this workshop.

## Want to Learn More?

Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/create-dashboards.html#GUID-56831078-BBF0-4418-81BB-D03D221B17E9) for documentation on creating dashboards, reports, and notebooks with an autonomous database.

## Acknowledgements

- **Author** - Nilay Panchal, ADB Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Richard Green, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
