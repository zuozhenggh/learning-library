# Create the Oracle Cloud Infrastructure GoldenGate Deployment

## Introduction

This lab walks you through the steps to create an Oracle Cloud Infrastructure GoldenGate Deployment.

Estimated Lab Time: 2 minutes

### About Oracle Cloud Infrastructure GoldenGate Deployments
A Oracle Cloud Infrastructure GoldenGate deployment manages the resources it requires to function. The GoldenGate deployment also lets you access the GoldenGate deployment console, where you can access the OCI GoldenGate deployment console to create and manage Extracts and Replicats.

### Objectives

In this lab, you will:
* Locate Oracle Cloud Infrastructure GoldenGate in the Console
* Create a OCI GoldenGate deployment
* Review the OCI GoldenGate deployment details
* Access the OCI GoldenGate deployment console

## **STEP 1**: Log in to the Console

1. Log in to the **Oracle Cloud Infrastructure Console** with your username and password. See [Signing in to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm) in the *Oracle Cloud Infrastructure* documentation.

2. After you log in to the Console, open the navigation menu, and then under **Database Related Services**, select **GoldenGate**.

   ![Select GoldenGate Deployments in Navigation menu](images/01-01-02.png "Access GoldenGate service")

You're brought to the **Deployments** page.

   ![GoldenGate Deployments page](images/01-01-02a.png "Deployments page")

## **STEP 2:** Create an OCI GoldenGate Deployment

1. On the Deployments page, click **Create Deployment**.

   ![Click Create Deployment](images/01-02-01.png "Create a deployment")

2. In the Create Deployment panel, enter **GGSDeployment** for Name.

3. From the Compartment dropdown, select **UA_USER**.

4. For OCPU Count, enter **2**.

5. For Subnet, click **Change Compartment**, select **UACompartment**, and then select **Public Subnet - VCNWithInternet**.

6. For License type, select **Bring You Own License (BYOL)**.

7. Click **Show Advanced Options**, and then select **Create Public Endpoint**.

   ![Create GoldenGate Deployment](images/02_07_ggs-createdeployment.png "Create GoldenGate Deployment")

8. Click **Next**.

9. For GoldenGate Instance Name, enter **ogginstance**.

10. For Administrator Username, enter **oggadmin**.

11. For Administrator Password, enter **oggadmin-A1**.

12. Click **Create**.

You're brought to the Deployment Detail page. It takes a few minutes for the deployment to be created. Its status will change from CREATING to ACTIVE when it is ready for you to use.

## **STEP 3:** Review the Deployment details

On the Deployment Details page, you can:

* Review the deployment's status
* Launch the GoldenGate service deployment console
* Edit the deployment's name or description
* Stop and start the deployment
* Move the deployment to a different compartment
* Review the deployment resource information
* Add tags

    ![Deployment Details page](images/01-03-gg_deployment_details.png "GoldenGate Deployment details")

## **STEP 4:** Launch the GoldenGate Deployment Console

1. When the deployment is active, click **Launch Console**.

    ![Launch Console](images/04-01-ggs-launchconsole.png)

2. To log in to the GoldenGate deployment console, enter **oggadmin** for User Name and **oggadmin-A1** for Password, and then click **Sign In**.

    ![GoldenGate Deployment Console](images/04-02-ggs-deploymentconsole-signin.png)

After you log in successfully, you're brought to the GoldenGate deployment console home page. Here, you can access the GoldenGate Administration, Performance Metrics, Distribution, and Receiver Servers, as well as add Extracts and Replicats for your data replication tasks.

In this lab, you created an OCI Deployment and reviewed its Deployment details. You can now proceed to the next [lab](#next).

## Learn More

* [Managing Deployments](https://docs.oracle.com//cloud/paas/goldengate-service/using/deployments.html)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management
* **Last Updated By/Date** - February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
