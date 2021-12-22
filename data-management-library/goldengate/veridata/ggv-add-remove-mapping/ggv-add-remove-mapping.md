# Add and Remove Mappings

## Introduction
This lab describes how to add and remove mappings.

In Oracle GoldenGate Veridata, you can add mappings to the selected source and target tables. Compare Pairs can then be configured for these columns. You can also remove the mappings from columns.

*Estimated Lab Time*: 20 minutes



### Objectives
In this lab, you will:
* Add column mapping
* Remove Column mapping

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    * Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    * Lab: Environment Setup
    * Lab: Initialize Environment
    * Lab: Create Datasource connections
    * Lab: Create Groups and Compare Pairs. Create a Group by name **`Group_Mapping`**.
    * Lab: Create Groups and Compare Pairs. Follow the Tasks 1 to 2 to create a compare pair.
- The understanding of Lab: Create Jobs and Execute Jobs.

## **Task 1:** Remove Mappings
To Remove Column Mapping:

1. In the Oracle GoldenGate Veridata UI, click **Group Configuration**, select a group, click **Edit**, and click **Go to Compare Pair Configuration** to display the **Compare Pair Configuration** page.

2. Click **Manual Mapping**.

3. Select a Source **Schema** and a Target **Schema** under **Datasource Information**, and then select the tables from **Source Tables** and **Target Tables** for Manual Compare Pair Mapping. Enter:

    * Source schema: **SOURCE**
    * Target schema: **TARGET**
    * Source Table: **DUMMY_TABLE**
    * Target Table: **DUMMY_TABLE**

6. Click **Generate Mappings**. The control moves to the **Preview** tab.

7. Click **Save** to save the generated compare pair.

   The control moves to the **Existing Compare Pairs** tab.

8. Click **Edit** under **Column Mapping**.
    ![](./images/1_ColumnMapping_Edit.png " ")

9. Click **User Defined**, and  
    ![](./images/2_ColumnMapping_ClickUserDefined.png " ")

10. Select the columns to remove and then click **Remove Mapping**.

    ![](./images/3-Select_Columns-to_Remove.png " ")

    The columns get removed.

    ![](./images/4-Columns_Removed.png " ")

11. Click **Save**. On the **Existing Column Mapping** tab, the remaining mapped columns are displayed.

    ![](./images/5-Remaining-Columns.png " ")

12. Click **Job Configuration**, click **New** to create a new job by Job Name **Job_Mapping** by following the steps in **Lab - Create Jobs and Execute Jobs**. Select Group_Mapping job you created to add group to this job.

13. Run the Job **Job_Mapping**.

14. On the Home Page, click **Finished Jobs**, click the **out-of-sync** link for the Finished job link for the Finished job **Job_Mapping**::

    ![](./images/6-FinishedJobs_Click-Out-of-Sync.png " ")

Comparison is now complete for the columns **DUMMY_KEY** and **DUMMY_DATE**. The other 2 mapped columns (**DUMMY_STRING** and **DUMMY_NUMBER**) have been skipped from being mapped and compared.

      ![](./images/7-ColumnsRemoved_Comparison_Complete.png " ")

## **Task 2:** Add Mappings

To add mappings:

1. From the **Existing Compare Pairs** tab, select the columns (both Source and Target Columns) and click **Add Mapping** to add the columns for mapping.

      [](./images/8-Select_Column_for_Add_Mapping.png " ")

      The columns **DUMMY_STRING** and **DUMMY_NUMBER** are added for mapping.
2. Click **Save**

    [](./images/9-Columns-Added-for-Mapping.png " ")

    These columns are added for comparison.

    [](./images/10-Columns-Added-for-Comparison.png " ")

3. Run the Job **Job_Mapping**.

4. On the Home Page, click **Finished Jobs**, click the **out-of-sync** link for the Finished job **Job_Mapping**.

5. Expand DUMMY_TABLE-DUMMY_TABLE notice that the **DUMMY_STRING** and **DUMMY_DATE** columns have also been added for comparison along the **DUMMY_KEY** and **DUMMY_NUMBER** columns.

    [](./images/11-Expand_Columns-to_View_Mappings.png " ")

You may now [proceed to the next lab](#next).

## Want to Learn More?

* [Oracle GoldenGate Veridata Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/index.html)
* [Configuring Partitions in Oracle GoldenGate Veridata ](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/configure-workflow-objects.html#GUID-03B3876F-7A79-43BA-9E14-8B216BD8F3BB)


## Acknowledgements
* **Author** - Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Contributors** -  Sukin Varghese, Jonathan Fu
* **Last Updated By/Date** - Anuradha Chepuri, February 2022
