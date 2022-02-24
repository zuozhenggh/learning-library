# How to query a table in a database?

## Introduction

This lab walks you through the steps to query a table in a database.

Estimated Time: 2 minutes

### Objectives

In this lab, you will:

* Query a table in a database

### Prerequisites

* Have created departments and employees tables in a database and inserted records

## Task 1: Query data in a table

1. To select data from a single table it is reasonably easy, simply use the SELECT ... FROM ... WHERE ... ORDER BY ... syntax.

    ```
    <copy>
    select * from employees;
    </copy>
    ```

    ![Query employees table](../images/query-emp-table.png)

2. To query data from two related tables you can join the data

    ```
    <copy>
    select e.name employee,
           d.name department,
           e.job,
           d.location
    from departments d, employees e
    where d.deptno = e.deptno(+)
    order by e.name;
    </copy>
    ```

    ![Join query](../images/join-query.png)

3. As an alternative to a join you can use an inline select to query data.

    ```
    <copy>
    select e.name employee,
          (select name 
           from departments d 
           where d.deptno = e.deptno) department,
           e.job
    from employees e
    order by e.name;
    </copy>
    ```

    ![Inline select query](../images/inline-select-query.png)

## Learn More

* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
