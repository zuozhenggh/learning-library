# How to write aggregate queries on table in a database?

## Introduction

This lab walks you through the steps to write aggregate queries on table in a database.

Estimated Time: 1 minute

### Objectives

In this lab, you will:

* Write aggregate queries on table in a database

### Prerequisites

* Have created departments and employees tables in a database and inserted records

## Task 1: Aggregate queries

1. You can sum data in tables using aggregate functions. We will use column aliases to rename columns for readability, we will also use the null value function (NVL) to allow us to properly sum columns with null values.

    ```
    <copy>
    select 
      count(*) employee_count,
      sum(salary) total_salary,
      sum(commission) total_commission,
      min(salary + nvl(commission,0)) min_compensation,
      max(salary + nvl(commission,0)) max_compensation
    from employees;
    </copy>
    ```

    ![Aggregate query](../images/aggregate-query.png)

## Learn More

* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)

## Acknowledgements

* **Contributor** - Anoosha Pilli, Product Manager
* **Last Updated By/Date** - Anoosha Pilli, February 2022