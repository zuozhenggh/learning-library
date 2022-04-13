# Enable Trandata, Add Heartbeat and Checkpoint Tables

## Introduction

With the ADD TRANDATA command, Oracle GoldenGate acquires the transaction information that it needs from the transaction records. For a seamless data replication in Oracle GoldenGate, you need to first enable TRANDATA for the database tables.

The Heartbeat functionality helps in monitoring replication lags. Add a heartbeat table to each of your databases by using the ADD HEARTBEATTABLE command.

The use of checkpoint table causes checkpoints to be part of the Replicat transaction. Use the ADD CHECKPOINTTABLE command to create a checkpoint table in the target database. Replicat uses the table to maintain a record of its read position in the trail for recovery purposes.


### Objectives
In this lab, you will:
* Enable Trandata
* Add Heartbeat table
* Add Checkpoint table

### Prerequisites
This lab assumes that you have:
* Established a database connection by following the steps in **Lab: Add Database Credentials**

## Task 1: Enable TRANDATA

To enable TRANDATA:

1. Execute the following command:

    ```
    <copy>
    ADD TRANDATA pdbeast.hr.employees, allcolumns
    <copy>
    ```


## Task 2: Add Heartbeat Tables
Add the heartbeat tables for both source and target endpoints by connecting to ggeast and ggwest database credential aliases.

To add the Heartbeat tables:

1. Execute the following command:

    ```
    <copy>
    ADD HEARTBEATTABLE TARGETONLY
    <copy>

    ```
2. Repeat step 1 on the target database.

## Task 3: Add Checkpoint table

To add the Checkpoint table:

1. Execute the following command:

  ```
  <copy>
  ADD CHECKPOINTTABLE Tablename
  <copy>
  
  ```

You may now [proceed to the next lab](#next).


## Learn More
* [Using the Admin Client](https://docs.oracle.com/en/middleware/goldengate/core/21.1/admin/getting-started-oracle-goldengate-process-interfaces.html#GUID-84B33389-0594-4449-BF1A-A496FB1EDB29)
*

## Acknowledgements
* **Author**
* **Contributors**
* **Last Updated By/Date**
