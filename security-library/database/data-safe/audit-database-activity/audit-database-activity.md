---
inject-note: true
---

# Audit Database Activity

## Introduction

In Oracle Data Safe, you can provision audit policies on your target databases and collect audit data into the Oracle Data Safe repository. There are basic, administrator, user, and custom audit policies, as well as audit policies designed to help you meet compliance standards. When you register a target database, Oracle Data Safe automatically creates an audit profile, audit policy, and an audit trail for each audit trail on your target database.

Start by reviewing the audit profile, audit policy, and audit trail that were automatically created when you registered your Autonomous Transaction Processing (ATP) database. Enable audit data collection on your target database and provision a few audit policies. Analyze the audit events, view reports, and then create a custom audit report.

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:

- Review the global settings for Oracle Data Safe and the audit profile for your target database
- Review the audit policy for your target database
- Review the audit trail for your target database
- View the quantity of audit records available on your target database for the discovered audit trail
- Start audit data collection
- Provision audit policies on your target database
- Analyze audit events across all your target databases
- View the All Activity report
- Create a custom audit report

### Prerequisites

This lab assumes you have:

- Obtained an Oracle Cloud account and signed in to the Oracle Cloud Infrastructure Console
- Prepared your environment for this workshop (see [Prepare Your Environment](?lab=prepare-environment)). It's important that Activity Auditing is enabled on your target database, and that you have permissions in Oracle Cloud Infrastructure Identity and Access Management (IAM) to use the Activity Auditing feature in Oracle Data Safe.
- Registered your Autonomous Database with Oracle Data Safe and loaded sample data into it (see [Register an Autonomous Database](?lab=register-autonomous-database))
- Accessed Security Center


### Assumptions

- Your data values are most likely different than those shown in the screenshots.

## Task 1: Review the global settings for Oracle Data Safe and the audit profile for your target database

1. In Security Center, click **Activity Auditing**.

2. On the left, click **Settings**, and review the global settings.

    - Each regional Oracle Data Safe service has global settings for online retention period, archive retention period, and paid usage.
    - Global settings are applied to all target databases unless their audit profiles override them.
    - By default, the online retention period is set to the maximum value 12, the archive retention period is set to the minimum value 0, and paid usage is enabled for all target databases.

3. Under **Related Resources**, click **Audit Profiles**.

4. From the **Compartment** drop-down list under **List Scope**, make sure that your compartment is selected.

5. On the right, click the audit profile for your target database.

6. Review the audit profile.

    - There are default settings for paid usage, online retention period, and offline retention period.
    - All initial audit profile settings are inherited from the global settings for Oracle Data Safe, but you can modify them here as needed.


## Task 2: Review the audit policy for your target database

1. On the left, click **Activity Auditing**.

2. Under **Related Resources**, click **Audit Policies**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.

5. On the right, click the name of the audit policy for your target database to view its details.

    - When you register a target database, Oracle Data Safe automatically creates one audit policy resource for your target database.

6. Review the audit policies that are retrieved from your target database and their corresponding provisioning status.

    - All the available unified audit policies for your target database are listed.
    - You can choose to provision any number of those audit policies on your target database and set filters on users and roles.


## Task 3: Review the audit trail for your target database

1. In the breadcrumb at the top of the page, click **Activity Auditing**.

2. On the left under **Related Resources**, click **Audit Trails**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.

5. On the right, click the name of the audit trail for your target database.

    - When you registered your target database, Oracle Data Safe automatically discovered the audit trails on it and created one audit trail per target database audit trail.




## Task 4: View the quantity of audit records available on your target database for the discovered audit trails

1. In the breadcrumb at the top of the page, click **Activity Auditing**.

2. On the left under **Related Resources**, click **Audit Profiles**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.

5. On the right, click the name of the audit profile for your target database to view its details.

6. Scroll down to the **Compute Audit Volume** section.

7. Click **Available on Target**. The **Compute Available Volume** dialog box is displayed.

8. In the **Select Start Date** box, enter the current date.

    - You can use the calendar widget to help you.

9. In the **Trail Locations** box, review the audit trails that are listed.

    - An Autonomous Database always has the  `UNIFIED_AUDIT_TRAIL`.

10. Click **Compute**. Oracle Data Safe calculates the available audit volume.

