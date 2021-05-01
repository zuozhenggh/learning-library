# Setting up Governance Policies

## Introduction
This lab walks you through the steps to set up governance policies on CM12.

Estimated Lab Time: 30 minutes

### Objectives
In this lab you will:
* x
* y
* z

### Prerequisites
- Access to the Cloud Manager console.
- Environment up and running

## **STEP 1**: Create Source Template

We first need to create a new template for our source environment. The DB name of our source environment and target environment **must** be different, which is why we cannot use an existing template. As for our target environment we will be using the environment created in the previous labs, **WorkshopEnvironment**.

1.  Navigate to **Dashboard** > **Environment Template**. Click **Add New Template**.
    ![](./images/template.png "")

2.  On the General Details page:
    * Give the template a name such as **PUMFT38** and enter a description
    * Click on the search icon next to PeopleSoft Image and select **PEOPLESOFT HCM UPDATE IMAGE 9.2.038 - NATIVE OS**
    ![](./images/.png "")
    * Click **Next**

3.  On the Select Topology page:
    * Click on the search icon under Topology Name and select **Fulltier**
    * Expand the **Custom Attributes** section and select **Fulltier** again in the dropdown
    * Click on **Edit Custom Attributes**
    ![](./images/attributes.png "")

    * Expand the **Region and Availability Domains** section and select the following: 
    ![](./images/regionad.png "")

    * Expand **Full Tier** > **General Settings** and make the following changes:
        * Database Operator Id: **PS**
        * Database Name: **SOURCEDB**
    ![](./images/dbps.png "")

    * Expand **Subnet Settings** and select **cm**
    ![](./images/dbps.png "")

4.  On the Define Security page:
    * Click on the search icon under Zone Name and select **Test**
    * Click on the search icon under Role Name and select **PACL_CAD**
    * Click **Next**
    ![](./images/testpacl.png "")

5.  On the Summary page:
    * Review the details and click **Submit**
    ![](./images/save.png "")

## **STEP 2**: Create Source Environment

1.  Navigate to **Dashboard** > **Environments**. Click **Create Environment**.
    ![](./images/.png "")

2. Provide a unique environment name such as **SourceEnv** and enter a description. For Template Name select the template we created in the previous step: **PUMFT38**.
    ![](./images/.png "")

3.  Expand **Environment Attributes** > **Region and Availability Domains** > **Credentials**. Assign the following values to each field:
    * Weblogic Administrator Password: **Psft1234**
    * Gateway Administrator Password: **Psft1234**
    * Web Profile Password for user PTWEBSERVER: **Psft1234**
    * Database Administrator Password: **PSft1234##**
    * Database Connect Password: **Psft1234**
    * Database Access Password: **Psft1234**
    * Database Operator Password: **Psft1234**
    * Windows Administrator Password: **Psft12345678#**
    ![](./images/pscred.png "")
    
    Click **Done**.
    ![](./images/clonetop1.png "")

4.  Click **Accept** on the license.
    ![](./images/license.png "")

## **STEP 3**: Create PUM Connection

1.  Navigate to **Dashboard** > **Environments**. On **SourceEnv** click the down arrow button and then click **Details**
    ![](./images/.png "")

    Click **Manage PUM Connections** on the side menu then click **Add Target**.
    ![](./images/.png "")

    Select **WorkshopEnvironment** as your target environment and for client select the windows client. Click **Add**.
    ![](./images/.png "")

Once creating the PUM connection is completed, you will see the uploaded target database information on the PUM source. If you want to apply some packages to the target DB, use PIA URL to log into the PUM source and manually apply change package. 

2.  We are now going to log into our source environment. On the side menu click **Environment Details** and then click on the URL.
    ![](./images/.png "")

    Enter your User ID (**PS**) and Password (**Psft1234**) to sign in.
    ![](./images/.png "")

3.  Click the navigation icon to open the navigation menu.
    ![](./images/.png "")

    Navigate to **PeopleTools** > **Lifecycle Tools** > **Update Manager** > **Update Manager Dashboard**
    ![](./images/.png "")

    From here you will be able to see the uploaded target DB information.
    ![](./images/.png "")

    From **Define Change Package** on the side menu you will be able to apply packages to the target DB.

## Acknowledgements

**Created By/Date**   
* **Authors** - Rich Konopka, Peoplesoft Specialist, Megha Gajbhiye, Cloud Solutions Engineer
* **Contributor** -  Sara Lipowsky, Cloud Engineer
* **Last Updated By/Date** - Hayley Allmand, Cloud Engineer, April 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.