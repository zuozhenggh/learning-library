# Assess Database Configurations with Oracle Data Safe

## Introduction
Using Oracle Data Safe you can assess the security of a database by using the Security Assessment feature and fix issues.

Suppose that you are notified by the “Audit and Compliance” department that due to the General Data Protection Regulation (GDPR) compliance efforts, you need to quickly report on the current security posture of your database. Your current understanding is unknown. You currently have auditing enabled and are aware of the following database users:

* `PU_PETE` (Power User)
* `APP_USER`
* `DBA_DEBRA` (Company DBA)
* `DBA_HARVEY` (Company Junior DBA)
* `EVIL_RICH`
* `SECURE_STEVE`

### Objectives

In this lab, you learn how to do the following:
* Assess the security of a database by using the Security Assessment feature in Oracle Data Safe
* Fix some of the security issues based on the assessment findings

## **Step 1:** Connect to your ExaCS DB with SQL Developer

Please visit [Lab 4: Configuring a development system for use with your EXACS database](?lab=lab-4-configure-development-system-for-use) for instructions to securely configure ExaCS to connect using Oracle SQL Developer, SQLXL and SQL*Plus.

## **Step 2:** Generate a Comprehensive Assessment Report

1. Return to the Oracle Data Safe Console.

2. Click the **Home** tab and then **Security Assessment**.

    ![](./images/security-assessment.png " ")

3. On the **Security Assessment** page, select the check box for your target database, and click **Assess**.

    ![](./images/target.png " ")

4. Wait a moment for the report to generate.

5. When the report is generated, review the high risk, medium risk, and low risk values.

6. In the **Last Generated Report** column, click **View Report**.

    ![](./images/target2.png " ")

7. The **Comprehensive Assessment** report is displayed on the **Reports** tab.

8. In the upper right corner, view the target name, when the database was assessed, and the database version.

    ![](./images/comprehensive-assessment.png " ")

9. View the values for the different risk levels. These values give you an idea of how secure your database is.

    ![](./images/high-risk.png " ")

10. View the values for security controls, user security, and security configurations. These totals show you the number of findings for each high-level category.

11. Browse the report by scrolling down and expanding and collapsing categories.
Each category lists related findings about your database and how you can make changes to improve its security.

12. View the **Summary** table.
This table compares the number of findings for each category and counts the number of findings per risk level. It helps you to identify the areas that need attention on your database.

    ![](./images/summary.png " ")

## **Step 3:** Review the Medium Risk, Low Risk, and Advisory findings

1. At the top of the report, click **Medium Risk** to filter the report to show only the medium risk findings.

2. Deselect all other risk levels.

3. Scroll through the report to view the medium risk findings.

4. At the top of the report, click **Low Risk** to filter the report to show only the low risk findings.

5. Deselect all other risk levels.

6. Review the low risk findings.

7. At the top of the report, click **Advisory** to filter the report to show only the advisory findings.

8. Deselect all other risk levels.

9. Review the advisory findings.

## **Step 4:** Review the Evaluate Findings

1. At the top of the report, click **Evaluate** to filter the report to show only the Evaluate findings.

    ![](./images/evaluate.png " ")

2. Deselect all other risk levels.

3. Scroll through the report to view the findings.

4. Focus on **System Privilege Grants** under Privileges and Roles:

  a. System privileges `(ALTER USER, CREATE USER, DROP USER)` can be used to create and modify other user accounts, including the ability to change passwords. This ability can be abused to gain access to another user's account, which may have greater privileges. The Privilege Analysis feature may be helpful to determine whether or not a user or role has used account management privileges.

  b. Security Assessment found 59 grants of system privilege grants on your target database.

  ![](./images/system-grants.png " ")

  c. Fix: In SQL Developer, run the following query on your database to find out who has the `PDB_DBA` role. Sort the results by `GRANTED_ROLE` to make it easy to identify the users with the role. Then, revoke the `PDB_DBA` role from the `EVIL_RICH` user account.

    ```
    <copy>select * from dba_role_privs;</copy>
    ```

    ![](./images/dba-roles-privs.png " ")

    ```
    <copy>revoke pdb_dba from EVIL_RICH;</copy>
    ```

5. Focus on **Audit Records**:

  a. Auditing is an essential component for securing any system. The audit trail lets you monitor the activities of highly privileged users. Even though auditing cannot prevent attacks that exploit gaps in other security policies, it does act as a critical last line of defense by detecting malicious activity. Enable unified auditing policies on the database and ensure that audit records exist. This is a STIG, GDPR, and CIS recommended policy.

  ![](./images/audit.png " ")

  b. Review the Details section in this finding and answer these questions: How many audit trails exist in your database and how many of those trails contain audit records? The report states that Security Assessment examined two audit trails and found records in one audit trail. There's only one audit trail because Autonomous Transaction Processing databases are in pure unified audit mode.

  c. Fix: You do not need to do anything on your database because your database already has unified auditing policies enabled.

6. Focus on **Unified Audit**:

    ![](./images/unified-audit.png " ")

7. Unified Auditing is the recommended audit method and is available in Oracle Database 12.1 and later releases. Not using Unified Auditing or disabling unified auditing policies is a risk. Verify that unified audit policies are enabled on the database. Audit all sensitive operations, including privileged user activities. Also audit access to application data that bypasses the application.

8. How many unified audit policies are on your target database and how many of them are enabled?

## **Step 5:** Review the Pass findings

1. At the top of the report, click **Advisory** to filter the report to show only the Advisory findings.

    ![](./images/advisory.png " ")

2. Deselect all other risk levels.

3. Scroll through the report to review the findings. For example, the following findings have a **Pass status**.

    ![](./images/pass-status.png " ")

4. User Accounts in `SYSTEM` or `SYSAUX`. Tablespace Case-Sensitive Passwords

    ![](./images/system-sysaux.png " ")

5. Users with Default Passwords

    ![](./images/users-default-password.png " ")

    a. Password Verifiers
    b. User Parameters
    c. Users with Unlimited Password Lifetime
    d. System Privileges Granted to `PUBLIC`

    ![](./images/system-privileges-public.png " ")

6. Roles Granted to Public

    ![](./images/public-roles.png " ")

7. Column Privileges Granted to `PUBLIC DBA` Role

    ![](./images/column-privileges.png " ")

## **Step 6:** Rerun Security Assessment and Compare Results

1. In the Oracle Data Safe Console, click the **Home** tab, and then click **Security Assessment**.

2. On the **Security Assessment** page, select the check box for your target database, and then click **Assess**.

3. In the **Last Generated Report** column, click the **View Report** link. The **Comprehensive Assessment** report is displayed.

4. View the totals for the risk levels.
If you fixed any of the previous risks, then the totals will be lower than in the first assessment.

5. Check the **Account Management Privileges** entry in the Evaluate category. Notice that `EVIL_RICH` is no longer listed.

6. To compare the results with the first assessment, do the following.

7. Click the **Reports** tab.

8. Click **Security Assessment**.

9. Click **Comprehensive Assessments**.

10. Click the previous assessment report to open it.

You may proceed to the next lab.

## Acknowledgements

- **Author** - Tejus Subrahmanya, Phani Turlapati, Abdul Rafae, Sathis Muniyasamy, Sravya Ganugapati, Padma Natarajan, Aubrey Patsika, Jacob Harless
- **Last Updated By/Date** - Jess Rein - Cloud Engineer, November 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
