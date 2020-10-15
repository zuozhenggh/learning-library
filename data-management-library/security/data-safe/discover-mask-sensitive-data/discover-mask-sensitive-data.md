# Discover and Mask Sensitive Data

## Introduction
This lab shows you how to discover and mask sensitive data in Oracle Data Safe by using the Data Discovery and Data Masking features.

Estimated Lab Time: 30 minutes

### About Oracle Data Safe
Oracle Data Safe is a fully-integrated, regional Cloud service focused on the security of your data. It provides a complete and integrated set of features for protecting sensitive and regulated data in Oracle Cloud databases.

### Objectives

In this lab, you'll:

- View sensitive data in your Autonomous Transaction Processing (ATP) database
- Discover sensitive data by using Data Discovery
- Mask sensitive data by using Data Masking
- Validate the masked data in your ATP database


### Prerequisites

To complete this lab, you need to have the following:

- Login credentials for the Oracle Data Safe Console
- An Oracle Data Safe service enabled in a region of your tenancy
- A registered target database in Oracle Data Safe with sample audit data and the password for the `ADMIN` user account


## **STEP 1**: View sensitive data in your ATP database

In this step, you use SQL Developer Web to query sensitive data in your ATP database. You can access SQL Developer Web from the ATP Console.

- In a new browser window, enter the url to your region in the Oracle Cloud Infrastructure Console.

    - To access the Ashburn region, enter the following url: [https://console.us-ashburn-1.oraclecloud.com/a/tenancy](https://console.us-ashburn-1.oraclecloud.com/a/tenancy).
    - To access the Frankfurt region, enter the following url:[https://console.eu-frankfurt-1.oraclecloud.com/a/tenancy](https://console.eu-frankfurt-1.oraclecloud.com/a/tenancy).

- If prompted, in the **Cloud Tenant** field on the **SIGN IN** page, enter your tenancy name, and then click **Continue**. Under **Oracle Cloud Infrastructure**, enter your user credentials for Oracle Cloud Infrastructure, and then click **Sign In**.

  Note: If you are signed in to Oracle Cloud Infrastructure on another tab, then you are not prompted to enter a tenancy name and can continue to the next step.


- Make sure the correct region is selected in your tenancy, for example, **US East (Ashburn)** or **Germany Central (Frankfurt)**.

  ![Select region in Oracle Cloud Infrastructure](images/177413377.png)


- From the navigation menu, select **Autonomous Transaction Processing**.

  ![Select Autonomous Transaction Processing](images/177413380.png)


- Under **COMPARTMENT**, make sure that your compartment is selected. For example, the `dsu01` user should be able to access the `dsc01` compartment.

  ![Select compartment](images/177413383.png)


- In the list of databases, click the name of your database, for example, **atp01**.

  ![List of registered databases in Oracle Cloud Infrastructure](images/177413385.png)


- Click **Service Console** to navigate to the **Autonomous Transaction Processing Console**.

  ![Service Console button](images/177413387.png)

  A new browser tab is opened called **Autonomous Transaction Processing | Overview**.

- If the browser prevents you from opening a pop-up window, click **Options**, and then select **Allow pop-ups for console.*region*.oraclecloud.com**.

- If you are prompted to log in to your ATP instance, enter the `ADMIN` user credentials.

- On the **Overview** page, click **Development**.

 ![Overview page for Autonomous Transaction Processing](images/177413390.png)


- Click **SQL Developer Web**.

 ![SQL Developer Web option circled](images/177413391.png)


- On the **SIGN IN** page for SQL Developer Web, enter the database credentials for the `ADMIN` user, and then click **Sign In**.

  - You are provided the password during the lab.

  ![SIGN IN page for SQL Developer](images/177413392.png)

- If a help note is displayed, you can click the **X** to close it.

  ![Help note for SQL Web Developer](images/177413393.png)

- On the **Navigator** tab, select the `HCM1` schema from the first drop-down menu. In the second drop-down menu, leave **Tables** selected.

  ![Navigator tab in SQL Web Developer](images/177413395.png)

- Drag the `EMPLOYEES` table to the worksheet.

  ![EMPLOYEES table](images/177413397.png)

- When prompted to choose an insertion type, click **Select**, and then click **Apply**.

   ![Choose the type of insertion dialog box](images/177413398.png)

- View the SQL query on the worksheet.

   ![Worksheet tab showing EMPLOYEES table](images/177413399.png)

- On the toolbar, click the **Run Statement** button (green circle with a white arrow) to execute the query.

 ![Run Statement button on toolbar](images/177413401.png)

- Review the query results.

  - Data such as `employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_date`, `job_id`, `salary`, and `manager_id` are considered sensitive data and should be masked if shared for non-production use, such as development and analytics.

  - Keep this tab open so that you can return to it later in step 4 when you view the masked data.

  ![Query results](images/177413404.png)





## **STEP 2**: Discover sensitive data by using Data Discovery

The Data Discovery wizard generates a sensitive data model that contains sensitive columns in your target database. When working in the wizard, you select sensitive types that you want to discover in your target database.

- Open a new tab in your browser, and enter one of the following URLs to the Oracle Data Safe service page in Oracle Cloud Infrastructure.

  - The url for the Ashburn region is [https://console.us-ashburn-1.oraclecloud.com/data-safe/instances](https://console.us-ashburn-1.oraclecloud.com/data-safe/instances).

  - The url for the Frankfurt region is [https://console.eu-frankfurt-1.oraclecloud.com/data-safe/instances](https://console.eu-frankfurt-1.oraclecloud.com/data-safe/instances).

- Click the **Service Console** button to access the Oracle Data Safe Console.

    ![Query results](images/click-service-console-from-overview-page.png)

  The **Home** tab is displayed.


- Access the Data Discovery wizard by clicking the **Data Discovery** tab.

    ![Side tabs with Data Discovery circled](images/177413405.png)


- On the **Select Target for Sensitive Data Discovery** page, select your target database, and then click **Continue**.

 ![Select Target for Sensitive Data Discovery page](images/177413415.png)


- On the **Select Sensitive Data Model** page, leave **Create** selected, enter **SDM1** for the name, enable **Show and save sample data**, select your resource group, and then click **Continue**.

 ![Select Sensitive Data Model page](images/177413416.png)


- On the **Select Schemas for Sensitive Data Discovery** page, scroll down and select the **HCM1** schema, and then click **Continue**.

  ![Select Schemas for Sensitive Data Discovery page](images/177413420.png)


- On the **Select Sensitive Types for Sensitive Data Discovery** page, expand all of the categories by moving the slider to the right, and then scroll down the page and review the sensitive types.

  - Notice that you can select individual sensitive types, sensitive categories, and all sensitive types.

  ![Select Sensitive Types for Sensitive Data Discovery page](images/177413423.png)


- At the top of the page, select the **Select All** check box, and then click **Continue** to start the data discovery job.

  ![Select All check box selected](images/177413425.png)


- When the job is completed, ensure that the **Detail** column states `Data discovery job finished successfully`, and then click **Continue**.

  ![Detail column](images/177413427.png)


- On the **Sensitive Data Discovery Result** page, examine the sensitive data model created by the Data Discovery wizard. To view all of the sensitive columns, move the **Expand All** slider to the right.
    - Oracle Data Safe automatically saves your sensitive data model to the Oracle Data Safe Library.

      ![Sensitive Data Discovery Result page](images/177413428.png)

- From the drop-down list, select **Schema View** to sort the sensitive columns by table.

    ![Schema View circled](images/177413429.png)

- Scroll down the page to view the sensitive columns.

  - You can view sample data (if it's available for a sensitive column), column counts, and estimated data counts.

  - In particular, take a look at the sensitive columns that Data Discovery found in the `EMPLOYEES` table. Columns that do not have a check mark are called referential relationships. They are included because they have a relationship to another sensitive column and that relationship is defined in the database's data dictionary.
  - Also view the sample data provided to get an idea of what the sensitive data looks like. Your sample data may be different.

  ![Sensitive columns list](images/177413430.png)


- Scroll to the bottom of the page, and then click **Report**.

 ![Report button](images/data-discovery-report-button.png)


- View the **Data Discovery** report.

    - The chart compares sensitive categories. You can view totals of sensitive values, sensitive types, sensitive tables, and sensitive columns.
    - The table displays individual sensitive column names, sample data for the sensitive columns, column counts based on sensitive categories, and estimated data counts.

      ![Sensitive columns table](images/177413431.png)


- Click the chart's **Expand** button.

    ![Chart's Expand button circled](images/177413432.png)


- Position your mouse over **Identification Info** to view statistics.

  ![Statistics](images/177413435.png)


- With your mouse still over **Identification Info**, click the **Expand** button to drill down.

  ![Expand button over Identification Info](images/177413438.png)


- Notice that the **Identification Info** category is divided into two smaller categories (**Personal IDs** and **Public IDs**). To drill-up, position your mouse over an expanded sensitive category, and then click the **Collapse** button.

  ![Collapse button over Identification Info](images/177413439.png)


- Click the **Close** button (**X**) to close the expanded chart. Continue to work in the wizard.

  ![Close button](images/177413441.png)



## **STEP 3**: Mask sensitive data by using Data Masking

The Data Masking wizard generates a masking policy for your target database based on a sensitive data model. In the wizard, you select the sensitive columns that you want to mask and the masking formats to use.

- Click **Continue to mask the data**. The Data Masking wizard is displayed.

   ![Continue to mask the data button is circled](images/177413442.png)


- On the **Select Target for Data Masking** page, your target database is selected. Click **Continue**.

   ![Select Target for Data Masking page](images/177413443.png)


- On the **Masking Policy** page, move the **Expand All** slider to the right to view all of the sensitive columns. Scroll down the page to view the default masking format selected for each sensitive column.

 ![Masking Policy page](images/177413444.png)


- For the `HCM1.LOCATIONS.STREET_ADDRESS` column, click the arrow to the right of the masking format to view other masking formats.

 ![HCM1.LOCATIONS.STREET_ADDRESS circled and masking formats drop-down list](images/177413445.png)


- Next to the arrow, click the **Edit Format** button (pencil icon).

 ![Edit Format button](images/177413446.png)


- In the **Edit Format** dialog box, view the details for the masking format, including column name, datatype, description, examples, and default configuration.

  - This is where you can modify a masking format. Click **Cancel**.

   ![Edit Format dialog box](images/177413447.png)


- At the bottom of the page, click **Confirm Policy**, and then wait a moment while Data Masking creates the masking policy.

 ![Bottom of Confirm Policy page](images/177413448.png)


- On the **Schedule the Masking Job** page, leave **Right Now** selected, and then click **Review**.

  ![Schedule the Masking Job page](images/177413449.png)


- On the **Review and Submit** page, review the information, and then click **Submit** to start the data masking job.

  ![Review and Submit page](images/177413450.png)


- Wait for the data masking job to finish. It takes a couple of minutes. You can follow the status of the job on the **Masking Jobs** page. When the job is finished, click **Report**.

  ![Masking Jobs page page](images/177413451.png)


- Examine the **Data Masking** report.

  - At the top of the report, you can view the number of values, sensitive types, tables, and columns that were masked.

  - The table shows you column counts for the sensitive categories and types. For each sensitive column, you can view the masking format used and the number of rows masked.

    ![Data Masking report](images/177413453.png)


- Click **Generate Report**.

    ![Generate Report button circled](images/177413454.png)


- In the **Generate Report** dialog box, leave **PDF** selected, enter **Mask1_HCM1** for the description, ensure your resource group is selected, and then click **Generate Report**.

    ![Generate Report dialog box with PDF selections](images/177413455.png)


- Wait for the report to generate. When it's generated, click **Download Report**.

    ![Download Report button circled](images/177413457.png)


- Save the report and then open it in Adobe Acrobat. Review the data, and then close it.

  ![Data Masking report in PDF format](images/177413459.png)



## **STEP 4**: Validate the masked data in your ATP database

- Return to the browser tab for **SQL Developer Web**. You should still have your query results from STEP 1 in this lab. Take a moment to review the data.

    ![Query results](images/177413404.png)


- On the toolbar, click the **Run Statement** button (green circle with a white arrow) to execute the query.

 ![Run Statement button on toolbar](images/177413401.png)


- If a dialog box is displayed stating that your session has expired, click **OK**, sign in again, and then click the **Run Statement** button.

  ![Session Expired dialog box](images/177413464.png)


- Review the masked data.

  - You can resize the panel to view more data, and you can scroll down and to the right.

    ![Masked EMPLOYEE data](images/177413466.png)


## Learn More

* [Data Discovery](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/data-discovery.html)
* [Data Masking](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/data-masking.html)

## Acknowledgements
* **Author** - Jody glover, UA Developer, Oracle Data Safe Team
* **Last Updated By/Date** - Jody Glover, Oracle Data Safe Team, August 2020


## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
