# How to index columns in a database?

## Introduction

This lab walks you through the steps to index columns in a database.

Estimated Time: 2 minutes

### Objectives

In this lab, you will:

* Index columns in a database

### Prerequisites

* Have created departments and employees tables in a database

## Task 1: Index columns

Typically developers index columns for three major reasons:
- To enforce unique values within a column
- To improve data access performance
- To prevent lock escalation when updating rows of tables that use declarative referential integrity

1. When a table is created and a PRIMARY KEY is specified an index is automatically created to enforce the primary key constraint. If you specific UNIQUE for a column when creating a column a unique index is also created. To see the indexes that already exist for a given table you can run the following dictionary query.

    ```
    <copy>
    select table_name "Table", 
        index_name "Index", 
        column_name "Column", 
        column_position "Position"
    from  user_ind_columns 
    where table_name = 'EMPLOYEES' or 
        table_name = 'DEPARTMENTS'
    order by table_name, column_name, column_position
    </copy>
    ```

    ![Dictionary query](../images/dictionary-query.png)

2. It is typically good form to index foreign keys, foreign keys are columns in a table that reference another table. In our EMPLOYEES and DEPARTMENTS table example the DEPTNO column in the EMPLOYEE table references the primary key of the DEPARTMENTS table.

    ```
    <copy>
    create index employee_dept_no_fk_idx 
    on employees (deptno)
    </copy>
    ```

    ![Create index](../images/create-index.png)

3. We may also determine that the EMPLOYEE table will be frequently searched by the NAME column. To improve the performance searches and to ensure uniqueness we can create a unique index on the EMPLOYEE table NAME column.

    ```
    <copy>
    create unique index employee_ename_idx
    on employees (name)
    </copy>
    ```

    ![Create unique index](../images/create-unique-index.png)

    Oracle provides many other indexing technologies including function based indexes which can index expressions, such as an upper function, text indexes which can index free form text, bitmapped indexes useful in data warehousing. You can also create indexed organized tables, you can use partition indexes and more. Sometimes it is best to have fewer indexes and take advantage of in memory capabilities. All of these topics are beyond the scope of this basic introduction.

## Learn More

* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)

## Acknowledgements

* **Contributor** - Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, February 2022