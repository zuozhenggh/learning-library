# Assess Users with Oracle Data Safe

## Introduction
Using Oracle Data Safe, assess user security in your target database by using the User Assessment feature and fix issues.  Suppose that recent data breaches in your industry occurred due to stolen credentials of high-privileged users. You are notified by “Audit and Compliance” to quickly report high risk users on your target database and show their recent activity. You want to know who the users are and what entitlements they have.

### Objectives

In this lab, you learn how to:
* Assess user security in your target database by using the User Assessment feature in Oracle Data Safe.
* Fix some issues pertaining to user security.

## **Step 1:** Sign into the Oracle Data Safe Console for Your Region

1. From the navigation menu, click **Data Safe**

    ![](./images/navigation.png " ")

2. You are taken to the **Registered Databases** Page.

3. Click on **Service Console**

    ![](./images/service-console.png " ")

4. You are taken to the Data Safe login page. Sign into Data Safe using your credentials.

    ![](./images/sign-in.png " ")

## **Step 2:** In SQL Developer Connect to SYS User

Please visit [Lab 4: Configuring a development system for use with your EXACS database](?lab=lab-4-configure-development-system-for-use) for instructions to securely configure ExaCS to connect using Oracle SQL Developer, SQLXL and SQL*Plus.

## **Step 3:** Run User Assessment on Your Target Database

1. In the Oracle Data Safe Console, click the **Home** tab, and then click **User Assessment**. The User Assessment page is displayed.

    ![](./images/user-assessment-nav.png " ")

2. Select the check box for your target database, and click **Assess**.

    ![](./images/target.png " ")

3. Wait for the report to generate.

4. When the report is generated, view the totals in the **Critical Risk**, **High Risk**, **Medium Risk**, and **Low Risk** columns.

5. In the Last Generated Report column, click **View Report**. The User Assessment report is displayed.

    ![](./images/target2.png " ")

## **Step 4:** Analyze the Information in the User Assessment Report

1. View the **User Risk** chart. This chart compares the number of critical, high, medium, and low risk users.

2. View the **User Roles** chart. This chart compares the number of users with the DBA, DV Admin, and Audit Admin roles.

    ![](./images/user-risk.png " ")

3. Click the second small circle below the charts to view the third and fourth charts.

4. View the **Last Password Change** chart. This chart shows you the number of users who have changed their passwords in the last 30 days, the last 30-90 days, and 90 days ago or more.

5. View the **Last Login** chart. This chart shows you the number of users that logged in in the last 24 hours, in the last week, within the current month, within the current year, and a year ago or more.

    ![](./images/last-password.png " ")

## **Step 5:** Search the Results for Critical and High Risk Users

1. Click the **+** sign to view the list of columns that you can display in the table. Add and remove columns as you wish, and then close the list.

    ![](./images/add-sign.png " ")

2. In the **Audit Records** column, click **View Activity** for the following users to view the audit records that they generated. Filters are automatically applied to **Operation Time** and **User Name**. Click Back to **User Assessment report** to return to the **User Assessment** report.

    ![](./images/view-activity.png " ")

3. `SECURE_STEVE`: Notice that `SECURE_STEVE` has not generated any audit records. This use may be a rogue user.

    ![](./images/secure-steve.png " ")

4. `DBA_DEBRA`: Notice that `DBA_DEBRA` has several login failures. Some other user may be trying to log in with this account.

5. `DBA_DEBRA`: Notice that `DBA_DEBRA` has the Audit Admin role, but has not generated any audit records.

6. View more detail about `DBA_DEBRA` by performing the following five steps.

7. In the table, click `DBA_DEBRA`. The **User Details** dialog box is displayed.

8. On the right, expand the roles to view the privileges.

9. On the left, click the question mark next to **Risk**. Here you can review the factors that designate a user as Critical, High, Medium, or Low risk.

10. Click outside the dialog box to close it.

11. Close the User Details dialog box.

## **Step 6:** Make Changes to the User Accounts

1. In SQL Developer, run the following code to drop `SECURE_STEVE`:

    ```
    <copy>drop user SECURE_STEVE cascade;</copy>
    ```

2. Run the following code to revoke the `AUDIT_ADMIN` role from `DBA_DEBRA`:

    ```
    <copy>revoke audit_admin from DBA_DEBRA</copy>
    ```

## **Step 7:** Rerun User Assessment on Your Target Database

1. Return to Oracle Data Safe.

2. Click the **Home** tab, and then click **User Assessment**.

3. Select the check box for your target database, and then click **Assess**.

4. Click **View Report**.

5. Look for changes in the **User Assessment** report. Notice that `DBA_DEBRA` no longer has the `AUDIT_ADMIN` role.

You may proceed to the next lab.

## Acknowledgements

- **Author** - Tejus Subrahmanya, Phani Turlapati, Abdul Rafae, Sathis Muniyasamy, Sravya Ganugapati, Padma Natarajan, Aubrey Patsika, Jacob Harless
- **Last Updated By/Date** - Jess Rein - Cloud Engineer, November 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
