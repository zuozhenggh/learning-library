# How to compress data in a table in a database?

## Introduction

This lab walks you through the steps to compress data in a table in a database.

Estimated Time: 1 minute

### Objectives

In this lab, you will:

* Compress data in a table in a database

### Prerequisites

* Have created departments and employees tables in a database and inserted records

## Task 1: Compress data in a table

As your database grows in size to gigabytes or terabytes and beyond, consider using table compression. Table compression saves disk space and reduces memory use in the buffer cache. Table compression can also speed up query execution during reads. There is, however, a cost in CPU overhead for data loading and DML. Table compression is completely transparent to applications. It is especially useful in online analytical processing (OLAP) systems, where there are lengthy read-only operations, but can also be used in online transaction processing (OLTP) systems.

You specify table compression with the COMPRESS clause of the CREATE TABLE statement. You can enable compression for an existing table by using this clause in an ALTER TABLE statement. In this case, the only data that is compressed is the data inserted or updated after compression is enabled. Similarly, you can disable table compression for an existing compressed table with the ALTER TABLE...NOCOMPRESS statement. In this case, all data the was already compressed remains compressed, and new data is inserted uncompressed.

1. To enable compression for future data use the following syntax.

    ```
    <copy>
    alter table EMPLOYEES compress for oltp; 
    alter table DEPARTMENTS compress for oltp;
    </copy>
    ```

    ![Compress data in both tables](../images/compress-data.png)

## Learn More

* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)

## Acknowledgements

* **Contributor** - Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, February 2022