11. In the **Available in Target Database** column, view the number of audit records for the `UNIFIED_AUDIT_TRAIL`.

    - Because you just provisioned the target database, there are a small number of audit records in the `UNIFIED_AUDIT_TRAIL`. But for an older target database where there are many more audit records, Oracle Data Safe splits up the numbers by month. These values help you decide on a start date for the Oracle Data Safe audit trail.


## Task 5: Start audit data collection

1. In the breadcrumb at the top of the page, click **Activity Auditing**.

2. On the left under **Related Resources**, click **Audit Trails**.

3. From the **Compartment** drop-down list, select your compartment.

4. From the **Target Databases** drop-down list, select your target database.

5. On the right, click the name of the audit trail for your target database.

6. Click **Start**. A **Start Audit Trail: UNIFIED\_AUDIT\_TRAIL** dialog box is displayed.

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

9. Under **Custom Policies**, select **EMPSEARCH\_SELECT\_USAGE\_BY\_PETE**.

10. Click **Update and Provision** to provision the selected policies on your target database.

11. Wait for the provisioning to finish, and then view the updated policy information on the page.



## Task 7: Analyze audit events across all your target databases

1. In the breadcrumb at the top of the page, click **Activity Auditing**.

2. Review the Activity Auditing dashboard.

    - By default, the Activity Auditing dashboard shows you a summary of audit events for the last one week for all target databases, in the form of charts and tables. You can modify the filters set on target database and time period as needed. The charts and tables are immediately updated.
    - The **Failed Login Activity** chart shows you the number of failed logins on all or selected target databases for the specified time period.
    - The **Admin Activity** chart shows you the number of database schema changes, logins, audit setting changes, and entitlement changes on all or selected target databases for the specified time period.
    - The **All Activity** chart shows you the total count of audit events on all or selected target databases for the specified time period.
    - The **Events Summary** tab shows you statistics for audit event categories. Statistics include the number of target databases that have an audit event in each event category and the total number of events per category.
    - The **Targets Summary** tab shows you various audit event counts per target database. Audit events include the number of login failures, schema changes, entitlement changes, audit settings changes, all activity (all audit events), database vault realm violations and command rule violations, and database vault policy changes. If there are no audit events for a target database, the target database isn't listed.

3. From the **Compartments** drop-down list on the left, select your compartment.

4. From the **Targets** drop-down list on the left, select your target database.

    - The dashboard automatically is updated to include audit event statistics for only your target database.

5.  On the **Events Summary** tab, click **Schema Changes By Admin** to view more detail.

6. On the **Schema Changes By Admin** page, review the following:

    - The filters set at the top of the page
    - The totals
    - The individual audit events


## Task 8: View the All Activity report

1. Under **Related Resources**, click **Audit Reports**.

2. On the **Predefined Reports** tab, review the list of available Activity Auditing reports.

3. Click the **All Activity** report to view it.

4. View totals in the report. The report totals are clickable. Some of them show you a list and some of them toggle a filter in the list of audit events.

5. Scroll down and view the individual audit events.

6. To view more detail for a particular event, click the down arrow to expand the row and show details for the particular event.

    - For some details, you can copy their values to the clipboard.


## Task 9: Create a custom audit report

1. At the top of the page, create the following two filters. To add a filter, click **+ Another Filter**. When you are done setting the filter parameters, click **Apply**.

    - **Target = your-target-database-name**
    - **Object Owner = HCM1**

2. Set the table in the report to include the **Target**, **DB User**, **Event**, **Object**, **Operation Time**, and **Unified Audit Policies** columns. To do this, click **Manage Columns**. In the **Manage Columns** panel, select the check boxes for the column names, and then **Apply Changes**.

3. Click **Create Custom Report**.

4. In the **Custom Report** dialog box, enter the report name **All Activity Report on schema: HCM1 in the target your-target-database-name**. Enter an optional description. Select your compartment. Click **Create Custom Report**.

5. Under **Related Resources**, click **Audit Reports**.

6. Click the **Custom Reports** tab.

7. Click the name of your custom report to view it. If you need to modify your custom report, you can click **Save Report** to save the changes.




## Learn More

* [Activity Auditing Overview](https://www.oracle.com/pls/topic/lookup?ctx=en/cloud/paas/data-safe&id=UDSCS-GUID-741E8CFE-041E-46C4-9C04-D849573A4DB7)

## Acknowledgements

* **Author** - Jody Glover, Consulting User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, February 11, 2022
