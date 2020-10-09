# Assess Database Configurations and Users

## Introduction
This lab shows you how to assess configurations and users in your Autonomous Database by using the User Assessment feature in Oracle Data Safe.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you'll:

- Sign in to the Oracle Data Safe Console
- Schedule and run a Security Assessment job against your database
- Analyze the security assessment results
- Run a User Assessment job against your database
- Analyze the user assessment results

### Prerequisites

To complete this lab, you need to have the following:

- An Oracle Cloud account
- Access to an Autonomous Database, sample data for Oracle Data Safe loaded into the database, and the Activity Auditing feature enabled on the database
- Access to an Oracle Data Safe service
- Privileges to use the Activity Auditing feature on your database
- Audit collection started on your target database in Oracle Data Safe. If not, see [Provision Audit and Alert Policies](../provision-audit-alert-policies/provision-audit-alert-policies.md).


### Assumptions

- You are signed in to the Oracle Cloud Infrastructure Console.
- Your data values will be different than those shown in the screenshots in this lab.


## **STEP 1**: (If needed) Sign in to the Oracle Data Safe Console

- From the navigation menu in the Oracle Cloud Infrastructure Console, select **Data Safe**. The **Overview** page for the Oracle Data Safe service is displayed.

- Click **Service Console**. The **Home** page in the Oracle Data Safe Console is displayed.


## **STEP 2**: Schedule and run a Security Assessment job against your database

You can use Security Assessment to evaluate the current security state of your target databases and receive recommendations on how to mitigate the identified risks.

- Click the **Security Assessment** tab.


- On the **Security Assessment** page, select the check box for your target database, and then click **Schedule Periodic Assessment**.

  ![Security Assessment page](images/schedule-security-assessment-job.png)

- In the **Schedule Assessment** dialog box, configure the schedule for every Sunday at 11:00PM:

    - From the **Schedule Type** drop-down list, select **Weekly**.
    - From the **Every** drop-down list, select **Sunday**.
    - In the **At** field, click the **Schedule** button and select **11:00 PM**, and click **OK**.
    - Click **Schedule**.

    ![Schedule every Sunday](images/schedule-every-sunday.png)

    - A confirmation messages states that the schedule period job is successful.

- Deselect the check box for the target database, and select it again.

- Click **Assess Now**.

- Wait approximately one minute for the assessment to finish. The counts for high risk, medium risk, and low risk findings are displayed. The job generates a **Comprehensive Assessment** report.


  ![Security Assessment risk numbers](images/security-assessment-risk-numbers.png)


## **STEP 3**: Analyze the security assessment results

  - To view the **Comprehensive Assessment** report, in the **Last Generated Report** column, click **View Report**. The **Comprehensive Assessment** report is displayed. At the top of the report, you can view the following:

    - Target database name, when the database was assessed, and the database version
    - Risk levels (**High Risk**, **Medium Risk**, **Low Risk**, **Advisory**, **Evaluate**, and **Pass**). These totals give you an idea of how secure your database is. The risk levels are color coded to make the risk levels easier to identify.
    - **Security Controls**, **User Security**, and **Security Configurations**. These totals show you the number of findings for each high-level category in the report.

     ![Totals in the Comprehensive Assessment report](images/totals-in-comprehensive-assessment-report.png)


  -  In the **Summary** category, you can view a table that compares the number of findings for each category and counts the number of findings per risk level. These values help you to identify areas that need attention.

    ![Summary table in the Comprehensive Assessment report](images/summary-table-comprehensive-assessment-report.png)

  - Expand **User Accounts** to view the list of findings for user accounts.

     - On the right, indicators show whether a finding is recommended by the Center for Internet Security (**CIS**), European Union's General Data Protection Regulation (**GDPR**), and/or Security Technical Implementation Guide (**STIG**). These indications make it easy for you to identify the recommended security controls.

     ![Summary table in the Comprehensive Assessment report](images/findings-user-accounts.png)


  - Collapse **User Accounts** and expand **Privileges and Roles**. View the list of findings.

  - Scroll down and expand other categories. Each category lists related findings about your database and how you can make changes to improve its security.

  - Scroll to the top of the report. Click each risk category to filter the findings by risk level. Each filter is a toggle. For example, if you click **Medium Risk**, only medium risk findings are displayed. If you click **Medium Risk** again, the filter on is removed.




## **STEP 4**: Run a User Assessment job against a target database

You can use User Assessment to identify user settings and risks on your target databases.

- Click the **Home** tab and then the **User Assessment** tab.

- On the **User Assessment** page, select the check box for your target database, and then click **Assess**. The assessment takes approximately 10 seconds.

  ![User Assessment page](images/user-assessment-page.png)

- Wait a moment for the assessment to finish.




## **STEP 5**: Analyze the user assessment results

- When the user assessment is completed, observe the following on the **User Assessment** page:
    - A green check mark is displayed in the **Last Generated Report** column
    - The number of **Critical Risk**, **High Risk**, **Medium Risk**, and **Low Risk** users

     ![User Assessment page after assessment](images/user-assessment-completed.png)


- In the **Last Generated Report** column, click **View Report**. The **Users** page is displayed.


- Review the 4 charts. You can click the small circles below the charts to navigate between them.

    - The **User Risk** chart shows you the percent of users who are **Critical Risk**, **High Risk**, **Medium Risk**, and **Low Risk**.

    ![User Risk chart](images/user-risk-chart.png)

    - The **User Roles** chart shows you the number of users with the **DBA**, **DV Admin**, and **Audit Admin** roles.

    ![User Risk chart](images/user-roles-chart.png)

    - The **Last Password Change** chart shows you the number of users who have changed their passwords in the last 30 days, the last 30-90 days, and 90 days ago or more.

    ![User Risk chart](images/last-password-change-chart.png)

    - The **Last Login** chart shows you the number of users that signed in to the database within the last 24 hours, within the last week, within the current month, within the current year, and a year ago or more.

    ![User Risk chart](images/last-login-chart.png)




  - Review the table below the charts. This table lets you quickly identify critical and high risk users, such as DBAs, DV Admins, and Audit Admins.

  ![User Assessment table](images/user-table.png)


- View audit records for the `admin` user. To do that, identify the row for the `ADMIN` user and scroll to the right. In the **Audit Records** column, click **View Activity**.

  ![Audit Records column with View Activity circled](images/view-activity-admin-user.png)


- Examine the **All Activity** report for the `ADMIN` user.
  - This report is automatically filtered to show you the audit records for the `ADMIN` user, for the past week, and for your target database.
  - At the top of the report, you can view totals for **Targets**, **DB Users**, **Client Hosts**, **Login Success**, **Login Failures**, **User Changes**, **Privilege Changes**, **DDLs**, and **DMLs**.
  - The **Event** column shows you the type of activities performed.

   ![All Activity report](images/all-activity-report-admin-user.png)


- At the bottom of the page, click the page numbers to view more audit records.


- At the top of the report, click **Back to User Assessment report**.


- Identify an expired user, and then click **View Activity** for that user to view the user's audit records. The following example shows `VOLDEMORT` as expired.

  ![User Assessment table with VOLDEMORT expired status](images/identify-expired-user.png)


- Observe that `VOLDEMORT` has no activity on the target database. Here is a case where you might consider removing this user from the target database.



Continue to the next lab.

## Learn More

* [User Assessment Overview](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/user-assessment-overview.html)
* [Security Assessment Overview](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/security-assessment-overview.html)


## Acknowledgements
* **Author** - Jody glover, UA Developer, Oracle Data Safe Team
* **Last Updated By/Date** - Jody Glover, Oracle Data Safe Team, October 9, 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
