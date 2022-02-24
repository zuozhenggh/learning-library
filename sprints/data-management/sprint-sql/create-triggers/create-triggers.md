# How to create triggers to a table in a database?

## Introduction

This lab walks you through the steps to create triggers to a table in a database.

Estimated Time: 2 minutes

### Objectives

In this lab, you will:

* Creating triggers to a table in a database

### Prerequisites

* Have created departments and employees tables in a database

## Task 1: Create triggers

Triggers are procedures that are stored in the database and are implicitly run, or fired, when something happens. Traditionally, triggers supported the execution of a procedural code, in Oracle procedural SQL is called a PL/SQL block. PL stands for procedural language. When an INSERT, UPDATE, or DELETE occurred on a table or view. Triggers support system and other data events on DATABASE and SCHEMA.

1. Triggers are frequently used to automatically populate table primary keys, the trigger examples below show an example trigger to do just this. We will use a built in function to obtain a globally unique identifier or GUID.

    ```
    <copy>
    create or replace trigger  DEPARTMENTS_BIU
        before insert or update on DEPARTMENTS
        for each row
    begin
        if inserting and :new.deptno is null then
            :new.deptno := to_number(sys_guid(), 
            'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        end if;
    end;
    /
    </copy>
    ```

    ![Create departments trigger](../images/create-dep-trigger.png)

    ```
    <copy>
    create or replace trigger EMPLOYEES_BIU
        before insert or update on EMPLOYEES
        for each row
    begin
        if inserting and :new.empno is null then
            :new.empno := to_number(sys_guid(), 
                'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        end if;
    end;
    /
    </copy>
    ```

    ![Create employees trigger](../images/create-emp-trigger.png)

## Learn More

* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)

## Acknowledgements

* **Contributor** - Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, February 2022