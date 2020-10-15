# Analyze Alerts and Audit Reports


## Introduction
This lab shows you how to view and analyze alerts, and audit data on your Autonomous Database with Oracle Data Safe.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you'll:

- Sign in to the Oracle Data Safe Console
- View and close alerts
- Analyze open alerts from the dashboard
- View all audit records for the past week
- View a summary of audit events collected and alerts raised
- Create a logins report


### Prerequisites

To complete this lab, you need to have the following:

- An Oracle Cloud account
- Access to an Autonomous Database, sample data for Oracle Data Safe loaded into the database, and the Activity Auditing feature enabled on the database
- Access to an Oracle Data Safe service
- Privileges to use the Activity Auditing feature on your database
- Audit collection started on your target database in Oracle Data Safe.


### Assumptions

This lab assumes that you completed the following labs:

- [Provision and Register and Autonomous Database](../provision-register-autonomous-database/provision-register-autonomous-database.md)
- [Provision Audit and Alert Policies](../provision-audit-alert-policies/provision-audit-alert-policies.md)

**Note:** Your data values will be different than those shown in the screenshots in this lab.



## **STEP 1**: Sign in to the Oracle Data Safe Console

You can skip this step if you are already signed in to the Oracle Data Safe Console.

- From the navigation menu in the Oracle Cloud Infrastructure Console, select **Data Safe**. The **Overview** page for the Oracle Data Safe service is displayed.

- Click **Service Console**. The **Home** page in the Oracle Data Safe Console is displayed.

## **STEP 2**: View and close alerts

- In Oracle Data Safe Console, click the **Alerts** tab.

- View the total number of target databases, critical alerts, high risk alerts, medium risk alerts, and open alerts.

  - At a glance, you can better understand whether the security of your database is in jeopardy and how you should prioritize your work.

  ![Alert totals](images/totals-alerts-page.png)


- Scroll down to review the alerts in the table.

  - The **DB User** column identifies who is doing the action.
  - The **Operation** column identifies the action.
  - The **Alert Severity** column indicates the seriousness of the action.

  ![Alerts in the table](images/alert-table.png)


- At the bottom of the page, click the page numbers to view other pages of alerts.


- To filter the report to show only open high alerts, at the top of the report, click **+ Filter** and then set the filter to be: **Alert Severity = High**. Click **Apply**.

   - If the filters are not displayed, click **Filters** below the totals at the top of the page.

  - Leave the default filters on **Alert Status** and **Operation Time** set as is.

  ![Alert filters](images/high-alert-severity.png)

  The table shows you the open high alerts.


- To sort the **Operation** column, position the cursor over the **Operation** column and click the arrow button.

 ![Sort the DB User column icon](images/sort-operation-column.png)


- To view more detail for an alert, click the alert ID.

 ![An alert ID highlighted in the Alerts table](images/click-alert-id.png)


- Review the information in the **Alert Details** dialog box, and then click **X** to close it. You can view the **DB User**, **Operation Status**, **SQL Text**, and much more.

   ![Alert Details dialog box](images/alert-details-dialog-box.png)


- To remove the filters, click the **X** next to each filter, and then click **Apply**.



- Create a filter to view the list of alerts for user entitlement changes.
  - To create the filter, click **+ Filter**, and set the filter to be: **Alert = User Entitlement Changes**.
  - Click **Apply**.


- Review the alerts.

  ![User Entitlement Changes alerts](images/user-entitlement-changes.png)

- Suppose you are fine with these entitlement changes. Now you can close the alerts:

    - Select the check box in the top left corner of the table to select all of the alerts displayed.

    - From the **Mark As** menu, select **Closed**.

    ![Mark As > Closed](images/closed-alerts.png)


- To hide closed alerts, move the **Open Alerts only** slider to the right.

  ![Open Alerts only slider](images/show-open-alerts-only.png)  




## **STEP 3**: Analyze open alerts from the dashboard

- Click the **Home** tab.

- Review the information in the charts on the dashboard. Currently, there is no data for Security Assessment, User Assessment, Data Discovery, and Data Masking because you have not yet used those features.

