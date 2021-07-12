# Loading data from object storage using Data Tools and the DBMS_CLOUD APIs

## Introduction

This lab takes you through the steps needed to link to, and load, data from the MovieStream data lake on Oracle Object Store into an Oracle autonomous database instance in preparation for exploration and analysis.

You can load data into your autonomous database (Autonomous Data Warehouse [ADW] or Autonomous Transaction Processing [ATP]) using Oracle Database tools, as well as Oracle and 3rd party data integration tools. You can load data:

+ from files in your local device,
+ from tables in remote databases, or
+ from files stored in cloud-based object storage (Oracle, S3, Azure, Google)

> **Note:** While this lab uses ADW, the steps are identical for loading data into an ATP database.

Estimated Time: 30 minutes

### Objectives <optional>


-   Learn how to define Object Store credentials for your autonomous database
-   Learn how to load data from the Object Store using Data Tools
-   Learn now to load data from the Object Store using the DBMS_CLOUD APIs executed from SQL


## **Step 1**: Configure the Object Storage Connection

1. In your ADW database's details page, click the Tools tab. Click **Open Database Actions**

	  ![Click on Tools, then Database Actions](images/launchdbactions.png)

2. On the login screen, enter the username MOVIEWORK, then click the blue **Next** button.

3. Enter the password for the MOVIEWORK user you set up in the previous lab.

4. Under **Data Tools**, click on **DATA LOAD**

    ![Click DATA LOAD](images/dataload.png)

5. In the **Explore and Connect** section, click on **CLOUD LOCATIONS** to set up the connection from your autonomous database to Object Store.

    ![Click CLOUD LOCATIONS](images/cloudlocations.png)

5. Click on **+Add Cloud Storage** in the top right of your screen.

-   In the **Name** field, enter 'MovieStreamDataLake'

> **Note:** Take care not to use spaces in the name.

-   Leave the Cloud Store selected as **Oracle**
-   Copy and paste the following URI into the URI + Bucket field:

> https://objectstorage.us-ashburn-1.oraclecloud.com/n/adwc4pm/b/moviestream_gold/o

-   Select **No Credential** as this is a public bucket
-   Click on the **Test** button to test the connection. Then click **Save**.


## **Step 2:** Load data from files in Object Storage

In this step we will perform some simple data loading tasks, to load in CSV files from Object Store into tables in our autonomous database.

1. To load or link data from our newly configured cloud storage, click on the **Data Load** link in the top left of your screen.

    ![Click on Data Load](images/backtodataload.png)

2. Under **What do you want to do with your data?** select **LOAD DATA**, and under **Where is your data?** select **CLOUD STORAGE**, then click **Next**

    ![Select Load Data, then Cloud Storage](images/loadfromstorage.png)

3. Expand the **customer**, **customer_segment**, and **genre** folders in the tree view on the left hand side and drag the following three files to the right hand pane:

-   customer.csv
-   customer_segment.csv
-   genre.csv

> **Note:** We will be loading files from the **movie** and **custsales** folders in later steps.

4. You will notice the target table names are derived from the folder and file names, but in this case we want to name the tables simply according to the file names. First, click on the pencil icon to edit the settings for the customer/customer.csv load task.

    ![Edit the load task for customer.csv](images/editcustomerload.png)

5. Rename the target table to **CUSTOMER**

    ![Change the target table name to CUSTOMER](images/custtablename.png)

6. In the Mapping section, we can see that the Data Load tool has guessed the target data types for the table. In this case, we want to change the target column type for the **POSTAL_CODE** column from NUMBER to VARCHAR2(4000).

    ![Change the column type for POSTAL_CODE](images/postalcodetype.png)

7. Click **Close** to close the settings editor.

8. Click on the pencil icon to edit the settings for the customer_segment/customer_segment.csv load task.

9. Rename the target table to **CUSTOMER_SEGMENT**. Then click **Close**.

10. Click on the pencil icon to edit the settings for the genre/genre.csv load task.

11. Rename the target table to **GENRE**. Then click **Close**.

12. Click on the Play button to run the data load job.

    ![Run the data load job](images/rundataload.png)

    The job should take about 30 seconds to run.

13. Check that all three data load tasks completed successfully, and have green tick icons next to them.

    ![Check the job is completed](images/loadcompleted.png)

## **Step 3:** Using Database APIs to load richer data files

In this step, we will use some of the additional features of the DBMS_CLOUD APIs to load in some files with differently structured data.

1.  Using the top left menu, navigate to **Development** > **SQL** to open a SQL Worksheet.

2.  Copy and paste the following script into the Worksheet. This script will create an external table **ext_custsales**, linking to the multiple parquet files in the **custsales** folder in Object Store.

