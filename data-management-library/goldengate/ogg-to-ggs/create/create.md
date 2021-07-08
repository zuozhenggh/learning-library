# Create the Oracle Cloud Infrastructure GoldenGate Deployment

## Introduction

This lab walks you through the steps to create an Oracle Cloud Infrastructure GoldenGate Deployment.

Estimated Lab Time: 5 minutes

### About Oracle Cloud Infrastructure GoldenGate Deployments
A Oracle Cloud Infrastructure GoldenGate deployment manages the resources it requires to function. The GoldenGate deployment also lets you access the GoldenGate deployment console, where you can access the OCI GoldenGate deployment console to create and manage Extracts and Replicats.

### Objectives

In this lab, you will:
* Locate Oracle Cloud Infrastructure GoldenGate in the Console
* Create a OCI GoldenGate deployment
* Review the OCI GoldenGate deployment details
* Access the OCI GoldenGate deployment console

### Prerequisites

This lab assumes that you completed all preceding labs.

## **STEP 1**: Create a Deployment

*Note that the compartment names in the screenshots may differ from values that appear in your environment.*

1.  Open the **Navigation Menu**, navigate to **Oracle Database**, and select **GoldenGate**.

    ![Select GoldenGate from Oracle Database](images/database-goldengate.png " ")

    You're brought to the **Deployments** page.

    ![GoldenGate Deployments page](images/01-01-02a.png "Deployments page")

2.  If you're prompted to select a compartment, select the compartment associated to your LiveLab workshop. For example, if your LiveLab username is LL1234-user, select the compartment **LL1234-COMPARTMENT**.

3.  On the Deployments page, click **Create Deployment**.

    ![Click Create Deployment](images/01-02-01.png "Create a deployment")

4.  In the Create Deployment panel, enter **GGSDeployment** for Name.

5.  From the Compartment dropdown, select a compartment.

6.  For OCPU Count, enter **2**.

7.  For Subnet, select **Public Subnet**.

8.  For License type, select **Bring You Own License (BYOL)**.

9.  Click **Show Advanced Options**, and then select **Create Public Endpoint**.

    ![Click Create Deployment](images/01-02-create_deployment_panel.png "Create a deployment")

10. Click **Next**.

11. For GoldenGate Instance Name, enter **ogginstance**.

12. For Administrator Username, enter **oggadmin**.

13. For Administrator Password, enter a password. Take note of this password.

14. Click **Create**.

You're brought to the Deployment Details page. It takes a few minutes for the deployment to be created. Its status will change from CREATING to ACTIVE when it is ready for you to use.


## **STEP 2:** Review the Deployment details

On the Deployment Details page, you can:

* Review the deployment's status
* Launch the GoldenGate service deployment console
* Edit the deployment's name or description
* Stop and start the deployment
* Move the deployment to a different compartment
* Review the deployment resource information
* Add tags

    ![Deployment Details page](images/01-03-gg_deployment_details.png "GoldenGate Deployment details")

## **STEP 3:** Launch the GoldenGate Deployment Console

1. When the deployment is active, click **Launch Console**.

    ![Launch Console](images/04-01-ggs-launchconsole.png)

2. To log in to the GoldenGate deployment console, enter **oggadmin** for User Name and the password you provided above, and then click **Sign In**.

    ![GoldenGate Deployment Console](images/04-02-ggs-deploymentconsole-signin.png)

After you log in successfully, you're brought to the GoldenGate deployment console home page. Here, you can access the GoldenGate Administration, Performance Metrics, Distribution, and Receiver Servers, as well as add Extracts and Replicats for your data replication tasks.

In this lab, you created an OCI Deployment and reviewed its Deployment details. You can now proceed to the next [lab](#next).

## **STEP 4:** Register the Target Database

Now, follow the steps below to register the target Autonomous Data Warehouse \(ADW\) instance.

1.  On the Registered Databases page, click **Register Database**.

2.  In the Register Database panel, enter **TargetADW** for Name and Alias.

3.  From the **Compartment** dropdown, select a compartment.

4.  Click **Select Database**.

5.  For **Autonomous Database in** *compartment*, click **Change Compartment**, select the compartment you created your ADW instance, and then select **ADWTarget** from the dropdown. Some fields are autopopulated based on your selection.

6.  Enter the database's password in the Password field, and then click **Register**.

    ![Target Database details](images/02_10-ggs-regDB_target.png)

    The source and target databases appear in the list of Registered Databases. The database becomes Active after a few minutes.

## **STEP 4:** Enable the ggadmin user

Although the ggadmin user is created during the database registration process, it is disabled by default. The following steps guide you through how to enable the ggadmin user.

1.  Click the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **Autonomous Data Warehouse**.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

2.  From the list of databases, select **ADWTarget**.

3.  On the ADWTarget Database Details page, click **Tools**, and then click **Open Database Actions**.

4.  Sign in to Database Actions using the ADMIN user details from Lab 1: Set Up the Environment. If you're running this lab as a workshop, copy the ADMIN password provided with your lab environment details.

5.  Under **Administration**, click **Database Users**.

6.  From the list of users, locate **GGADMIN**, and then click the ellipsis (three dots) icon and select **Edit**.

    ![GGADMIN user](images/02-06-locked.png)

7.  In the Edit User panel, deselect **Account is Locked**, enter the password you gave the ggadmin user in the database registration steps above, and then click **Apply Changes**.

    ![Edit user](images/02-07-edit.png)

    Note that the user icon changes from a blue padlock to a green checkmark.

8.  Log out of Database Actions.

## Learn More

* [Managing Deployments](https://docs.oracle.com/en/cloud/paas/goldengate-service/using/deployments.html)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management
* **Last Updated By/Date** - Jenny Chan, June 2021
