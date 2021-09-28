---
inject-note: true
---

# Assess Database Configurations and Users

## Introduction

Security Assessment helps you assess the security of your database configurations. It analyzes database configurations, user accounts, and security controls, and then reports the findings with recommendations for remediation activities that follow best practices to reduce or mitigate risk. User Assessment helps you assess the security of your database users and identify high risk users. By default, Oracle Data Safe automatically generates a Security Assessment and User Assessment report for your target database during target registration. Both Security Assessment and User Assessment also let you monitor security drift on your target databases. By setting a baseline, and comparing it to another assessment, you can generate a Comparison report.

In this lab, you explore Security Assessment and User Assessment. Because these features are similar, you perform some tasks in Security Assessment and others in User Assessment.

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:

- View the dashboard for Security Assessment
- View the latest security assessment for your target database
- Refresh the latest security assessment and analyze the results
- Schedule a security assessment for every Sunday at 11:00 PM for your target database
- View the history of security assessments
- Set a baseline and generate a Comparison report for Security Assessment
- View the dashboard for User Assessment
- Analyze users across all your target databases
- Review the `ADMIN` user's audit records
- View the user assessment history, rename an assessment, and download a report
- Compare the latest user assessment with another user assessment

### Prerequisites

Before starting, be sure that you have completed the following prerequisite tasks:

- You obtained an Oracle Cloud account and signed in to the Oracle Cloud Infrastructure Console.
- You prepared your environment for this workshop. If not, see [Prepare Your Environment](?lab=prepare-environment). It's important that your ATP database is registered with Oracle Data Safe, you have enabled the Activity Auditing, User Assessment, and Security Assessment features on your database, and you have the appropriate privileges in Oracle Data Safe to use the Activity Auditing, User Assessment, and Security Assessment features with your database.
- You registered your Autonomous Database with Oracle Data Safe and loaded sample data into it. If not, see [Register an Autonomous Database](?lab=register-autonomous-database).
- Audit data collection is started in Oracle Data Safe for your ATP database. If not, see [Provision Audit and Alert Policies](?lab=provision-audit-alert-policies).


### Assumptions

- Your data values are most likely different than those shown in the screenshots.


## Task 1: View the dashboard for Security Assessment

1. If you are in the Oracle Data Safe Console, click the **Home** tab, and then click the **Security Assessment** tab. You are navigated to Security Assessment in the Security Center in Oracle Cloud Infrastructure.

2. If you are in the Security Center, click **Security Assessment**.

3. Under **List Scope**, select your compartment.

    - You can include target databases in child compartments by selecting the **Include child compartments** check box. The dashboard shows statistics across all the target databases listed.

4. At the top of the page, review the **Risk Level** and **Risks by Category** charts.

    - Risk Level shows you a percentage breakdown of the different risk levels (High, Medium, Low, Advisory, and Evaluate) across all of your target databases.
    - Risks by Category shows you a percentage breakdown of the different risk categories (User Accounts, Privileges and Roles, Authorization Control, Data Encryption, Fine-Grained Access Control, Auditing, and Database Configurations) across all of your target databases.




5. View the **Risk Summary** tab.

    - The Risk Summary shows you how much risk you have across all of your target databases.
    - You can compare the number of high, medium, low, advisory, and evaluate risk findings across all of your target databases, and view which risk categories have the greatest numbers.
    - Risk categories include Target Databases, User Accounts, Privileges and Roles, Authorization Control, Fine-Grained Access Control, Data Encryption, Auditing, and Database Configuration.
    - Make note of the **Total Findings** for high, medium, and low risk levels.

6. Click the **Target Summary** and view the information.

    - The Target Summary shows you a view of the security posture of each of your target databases.
    - You can view the number of high, medium, low, advisory, and evaluate risks for each database.
    - You can find out if the latest assessment deviates from the baseline and the assessment date.
    - You can access the latest assessment report for each target database.



## Task 2: View the latest security assessment for your target database

