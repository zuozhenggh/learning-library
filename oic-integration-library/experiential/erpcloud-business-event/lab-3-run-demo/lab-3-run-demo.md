# Run Demo

## Introduction
This demo lab will walk you through the steps to create an ERP Purchase Order and validate how the data is processed in the integration flow. 

Estimated Time: 10 minutes

### Objectives
In this lab, you will:
- Create Purchase Order (PO) in ERP Cloud
- View message flow triggered by the PO Create Event
- Verify PO record in ADW Table

### Prerequisites
This lab assumes you have:
- Completed all previous labs successfully 


## Task 1: Create Purchase Order in ERP Cloud
1. Access your ERP Cloud environment. Login with a user having the correct roles and privileges to create a PO. 

2. Navigate to the **Procurement** Tab.

3. Click **Purchase Orders**.

4. In the **Overview** section, click **Tasks** button on the right.
   ![](images/run-demo01.png)

    This opens the Tasks menu. 

5. Under the *Orders* section, select **Create Order**.
  ![](images/run-demo02.png)

    The *Create Order* dialog is displayed.

6. Enter a valid entry in the *Supplier* field, for example `ABC Consulting`, and select the corresponding supplier in the drop down. 

    > **Tip:** You can also search for valid suppliers using the **Search** icon. 

7. Click **Create**.

    This opens the *Edit Document (Purchase Order)* page.
    ![](images/run-demo03.png)

8. Under *General* section, in the *Description* field, enter the same value used for *Lab 2 > Task 2 > Step 5: Filter Expr for Purchase Order Event*. For example: `"LL demo"` 

9. In the *Lines* Tab, click **+** to add a Purchase Order row.
    ![](images/run-demo04.png)

10. Enter values in the below fields (sample values provided)
    | **Field**        | **Value**          |       
    | --- | ----------- |
    | Line | `1` (Default)       |
    | Type | `Goods` |
    | Item | Start typing `AS1`, then select an item from the drop-down (or hit the search button to select a valid item)
    | Description | &lt;keep default&gt; |
    | Quantity | Enter a valid number, eg. `2` |
    | UOM | `Ea` (default) |
    | Base Price | Enter a valid number, eg. `200`

     ![](images/run-demo05.png)   

11. Click the **EDIT** button under *Lines* section.
    ![](images/run-demo06.png)

    This opens the *Edit Line* page for the current purchase order line. 

12. Enter a future date in either *Requested Delivery Date* or *Promised Delivery Date* fields. 
    ![](images/run-demo07.png)

13. Click **OK** at the top right of the *Edit Line* page and return to the parent window. 

14. Click **Submit** to initiate the the Purchase Order processing. 
    ![](images/run-demo08.png)

    After submitting the Purchase Order, a confirmation message should appear with the PO number.

15. Click **OK** to close the confirmation dialog. 


## Task 2: Validate Purchase Order
After the PO is submitted, the initial status becomes *Pending Approval*. The PO Create event will occur once the status changes to *Open*. 

1. In the **Overview** section, click **Tasks** button on the right.

    This opens the *Tasks* menu. 

2. Under the *Orders* section, click on **Manage Orders**.

3. Click **Search**. You should see the Purchase Orders for the current user. 

4. Look for your Purchase Order in the list with the PO number displayed in the previous task.

    > **Tip:** The last created PO should generally be the top one in the list.

5. Validate the PO Status. If it's *Open* then the Business Event has occurred. 
    > **Note:** If PO has another Status, such as *Pending Approval*, then wait a couple of minutes and keep refreshing the page until the desired PO Status appears. 


## Task 3: Track incoming PO Event in Integration
Use the Oracle Integration dashboard to see the data flow resulting from the create Purchase Order event in ERP Cloud. 

1. In the Integration navigation pane, click **Home** > **Monitoring** > **Integrations** > **Tracking**

2. Find our corresponding Integration Instance, by matching the PO number which was generated in ERP Cloud. This should be under the column *Business Identifiers*.

3. Click on your **Order Number** link to open the corresponding instance

   ![](images/integration-instance-run.png)

4. Review the 


## Task 3: Verify PO record in ADW Table
Follow these steps to view the PO record in the designated DB table. 

1. If you are not already logged in to Oracle Cloud Console, log in and select Autonomous Data Warehouse from the navigation menu.

    ![Select Autonomous Database](../setup/images/adb-navigation01.png)

    > Note: You can also directly access your Autonomous Data Warehouse or Autonomous Transaction Processing service in the **Quick Actions** section of the dashboard.

2. Navigate into your demo database by clicking on the instance link.

    ![Select Autonomous Database](../setup/images/adb-navigation02.png)

    > Note: Similar steps apply to either Autonomous Data Warehouse or Autonomous Transaction Processing.

3. In your ADW Database Details page, click the **Database Actions** button.

    ![Select Autonomous Database](../setup/images/adb-navigation03.png)

4. Sign-in with your database instance's default administrator account, Username = `ADMIN` and click **Next**.

   ![Enter DB username](../setup/images/adb-navigation04.png)

5.  Enter the **ADMIN** password and click **Sign in**.

    ![Enter DB password](../setup/images/adb-navigation05.png)

6. The Database Actions page opens. In the *Development* box, click **SQL**.

    ![Enter DB password](../setup/images/adb-navigation06.png)


7. The SQL Worksheet appears. In the *Navigator* on the left, select the **PURCHASEORDER** table, then right-click on **Open**.
    ![Open PO table](images/sql-open-po-table.png)

    This opens the *ADMIN.PURCHASEORDER* table window. 

8. Click on **Data** in the left menu to display the table data. Verify the PO record is available. 
   ![Show PO data](images/sql-show-po-data.png)


## Acknowledgements
* **Author** - Ravi Chablani, Product Management - Oracle Integration
* **Last Updated By/Date** - Ravi Chablani, February 2022

