# Get started with Free Tier Setup

## Introduction
This lab walks you through the steps to set up your free tier environment that includes provisioning an Oracle Autonomous Database, and signing into Oracle Machine Learning user interface.

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will learn how to:

* Provision an Oracle Autonomous Database
* Sign into Oracle Machine Learning user interface
* Create the CUSTOMERS360 table.

	>**Note:** You will use this table in the lab on AutoML UI and OML Services.

### Prerequisites
* Sign up for a free tier Oracle Cloud account.

> **Note:** You may see differences in account details (eg: Compartment Name is different in different places) as you work through the labs. This is because the workshop was developed using different accounts over time.


## Task 1: Provision an Oracle Autonomous Database

To provision an Oracle Autonomous Database:

1. From the **Navigation Menu** in the upper left corner, select **Oracle Database**, and then select **Autonomous Data Warehouse**.

	![Autonomous Data Warehouse option under Oracle Database](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png "Autonomous Data Warehouse option under Oracle Database")

2. From the Oracle Cloud Infrastructure Console, on the Oracle Autonomous Database page choose your region and select a compartment.

3. Click **Create Autonomous Database**.

    ![Create Autonomous Database option](images/create-autonomous-db.png)

4. Provide basic information for the Oracle Autonomous Database.

    Enter a user-friendly display name for the ADB instance to easily identify the resource. The display name does not have to be unique.

    ![Create Autonomous Database dialog](images/create-autonomous-db-1.png)

5. For Workload Type, click **Data Warehouse**.

6. For Deployment, select **Shared Infrastructure**.

7. For Database configuration, select the following:

    - **Choose database version:** Select the database version. The available database version is **19c**.
    - **OCPU Count:** Enter ``1`` . This is number of CPU cores for your database.
    - **Storage (TB):** Specify the storage you wish to make available to your database, in terabytes. Click the arrow to select ``1``.
    - **Auto Scaling:** By default auto scaling is enabled to allow the system to automatically use up to three times more CPU and IO resources to meet workload demand.

    ![Configure Database dialog](images/create-adw-config.png)

8. For Administrator credentials, enter and re-confirm a password.

9. For network access, select **Allow secure access from everywhere.**

    ![Network Access settings](images/create-adw-network.png)

10. For License, select **License Included**.

    ![License settings](images/create-adw-license.png)

11. Click **Create Autonomous Database**. The Oracle Autonomous Data Warehouse instance starts provisioning. Click **Autonomous Data Warehouse** again from the navigation to see a list of Oracle Autonomous Database instances in your console.

12. Click the Autonomous Data Warehouse instance you just created.

    ![List of Oracle Autonomous Database instances](images/adb_instance.png)

## Task 2: Create an Oracle Machine Learning user

An administrator creates a new user account and user credentials for Oracle Machine Learning in the User Management interface.

>**Note:** You must have the administrator role to access the Oracle Machine Learning User Management interface.

To create a user account:

1. Sign in to your OCI account, click the hamgurger on the left to open the left navigation pane, and click **Autonomous Data Warehouse**.

	![Oracle Autonomous Data Warehouse](images/adw.png)


2. Click on an Autonomous Database instance.   

	![Oracle Autonomous Data Warehouse](images/adb_instance.png)


3. On the Autonomous Database Details page, click **Service Console**.

	![Oracle Autonomous Data Warehouse](images/service-console.png)


4. On the Service Console click **Administration**.

	![Oracle Autonomous Data Warehouse](images/administration.png)


5. Click **Manage Oracle ML Users** to open the Oracle Machine Learning User Administration page.

	![Oracle Autonomous Data Warehouse](images/manage_oml_users.png)

6. Click **Create** on the Oracle Machine Learning User Administration page.

	![Oracle Autonomous Data Warehouse](images/oml_um_page.png)

