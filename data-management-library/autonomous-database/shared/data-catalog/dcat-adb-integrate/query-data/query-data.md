# Query Data Across ADB and the Data Lake

## Introduction

Estimated Time: 45 minutes

### Objectives

In this lab, you will:
* Query joined data from both the Data Warehouse and Object Storage.

### Prerequisites

This lab assumes you have:
* An Oracle account
* Completed all previous labs successfully

## Task 1: Query Data from the Data Warehouse and Object Storage

1. Query the customers information in the Data Warehouse.

    ```
    <copy>
    select *
    from Query the mer_contact
    where rownum < 10;
    </copy>
    ```

2. Query the 3rd party customers' information.

    ```
    <copy>
    select *
    from oci$phx_landing.customer_extension
    where rownum < 10;
    </copy>
    ```

3.  Query sales by genre across different customer attributes.

    ```
    <copy>
    with sales_breakout as (
        select c.income_level,
               c.gender,
               c.age,
               c.marital_status,
               c.education,
               c.job_type,
               case when c.household_size > 2 then 'Yes' else 'No' end as has_children,
               g.name as genre,
               actual_price actual_price
        from oci$phx_landing.customer_extension c, custsales s, genre g
        where c.cust_id = s.cust_id
        and s.genre_id = g.genre_id
        and c.age >= 20
        and c.age < 40
        );
    </copy>
    ```

    ```
    <copy>
    select genre, income_level, gender, age, marital_status, education, job_type, has_children, round(sum(actual_price)) sales, count(*) as watched
    from sales_breakout
    group by genre, income_level, age, marital_status, education, job_type, has_children, gender;
    </copy>
    ```

## Learn More

* [Using Oracle Autonomous Database on Shared Exadata Infrastructure](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/index.html)
* [Connect with Built-in Oracle Database Actions](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/sql-developer-web.html#GUID-102845D9-6855-4944-8937-5C688939610F)
* [DBMS_DCAT Package](https://docs-uat.us.oracle.com/en/cloud/paas/exadata-express-cloud/adbst/ref-dbms_dcat-package.html#GUID-4D927F21-E856-437B-B42F-727A2C02BE8D)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Get Started with Data Catalog](https://docs.oracle.com/en-us/iaas/data-catalog/using/index.htm)
* [Data Catalog Overview](https://docs.oracle.com/en-us/iaas/data-catalog/using/overview.htm)

## Acknowledgements
* **Author:** Lauran Serhal, Principal UA Developer, Oracle Database and Big Data User Assistance
* **Contributor:** Martin Gubar, Director, Product Management Autonomous Database / Cloud SQL    
* **Last Updated By/Date:** Lauran Serhal, September 2021
