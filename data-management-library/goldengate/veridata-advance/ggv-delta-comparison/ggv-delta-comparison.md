# Configure Delta Comparison in Oracle GoldenGate Veridata

## Introduction
This lab shows you how to enable delta comparison for database compare pairs in Oracle GoldenGate Veridata.

Oracle GoldenGate Veridata compares a source database table to the target database table. The source and target tables are configured using compare pairs, which are grouped and added to a job to run the comparison (see lab). When all the rows in the table are compared, it is a Full Comparison Job.

During the subsequent runs of a comparison job, the comparison of the tables can be performed based on what has changed in the tables from previous job run; these jobs are Delta Processing Jobs. Delta processing is usually performed on tables that contain a large number of rows so it is probable that in these tables there will be columns eligible for delta processing.

### What Do You Need?

+ **An existing Oracle GoldenGate Veridata install that is functional, version 12.2.1.2 and higher**

## Task 1: Configure Delta Comparison

1. In the Compare Pair Configuration page, click **Manual Mapping**.
2. Select a Source **Schema** and a Target **Schema** under **Datasource Information**, and then select the tables from **Source Tables** and **Target Tables** for Manual Compare Pair Mapping.
Enter:
    * Source schema: **SOURCE**
    * Target schema: **TARGET**
    * Source Table: **DELTA_TEST1**
    * Target Table: **DELTA_TEST1**
    ![](./images/1DP.png " ")
3. Click **Generate Compare Pair**.
    ![](./images/2DP.png " ")
4. Click **Save** to save the generated compare pairs on the **Preview** tab.
5. Click the **Existing Compare Pairs** tab, select the Compare Pair **DELTA_TEST1=DELTA_TEST1**, and click **Edit** under **Column Mapping**.
    ![](./images/3DP.png " ")

6.  Click the **Delta Processing** tab, select the **Enable Delta Processing** check box, and then click **Save**.

    ![](./images/3DP_selectEnableDelta.png " ")

7. Notice the successful operation and then click the **Compare Pair Configuration** link.

    ![](./images/5DP.png " ")

    Delta Processing is enabled. Notice the orange triangular icon next to the compare pairs on the **Existing Compare Pairs** tab:
    ![](./images/6DP.png " ")

7.  Create a job and name it **Job_Delta_Processing** and run this job.
      <Insert Screen>
8.  Click out-of-sync link (later we need to add the number).

     ![](./images/7DP.png " ")

    Note that for the 1st job run, the out-of-sync is 800 rows with 800-Inserts. Next, let's insert 5 more **Inserts** to the source database from the Terminal.

9.   Open the terminal.
10.  Run the following command:

      ```
    <copy>
    cd /home/opc/stage/scripts
     source env_setup.sh
     sqlplus   <\copy>

     ```  
10.  Enter the following credentials:
      * **User Name**: source
      * **Password**: source
11. Enter the following INSERT query:

      ```
      <copy>
      insert into delta_test1 values ('2000',2000);
      insert into delta_test1 values ('2001',2001);
      insert into delta_test1 values ('2002',2002);
      insert into delta_test1 values ('2003',2003);
      insert into delta_test1 values ('2004',2004);
      commit;
      <\copy>
     ```
12.  Go back to the Oracle GoldenGate Veridata UI run the job again with Delta Base Time to retrieve the delta out-of-sync entries between the 2 job runs. In the **Run/Execute Job** page, select **Job_Delta_Processing** from the **Job** drop-down list and click **Retrieve Compare Pair List**.

13. Click **Select...** under **Delta Base Time** to select the delta-base time from the list to perform delta processing.

      ![](./images/8DP.png " ")

14. In the **Delta Base Time Selection** page, select **Base Time** and then click **Select**.

      ![](./images/9DP.png " ")

15. Notice the Delta Base Time has been updated to the time slot selected in the previous step. (highlight the Delta Base Time - Aug 13).

    ![](./images/10DP.png " ")

16. Run the Job.

    To add a screen showing Finished Jobs status.

17. Click **Out-of-Sync** link (number to be included later).    

      ![](./images/11DP.png " ")



## Want to Learn More?



## Acknowledgements
* **Author** - Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Contributors** -  Nisharahmed Soneji, Senior Principal Product Manager and Sukin Varghese, Senior Member of Technical staff
* **Last Updated By/Date** - Anuradha Chepuri, September 2021