7. On the Create User page, enter the following details to create the user:

	![Oracle Autonomous Data Warehouse](images/create_user.png)

	* **Username:** Enter a username for the account. Using the username, the user will log in to an Oracle Machine Learning instance.
	* **First Name:** Enter the first name of the user.
	* **Last Name:**  Enter the first name of the user.
	* **Email Address:** Enter the email ID of the user.
	* Select the option **Generate password and email account details to user. User will be required to reset the password on first sign in** to auto generate a temporary password and send an email with the account credentials to the user. If you select this option, you need not enter values in the Password and Confirm Password fields; the fields are grayed out.
	* **Password:** Enter a password for the user, if you choose to create a password for the user.
	>**Note:** This option is disabled if you select the **Generate password...** option to auto generate a temporary password for the user.

	* **Confirm Password:** Enter a password to confirm the value that you entered in the Password field. By doing so, you create the password for the user. The user can change the password when first logging in.

8. Click **Create**.


## Task 3: Sign into Oracle Machine Learning Notebooks

A notebook is a web-based interface for data analysis, data discovery, data visualization, and collaboration. You create and run notebooks in Oracle Machine Learning Notebooks. You can access Oracle Machine Learning Notebooks from Autonomous Database.

1. From the tab on your browser with your ADW instance, click **Service Console**, then select **Development** on the left.

	![Development option in ADW Service Console](images/adw_development.png)


2. Click **Oracle Machine Learning Notebooks.**

	  ![Oracle Machine Learning Notebooks in ADW](images/adw_oml_notebooks.png)

3. Enter your user credentials and click **Sign in**.


	![Oracle Machine Learning Notebooks Sign in page](images/oml_signin_page.png)

4. Click **Notebooks** in the Quick Actions section.

	![Notebooks option in OML homepage](images/homepage_notebooks.png)


## Task 4: Create the CUSTOMERS360 table

In this step, you will create a notebook and run a SQL query to create the table ``CUSTOMERS60``.

>**Note:** You will be using the table CUSTOMERS360 in the lab titled "Using Oracle Machine Learning Services".

To create the table:

1. On the Oracle Machine Learning user interface home page, click **Notebooks**. The Notebooks page opens.

2. On the Notebooks page, click **Create**.

3. In the Create Notebook dialog, enter Customers_360 in the name field. and click **OK**.

4. Type ``%sql`` to connect to the SQL interpreter and press enter.

5. Enter the following script and click the run icon:

    ```
    <copy>
		CREATE TABLE CUSTOMERS360 AS
              (SELECT a.CUST_ID, a.CUST_GENDER, a.CUST_MARITAL_STATUS,
                 a.CUST_YEAR_OF_BIRTH, a.CUST_INCOME_LEVEL, a.CUST_CREDIT_LIMIT,
                 b.EDUCATION, b.AFFINITY_CARD,
                 b.HOUSEHOLD_SIZE, b.OCCUPATION, b.YRS_RESIDENCE, b.Y_BOX_GAMES
           FROM SH.CUSTOMERS a, SH.SUPPLEMENTARY_DEMOGRAPHICS b
           WHERE a.CUST_ID = b.CUST_ID);
		</copy>
    ```

	![SQL script to create Customers360 table](images/sql_script.png)

6. In the next paragraph, run the following script to view the data:

	```
		<copy>
		select * from CUSTOMERS360
			where rownum < 10;
		 </copy>
	 ```


	![Script to view Customers360 table](images/script_view_customers360.png)


## Learn More

* [Get Started with Oracle Machine Learning for Python](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/get-started-with-oml4py.html#GUID-B45A76E6-CE48-4E49-B803-D25CA44B09ED)
* [Oracle Machine Learning Notebooks](https://docs.oracle.com/en/database/oracle/machine-learning/oml-notebooks/)

## Acknowledgements
* **Author** - Moitreyee Hazarika, Principal User Assistance Developer, Oracle Database
* **Contributors** -  Mark Hornick, Senior Director, Data Science and Machine Learning; Marcos Arancibia Coddou, Product Manager, Oracle Data Science; Sherry LaMonica, Principal Member of Tech Staff, Advanced Analytics, Machine Learning
* **Last Updated By/Date** - Moitreyee Hazarika, September 2021
