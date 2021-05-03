# Cloning an Environment

## Introduction
This lab walks you through the steps to clone an environment.

Estimated Lab Time: 30 minutes

### Objectives
In this lab you will:
* Clone an existing environment

### Prerequisites
- Access to the Cloud Manager console.
- Environment up and running

## **STEP 1**: Creating a Clone of an Environment

1.  Navigate to **Dashboard** > **Environments**. On the environment that we just created (**WorkshopEnvironment**) click the down arrow and then click **Clone Environment**.
    ![](./images/cloneworkshop.png "")

2.  Give the new environment a name such as **WorkshopClone**. Click **Clone**.
    ![](./images/workclone.png "")

    When asked if you want too proceed with Clone Operation click **Yes**.
    ![](./images/proceed.png "")

3.  Refresh the page. You should now see the **WorkshopClone** Environment. This environment will take a few minutes to provision. Click the down arrow and then click **Details**
    ![](./images/initiating.png "")

    Note on the **Environment Details** page, under **Status** you will see a red exclamation point. This will remain until the entire environment has successfully provisioned. Once provisioned, the status will change to a green checkmark.
    ![](./images/red.png "")
    
    On the side menu click **Logs**. From here you can monitor the status of your clone environment.
    ![](./images/clonestat.png "")

    You can also go to **Provision Task Status** on the side menu to see detailed progress status for every step.
    ![](./images/provisionclone.png "")

    Once the environment has a green dot with a status of **Running** you have successfully created a clone of your environment.
    ![](./images/running.png "")

## Acknowledgements

**Created By/Date**   
* **Authors** - Hayley Allmand, Cloud Engineer
* **Last Updated By/Date** - Hayley Allmand, Cloud Engineer, April 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.