- In the **Open Alerts** chart, notice that the chart shows the number of open alerts for the last 7 days. Click the last node in the chart.

    ![Open Alerts chart](images/last-node-open-alerts-chart.png)  


- In the **Open Alerts** dialog box, view the number of open alerts for the last 7 days.

  ![Open Alerts dialog box](images/open-alerts-last-seven-days.png)  


- Hover over the counts to view the number of **Critical**, **High**, and **Medium** alerts for each day.


- Click the name of your target database to open the **All Alerts** report. The **All Alerts** report is filtered to show only the open alerts for your target database for the past 7 days.

  ![all Alerts report filtered](images/all-alerts-report-last-seven-days.png)  





## **STEP 4**: View all audit records for the past week

- Click the **Reports** tab.


- On the left, under **Activity Auditing**, click the **All Activity** report.


- At the top of the report, view the totals for **Targets**, **DB Users**, **Client Hosts**, **Login Success**, **Login Failures**, **User Changes**, **Privilege Changes**, **DDLs**, and **DMLs**.

  ![Totals in All Activity report](images/all-activity-report-totals.png)  


- The report is automatically filtered to show one week's worth of audit data for your target database.

    - If the filters are not displayed, click **Filters**.

   ![Filters automatically set in All Activity Report](images/filters-table-all-activity-report.png)  



## **STEP 5**: View a summary of audit events collected and alerts raised

- On the left, expand **Summary**, and then click **Audit Summary**.

    - The **Audit Summary** report helps you to gain an understanding of the activity trends of your target databases. By default, the report shows you data for all of your target databases for the past week.

- View the totals to learn how many target databases are represented in the charts, how many users are audited, and how many client hosts have connected to your target database. The report is filtered to show data for the last week.

    ![Totals in Audit Summary report](images/audit-summary-filters-totals.png)  


- View the charts.

  - The **Open Alerts** chart compares the number of critical, high, and medium open alerts for the past week.
  - The **Admin Activity** chart compares the number of logins, database schema changes, audit setting changes, and entitlement changes for the past week.
  - The **Login Activity** chart compares the number of failed and successful logins for the past week.
  - The **All Activity** chart compares the total number of events for the past week.

   ![Audit Summary report charts](images/audit-summary-report-charts.png)  

- To filter the time period for the report, at the top, select **Last 1 Month**, and then click **Apply**.

- To filter the target database for the report, click **All Targets** in the **Filters** section.

- In the **Select Targets** dialog box, deselect the check box for **All Targets**, click the field, select your target database, and then click **Done**.

- Click **Apply**.


- Your target database is now set as a filter.

  ![Database set as a filter](images/last-one-month-filter.png)  



## **STEP 6**: Create a logins report

- Click the **Reports** tab.

- To view the **Login Activity** report, in the list under **Activity Auditing**, click **Login Activity**.


- From the **Report Definition** menu, select **Save As New**.

- In the **Save As** dialog box, enter the report name **<user name> Logins**, enter the description **Logins report**, select your compartment, and then click **Save As**. A confirmation message states that you successfully created the report.

- Click the **Reports** tab.


- At the top of the list under **Custom Reports**, click your **Logins** report.

    ![List of Custom Reports](images/logins-report-listed.png)  


- Click **Generate Report**.


- In the **Generate Report** dialog box, leave **PDF** selected, select your compartment, and then click **Generate Report**.

- Wait for a confirmation message that states that the report was generated successfully.


- Click **Download Report**.  The **Opening Logins.pdf** dialog box is displayed.


- Select the application with which you want to open the PDF, and click **OK**.

- Review the report, and then close it.

  ![Login report](images/login-report-pdf.png)



Continue to the next lab.

## Learn More

* [Activity Auditing Reports](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/activity-auditing-reports.html)
* [Manage Alerts](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/manage-alerts.html)


## Acknowledgements
* **Author** - Jody Glover, Principal User Assistance Developer, Database Development
* **Last Updated By/Date** - Jody Glover, October 15, 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
