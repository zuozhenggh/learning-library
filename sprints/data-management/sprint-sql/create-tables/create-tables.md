# How to create tables in a database?

## Introduction

This lab walks you through the steps to create tables in a database.

Estimated Time: 2 minutes

### Objectives

In this lab, you will:

* Creating tables in a database

## Task 1: Create tables

Tables are the basic unit of data storage in an Oracle Database. Data is stored in rows and columns. You define a table with a table name, such as employees, and a set of columns. You give each column a column name, such as employee\_id, last\_name, and job\_id; a datatype, such as VARCHAR2, DATE, or NUMBER; and a width. The width can be predetermined by the datatype, as in DATE. If columns are of the NUMBER datatype, define precision and scale instead of width. A row is a collection of column information corresponding to a single record.

1. You can specify rules for each column of a table. These rules are called integrity constraints. One example is a NOT NULL integrity constraint. This constraint forces the column to contain a value in every row.

    For example:

    ```
    <copy>
    create table DEPARTMENTS (  
        deptno        number,  
        name          varchar2(50) not null,  
        location      varchar2(50),  
        constraint pk_departments primary key (deptno)  
    );
    </copy>
    ```

    ![Create departments table](../images/create-dep-table.png)

2. Tables can declarative specify relationships between tables, typically referred to as referential integrity. To see how this works we can create a "child" table of the DEPARTMENTS table by including a foreign key in the EMPLOYEES table that references the DEPARTMENTS table. For example:

    ```
    <copy>
    create table EMPLOYEES (  
        empno             number,  
        name              varchar2(50) not null,  
        job               varchar2(50),  
        manager           number,  
        hiredate          date,  
        salary            number(7,2),  
        commission        number(7,2),  
        deptno           number,  
        constraint pk_employees primary key (empno),  
        constraint fk_employees_deptno foreign key (deptno) 
            references DEPARTMENTS (deptno)  
    );
    </copy>
    ```

    ![Create employees table](../images/create-emp-table.png)

    Foreign keys must reference primary keys, so to create a "child" table the "parent" table must have a primary key for the foreign key to reference.

## Learn More

* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)

## Acknowledgements

* **Contributor** - Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, February 2022