## Introduction
This Lab walks you through the steps to use SQL Developer to manage indexes and views.

Estimated Lab Time: 15 minutes

## **STEP 1**: View Index

1. Expand the HR user in the Other Users node. Expand Indexes.
2. Select EMP_DEPARTMENT_IX.
3. Information about the index definition is displayed in the Columns tab. Click the Details tab to view additional information.
4. The Details tab shows additional information about the index definition.

## **STEP 2**: Create Indexes

1. Select the HR user in the Other Users list and expand the Tables entry.
2. Right-click the Employees table. Select Index in the menu and then select Create Index.
3. Enter SALARY_IDX in the Name field. Click the "Add Index Expression" icon and select SALARY in the "Expression" field. Click OK.
4. Select EMPLOYEES in the Connections pane under Tables.
5. Select the Indexes tab on the EMPLOYEES page. Your new SALARY_IDX index is listed.

## **STEP 3**: Display Views

1. Expand HR under Other Users in the Connections pane and then expand Views.
2. Select the EMP_DETAILS_VIEW view.
3. The Columns tab in the EMP_DETAILS_VIEW page displays the columns that are part of this view.


## **STEP 4**: Create a View

In this example, you create a view named KING_VIEW, which queries the HR.EMPLOYEES table. This view filters the table data so that only employees who report directly to the manager named King, whose employee ID is 100, are returned in queries.

1. Expand the HR user in the Connections pane. Right click Views and select New View.
2. Enter KING_VIEW in the Name field. Enter the following query in the SQL Query box and click OK.

    ```
    SELECT *
    FROM hr.employees
    WHERE manager_id = 100;
    ```

3. The new view is listed under Views in the Connections pane. Select the KING_VIEW view.

4. The columns that are included in the view are displayed in the Columns tab. Click the Data tab.

5. The rows that are retrieved when the view is queried are displayed in the Data tab.


## Acknowledgements

* **Last Updated By/Date** - Dimpi Sarmah, Senior UA Developer

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
