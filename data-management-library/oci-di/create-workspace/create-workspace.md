# Create an OCI Data Integration Workspace

## Introduction

This lab will guide you through the steps to set up the necessary policies for OCI Data Integration and to create an OCI Data Integration Workspace.

Estimated Lab Time: 15 minutes

## OCI Data Integration policies and workspaces
Oracle Cloud Infrastructure Data Integration uses standard authentication and authorization offered by Oracle Cloud Infrastructure. Policies required for OCI Data Integration will be an addition to the regular policies used in Oracle Cloud Infrastructure for accessing other necessary resources. To control access to Data Integration and the type of access each group of users has, you must create policies. By default, only the users in the Administrators group can access all Data Integration resources. For everyone else who's involved with Data Integration, you must create policies that gives them proper access to Data Integration resources.
Before you can get started with Data Integration, you must first create a workspace for your data integration solution. A workspace is an organizational construct to keep multiple data integration solutions and their resources (data assets, data flows, tasks, and so on) separate from each other, helping you to stay organized. For example, you can have separate workspaces for development, testing, and production. The workspace is the preliminary component of Oracle Cloud Infrastructure Data Integration.

## Objectives
In this lab, you will:
* Create access policies for OCI Data Integration using Policy Builder UI in Oracle Cloud Infrastructure
* Create a Workspace for Data Integration resources

## Prerequisites
* An Oracle Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported
* You have completed Lab 0 - Setting up the Data Integration prerequisites in Oracle Cloud Infrastructure


## **STEP 1**: Create access policies for OCI Data Integration

1. In your Oracle Cloud console, open the **Menu** in the upper left.
     ![](./images/menu.png " ")

2. In the Oracle Cloud Infrastructure Console navigation menu, navigate to **Identity**, and then select **Policies**.
    ![](./images/menu_policies.png " ")

3. Under List Scope, select the **Compartment** you are using for Data Integration, in this case the one we have created in Lab 0.
    ![](./images/list_comp.png " ")

4. After you have selected your compartment, click on **Create Policy**.
    ![](./images/add_policy.png " ")

5. In the **Create Policy** panel, complete the following fields:
  * Enter a unique **Name** for your policy (For example "Policies-OCI-DI"). *Note that the name can NOT contain spaces.*
  * Enter a **Description** to help other users know the purpose of this set of policies (for example, "Policies for OCI Data Integration").
  * Using the Policy Builder UI, you will choose „Data Integration” for **Policy use cases** and „Let users create and delete workspaces with networking” for **Common policy templates**.
  * Select your **Group** and your **Compartment**, created in Lab 0
  The policy statements should appear below. Click **Create**.
![](./images/policy_builder.png " ")

## **STEP 2:** Create an OCI Data Integration Workspace

1. In your Oracle Cloud console, open the **Menu** in the upper left.
 ![](./images/menu.png " ")

2. In the Oracle Cloud Infrastructure Console navigation menu, navigate to **Analytics & AI**. Under Big Data, click **Data Integration**.
![](./images/menu_di.png " ")

3. Under **List Scope**, from the Compartment dropdown, select the compartment you created policies for in the previous section and on the Data Integration Workspaces page, click **Create Workspace**.
![](./images/workspaces.png " ")

4. In the **Create Workspace** panel, complete the fields as follows, and then click **Create**:
* For **Name**, enter a name without any spaces. (For example, "Workspace1"). *You can only use alphanumeric characters, hyphens, periods, and underscores in the name.*
* You can add a meaningful **Description** to help other understand more about your Data Integration Workspace
* Under Network Selection, **uncheck "Enable private network"**. It should now appear disabled.
![](./images/create_workspace.png " ")

5.	Click **Create**. The workspace takes a few minutes to create and become active. After the creation process is completed, you can access the workspace from the workspace list.
![](./images/create.png " ")

*At the conclusion of the lab add this statement:*
Congratulations!  Now you have the workspace that will hold all your Data Integration resources, such as projects, folders, data assets, tasks, data flows, pipelines, and applications and schedules.   


## Acknowledgements
* **Author** -
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.
