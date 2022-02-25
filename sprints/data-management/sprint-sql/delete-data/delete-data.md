# How to delete data in a table in a database?

## Introduction

This lab walks you through the steps to delete data in a table in a database.

Estimated Time: 1 minute

### Objectives

In this lab, you will:

* Delete data in a table in a database

### Prerequisites

* Have created departments and employees tables in a database and inserted records

## Task 1: Delete data in a table

1. You can delete one or more rows from a table using the DELETE syntax. For example to delete a specific row:

    ```
    <copy>
    delete from employees 
    where name = 'Sam Smith';
    </copy>
    ```

    ![Delete data in employees table](../images/delete-data-emp-table.png)

## Learn More

* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
