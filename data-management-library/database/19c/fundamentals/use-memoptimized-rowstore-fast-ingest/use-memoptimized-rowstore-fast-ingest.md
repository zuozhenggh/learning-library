# Use Memoptimized Rowstore - Fast Ingest

## Introduction

In this practice, you see how Memoptimized Rowstore - Fast Ingest deferred inserts are handled in the SGA and on disk through the Space Management Coordinator (SMCO) and Wxxx slave background processes, and how deferred inserted rows are different from conventional inserts.

### Objectives

*List objectives for the lab - if this is the intro lab, list objectives for the workshop, for example:*

In this lab, you will:
* Provision
* Setup
* Data Load
* Query
* Analyze
* Visualize

### Prerequisites

## Task 1: Prepare your environment

## Task 2: Create a table in PDB1 to have rows inserted as deferred inserts.

Create the HR.MEMOPTWRITES table in PDB1 to have rows inserted as deferred inserts. You will also ensure that the table data is written to the space allocated for fast ingest writes in the large pool in the shared pool area before being written to disk.

1. Log into SQL*Plus as `system`
    ```
    $ <copy>sqlplus system/Ora4U_1234@PDB1 as sysdba</copy>
    ```

2. Create a table called `hr.memoptwrites` with the `MEMOPTIMIZE FOR WRITE` attribute.
    ```
    SQL> <copy>CREATE TABLE hr.memoptwrites 
        (c1 NUMBER, c2 VARCHAR2(12)) MEMOPTIMIZE FOR WRITE;</copy>
    2   
    *
    ERROR at line 1:
    ORA-62145: MEMOPTIMIZE FOR WRITE feature not allowed on segment
    with deferred storage.
    ```
By default, an object created like a table does not have a segment created until a first row is inserted. `MEMOPTIMIZE FOR WRITE` tables require a segment created before the first row is inserted.

  1. View the `deferred_segment_creation` startup parameter.
    ```
    SQL> <copy>SHOW PARAMETER deferred_segment_creation</copy>            

    NAME                            TYPE        VALUE
    ------------------------------- ----------- --------------------
    deferred_segment_creation       Boolean     TRUE

    ```
  2. Disable `deferred_segment_creation`.
    ```
    SQL> <copy>ALTER SYSTEM SET deferred_segment_creation = FALSE 
                      SCOPE=BOTH;</copy>
    2
    System altered.
    ```
  3. Attempt to create `hr.memoptwrites`.
    ```
    SQL> <copy>CREATE TABLE hr.memoptwrites
        (c1 NUMBER, c2 VARCHAR2(12)) MEMOPTIMIZE FOR WRITE;</copy>
    2
    Table created.
    ```
  4. Verify that `MEMOPTIMIZE FOR WRITE` is set.
    ```
    SQL> <copy>SELECT memoptimize_read Mem_read, 
            memoptimize_write Mem_write  
     FROM   dba_tables 
     WHERE  table_name = 'MEMOPTWRITES';</copy>

      2   3   4
      MEM_READ MEM_WRIT
      -------- --------
      DISABLED ENABLED

    ```
  5. Check to see if the space allocated for fast ingest writes in the large pool are initialized.
    ```
    SQL> <copy>SELECT * FROM V$MEMOPTIMIZE_WRITE_AREA;</copy>
    ```
  6. Insert a row into the table so that the row goes to the space allocated for fast ingest writes in the large pool.
    ```
    SQL> <copy>INSERT /*+ MEMOPTIMIZE_WRITE */ INTO hr.memoptwrites 
            VALUES (1, 'Memoptwrites');</copy>
    2
    1 row created.

    ```
  7. Commit the insert.
    ```
    SQL> <copy>COMMIT;</copy>

    Commit complete.
    ```
  8. View how many bytes are being consumed by the space allocated for fast ingest writes in the large pool.
    ```
    SQL> <copy>SELECT * FROM V$MEMOPTIMIZE_WRITE_AREA;</copy>

    TOTAL_SIZE USED_SPACE FREE_SPACE NUM_WRITES NUM_WRITERS CON_ID
    ---------- ---------- ---------- ---------- ----------- ------
    2154823680    164400  2154659280          0           1      3
    ```
  Here's a reference as to what the various columns store:
  `TOTAL_SIZE` refers to the total amount of memory allocated for fast ingest data in the large pool.
  `USED_SPACE` refers to the total amount of memory **currently used** by fast ingest data data in the large pool.
  `FREE_SPACE` refers to the total amount of memory **currently free** for storing fast ingest data in the large pool.
  `NUM_WRITES` refers to the number of fast ingest insert operations for which data is still in the large pool and is yet to be written to disk.
  `NUM_WRITES` refers to the number of clients currently using fast ingest for inserting data into the database.
  `CON_ID` refers to The ID of the container to which the data pertains. Possible values include:
  * 0: This value is used for rows containing data that pertain to the entire CDB. This value is also used for rows in non-CDBs.
  * 1: This value is used for rows containing data that pertain to only the root.
  * n: Where n is the applicable container ID for the rows containing data.

  By default, 2 gigabytes are allocated from the large pool. If there is not enough space, the allocation is attempted again with a half the size. This process will continue until the allocation has been retried with a target size of 256 megabytes. If it fails at 256 megabytes, fast ingest writes in the large pool will be disabled until the instance is restarted. 





## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)
* [V$MEMOPTIMIZED_WRITE_AREA](https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-MEMOPTIMIZE_WRITE_AREA.html#GUID-C6904827-0F5B-436B-8C2D-0E487EB8BE70)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Adapted for Cloud by** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.
