# Application Queries on a sharded Database

## Introduction   
Run each SQL query by logging in to the shard catalog database as well as one of the shard databases. You can observe the difference in row count on the shard catalog compared to the shard-database (porcl1cdb_porcl1pdb/ porcl2cdb_porcl2pdb/ porcl3cdb_porcl3pdb).

*Estimated Lab Time*: 20 Minutes

### Objectives
In this lab, you will:
* Try running your queries on already loaded data.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- SSH Private Key to access the host via SSH
- You have completed:
    - Lab: Generate SSH Keys (*Free-tier* and *Paid Tenants* only)
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

## **STEP 1**: Application Queries on sharding Database.

Run the below each sql query by login into Catalog database as well as one of the shard database. You can notice the difference of row count on Shard catalog vs shard-DB (porcl1cdb_porcl1pdb/ porcl2cdb_porcl2pdb/ porcl3cdb_porcl3pdb).

1. Top Selling Products: Return top Selling products in the store from last two months
 by fetching from LINE_ITEM (Relational ) & Products (JSON) & Reviews (JSON) Tables.

    ```
    <copy>
    select le.SKU,pr.Product_Name,le.count,le.SELL_VALUE,re.Avg_Senti_Score,rev.BEST_REVIEW from (select product_id as SKU, sum(PRODUCT_QUANTITY) as count,ROUND(sum(PRODUCT_COST*PRODUCT_QUANTITY),2) as SELL_VALUE from LINE_ITEM where DATE_ORDERED > sysdate -60 group by product_id ) le,(select r.sku as id,round(avg(r.senti_score)) as Avg_Senti_Score from reviews r group by r.sku) re,(select p.sku as pid,substr(p.json_text.NAME,0,30) as Product_Name from products p) pr,(select r.sku as rvid,r.revid,substr(r.json_text.REVIEW,0,40) as BEST_REVIEW from reviews r,(select sku as pid ,max(senti_score) as bestscore from reviews group by sku) where r.sku=pid and r.senti_score=bestscore) rev where re.id=le.SKU and pr.pid=le.SKU and rev.rvid=le.SKU order by 3 desc;
    </copy>
    ```

2. Text search on Products (JSON) table with auto corrections: Oracle Fuzzy matching is a method that provides an improved ability to process word-based matching queries to find matching phrases or sentences from a database.

    ```
    <copy>
    select p.json_text.NAME from PRODUCTS p where contains(json_text, 'fuzzy((sona))', 1) > 0 order by score(1) desc;
    </copy>
    ```

3. Dollor Value sale by month: A single query spanning from LINE_ITEM shard table by accessing multiple (3) shard databases.
   
    ```
    <copy>
    Select L.monthly,to_char(l.monthly,'MON') as month,sum(l.value) value from (select TRUNC(date_ordered, 'MON') as Monthly,Product_Cost*Product_Quantity as value, date_ordered from LINE_ITEM order by date_ordered asc) l where rownum <= 12 and :YEAR_SELECTED =to_char(l.monthly,'YYYY') group by l.monthly order by monthly asc;
    </copy>
    ```

4. Sentiment Percentage:    A single query spanning from REVIEWS shard table by accessing multiple shard databases.
   
    ```
    <copy>
    with pos as(select sum(senti_score) as positive_score from REVIEWS where senti_score > 0), neg as (select sum(senti_score) as negative_score from REVIEWS where senti_score <0),A as (select ABS(nvl(p.positive_score,0)) POSITIVE, ABS(nvl(n.negative_score,0)) NEGATIVE from pos p, neg n) select ROUND(POSITIVE/(POSITIVE+NEGATIVE) *100,2) as POS_PER, ROUND(NEGATIVE/(POSITIVE+NEGATIVE) *100,2) as NEG_PER from A;
    </copy>
    ```

5. Select products ordered by maximum sell

    ```
    <copy>
    select product_id as SKU, sum(PRODUCT_QUANTITY) as count,ROUND(sum(PRODUCT_COST*PRODUCT_QUANTITY),2) as SELL_VALUE from LINE_ITEM where DATE_ORDERED > sysdate -60 group by product_id order by count desc
    </copy>
    ```

6. Customer Average Review and review count

    ```
    <copy>
    select substr(p.json_text.NAME,0,40) NAME,p.json_text.CUSTOMERREVIEWAVERAGE as AVG_REV,p.json_text.CUSTOMERREVIEWCOUNT as REV_COUNT,SKU from PRODUCTS p where SKU in ('SKU1','SKU2')
    </copy>
    ```
7. Positive Review

    ```
    <copy>
    select sum(senti_score) as SCORE, rj.json_text.PRODUCT_ID from REVIEWS rj where senti_score>0 and json_value(rj.json_text, '$.PRODUCT_ID' returning VARCHAR2(64)) in ('SKU1','SKU2') group by rj.json_text.PRODUCT_ID
    </copy>
    ```

8. Negative Review

    ```
    <copy>
    select sum(senti_score) as SCORE, rj.json_text.PRODUCT_ID from REVIEWS rj where senti_score<=0 and json_value(rj.json_text, '$.PRODUCT_ID' returning VARCHAR2(64)) in ("+inClauseString+") group by rj.json_text.PRODUCT_ID
    </copy>
    ```


## Learn More

- [Oracle Sharding Documentation] (https://docs.oracle.com/en/database/oracle/oracle-database/19/shard/sharding-overview.html#GUID-0F39B1FB-DCF9-4C8A-A2EA-88705B90C5BF)

## Rate this Workshop
When you are finished don't forget to rate this workshop!  We rely on this feedback to help us improve and refine our LiveLabs catalog.  Follow the steps to submit your rating.

1.  Go back to your **workshop homepage** in LiveLabs by searching for your workshop and clicking the Launch button.
2.  Click on the **Brown Button** to re-access the workshop  

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/images/workshop-homepage-2.png " ")

3.  Click **Rate this workshop**

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/cloud-login/images/rate-this-workshop.png " ")

If you selected the **Green Button** for this workshop and still have an active reservation, you can also rate by going to My Reservations -> Launch Workshop.

## Acknowledgements
* **Authors** - Shailesh Dwivedi, Database Sharding PM , Vice President
* **Contributors** - Alex Kovuru, Nishant Kaushik, Ashish Kumar, Priya Dhuriya, Richard Delval, Param Saini,Jyoti Verma, Virginia Beecher, Rodrigo Fuentes
* **Last Updated By/Date** - Alex Kovuru, Principal Solution Engineer - June 2021
