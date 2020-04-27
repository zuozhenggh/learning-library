
<!-- Updated March, 2020 -->

# OML - Understanding Permissions

## Introduction

In this lab, you will be using the Oracle Machine Learning (OML) SQL notebook application provided with your Autonomous Data Warehouse. This browser-based application provides a web interface to run SQL queries and scripts, which can be grouped together within a notebook. Notebooks can be used to build single reports, collections of reports, and even dashboards. OML provides a simple way to share workbooks, and collections of workbooks, with other OML users.

### Objectives

-   Learn how to create OML Users
-   Learn how to run a SQL Statement
-   Learn how to share notebooks
-   Learn how to create and run SQL scripts

### Required Artifacts

-   This lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Public Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.


## STEP 10: Logging In to OML as the Second OML (OMLUSER2) User and Sharing Notebooks

By default, when you create a notebook it’s only visible to you.

To make it available to other users you need to share the workspace containing the notebook. You can create new workspaces and projects to organize your notebooks for ease of use and to share with other users.

To demonstrate the sharing process let’s begin by logging in to OML as our second OML (OMLUSER2) user and checking if any notebooks are
available.

1. Click on your user name in the top right corner (**OMLUSER1**) and select “**Sign Out**”.

    ![](./images/Picture700-35.png " ")

2. Now sign in as OML user **OMLUSER2** using the password you entered at the beginning of this workshop:

    ![](./images/Picture700-36.png " ")

    ![](./images/Picture700-37.png " ")

Notice that you have no activity listed in the **Recent Activities** panel on your OML home page and you don’t have any notebooks.

3. Hint – click on the **Go to Notebooks** link in the **Quick Actions** panel:

    ![](./images/Picture700-38.png " ")

4. Repeat the previous steps to logout of OML and sign into OML as **OMLUSER1**.

## STEP 11: Changing Workspace Permissions

1. From the OML home page, click the **OML Project (OML Workspace)** link in the top right corner on the OML home page to display the workspace-project menu. Then select **Workspace Permissions**.

    ![](./images/Picture700-39.png " ")

2. The permissions dialog box will appear (see below).

3. In the dialog box next to the **Add Permissions** text, type **OMLUSER2** (use uppercase).

4. Set the permission type to **Viewer** (this means read-only access to the workspace, project and notebook).

**Note:**

    -   A “Developer” would have read-only access to the workspace, project but could add new notebooks, update and delete existing notebooks and schedule jobs to refresh a notebook.

    -   A “Manager” would have read-only access to the workspace, can create update and delete projects, add new notebooks, update and delete existing notebooks and schedule jobs to refresh a notebook.

    ![](./images/Picture700-40.png " ")

5. Click the **Add** button to add the user **OMLUSER2** as a read-only viewer of the workspace. Your form should look like this:

    ![](./images/Picture700-41.png " ")

6. Finally, click the **OK** button.

## STEP 12: Accessing shared notebooks

1. Now, repeat the process you followed at the start of this section and sign-out of OML and sign-in to OML again as user **OMLUSER2**.

-   First thing to note is that the **Recent Activities** panel below the **Quick Links** panel now shows all the changes user OMLUSER1
    made within the workspace OML-Workspace.

    ![](./images/Picture700-42.png " ")

2. As user **OMLUSER2** you can now run the **Sales Analysis Over Time** notebook by clicking on **the blue-linked text** in the **Recent Activities** panel (*note that your recent activity will be logged under the banner labeled “Today”*).

    ![](./images/Picture700-43.png " ")

3. The notebook will now open:

    ![](./images/Picture700-44.png " ")


## Want to Learn More?

Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/create-dashboards.html#GUID-56831078-BBF0-4418-81BB-D03D221B17E9) for documentation on creating dashboards, reports, and notebooks with an autonomous database.

## Acknowledgements

- **Author** - Nilay Panchal, ADB Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Richard Green, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
