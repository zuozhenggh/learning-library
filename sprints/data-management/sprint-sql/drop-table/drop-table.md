# How to drop a table in a database?

## Introduction

This lab walks you through the steps to drop a table in a database.

Estimated Time: 1 minute

### Objectives

In this lab, you will:

* Drop a table in a database

### Prerequisites

* Have created departments and employees tables in a database

## Task 1: Drop a table

1. You can drop tables using the SQL DROP command. Dropping a table will remove all of the rows and drop sub-objects including indexes and triggers. The following DROP statements will drop the departments and employees tables. The optional cascade constraints clause will drop remove constraints thus allowing you to drop database tables in any order.

    ```
    <copy>
    drop table departments cascade constraints;
    drop table employees cascade constraints;
    </copy>
    ```

    ![Drop both employees and departments tables](../images/drop-tables.png)

## Learn More

* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
