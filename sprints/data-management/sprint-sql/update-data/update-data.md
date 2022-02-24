# How to update data in a table in a database?

## Introduction

This lab walks you through the steps to update data in a table in a database.

Estimated Time: 2 minutes

### Objectives

In this lab, you will:

* Update data in a table in a database

### Prerequisites

* Have created departments and employees tables in a database and inserted records

## Task 1: Update data in a table

1. You can use SQL to update values in your table, to do this we will use the update clause.

    ```
    <copy>
    update employees
    set country_code = 'US';
    </copy>
    ```

    ![Update employees table](../images/update-emp-table.png)

2. The query above will update all rows of the employee table and set the value of country code to US. You can also selectively update just a specific row.

    ```
    <copy>
    update employees
    set commission = 2000
    where  name = 'Sam Smith';
    </copy>
    ```

    ![Update employees table](../images/update-emp-table2.png)

3. Lets run a Query to see what our data looks like

    ```
    <copy>
    select name, country_code, salary, commission
    from employees
    order by name;
    </copy>
    ```

    ![Select employees table](../images/select-emp-table.png)

## Learn More

* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)

## Acknowledgements

* **Contributor** - Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, February 2022