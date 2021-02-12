# Set up Oracle Data Safe on your EBS environments 

## Introduction

This lab walks you through the setup of Data Safe on a private database provisioned by the EBS Cloud Manager. You will be configuring network settings and creating a user on the database with the appropriate permissions to setup a connnection to Data Safe. Then the lab provides a short walkthrough of the features of Data Safe. 

This lab assumes you have completed the **Lift and Shift On-Premises EBS to OCI Workshop** found [here](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=672&clear=180&session=5980193088668). It also assumes you have created an EBS environment through advanced provisioning with a Virtual Machine Database System. 

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:
* Enable Data Safe on your tenancy
* Set up a private endpoint for Data Safe
* Create a Data Safe user on the target datbase with the correct permissions
* Add the database as a target to the Data Safe console 
* Monitor the target database on the Data Safe Console

### Prerequisites

* A tenancy admin user
* A paid Oracle Cloud Infrastructure tenancy (not available for Free Tier or Always Free tenancies)
* An advanved-provisioned EBS instance from Cloud Manager with a Virtual Machine Database System.  
* A text file with the following values: 
    - The private IP address of the database to be targeted on Data Safe
    - The public IP address of the EBS Cloud Manager
    - The OCID of the target database


## **STEP 1:** Enable Data Safe

This step is not necessary if Data Safe is already been used in you tenancy and region. If it is not, follow these steps:

1. Using your tenancy admin user account, login to Oracle Cloud Infrastructure.

2. Select the region in which you would like to enable Data Safe. 

3. From the navigation menu, select **Data Safe**. 

4. Click **Enable Data Safe**. 


## **STEP 2:** Create a Private Endpoint for the Database

This step is only necessary if your database is private. Since it is highly recommended to make your EBS databases private, this step should be followed. If for demo purposes the database had been left public, you may skip this step. 

1. From the naviagtion menu on OCI, go to **Data Safe** and then click on **Private Endpoints**. 

