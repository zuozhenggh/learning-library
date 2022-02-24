# How to insert data into a table in a database?

## Introduction

This lab walks you through the steps to insert data into a table in a database.

Estimated Time: 2 minutes

### Objectives

In this lab, you will:

* Insert data into a table in a database

### Prerequisites

* Have created departments and employees tables in a database

## Task 1: Insert data into a table

1. Now that we have tables created, and we have triggers to automatically populate our primary keys, we can add data to our tables. Because we have a parent child relationship, with the DEPARTMENTS table as the parent table, and the EMPLOYEES table as the child we will first INSERT a row into the DEPARTMENTS table.

    ```
    <copy>
    insert into departments (name, location) values
        ('Finance','New York');

    insert into departments (name, location) values
        ('Development','San Jose');
    </copy>
    ```

    ![Insert records into departments table](../images/insert-dep-records.png)

2. Lets verify that the insert was successful by running a SQL SELECT statement to query all columns and all rows of our table.

    ```
    <copy>
    select * from departments;
    </copy>
    ```

    ![Query departments table](../images/query-dep-table.png)

3. You can see that an ID will have been automatically generated. You can now insert into the EMPLOYEES table a new row but you will need to put the generated DEPTID value into your SQL INSERT statement. The examples below show how we can do this using a SQL query, but you could simply enter the department number directly.

    ```
    <copy>
    insert into EMPLOYEES 
        (name, job, salary, deptno) 
        values
        ('Sam Smith','Programmer', 
            5000, 
        (select deptno 
        from departments 
        where name = 'Development'));

    insert into EMPLOYEES 
        (name, job, salary, deptno) 
        values
        ('Mara Martin','Analyst', 
        6000, 
        (select deptno 
        from departments 
        where name = 'Finance'));

    insert into EMPLOYEES 
        (name, job, salary, deptno) 
        values
        ('Yun Yates','Analyst', 
        5500, 
        (select deptno 
        from departments 
        where name = 'Development'));
    </copy>
    ```

    ![Insert records into employees table](../images/insert-emp-records.png)

## Learn More

* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
