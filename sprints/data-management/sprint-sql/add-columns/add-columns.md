# How to add columns to a table in a database?

## Introduction

This lab walks you through the steps to add columns to a table in a database.

Estimated Time: 1 minute

### Objectives

In this lab, you will:

* Add columns to a table in a database

### Prerequisites

* Have created departments and employees tables in a database

## Task 1: Add column to a table

1. You can add additional columns after you have created your table using the ALTER TABLE ... ADD ... syntax. For example:

    ```
    <copy>
    alter table EMPLOYEES 
    add country_code varchar2(2);
    </copy>
    ```

    ![Alter table to add a column](../images/alter-table-add-column.png)

## Learn More

* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)

## Acknowledgements

* **Contributor** - Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, February 2022