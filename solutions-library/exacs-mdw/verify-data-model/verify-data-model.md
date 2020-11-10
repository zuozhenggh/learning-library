# Verify a Sensitive Data Model with Oracle Data Safe

## Introduction

Using Oracle Data Safe, verify a sensitive data model by using the verification option in the Library and by using the Data Discovery wizard.

### Objectives

In this lab, you learn how to do the following:
* Verify a sensitive data model by using the verification option in the Library
* Verify a sensitive data model by using the Data Discovery wizard
* Manually update a sensitive data model stored in the Library

## **Step 1:** Connect to ExaCS DB Using SQL Developer

Please visit [Lab 4: Configuring a development system for use with your EXACS database](?lab=lab-4-configure-development-system-for-use) for instructions to securely configure ExaCS to connect using Oracle SQL Developer, SQLXL and SQL*Plus.

## **Step 2:** In SQL Developer, add a column to the `EMPLOYEES` table in your database

1. In SQL Developer, run the following command to connect to PDB1 pluggable database:

    ```
    <copy>ALTER SESSION SET CONTAINER=YOUR_PDB_NAME</copy>
    ```

2. On the SQL Worksheet, run the following command to add an `AGE` column to the `EMPLOYEES` table.

    ```
    <copy>ALTER TABLE HCM1.EMPLOYEES ADD AGE NUMBER;</copy>
    ```

3. Click the **Refresh** button to view the newly added column.

4. Run the following command to gather schema statistics.

    ```
    <copy>EXEC DBMS_STATS.GATHER_SCHEMA_STATS('HCM1');</copy>
    ```

5. Keep this tab open because you return to it in a later step.

## **Step 3:** Sign into the Oracle Data Safe Console in Your Region

1. From the navigation menu, click **Data Safe**

    ![](./images/navigation.png " ")

2. You are taken to the **Registered Databases** Page.

3. Click on **Service Console**

    ![](./images/service-console.png " ")

4. You are taken to the Data Safe login page. Sign into Data Safe using your credentials.

    ![](./images/sign-in.png " ")

## **Step 4:** Verify Your Sensitive Data Model by Using the Verification Option

1. In the Oracle Data Safe Console, click the **Library** tab, and then click **Sensitive Data Models**.

2. Select the check box for your sensitive data model that you created in Discovery Lab 1 - Discover Sensitive Data with Oracle Data Safe (**<username> SDM1**).

3. Click **Verify Against Target**.

    ![](./images/sensitive-verify.png " ")

4. On the **Select Target for Data Model Verification** page, select your target database, and click **Continue**. The verification job is started.

    ![](./images/select-model-target.png " ")

5. When the job is finished, notice that the **Detail** column reads `Data model verification job finished successfully`.

6. Click **Continue**.

7. On the **Data Model Verification Result** page, notice that there are no differences to report. The verification job did not find the new sensitive column, AGE.

8. The verification feature checks whether the sensitive columns in the sensitive data model are present in the target database. If there are some present in the sensitive data model, but missing in the target database, it reports them. In addition, it reports new referential relationships for the columns already present in the sensitive data model. It does not, however, discover ALL the relationships.

    ![](./images/data-model-verification.png " ")

9. Click **Continue**.

## **Step 5:** Manually Add the AGE Column to Your Sensitive Data Model

1. On the Sensitive Data Model: **<username> SDM1** page, click **Add**. The **Add Sensitive Columns** dialog box is displayed.

    ![](./images/sdm1-data-model.png " ")

2. Expand the **HCM1** schema, and then the **EMPLOYEES** table.

3. Select the **AGE** column.

    ![](./images/add-sensitive.png " ")

4. At the top of the dialog box in the **Sensitive Type** field, enter **age**. `AGE` is automatically retrieved as a sensitive type and you can select it.

    ![](./images/add-sensitive-2.png " ")

5. Scroll to the bottom and click **Add to Result**.

6. Your sensitive data model is updated to include the `AGE` column.

7. To verify, enter age in the search box. `HCM1.EMPLOYEES.AGE` should be listed under **Biographic Information**.

    ![](./images/age-search.png " ")

8. Click **Save and Continue**.

9. Click **Exit**.

## **Step 6:** Drop the AGE Column in Your Database

1. Return to SQL Developer.

2. On the SQL Worksheet, run the following commands to drop the `HCM1.EMPLOYEES.AGE` column.

    ```
    <copy>ALTER TABLE HCM1.EMPLOYEES DROP COLUMN AGE;</copy>
    ```

3. Run the following command to gather schema statistics.

    ```
    <copy>EXEC DBMS_STATS.GATHER_SCHEMA_STATS('HCM1');</copy>
    ```

4. To verify that the `EMPLOYEES` table no longer has an `AGE` column, run the following script:

    ```
    <copy>SELECT AGE FROM HCM1.EMPLOYEES;</copy>
    ```

5. Notice that the `AGE` column is gone and you receive an "Invalid Identifier" message when you run the command.

6. If the AGE column is still there, click the **Refresh** button to refresh the table.

## **Step 7:** Verify Your Sensitive Data Model Using the Data Discovery Wizard

1. Return to Oracle Data Safe.

2. Click the **Home** tab, and then click **Data Discovery**.

    ![](./images/discovery-nav.png " ")

3. On the **Select Target for Sensitive Data Discovery** page, select your target database, and then click **Continue**.

    ![](./images/discovery-target.png " ")

4. The **Select Sensitive Data Model** page is displayed.

5. For **Sensitive Data Model**, select **Pick from Library**, and then click **Continue**. The **Select Sensitive Data Model** page is displayed.

    ![](./images/library-pick.png " ")

6. Select your sensitive data model, **<username> SDM1**.

7. Scroll down to the bottom of the page and select **Verify if SDM is compatible with the target**.

    ![](./images/verify-sdm1.png " ")

8. To start the verification job, click **Continue**.

9. If the job finishes successfully, click **Continue**.

10. The **Data Model Verification Result** page is displayed.

11. Expand **Missing sensitive columns**, and then `HCM1`. The Data Discovery wizard identifies the `AGE` column as missing from the database.

    ![](./images/missing.png " ")

### **Step 8:** Manually update your sensitive data model from the Library

1. You can manually update your sensitive data model while continuing to work in the Data Discovery wizard. In which case, you simply deselect your sensitive column and save your sensitive data model. This part, however, shows you another way to do it from the Library.

2. Click **Exit** to exit the Data Discovery wizard.

3. Click the **Library** tab, and then click **Sensitive Data Models**.

4. Click your sensitive data model to open it.

5. Search for **AGE**.

    ![](./images/age-search.png " ")

6. In the list of sensitive columns, deselect `HCM1.EMPLOYEES.AGE`.

7. Your sensitive data model is now updated and accurate.

8. Click **Save** then **Exit**.

You may proceed to the next lab.

## Acknowledgements

- **Author** - Tejus Subrahmanya, Phani Turlapati, Abdul Rafae, Sathis Muniyasamy, Sravya Ganugapati, Padma Natarajan, Aubrey Patsika, Jacob Harless
- **Last Updated By/Date** - Jess Rein - Cloud Engineer, November 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
