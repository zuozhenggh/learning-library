# Query Data Across ADB and the Data Lake

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
