# How to query the Oracle data dictionary?

## Introduction

This lab walks you through the steps to query the Oracle data dictionary.

Estimated Time: 1 minutes

### Objectives

In this lab, you will:

* Query the Oracle data dictionary

### Prerequisites

* Have created departments and employees tables in a database

## Task 1: Query the Oracle data dictionary

1. Table meta data is accessible from the Oracle data dictionary. The following queries show how you can query the data dictionary tables.

    ```
    <copy>
    select table_name, tablespace_name, status
    from user_tables
    where table_Name = 'EMPLOYEES';
    </copy>
    ```

    ![Query Oracle Data Dictionary](../images/query-data-dictionary.png)

    ```
    <copy>
    select column_id, column_name , data_type
    from user_tab_columns
    where table_Name = 'EMPLOYEES'
    order by column_id;
    </copy>
    ```

    ![Query Oracle data dictionary](../images/query-data-dictionary2.png)

## Learn More

* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)

## Acknowledgements

* **Contributor** - Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, February 2022