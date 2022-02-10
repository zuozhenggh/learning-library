---
inject-note: true
---

# Provision Audit and Alert Policies

## Introduction

When you register a target database, Oracle Data Safe automatically creates an audit profile, audit policy, and audit trail(s) for your target database. In Oracle Data Safe, you can start collecting audit data with a single click and provision audit and alert policies on your target databases. You can provision basic, administrator, user, and custom audit policies, as well as audit policies designed to help you meet compliance standards.

An alert is a message that notifies you when a particular audit event happens on a target database. The alerts generated depend on which alert policies you enabled for your target database in Oracle Data Safe. An audit trail is a database table that stores audit data. Oracle Data Safe copies audit data from the database's audit trail into the Oracle Data Safe audit table.

Start by reviewing the audit profile, audit policy, and audit trail that were automatically created when you registered your Autonomous Transaction Processing (ATP) database. Enable audit data collection and provision a few audit and alert policies on your target database.

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:

- Review the global settings for Oracle Data Safe and the audit profile for your target database
- Review the audit policy for your target database
- Review the audit trail for your target database
- View the quantity of audit records available on your target database for the discovered audit trail
- Start audit data collection
- Provision audit policies on your target database
- Provision an alert policy on your target database

### Prerequisites

This lab assumes you have:

- Obtained an Oracle Cloud account and signed in to the Oracle Cloud Infrastructure Console
- Prepared your environment for this workshop (see [Prepare Your Environment](?lab=prepare-environment)). It's important that the Activity Auditing feature is enabled on your target database and that you have privileges in Oracle Cloud Infrastructure Identity and Access Management (IAM) to use the Activity Auditing and Alerts features with your target database.
- Registered your Autonomous Database with Oracle Data Safe and loaded sample data into it (see [Register an Autonomous Database](?lab=register-autonomous-database))
- Accessed Security Center


### Assumptions

- Your data values are most likely different than those shown in the screenshots.

## Task 1: Review the global settings for Oracle Data Safe and the audit profile for your target database

1. In Security Center, click **Activity Auditing**.

2. On the left, click **Settings**, and review the global settings.

  Each regional Oracle Data Safe service has global settings for online retention period, archive retention period, and paid usage. Global settings are applied to all target databases unless their audit profiles override them. By default, the online retention period is set to the maximum value 12, the archive retention period is set to the minimum value 0, and paid usage is enabled for all target databases.

3. Under **Related Resources**, click **Audit Profiles**.

4. From the **Compartment** drop-down list under **List Scope**, make sure that your compartment is selected.

5. On the right, click the audit profile for your target database.

6. Review the audit profile. Review the default settings for paid usage, online retention period, and offline retention period. All of these settings are inherited from the global settings for Oracle Data Safe, but can be modified here as needed.


## Task 2: Review the audit policy for your target database

1. On the left, click **Activity Auditing**.

2. Under **Related Resources**, click **Audit Policies**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.


5. On the right, click the name of the audit policy for your target database to view its details.

  When you register a target database, Oracle Data Safe automatically creates one audit policy resource for your target database.

6. Review the audit policies that are retrieved from your target database and their corresponding provisioning status.

  All the available unified audit policies for your target database are listed. You can choose to provision any number of those audit policies on your target database and set filters on users and roles.


## Task 3: Review the audit trail for your target database

1. In the breadcrumb at the top of the page, click **Activity Auditing**.

2. On the left under **Related Resources**, click **Audit Trails**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.

5. On the right, click the name of the audit trail for your target database.

  When you registered your target database, Oracle Data Safe automatically discovered the audit trails on it and created one audit trail per target database audit trail.




## Task 4: View the quantity of audit records available on your target database for the discovered audit trails

1. In the breadcrumb at the top of the page, click **Activity Auditing**.

2. On the left under **Related Resources**, click **Audit Profiles**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.

5. On the right, click the name of the audit profile for your target database to view its details.

6. Scroll down to the **Compute Audit Volume** section.

7. Click **Available on Target**.

  The **Compute Available Volume** dialog box is displayed.

8. In the **Select Start Date** box, enter the current date. You can use the calendar widget to help you.

9. In the **Trail Locations** box, review the audit trails that are listed. An Autonomous Database always has the  `UNIFIED_AUDIT_TRAIL`.

10. Click **Compute**. Oracle Data Safe calculates the available audit volume.

11. In the **Available in Target Database** column, view the number of audit records for the `UNIFIED_AUDIT_TRAIL`.

  Because you just provisioned the target database, there are a small number of audit records in the `UNIFIED_AUDIT_TRAIL`. But for an older target database where there are many more audit records, Oracle Data Safe splits up the numbers by month. These values help you decide on a start date for the Oracle Data Safe audit trail.


## Task 5: Start audit data collection

1. In the breadcrumb at the top of the page, click **Activity Auditing**.

2. On the left under **Related Resources**, click **Audit Trails**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.

5. On the right, click the name of the audit trail for your target database.

6. Click **Start**. A **Start Audit Trail: UNIFIED_AUDIT_TRAIL** dialog box is displayed.

7. Leave the default start date as is, and click **Start**.

8. Wait for the status of the audit trail to go from **UPDATING** TO **ACTIVE**.  

9. Notice that the **Collection State** changes to **Collecting/Idle**.


## Task 6: Provision audit policies

1. On the left, click **Activity Auditing**.

2. Under **Related Resources**, click **Audit Policies**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.

5. On the right, click the name of the audit policy for your target database to view its details.

6. Click **Update and Provision**. The **Provision Audit Policies** page is displayed.

7. Under **Basic Auditing**, select **Database Schema Changes** and **Critical Database Activity**.

8. Under **Admin Activity Auditing**, select **Admin User Activity**.

9. Under **Custom Policies**, select **EMPSEARCH_SELECT_USAGE_BY_PETE**.

10. Click **Update and Provision** to provision the selected policies on your target database.

11. Wait for the provisioning to finish, and then view the updated policy information on the page.


## Task 7: Provision an alert policy on your target database

1. In the breadcrumb, click **Security Center**.

2. Click **Alerts**.

3. Under **Related Resources**, click **Alert Policies**. A list of available alert policies is displayed.

4. Click the **User Creation/Modification** alert policy to view its details. The **User Creation/Modification** page is displayed.

5. Click **Apply Policy**. The **Apply And Enable Alert Policy To Target Databases** panel is displayed.

6. Keep **Selected Targets Only** selected.

7. In the **Target Databases** field, click and select the name of your target database.

8. Click **Apply Policy**.

9. Keep the panel open and view the progress information.

10. After the alert policy is successfully provisioned, click **Close** to close the panel.

11. On the **User Creation/Modification** page, click **View List** to view the target databases associated with the alert policy. Notice that your target database is listed.




## Learn More

* [Activity Auditing Overview](https://www.oracle.com/pls/topic/lookup?ctx=en/cloud/paas/data-safe&id=UDSCS-GUID-741E8CFE-041E-46C4-9C04-D849573A4DB7)
* [Alerts Overview](https://www.oracle.com/pls/topic/lookup?ctx=en/cloud/paas/data-safe&id=UDSCS-GUID-37F8AC38-44D4-42D1-AE93-9775DCF21511)

## Acknowledgements

* **Author** - Jody Glover, Principal User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, February 10, 2022