```
define uri_gold = 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/adwc4pm/b/moviestream_gold/o'
define parquet_format = '{"type":"parquet",  "schema": "all"}'
 
begin
    dbms_cloud.create_external_table(
        table_name => 'ext_custsales',
        file_uri_list => '&uri_gold/custsales/*.parquet',
        format => '&parquet_format',
        column_list => 'MOVIE_ID NUMBER(20,0),
                        LIST_PRICE BINARY_DOUBLE,
                        DISCOUNT_TYPE VARCHAR2(4000 BYTE),
                        PAYMENT_METHOD VARCHAR2(4000 BYTE),
                        GENRE_ID NUMBER(20,0),
                        DISCOUNT_PERCENT BINARY_DOUBLE,
                        ACTUAL_PRICE BINARY_DOUBLE,
                        DEVICE VARCHAR2(4000 BYTE),
                        CUST_ID NUMBER(20,0),
                        OS VARCHAR2(4000 BYTE),
                        DAY date,
                        APP VARCHAR2(4000 BYTE)'
    ); 
end;
```

3.  Click on the **Run Script** button (or use the F5 key) to run the script.

    ![Run the script to load the ext_custsales table](images/custsalesscript.png)

    We now have a new **ext_cust_sales** table that links to the parquet files in our data lake on Object Store. We can work with this data directly in the autonomous database, but for the purposes of later labs, it is useful for us to copy this data over to **cust_sales** table. 

4.  To do this, click on the bin icon to clear the worksheet.

    ![Click on the bin icon](images/binicon.png)

    Then, copy and paste the following statement into the worksheet:

```
create table custsales as select * from ext_custsales;
```

5.  Click on the Run (or Run Script) button to run the statement.

6.  Next, we will create an external table to link to the **movies.json** file, then create a more structured table from this data, including a primary key and format constraints. To do this, click on the bin icon to clear the worksheet, then copy and paste the following script:

```
define uri_gold = 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/adwc4pm/b/moviestream_gold/o'
define json_format = '{"skipheaders":"0", "delimiter":"\n", "ignoreblanklines":"true"}'
begin
    dbms_cloud.create_external_table(
        table_name => 'ext_movie',
        file_uri_list => '&uri_gold/movie/movies.json',
        format => '&json_format',
        column_list => 'doc varchar2(30000)'
        );
end;
/  

create table movie as
select
    cast(m.doc.movie_id as number) as movie_id,
    cast(m.doc.title as varchar2(200 byte)) as title,   
    cast(m.doc.budget as number) as budget,
    cast(m.doc.gross as number) gross,
    cast(m.doc.list_price as number) as list_price,
    cast(m.doc.genre as varchar2(4000)) as genre,
    cast(m.doc.sku as varchar2(30 byte)) as sku,   
    cast(m.doc.year as number) as year,
    to_date(m.doc.opening_date, 'YYYY-MM-DD') as opening_date,
    cast(m.doc.views as number) as views,
    cast(m.doc.cast as varchar2(4000 byte)) as cast,
    cast(m.doc.crew as varchar2(4000 byte)) as crew,
    cast(m.doc.studio as varchar2(4000 byte)) as studio,
    cast(m.doc.main_subject as varchar2(4000 byte)) as main_subject,
    cast(m.doc.awards as varchar2(4000 byte)) as awards,
    cast(m.doc.nominations as varchar2(4000 byte)) as nominations,
    cast(m.doc.runtime as number) as runtime,
    substr(cast(m.doc.summary as varchar2(4000 byte)),1, 4000) as summary
from ext_movie m
where rownum < 10;
 
alter table movie add constraint pk_movie_cust_id primary key("MOVIE_ID");
alter table movie add CONSTRAINT movie_cast_json CHECK (cast IS JSON);
alter table movie add CONSTRAINT movie_genre_json CHECK (genre IS JSON);
alter table movie add CONSTRAINT movie_crew_json CHECK (crew IS JSON);
alter table movie add CONSTRAINT movie_studio_json CHECK (studio IS JSON);
alter table movie add CONSTRAINT movie_awards_json CHECK (awards IS JSON);
alter table movie add CONSTRAINT movie_nominations_json CHECK (nominations IS JSON);
```

7.  Click on the **Run Script** button to run the script.

8.  Next, we will use a similar script to create an external table, and then a table, from the pizza_locations.csv file in the landing area of our data lake. Click on the bin icon to clear the worksheet, then copy and paste the following script:

```
define uri_landing = 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/adwc4pm/b/moviestream_landing/o'
define csv_format = '{"dateformat":"YYYY-MM-DD", "skipheaders":"1", "delimiter":",", "ignoreblanklines":"true", "removequotes":"true", "blankasnull":"true", "trimspaces":"lrtrim", "truncatecol":"true", "ignoremissingcolumns":"true"}'
begin       
    dbms_cloud.create_external_table(
        table_name => 'ext_pizza_locations',
        file_uri_list => '&uri_landing/pizza-locations/*.csv',
        format => '&csv_format',
        column_list => 'PIZZA_LOC_ID NUMBER,
                        LAT NUMBER,
                        LON NUMBER,
                        CHAIN_ID NUMBER,
                        CHAIN VARCHAR2(30 BYTE),
                        ADDRESS VARCHAR2(250 BYTE),
                        CITY VARCHAR2(250 BYTE),
                        STATE VARCHAR2(26 BYTE),
                        POSTAL_CODE VARCHAR2(38 BYTE),
                        COUNTY VARCHAR2(250 BYTE)'
        ); 
end;
/

create table pizza_locations as select * from ext_pizza_locations;
```

