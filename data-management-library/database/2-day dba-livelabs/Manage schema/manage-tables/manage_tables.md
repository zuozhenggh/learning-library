# Introduction
This Lab walks you through the steps to how to view table definitions and table data. You also learn to create a new table and modify it.

Estimated Lab Time: 15 minutes

## Background

A schema is a collection of database objects. A schema is owned by a database user and shares the same name as the user. Schema objects are logical structures created by users. Some objects, such as tables or indexes, hold data. Other objects, such as views or synonyms, consist of a definition only.

### What Do You Need?

* Oracle Database 19c
* SQL Developer 19.1
* Installed the sample schemas in the pluggable database
* Download the load_po.csv file.


## **STEP 1**: View Tables

1. Expand the system node in Oracle SQL Developer.
2. Expand the Other Users node and then expand the HR node.
3. Expand the Tables (Filtered) node and select the EMPLOYEES table. Detailed information about the table is displayed in the object pane. The Columns tab displays the column names and definitions.

    ![Image alt text](images/001_adv.png)

## **STEP 2**: View Table Data


1. Ensure that the EMPLOYEES table is selected in the Connections pane. Click the Data tab to view the data stored in the table. The Data tab shows the rows stored in the EMPLOYEES table.

2. To sort the rows by last name, right-click the LAST_NAME column name and select Sort in the menu.

3. To Select the LAST_NAME column and click the right-arrow to move it to the Selected Columns list. Click OK.

4. The data is now displayed in sorted order.


    Dismiss the EMPLOYEES and SYSTEM window.

## **STEP 3**: Create a Table

In this topic you create a new table in the APPUSER schema. You created the APPUSER schema in the Administering User Accounts and Security tutorial.

1. Expand the APPUSER node in Oracle SQL Developer. Right-click the Tables node and select New Table.

2. Enter PURCHASE_ORDERS in the Name field. Select Primary Key. Enter PO_NUMBER in the Column Name field. Select NUMBER as the Data Type. Select Not Null. Click Add Column.

3. Enter PO_DESCRIPTION in the Column Name field. Select VARCHAR2 as the type. Enter 200 in the Size field. Click Add Column.

4. Enter PO_DATE in the Column Name field. Select DATE for the type and select the Not Null column. Click Add Column.
5. Enter PO_VENDOR in the Column Name field. Select NUMBER as the type and select the Not Null column. Click OK.

6. Expand the Tables node to view the PURCHASE_ORDERS table in the Tables list for the APPUSER user.
7. Click the Columns tab to view the column definitions of the PURCHASE_ORDERS table.

## **STEP 4**: Add a Column

1. Right-click the PURCHASE_ORDERS table and select Edit.
2. The Edit Table dialog box appears. Click the plus sign to add a column or press Alt+1.
3. Enter PO_DATE_RECIEVED in the Name field. Select DATE in the Type menu. Click the plus sign again or press ALT+1.
4. Enter PO_REQUESTOR_NAME in the Name field. Select VARCHAR2 in the Type menu. Enter 40 in the Size field. Click OK.
5. The Columns tab shows the new columns.

## **STEP 5**:Load Data into a Table

1. Download the load_po.csv file.
2. Right-click the APPUSER user and select Edit User.
3. On the Edit User window, click Quotas. Select Unlimited for the APPTS tablespace and click Apply. You will receive a prompt stating that the SQL command processed successfully, click OK. The Edit User window closes automatically.

4. Expand Tables. Right-click the PURCHASE_ORDERS table and select Import Data.

5. Click Browse and select the load_po.csv file. Click Open.
6. Deselect Header. Ensure that Format is set to csv and UTF8 is selected for Encoding. Select none for Left Enclosure. Click Next.

7. Ensure that Import Method is set to Insert. Click Next. Click Next.
8. Verify each column in the Source Data Columns list and its value in the Name field BEFORE clicking Next. After verifying all five columns, click Next. As shown in the screenshot, you may need to edit the Format of COLUMN5 to DD-MON-YYYY.

9. Click Finish.You get a success message that the data is successfully imported. Click OK.
10. Select the PURCHASE_ORDERS table and click the Data tab to see the new rows.


## Acknowledgements

* **Last Updated By/Date** -  Dimpi Sarmah, Senior UA Developer

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
