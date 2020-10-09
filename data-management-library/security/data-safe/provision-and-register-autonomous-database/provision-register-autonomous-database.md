
# Provision and Register an Autonomous Database

## Introduction
This lab shows you how to create an Autonomous Database in Oracle Cloud Infrastructure, register it with Oracle Data Safe, and load sample data into it. You also view the list of registered target databases from the Oracle Data Safe Console and from the Oracle Data Safe service page in the Oracle Cloud Infrastructure Console.

Estimated Lab Time: 30 minutes

### Objectives
In this lab, you'll:

- Provision an Autonomous Data Warehouse on Shared Exadata Infrastructure instance
- Register your database with Oracle Data Safe
- Run a SQL script using SQL Developer Web to load sample data into your database
- Sign in to the Oracle Data Safe Console and view the list of registered target databases
- View the list of registered target databases from the Oracle Data Safe service page in the Oracle Cloud Infrastructure Console


### Prerequisites
To complete this lab, you need to have the following:

- An Oracle Cloud account
- Access to a compartment in the LiveLabs tenancy or your own tenancy where you can create an Autonomous Database


### Assumptions

- You are signed in to the Oracle Cloud Infrastructure Console.





## **STEP 1**: Provision an Autonomous Data Warehouse database

- From the navigation menu (hamburger menu in the upper-left corner), select **Autonomous Data Warehouse**.

- Make sure your workload type is **Data Warehouse** or **All** to see your Autonomous Data Warehouse instances.


- From the **Compartment** drop-down list, select your compartment.
  - If you're working in the LiveLabs tenancy, expand the **c4u03** and **Livelabs** compartments. You will see your compartment listed. The name is based on your username, for example, if your username is `LL630`, then your compartment name is `LL630-COMPARTMENT`.


- Click **Create Autonomous Database**.