1. On the **Target Summary** tab, locate the line that has your target database, and click **View Report**. The latest assessment for your target database is displayed.




2. Review the table on the **Assessment Summary** tab. This table compares the number of findings for each category in the report and counts the number of findings per risk level (**High Risk**, **Medium Risk**, **Low Risk**, **Advisory**, **Evaluate**, and **Pass**). These values help you to identify areas that need attention.


3. Click the **Assessment Information** tab to view details about the assessment. Details include assessment name, OCID, compartment in which the assessment was saved, target database name, target database version, assessment date, schedule (if applicable), baseline name (if set), and complies with baseline flag (Yes, No, or No Baseline Set).


4. Scroll down and view the **Assessment Details** section.

    - This section shows you all the findings for each risk category.
    - Risks are color-coded to help you easily identify categories that are high risk (colored red).


5. Under **Filters** on the left, notice that you can select the risk levels that you want displayed. Deselect **Advisory** and **Evaluate**, and then click **Apply**.


6. Under **User Accounts**, expand **User Details**. For each user in your target database, the table shows you their status, profile used, the user's default tablespace, whether the user is Oracle Defined (Yes or No), and how the user is authenticated (Auth Type).



7. Expand another category and review the findings.

    - Each finding shows you the status (risk level), a summary of the finding, details about the finding, remarks to help you to mitigate the risk, and references (whether a finding is recommended by the Center for Internet Security (**CIS**), European Union's General Data Protection Regulation (**GDPR**), and/or Security Technical Implementation Guide (**STIG**).) These references make it easy for you to identify the recommended security controls.


8. Under **Filters**, select all filters, and then click **Apply**.

9. Collapse **User Accounts**, expand a few categories under **Privileges and Roles**, and review the findings.

10. Scroll down further and expand other categories. Each category lists related findings about your target database and how you can make changes to improve its security.


## Task 3: Refresh the latest security assessment and analyze the results

1. On the **Security Assessment Details** page, click **Refresh Now**. The **Refresh now** page is displayed.

2. In the **Save Latest Assessment** box, enter **My Security Assessment**, and then click **Refresh Now**.

    - This action updates the latest security assessment for your target database and also saves a copy named My Security Assessment.



3. Click the **Assessment Information** tab. Notice that the **Assessed On** date is right now.



4. In the breadcrumb at the top of the page, click **Security Assessment** to return to the dashboard. Review the total findings for high, medium, and low risk levels. These values are different than when you viewed the numbers in Task 1.




5. In the **Risk Level** column, click **Medium** to view all the medium level risks.



6. On the **Overview** tab, review the **Risks by Category** chart. You can position your cursor over the percentage values to view the category name and count.

7. In the **Risk Details** section, expand one of the medium level risks.

    - The **Remarks** section explains the risk and how you can mitigate it.
    - The **Target Databases** section lists the target databases to which the risk applies.

8. Click your target database name to view the finding details for your target database.

    - The finding includes your target database name, risk level, a summary about the risk, details on your target database, remarks that explain the risk and help you to mitigate it, and references.


9. To view the latest assessment for your target database, click the **click here** link. You are returned to your latest assessment.





## Task 4: Schedule a security assessment for every Sunday at 11:00 PM for your target database


1. In the breadcrumb at the top of the page, click **Security Assessment**.

2. Under **Related Resources** on the left, select **Schedules**.



3. Click **Add Schedule**. The **Add Schedule To Save Assessments** page is displayed.

4. From the **Target Database** drop-down list, select your target database.

5. In the **Schedule Name** box, enter **Sunday_Assessment**.

6. From the **Compartment To Save The Assessment** drop-down list, select your compartment.

7. From the **Schedule Type** drop-down list, select **Weekly**.

8. From the **Every** drop-down list, select **Sunday**.

9. Click the **Time** box, scroll down, and select **11:00 PM**.

10. Click **Add Schedule**. When the schedule is created, the status is changed to SUCCEEDED.








## Task 5: View the history of security assessments

You can access all the assessments viewing the history.

1. Click **View History**. All the assessments for your target database are listed, including the copy you made earlier (My Security Assessment).

    - If you don't see your assessments, make sure that your compartment is selected.
    - To view assessments saved to a different compartment, select the compartment from the **Compartment** drop-down list.
    - To include in the list assessments saved to child compartments of the selected compartment, select the **Include child compartments** check box.

2. Review the number of findings for each risk level for your target database. Notice how the values changed over time.




## Task 6: Set a baseline and generate a Comparison report for Security Assessment

1. Click the name of your original assessment. The assessment is displayed.

2. Click **Set As Baseline**.



    A **Set As Baseline?** dialog box is displayed confirming that you want to set the assessment as the baseline.


3. Click **Yes** and wait for the baseline to be set. Stay on the page until the message **Baseline has been set** is displayed.



4. Click **Close**.


5. Under **Resources**, click **Compare with Baseline**.


6. When the comparison operation is completed, review the Comparison report.

    - Review the number of findings per risk category for each risk level. Categories include **User Accounts**, **Privileges and Roles**, **Authorization Control**, **Data Encryption**, **Fine-Grained Access Control**, **Auditing**, and **Database Configuration**.
    - You can view the number of new risks added, the number of risks remediated (removed), and the number of risks that have changed to a different risk level (modified).
    - The change value is the total count of new, remediated, and modified risks on the target database for each category/risk level.
    - The green color is used to indicate a positive change whereas the red color indicates the change needs your attention.
    - In the details table, you can view the risk level for each finding, the category to which the finding belongs, the finding name, and a description of what has changed on your target database. The Comparison Report column is important because it provides explanations of what is changed, added, or removed from the target database since the baseline report was generated. The column also tells you if the change is a new risk or a remediated risk.




## Task 7: View the dashboard for User Assessment

1. Navigate to User Assessment. To do this, in the breadcrumb at the top of the page, click **Data Safe**. Click **Security Center**, and then **User Assessment**.

2. Under **List Scope**, select your compartment, if needed.

3. At the top of the dashboard, review the four charts.

    - The **User Risk** chart shows you the number and percentage of users who are **Critical Risk**, **High Risk**, **Medium Risk**, and **Low Risk**.
    - The **User Roles** chart shows you the number of users with the **DBA**, **DV Admin**, and **Audit Admin** roles.
    - The **Last Password Change** chart shows you the number and percentage of users who changed their passwords within the last 30 days, within the last 30-90 days, and 90 days ago or more.
    - The **Last Login** chart shows you the number and percentage of users that signed in to the database within the last 24 hours, within the last week, within the current month, within the current year, and a year ago or more.


4. Review the **Risk Summary** tab.

    - The Risk Summary focuses on risk levels, where the risks were found, the number of users at each risk level and the roles held by the total number of users at each risk level.



5. Review the **Target Summary** tab. You can view the following information:

    - Number of critical and high risk users, DBAs, DV Admins, and Audit Admins
    - Date and time of the last assessment
    - Whether the latest assessment deviates from the baseline (if set)


## Task 8: Analyze users across all your target databases

1. Click the **Risk Summary** tab.

2. In the **Risk Level** column, click **Critical**. The **Risk Details** page is displayed.


3. Review the three charts. The **User Roles**, **Last Password Change**, and **Last Login** charts focus on critical risk users.


4. Scroll down and review the **Critical Risk Details** section. The table provides the following information to help you understand all the critical risk users:

    - Target database to which the user belongs
    - User type (for example, PRIVILEGED)
    - Whether the user is a DBA, DV Admin, or Audit Admin
    - User's status (for exmaple, OPEN)
    - Date and time when the user last logged in to the target database
    - Audit records for the user


5. In the **User Name** column, click one of the users. The **User Details** page is displayed and provides the following information about the user:

    - User name
    - Target database name
    - Date and time when the user was created
    - Risk level - Hover over the question mark to view what constitutes a critical risk user.
    - User type
    - User profile
    - Privileged roles (which Admin roles are granted to the user)
    - Last login date and time
    - Roles - Expand **All Roles** to view all the roles granted to the user.
    - Privileges - Expand **All Privileges** to view all the privileges granted to the user.


6. Click **Close**.

7. Notice at the top of the table that you can set filters. From the first drop-down list, select **Password Changed**. From the second drop-down list, select **Before**. Click the date box and select a date from one year ago. Click **Apply**. Are there any users?


8. To remove the filter, click the **X** next to the filter.


## Task 9: Review the `ADMIN` user's audit records

1. Identify the row in the table for the `ADMIN` user. In the **Audit Records** column for the `ADMIN` user, click **View Activity**. A new browser tab is opened and the **All Activity** report is displayed in the Oracle Data Safe Console.



2. Examine the **All Activity** report for the `ADMIN` user.

    - The report is automatically filtered to show you audit records for the past week, for the `ADMIN` user, and for your target database.
    - At the top of the report, you can view totals for **Targets**, **DB Users**, **Client Hosts**, **Login Success**, **Login Failures**, **User Changes**, **Privilege Changes**, **User Changes**, **DDLs**, **DMLs**, and **Total Events**.
    - The **Event** column in the table shows you the types of activities performed, for example, `LOGON`, `AUDIT`, `CREATE AUDIT POLICY`, and so on.
    - At the bottom of the page, click the page numbers to view more audit records.

3. Close the browser tab. You are returned to the Security Center.



## Task 10: View the user assessment history, rename an assessment, and download a report

1. Return to the browser tab where you last left off. In the breadcrumb at the top of the page, click **User Assessment**.

2. Under **Related Resources**, click **Assessment History**.

    - All user assessments for all target databases are listed here.
    - You can compare the number of critical risks, high risks, DBAs, DV Admins, and Audit Admins across all target databases.
    - You can also quickly identify target databases that are set as baselines.



3. To sort the list by target database, click the **Target Database** column heading.

4. Click one of the assessments for your target database. The **Saved Assessment Details** page is displayed.

5. On the **Assessment Information** tab, click the **Pencil** icon next to the assessment name. Change the name to **User Assessment ad01**, and then click the **Save** icon.

6. Click **Generate Report**. The **Generate Report** dialog box is displayed.

7. Leave **PDF** selected as the report format, and click **Generate Report**.

8. When the report generation is completed, click **Close**.

9. Click **Download Report**. The **Download Report** dialog box is displayed.

10. Leave the **PDF** report format selected, and click **Download Report**. The **Opening user-assessment-report.pdf** dialog box is displayed.

11. Select **Save File**, and then click **OK**. The **Enter name of file to save to** dialog box is displayed.

12. Browse to the desktop, leave **user-assessment-report.pdf** set as the name, and then click **Save**.

13. On your desktop, open the report and scroll through it. When you are done, close the file.


## Task 11: Compare the latest user assessment with another user assessment

You can select a user assessment to compare with the latest user assessment. With this option, you don't need to set a baseline.

1. In the breadcrumb at the top of the page, click **User Assessment**.

2. Click the **Target Summary** tab, and then click **View Report** for your target database. The latest user assessment is displayed.

3. On the left under **Resources**, click **Compare Assessments**.

4. Scroll down to the **Comparison with Other Assessments** section.

5. If your compartment isn't shown, click **Change Compartment** and select your compartment.

6. From the **Select Assessment** drop-down list, select an earlier assessment of your target database. As soon as you select the assessment, the comparison will begin.

7. Review the comparison results. In some cases, the assessments may be identical.





## Learn More

* [User Assessment Overview](https://docs.oracle.com/en-us/iaas/data-safe/doc/user-assessment-overview.html)
* [Security Assessment Overview](https://docs.oracle.com/en-us/iaas/data-safe/doc/security-assessment-overview.html)


## Acknowledgements
* **Author** - Jody Glover, Principal User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, September 27 2021