2. Click **Create Private Endpoint**.

  a. **Name:** ``EBSPrivateEndpoint``

  b. **Virtual Cloud Network**: ``ebshol_vcn`` (or whichever VCN that was created as part of the EBS to OCI lab)

    Note: Make sure you have the correct compartment selected for the VCN to display. 

  c. **Subnet:** ``ebshol_db_subnet`` (or whichever subnet that houses the database to which you're connecting to Data Safe)

  d. Click **Create Private Endpoint**

  e. Once the endpoint has finished creating, copy its private IP into a text file for later reference. 

## **STEP 3:** Create a User for Data Safe on the Target Database

In this step, we will create a database user and grant them privileges which will allow them to be used as the Data Safe user. Before we can create the user, we must download a file from the Data Safe console that will give the created user the roles necessary to act as a Data Safe user. 

1. Access the Data Safe console by going to **Data Safe** under the Navigation menu and then selecting the **Service Console** button.

2. Click on the **Targets** tab at the top. 

  a. Click **Register**.

  b. Click **Download Privilege Script** and save the file to your local computer.

    This will download the .sql file that we will run on the database later to give privileges to our user. 

3. Login to your Cloud Manager using ssh and its public IP address.

        <copy>
        ssh -i <private-ssh-key-filepath> opc@<Cloud-Manager-public-IP>
        </copy>

4. Login to your database from the Cloud Manager using the database's private IP address. 

        <copy>
        ssh <database-private-IP>
        </copy>

5. Copy over the ``datasafe_privileges.sql`` file we downloaded in part 2. 

  a. On your local machine, open the file in a text editor (or cat it in terminal) and copy its contents. 

  b. On the database, create a file ``datasafe_privileges.sql``. 

        <copy>
        vi datasafe_privileges.sql
        </copy>

  c. Press ``i`` to start inserting values into the file. 

  d. Now paste in the contents of the downloaded file into the file we just created on the database. 

  e. Save and exit by pressing ``ecs`` and then typing in ``:wq``. 

6. Now connect to SQLPlus as the sysdba user. 

        <copy>
        sqlplus / as sysdba
        </copy>

7. Connect to the pdb 

        <copy>
        alter session set container="<pdb-name>";
        </copy>

  Make sure the pdb's name is in quotation marks. If you are unsure of the pdb name, enter the following command into sqlplus. 

        <copy>
        show pdbs;
        </copy>

8. Before we are able to create a user, we must create a tablespace on the database that will act as the user's default tablespace. 

        <copy>
        CREATE TABLESPACE DATASAFE_TABLE
        DATAFILE ‘datasafe_table.dbf’
        SIZE 1m;
        </copy>

9. Now we can create the user that will act as our Data Safe user on this database. 

        <copy>
        CREATE USER DATASAFE_ADMIN IDENTIFIED BY <password>
        DEFAULT TABLESPACE DATASAFE_TABLE
        TEMPORARY TABLESPACE TEMP;
        </copy>

10. Grant permissions to this user. 

        <copy>
        GRANT CONNECT, RESOURCE TO DATASAFE_ADMIN;
        </copy>

11. Now run the following command to grant privileges to this user. 

        <copy>
        @datasafe_privileges.sql DATASAFE_ADMIN GRANT ALL
        </copy>

12. Lastly run this command and write down its output in a text file under "Database Service Name" for later reference. 

        <copy>
        SELECT sys_context(‘userenv’,’service_name’) FROM dual;
        </copy>


## **STEP 4:** Register the Target Database on the Data Safe Console

1. Login to the Data Safe Service Console from OCI. 

  a. Navigate from the menu to Data Safe and click on the **Service Console** button. 

2. Click the **Targets** tab at the top. 

3. Click **Register** and fill out the following details. 

  a. **Target Name:** ``AdvancedEBSTarget``

  b. **Target Type:** ``Oracle Cloud Database``

  c. **OCID:** the OCID of your target database

  d. **Compartment:** the compartment of your database

  e. **Database with Private IP:** ``Yes``

  f. **IP address:** private IP address of your database

  g. **Port number:** ``1521``

  h. **Database Service Number:** the value from the SQLPlus command we ran in part 12 of Step 3. 

  i. **Database User Name:** ``DATASAFE_ADMIN``

  j. **Database Password:** the DATASAFE_ADMIN password you specified in part 9 of Step 3. 

4. Click **Test Connection** to verify the connection information is correct. 

5. Once the connection has been verified, click **Register Target**. 

Congratulations! You have successfully registered a database with Data Safe. You can now go to the **Home** tab on Data Safe and begin running asssessments to gain additional insight into your EBS data. 


## **STEP 4:** Monitor your Target Database on the Data Safe Console


## Learn More

* [Oracle Data Safe Documentation](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/get-started-oracle-data-safe.html)
* [Learn how to set up Data Safe with a Compute Database](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/register-oracle-databases-oracle-cloud-infrastructure-compute-instances.html#GUID-304A2F0E-67B1-44E4-AD48-649F1FE59DAC)
* [Learn how to register an on-premise database with a Private Endpoint](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/register-premises-oracle-databases-using-oracle-data-safe-private-endpoint.html#GUID-61F946FF-5AFB-4BB3-9BAB-7BABC9B4A6C4)
* [Learn how to register an on-premise database with an On-Premises Connector](https://docs.oracle.com/en/cloud/paas/data-safe/udscs/register-onpremises-oracle-databases-using-oracle-data-safe-onpremises-connector.html#GUID-ED6C6F89-3123-4A4E-9EBE-30D2C920C1CA)

## Acknowledgements

* **Author:** William Masdon, Cloud Engineering
* **Contributors:** 
    - Quintin Hill, Cloud Engineering
* **Last Updated By/Date:** William Masdon, Cloud Engineering, Feb 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