9.  Click on the **Run Script** button to run the script.

10. Part of our later data analysis will require us to have a TIME table in the autonomous database. We can create this table with a few lines of SQL. Click on the bin icon to clear the worksheet, then copy and paste the following lines:

```
create table TIME as
SELECT TRUNC (to_date('20210101','YYYYMMDD')) as day
  FROM DUAL CONNECT BY ROWNUM < 732;  
```

11. Click on the **Run Script** button to run the script.

12. Now that we have all the data we need loaded into the database, it is useful to create some views on the data that we can use in later analysis. Click on the bin icon to clear the worksheet, then copy and paste the following script:

```
CREATE OR REPLACE VIEW v_custsales AS
SELECT
    cs.day,
    c.cust_id,
    c.last_name,
    c.first_name,
    c.city,
    c.state_province,
    c.country,
    c.continent,
    c.age,
    c.commute_distance,
    c.credit_balance,
    c.education,
    c.full_time,
    c.gender,
    c.household_size,
    c.income,
    c.income_level,
    c.insuff_funds_incidents,
    c.job_type,
    c.late_mort_rent_pmts,
    c.marital_status,
    c.mortgage_amt,
    c.num_cars,
    c.num_mortgages,
    c.pet,
    c.promotion_response,
    c.rent_own,
    c.work_experience,
    c.yrs_current_employer,
    c.yrs_customer,
    c.yrs_residence,
    c.loc_lat,
    c.loc_long,   
    cs.app,
    cs.device,
    cs.os,
    cs.payment_method,
    cs.list_price,
    cs.discount_type,
    cs.discount_percent,
    cs.actual_price,
    1 as transactions,
    s.short_name as segment,
    g.name as genre,
    m.title,
    m.budget,
    m.gross,
    m.genre as genre_list,
    m.sku,
    m.year,
    m.opening_date,
    m.cast,
    m.crew,
    m.studio,
    m.main_subject,
    nvl(json_value(m.awards,'$.size()'),0) awards,
    nvl(json_value(m.nominations,'$.size()'),0) nominations,
    m.runtime
FROM
    genre g, customer c, custsales cs, customer_segment s, movie m
WHERE
     cs.movie_id = m.movie_id
AND  cs.genre_id = g.genre_id
AND  cs.cust_id = c.cust_id
AND  c.segment_id = s.segment_id;
 
create materialized view mv_custsales
build immediate
refresh complete
as SELECT
    cs.day,
    c.cust_id,
    c.last_name,
    c.first_name,
    c.city,
    c.state_province,
    c.country,
    c.continent,
    c.age,
    c.commute_distance,
    c.credit_balance,
    c.education,
    c.full_time,
    c.gender,
    c.household_size,
    c.income,
    c.income_level,
    c.insuff_funds_incidents,
    c.job_type,
    c.late_mort_rent_pmts,
    c.marital_status,
    c.mortgage_amt,
    c.num_cars,
    c.num_mortgages,
    c.pet,
    c.promotion_response,
    c.rent_own,
    c.work_experience,
    c.yrs_current_employer,
    c.yrs_customer,
    c.yrs_residence,
    c.loc_lat,
    c.loc_long,   
    cs.app,
    cs.device,
    cs.os,
    cs.payment_method,
    cs.list_price,
    cs.discount_type,
    cs.discount_percent,
    cs.actual_price,
    1 as transactions,
    s.short_name as segment,
    g.name as genre,
    m.title,
    m.budget,
    m.gross,
    m.genre as genre_list,
    m.sku,
    m.year,
    m.opening_date,
    m.cast,
    m.crew,
    m.studio,
    m.main_subject,
    nvl(json_value(m.awards,'$.size()'),0) awards,
    nvl(json_value(m.nominations,'$.size()'),0) nominations,
    m.runtime
FROM
    genre g, customer c, custsales cs, customer_segment s, movie m
WHERE
     cs.movie_id = m.movie_id
AND  cs.genre_id = g.genre_id
AND  cs.cust_id = c.cust_id
AND  c.segment_id = s.segment_id;
  
alter table mv_custsales add CONSTRAINT cs_cast_json CHECK (cast IS JSON);
alter table mv_custsales add CONSTRAINT cs_crew_json CHECK (crew IS JSON);
alter table mv_custsales add CONSTRAINT cs_studio_json CHECK (studio IS JSON);
```

13. Click on the **Run Script** button to run the script and create the views.

This completes the Data Load lab. We now have a full set of structured tables and views loaded into the Autonomous Database from the MovieStream Data Lake. We will be working with these tables and views in later labs.


## Acknowledgements

* **Author** - <Mike Matthews, Autonomous Database Product Management>
* **Contributors** -  <Marty Gubar, Autonomous Database Product Management> 
* **Last Updated By/Date** - <Mike Matthews, Autonomous Database Product Management, July 2021>
