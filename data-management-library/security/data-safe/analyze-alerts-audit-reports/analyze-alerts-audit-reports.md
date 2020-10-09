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
- Create a failed logins report


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

  

- Create two new filters to find out if the user `EVIL_RICH` is making any user entitlement changes.
  - To create the first filter, click **+ Filter**, and set the filter to be: **Alert = User Entitlement Changes**.
  - To create the second filter, click **+Filter**, and set the filter to be: **DB User = EVIL_RICH**.
  - Click **Apply**.

     ![Two filters for user EVIL_RICH](images/177425186.png)


- Review the alerts for `EVIL_RICH`.

- Click the **Alert ID** for the first alert. The Alert Details dialog box is displayed.

 ![Alerts for EVIL_RICH](images/177425201.png)


- Scroll down in the dialog box and review the SQL command. `EVIL_RICH` tried to execute the SQL command: `grant PDB_DBA to ATILLA`, but failed. Close the dialog box.

    ![Alert Details dialog box](images/177425210.png)


- Open the other **Alert IDs** for `EVIL_RICH`. Notice that the SQL text is similar in that the failed grants are for the `ATILLA` user.


- Suppose you take appropriate action. Now you can close the alerts. To do so, select the check box in the top left corner of the table to select all of the alerts displayed. From the **Mark As** menu, select **Closed**.

  ![Mark As > Closed](images/177425240.png)


- To hide closed alerts, move the **Open Alerts only** slider to the right.

  ![Open Alerts only slider](images/177413562.png)  




## **STEP 3**: Analyze open alerts from the dashboard

- Click the **Home** tab.

- Review the information in the charts on the dashboard. Currently, there is no data for Security Assessment, User Assessment, Data Discovery, and Data Masking because you have not yet used those features.

    ![Dashboard](images/177408455.png)  

- In the **Open Alerts** chart, notice that the chart shows the number of open alerts for the last 7 days. Click the last node in the chart.

    ![Open Alerts chart](images/177408465.png)  


- In the **Open Alerts** dialog box, view the number of open alerts for the last 7 days.

  ![Open Alerts dialog box](images/177408484.png)  


- Hover over the counts to view the number of **Critical**, **High**, and **Medium** alerts for each day.


- Click the name of your target database to open the **All Alerts** report. The **All Alerts** report is filtered to show only the open alerts for your target database for the past 7 days.

![all Alerts report filtered](images/177408562.png)  





## **STEP 4**: View all audit records for the past week

- Click the **Reports** tab.


- On the left, expand **Activity Auditing** (if needed), and then click the **All Activity** report.


- At the top of the report, view the totals for **Targets**, **DB Users**, **Client Hosts**, **Login Success**, **Login Failures**, **User Changes**, **Privilege Changes**, **DDLs**, and **DMLs**.

  ![Totals in All Activity report](images/177408585.png)  


- If the filters are not displayed, click **Filters**. The report is automatically filtered to show one week's worth of audit data for your target database.

  ![Filters automatically set in All Activity Report](images/177408600.png)  



## **STEP 5**: View a summary of audit events collected and alerts raised

- On the left, expand **Summary**, and then click **Audit Summary**. The **Audit Summary** report helps you to gain an understanding of the activity trends of your target databases. By default, the report shows you data for all of your target databases for the past week.

- View the totals to learn how many target databases are represented in the charts, how many users are audited, and how many client hosts have connected to your target database. The report is filtered to show data for the last week.

    ![Totals in Audit Summary report](images/177408621.png)  


- View the charts.

  - The **Open Alerts** chart compares the number of critical, high, and medium open alerts for the past week.
  - The **Admin Activity** chart compares the number of logins, database schema changes, audit setting changes, and entitlement changes for the past week.
  - The **Login Activity** chart compares the number of failed and successful logins for the past week.
  - The **All Activity** chart compares the total number of events for the past week.

  ![All Activity chart](images/177408629.png)  

- To filter the time period for the report, at the top, select **Last 1 Month**, and then click **Apply**.

  ![Audit Summary filter](images/177408636.png)  


- To filter the target database for the report, click **All Targets** in the Filters section.

  ![All Targets circled](images/177413580.png)  

- In the **Select Targets** dialog box, deselect the check box for **All Targets**, click the field, select your target database, and then click **Done**.

  ![All Targets option](images/177408650.png)  


- Your target database is now set as a filter.

  ![Database set as a filter](images/177408657.png)  



## **STEP 6**: Create a failed logins report

- Click the **Reports** tab.

- To view the **Login Activity** report, in the list under **Activity Auditing**, click **Login Activity**.


- To set a filter on Operation Status, select **Operation Status = FAILURE** (no quotes), and then click **Apply**.

  ![Login Activity report filters](images/177413592.png)  


- The report shows only failed logins.

  ![Login Activity report showing only failed logins](images/177413920.png)  


- From the **Report Definition** menu, select **Save As New**.

  ![Report Definition menu options with Save As New circled](images/177426047.png)  


- In the **Save As** dialog box, enter the report name **<user name> Failed Logins**, enter the description **Failed logins report**, select your compartment, and then click **Save As**.

  ![Save As dialog box](images/177426111.png)  

  A confirmation message states &quot;Successfully created the report.&quot;

- Click the **Reports** tab.


- At the top of the list under **Custom Reports**, click your failed logins report (**<user name> Failed Logins)**.

    ![List of Custom Reports](images/177427052.png)  


- Click **Generate Report**.

    ![Generate Report option circled](images/177413598.png)  


- In the **Generate Report** dialog box, leave **PDF** selected, select your compartment, and then click **Generate Report**.

  ![Generate Report dialog box with PDF circled](images/177427064.png)  

- Wait for a confirmation message that states that the report was generated successfully.


- Click **Download Report**. The PDF is downloaded to your browser.

    ![Download Report link circled](images/177413602.png)  



- To view the report, click the downloaded **Failed Logins.pdf** file.

    ![Login Activity report in PDF format](images/177427077.png)  


- When you are finished viewing the report, close it.

You may proceed to the next lab.

## Learn More

* [Activity Auditing Reports](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/activity-auditing-reports.html)
* [Manage Alerts](https://docs.cloud.oracle.com/en-us/iaas/data-safe/doc/manage-alerts.html)


## Acknowledgements
* **Author** - Jody glover, UA Developer, Oracle Data Safe Team
* **Last Updated By/Date** - Jody Glover, Oracle Data Safe Team, October 2, 2020


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