- On the **Create Autonomous Database** page, provide basic information for your database:

  - **Compartment** - Select your compartment.

  - **Display name** - Enter a memorable name for the database for display purposes, for example, **ad01** (short for Autonomous Database 1).

  - **Database Name** - Enter **ad01**. It's important to use letters and numbers only, starting with a letter. The maximum length is 14 characters. Underscores are not supported.

  - **Workload Type** - Leave **Data Warehouse** selected.
    - Note: You cannot use a **Transaction Processing** or **JSON** workload type for this lab.

  - **Deployment Type** - Leave **Shared Infrastructure** selected.

  - **Always Free** - Leave is option deselected (the slider should be to the left).

  - **Database version** - Leave **19c** selected.

  - **OCPU Count** - Select **2**.

  - **Storage** - Leave **1** selected.

  - **Auto scaling** - Leave this checkbox selected.

    - **Password and Confirm Password** - Specify a password for the `ADMIN` database user and make note of this password. The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character. It cannot contain your username or the double quote (") character, must be different from the last 4 passwords used, and must not be the same password that is set less than 24 hours ago.

  - **Network Access** - Leave **Allow secure access from everywhere** selected.

  - **License Type** - Select **License Included**.



- Click **Create Autonomous Database**. The **Autonomous Database Details** page is displayed.

- Wait a few minutes for your instance to provision. When it is ready, AVAILABLE is displayed below the large ADW icon.


## **STEP 2**: Register the Autonomous Database with Oracle Data Safe

  - If you closed the **Autonomous Database Details** page: From the navigation menu, select **Autonomous Data Warehouse**. From the **COMPARTMENT** drop-down list, select your compartment. Click the name of your database. The **Autonomous Database Information** tab on the **Autonomous Database Details** page is displayed.


- Under **Data Safe**, click **Register**.
  - If you do not see the **Register** option for the **Data Safe** section, it is because you are working in a region that does not have the Oracle Data Safe service enabled in it. Please contact the LiveLabs organization to gain access to an appropriate region.

  A **Confirm** dialog box asks if you are sure you want to register the database with Oracle Data Safe.

- Click **Confirm**.

- Wait for the registration process to finished.

  When registration is completed, the status reads **Registered**. By default, you are authorized to manage the User Assessment, Security Assessment, and Activity Auditing features in Oracle Data Safe on your database.



## **STEP 3**: Run a SQL script using SQL Developer Web to load sample data into your database
The `load-data-safe-sample-data_admin.sql` script creates several tables with sample data that you can use with the Oracle Data Safe features. It also enables the Data Discovery and Data Masking features on your database.

- On the **Autonomous Database Details** page, click the **Tools** tab.

- Click **Open SQL Developer Web**. The **Oracle Database Actions | Sign in** page is opened.

- Enter the database credentials for the `ADMIN` user, and then click **Sign In**.
  - Recall that you specified the password for the `ADMIN` user when you created the database.

- If a help note is displayed, click the **X** to close it.


- Open the [load-data-safe-sample-data_admin.sql](files/load-data-safe-sample-data_admin.sql) script in a text editor like NotePad.

- Copy the entire script to the clipboard and then paste it into a worksheet in SQL Developer Web.

- Click the **Script Output** tab so that you can view the script activities.

- On the toolbar, click the **Run Script** button (page icon with the green arrow). The script takes a couple of minutes to run. In the bottom-left corner, the cog wheel turns as the script is being processed. Don't worry if you see some error messages. These are expected the first time you run the script.

- When the script is finished, on the **Navigator** tab on the left, select the **HCM1** schema from the first drop-down menu. In the second drop-down menu, leave **Tables** selected.

  - If you don't see **HCM1** listed, sign out and sign in again, and then select the **HCM1** schema from the first drop-down menu.

- Clear the worksheet, and then for each table below, drag the table to the worksheet and process the query. Choose **Select** as your insertion type when prompted. Make sure that you have the same number of rows in each table as stated below.
  - `COUNTRIES` - 25 rows
  - `DEPARTMENTS` - 27 rows
  - `EMPLOYEES` - 107 rows
  - `EMPT_EXTENDED` - 107 rows
  - `JOBS` - 19 rows
  - `JOB_HISTORY` - 10 rows
  - `LOCATIONS` - 23 rows
  - `REGIONS` - 4 rows
  - `SUPPLEMENTAL_DATA` - 149 rows





## **STEP 4**: Sign in to the Oracle Data Safe Console and view the list of registered target databases


- Under **Data Safe**, click **Service Console**.

  You are automatically signed in to the Oracle Data Safe Console and are presented with a dashboard on the **Home** tab.

- Review the charts in the dashboard.

    - The dashboard lets you monitor several activities at once.

    - When you first sign in to the Oracle Data Safe Console, the charts in your dashboard may not contain data because you have not yet used any of the features.

     ![Oracle Data Safe Dashboard](images/dashboard.png)


- Click each of the top tabs and review the pages. These tabs provide quick access to the dashboard (**Home** tab), registered target databases (**Targets** tab), the Oracle Data Safe Library (**Library** tab), reports for all Oracle Data Safe features (**Reports** tab), all of the alerts (**Alerts** tab), and all of the current and scheduled jobs (**Jobs** tab).

     ![Top tabs in the Oracle Data Safe Console](images/top-tabs-data-safe-console.png)


  - Click each of the side tabs and review the pages. These tabs provide quick access to Oracle Data Safe's main features, including **Security Assessment**, **User Assessment**, **Data Discovery**, **Data Masking**, and **Activity Auditing**.

     ![Side tabs in the Oracle Data Safe Console](images/side-tabs-data-safe-console.png)



- Click the **Targets** tab. Notice that your database is listed as a target database.

    ![Targets tab circled in the Oracle Data Safe Console](images/click-targets-tab.png)




- Click the name of your target database to view its details.

      ![Targets tab with target database circled](images/targets-tab-click-target-database-name.png)


- In the **Target Details** dialog box, review the read-only connection information for your database. Note the following:
    - You cannot edit the registration details for an Autonomous Database.
    - You can view the compartment to which the database belongs. The compartment for an Autonomous Database is the same compartment in Oracle Cloud Infrastructure in which the database resides.
    - Oracle Data Safe connects to the database via a TLS connection.

     ![Targets Details dialog box](images/target-details-dialog-box.png)


- Click **Cancel** to close the **Target Details** dialog box.





## **STEP 5**: View the list of registered target databases from the Oracle Data Safe service page in the Oracle Cloud Infrastructure Console

The Registered Databases page in the Oracle Cloud Infrastructure Console also lists the registered target databases with your Oracle Data Safe service.

- In the upper-right corner, click **Sign Out** to sign out of the Oracle Data Safe Console.

- From the navigation menu, select **Data Safe**. The **Overview** page for the Oracle Data Safe service is displayed. From here you can access the Oracle Data Safe Console and find links to useful information.

- On the left, click **Registered Databases**.

- From the **COMPARTMENTS** drop-down list, select your compartment. Your Autonomous Database is listed.

- Click the three dots next to your Autonomous Database. Notice that you can access the Oracle Data Safe Console from here too.


You can continue to the next lab.


## Learn More

  - [Provision Autonomous Data Warehouse](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/autonomous-provision.html#GUID-0B230036-0A05-4CA3-AF9D-97A255AE0C08)
  - [Loading Data with Autonomous Data Warehouse](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/load-data.html#GUID-1351807C-E3F7-4C6D-AF83-2AEEADE2F83E)
  - [Target Database Registration](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/target-database-registration.html)


## Acknowledgements
  * **Author** - Jody glover, UA Developer, Oracle Data Safe Team
  * **Last Updated By/Date** - Jody Glover, Oracle Data Safe Team, October 1, 2020


## See an issue?
  Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
