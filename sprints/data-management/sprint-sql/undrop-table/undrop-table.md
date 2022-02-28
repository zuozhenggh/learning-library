# How to un-drop a table in a database?

## Introduction

This lab walks you through the steps to un-drop a table in a database.

Estimated Time: 2 minutes

### Objectives

In this lab, you will:

* Un-drop a table in a database

### Prerequisites

* Have created departments and employees tables in a database

## Task 1: Un-drop a table

1. If the RECYCLEBIN initialization parameter is set to ON (the default in 10g), then dropping this table will place it in the recycle bin. To see if you can undrop a table run the following data dictionary query:

    ```
    <copy>
    select object_name, 
       original_name, 
       type, 
       can_undrop, 
       can_purge
    from recyclebin;
    </copy>
    ```

    ![Check if you can undrop the tables](../images/check-undrop-table.png)

2. To undrop tables we use the flashback command, for example:

    ```
    <copy>
    flashback table DEPARTMENTS to before drop;
    flashback table EMPLOYEES to before drop;
    select count(*) departments 
    from departments;
    select count(*) employees
    from employees;
    </copy>
    ```

    ![Undrop both the tables](../images/undrop-tables.png)

## Learn More

* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
