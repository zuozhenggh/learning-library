# Assess Database Configurations and Users

## Introduction
This lab shows you how to assess configurations and users in your Autonomous Database by using the User Assessment feature in Oracle Data Safe.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you'll:

- Sign in to the Oracle Data Safe Console
- Schedule and run a Security Assessment job against your database
- Run a User Assessment job against your database
- Analyze the user assessment results
- Analyze the security assessment results

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

- Wait approximately one minute for the assessment to finish. When it's done, review the numbers for high risk, medium risk, and low risk issues.


  ![Security Assessment risk numbers](images/security-assessment-risk-numbers.png)





## **STEP 3**: Run a User Assessment job against a target database

You can use User Assessment to identify user settings and risks on your target databases.

- Click the **User Assessment** tab.

- On the **User Assessment** page, select the check box for your target database, and then click **Assess**. The assessment takes approximately 10 seconds.

  ![User Assessment page](images/177413502.png)




## **STEP 4**: Analyze the user assessment results

- When the user assessment is completed, notice the following on the **User Assessment** page:
    - A green check mark is displayed in the **Last Generated Report** column.
    - You can view the number of **Critical Risk**, **High Risk**, **Medium Risk**, and **Low Risk** users.

    ![User Assessment page after assessment](images/177413503.png)


- In the **Last Generated Report** column, click **View Report**.

  ![Last Generated Report column](images/177413505.png)


- On the **Users** page, review the 4 charts. You can click the small circles below the charts to navigate between them.

  - The **User Risk** chart shows you the percent of users who are **Critical Risk**, **High Risk**, **Medium Risk**, and **Low Risk**.

  ![User Risk chart](images/177413506.png)


  - The **User Roles** chart shows you the number of users with the **DBA**, **DV Admin**, and **Audit Admin** roles.

    ![User Risk chart](images/177413508.png)


  - The **Last Password Change** chart shows you the number of users who have changed their passwords in the last 30 days, the last 30-90 days, and 90 days ago or more.

  ![Last Password Change chart](images/177413509.png)


  - The **Last Login** chart shows you the number of users that signed in to the database within the last 24 hours, within the last week, within the current month, within the current year, and a year ago or more.

  ![Last Login chart](images/177413511.png)


  - Review the table below the charts. This table lets you quickly identify critical and high risk users, such as DBAs, DV Admins, and Audit Admins.

  ![User Assessment table](images/177413512.png)


- View audit records for the `admin` user. To do that, identify the row for the 'ADMIN' user and scroll to the right. In the **Audit Records** column, click **View Activity**.

  ![Audit Records column with View Activity circled](images/177413513.png)


- Examine the **All Activity** report for the `ADMIN` user.
  - This report is automatically filtered to show you the audit records for the `ADMIN` user, for the past week, and for your target database.
  - At the top of the report, you can view totals for **Targets**, **DB Users**, **Client Hosts**, **Login Success**, **Login Failures**, **User Changes**, **Privilege Changes**, **DDLs**, and **DMLs**.
  - The **Event** column shows you the type of activities performed.

  ![All Activity report](images/177413514.png)


- At the bottom of the page, click the page numbers to view more audit records.


- At the top of the report, click **Back to User Assessment report**.


- At the bottom of the **User Assessment** page, click **2** to view page 2.


- Identify an expired user, and then click **View Activity** for that user to view the user's audit records. The following example shows `VOLDEMORT` as expired.

  ![User Assessment table with VOLDEMORT expired status](images/177413520.png)


- Notice that `VOLDEMORT` has no activity on the target database. Here is a case where you might consider removing this user from the target database.

  ![All Activity report showing VOLDEMORT user with no data](images/177413522.png)




## **STEP 5**: Analyze the security assessment results

- Click the **Home** tab, and then click the **Security Assessment** tab.

- On the **Security Assessment** page, find out when you last assessed the security of your target database, and the number of **High Risk**, **Medium Risk**, and **Low Risk** users.

- To view the **Comprehensive Assessment** report, in the **Last Generated Report** column, click **View Report**.

- At the top of the **Comprehensive Assessment** report, you can view the target database name, when the database was assessed, and the database version.

  ![Top of the Comprehensive Assessment report](images/177413531.png)


- Also at the top of the report, you can view totals for the following:
  - Risk levels (**High Risk**, **Medium Risk**, **Low Risk**, **Advisory**, **Evaluate**, and **Pass**). These totals give you an idea of how secure your database is. The risk levels are color coded to make the risk levels easier to identify.
  - **Security Controls**, **User Security**, and **Security Configurations**. These totals show you the number of findings for each high-level category in the report.

   ![Totals in the Comprehensive Assessment report](images/177413533.png)


-  In the **Summary** category, you can view a table that compares the number of findings for each category and counts the number of findings per risk level. These values help you to identify areas that need attention.

  ![Summary table in the Comprehensive Assessment report](images/177413534.png)

- Expand **User Accounts** to view a list of all user accounts in the target database. You can view each user's status, profile, and tablespace; whether the user is Oracle defined; and the authentication type for the user.

  ![Summary table in the Comprehensive Assessment report](images/177413535.png)


- Expand **User Profiles** to view a list of profile names, parameters, and values.

  ![Summary table in the Comprehensive Assessment report](images/177413536.png)


- Scroll down and expand categories. Each category lists related findings about your database and how you can make changes to improve its security.

- On the right, indicators show whether a finding is recommended by the Center for Internet Security (**CIS**), European Union's General Data Protection Regulation (**GDPR**), and/or Security Technical Implementation Guide (**STIG**). These indications make it easy for you to identify the recommended security controls.

  ![Summary table in the Comprehensive Assessment report](images/177413537.png)


- Scroll to the top of the report. Click the various filter options and review the findings. Each filter is a toggle. For example, if you click **Medium Risk**, only medium risk findings are displayed. If you click **Medium Risk** again, the filter on is removed.

   ![Summary table in the Comprehensive Assessment report](images/177413538.png)


You may proceed to the next lab.

## Learn More

* [User Assessment Overview](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/user-assessment-overview.html)
* [Security Assessment Overview](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/security-assessment-overview.html)


## Acknowledgements
* **Author** - Jody glover, UA Developer, Oracle Data Safe Team
* **Last Updated By/Date** - Jody Glover, Oracle Data Safe Team, October 2, 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
