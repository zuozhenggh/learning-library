# Create a Database Registration

## Introduction

This lab walks you through the steps to create a database registration.

Estimated Lab Time: 2 minutes

### About Database Registrations
Database Registrations capture source and target credential information. A database registration also enables networking between the OCI GoldenGate service tenancy virtual cloud network (VCN) and your tenancy VCN using a private endpoint.

### Objectives
In this lab, you will register source and target databases for Oracle GoldenGate deployments to use for the duration of this lab.

## **STEP 1**: Register the Source Database

First, follow the steps below to register the source Oracle Database.

1. Click **Registered Databases**.

    ![Click Registered Databases](images/01-01-ggs-registerdb.png "Click Registered Databases")

2. Click **Register Database**.

    ![Click Register Database](images/01-02-ggs-registerdb.png "Click Register Database")

3. In the Register Database panel, for Name and Alias, enter **SourceCDB**.

4. From the Compartment dropdown, select **UA_USER**.

5. Click **Select Database**.

6. From the Database Type dropdown, select **Database (Bare Metal, VM, Exadata)**.

7. For Database System in <Compartment_Name>, click **Change Compartment**, select **UACompartment**, and then select **UA_DBSYSTEM** from the dropdown. Some fields are autopopulated based on your selection.

8. For Database Username, enter **C##GGADMIN_UAUSER**.

9. For Database Password, enter **#OracleWelcome1**.

10. Select **Network Connectivity via Private Endpoint**.

11. For Subnet, click **Change Compartment**, select **UACompartment**, and then select **Public Subnet-VCNWithInternet**.

11. Click **Register**.

    ![Source Database details](images/01_01_12_regSourceDB.png)

## **STEP 2:** Register the Target Database

Now, follow the steps below to register the target Autonomous Database.

1. On the Registered Databases page, click **Register Database**.

2. In the Register Database panel, enter **TargetADB** for Name and Alias.

3. From the **Compartment** dropdown, select **UACompartment**.

4. Click **Select Database**.

5. For **Database Type**, click **Change Compartment**, select **UACompartment**, and then select **ADWTarget** from the dropdown.

6. Enter the fully-qualified database name for **Database FQDN**.

7. Enter the **Database Username** and corresponding **Database Password**.

8. Select **Publicly Available** option selected.

10. Click **Register**.

    ![Target Database details](images/02_10-ggs-regDB_target.png)

The source and target databases appear in the list of Registered Databases. You may now [proceed to the next lab](#next).

## Learn More

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management
* **Last Updated By/Date** - February 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
