# Analyze movie sales data

## Introduction
In this lab, you will learn many of the basics for analyzing data across multiple tables. This includes using views to simplify sophisticated queries, performing time series analyses and more.

Estimated time: 10 minutes

### Objectives

- Understand how to use SQL Worksheet

- Perform time series analyses

- Calculate rankings and shares

- Bin customers by key metrics

### Prerequisites
- This lab requires completion of Labs 1 and 2 in the Contents menu on the left.

## Task 1: Log into the SQL Worksheet
Make sure you are logged into Autonomous Database's **Database Tools** as the MOVIESTREAM user.   

1. Navigate to the Details page of the Autonomous Database you provisioned in the "Provision an ADW Instance" lab. In this example, the database name is "My Quick Start ADW." Launch **Database Actions** by clicking the **Tools** tab and then click **Open Database Actions**.

    ![Details page of your Autonomous Database](images/2878884319.png " ")

2. Enter MOVIESTREAM for the username and click **Next**. On the next form, enter the MOVIESTREAM password - which is the one you entered when creating your MOVIESTREAM user. Click **Sign in**.

    ![Log in dialog for Database Actions](images/login-moviestream.png " ")

3. In the Development section of the Database Actions page, click the SQL card to open a new SQL worksheet:

    ![Go to SQL worksheet](images/sql-card.png " ")

4. Enter your commands in the worksheet. You can use the shortcuts [Control-Enter] or [Command-Enter] to run the command and view the Query Result (tabular format). Clear your worksheet by clicking the trash:

    ![Go to SQL worksheet](images/sql-worksheet.png " ")

You are now ready to start analyzing MovieStream's performance using SQL.

## Task 2: Prepare the data warehouse schema
The MovieStream data warehouse uses an design approach called a 'star schema'. A star schema is characterized by one or more very large fact tables that contain the primary information in the data warehouse and a number of much smaller dimension tables (or lookup tables), each of which contains information about the entries for a particular attribute in the fact table.


![A simple data warehouse star schema.](images/star.png)

The main advantages of star schemas are that they:

* Offer a direct and intuitive mapping between the business entities being analyzed by end users and the schema design.</li>
* Offer highly optimized performance for typical data warehouse queries.</li>

One of the key dimensions in the MovieStream data warehouse is **TIME**. Currently the time dimension table has a single column containing just the ids for each day. When doing type data warehouse analysis there is a need to view data across different levels within the time dimension such as week, month, quarter, and year. Therefore we need to expand the current time dimension to include these additional levels.

1. View the time dimension table.

    ```
    <copy>
    SELECT
    *  
    FROM time;</copy>
    ```

> **Note:** The TIME dimension table has a typical calendar hierarchy where days aggregate to weeks, months, quarters and years.

Querying a data warehouse can involve working with a lot of repetitive SQL. This is where 'views' can be very helpful and very powerful. The code below is used to simplify the queries used throughout this workshop. The main focus here is to introduce the concept of joining tables together to returned a combined resultset.

The code below uses a technique called **INNER JOIN** to join the dimension tables to the fact table.

2. Creating a view that joins the GENRE, CUSTOMER and TIME dimension tables with the main fact table CUSTSALES.

    >**Note**: For copy/pasting, be sure to click the convenient Copy button in the upper right corner of the following code snippet, and all subsequent code snippets:

    ```
    <copy>CREATE OR REPLACE VIEW vw_movie_sales_fact AS
    SELECT
    m.day_id,
    t.day_name,
    t.day_dow,
    t.day_dom,
    t.day_doy,
    t.week_wom,
    t.week_woy,
    t.month_moy,
    t.month_name,
    t.month_aname,  
    t.quarter_name,  
    t.year_name,  
    c.cust_id as customer_id,
    c.state_province,
    c.country,
    c.continent,
    g.name as genre,
    m.app,
    m.device,
    m.os,
    m.payment_method,
    m.list_price,
    m.discount_type,
    m.discount_percent,
    m.actual_price,
    m.genre_id,
    m.movie_id
    FROM custsales m
    INNER JOIN time t ON m.day_id = t.day_id
    INNER JOIN customer c ON m.cust_id = c.cust_id
    INNER JOIN genre g ON m.genre_id = g.genre_id;
    </copy>
    ```

There are lots of different types of joins you can use within a SQL query to combine rows from one table with rows in another table. Typical examples are:

### A) INNER JOIN
An inner join, which is sometimes called a simple join, is a join of two or more tables that returns only those rows that satisfy the join condition. In the example above, only rows in the sales fact table will be returned where a corresponding row for day exists in the time dimension table and a corresponding row exists in the customer dimension table and a corresponding row exists in the genre dimension table.

### B) OUTER JOIN
An outer join extends the result of a simple join. An outer join returns all rows that satisfy the join condition and also returns some or all of those rows from one table for which no rows from the other satisfy the join condition. This join technique is often used with time dimension tables since you will typically want to see all months or all quarters within a given year even if there were no sales for a specific time period. There is an example of this type of join in the next task.

## Task 3: Learn more about joins
In the previous SQL code we used an inner join to merge time, customer and genre dimensional data with the sales data. However, inner joins ignore rows in the dimension tables where there is no corresponding sales data. This means that some queries may need to use a different join method if you want to gain a deeper understanding of your sales data. Consider the following example:

1. How many news category films were viewed in 2020?

    ```
    <copy>SELECT
        g.name,
        count(m.genre_id)
    FROM (SELECT genre_id FROM vw_movie_sales_fact  WHERE year_name = '2020') m
    INNER JOIN genre g ON m.genre_id = g.genre_id
    GROUP BY g.name
    order by 1;</copy>
    ```

    The result will look like this:

    |NAME|COUNT(M.GENRE_ID)|
    |---|---|
    |Action|1629149|
    |Adventure|1088422|
    |Animation|109517|
    |Biography|187264|
    |Comedy|1104148|
    |Crime|416139|
    |Documentary|22608|
    |Drama|2488106|
    |Family|609975|
    |Fantasy|860680|
    |Film-Noir|117250|
    |History|51441|
    |Horror|671819|
    |Lifestyle|17327|
    |Musical|336557|
    |Mystery|190321|
    |Reality-TV|8290|
    |Romance|749525|
    |Sci-Fi|793888|
    |Sport|24646|
    |Thriller|909956|
    |Unknown|11814|
    |War|191657|
    |Western|45668|

    Unless you had a detailed knowledge of all the available genres you would probably miss the fact that there is no row shown for the genre "News" because there were no purchases of movies within this genre during 2020. This type of analysis requires a technique that is often called "densification." This means that all the rows in a dimension table are returned even when no corresponding rows exist in the fact table. To achieve data densification we use an OUTER JOIN in the SQL query. Compare the above result with the next query.

2. Modify the above SQL to use an outer join:

    ```
    <copy>SELECT
        g.name,
        count(m.genre_id)
    FROM (SELECT genre_id FROM vw_movie_sales_fact WHERE year_name = '2020') m
    FULL OUTER JOIN genre g ON m.genre_id = g.genre_id
    GROUP BY g.name
    order by 1;</copy>
    ```

    The result will now look like this, where we can now see how many news category films were viewed in 2020:

    |NAME|COUNT(M.GENRE_ID)|
    |---|---|
    |Action|1629149|
    |Adventure|1088422|
    |Animation|109517|
    |Biography|187264|
    |Comedy|1104148|
    |Crime|416139|
    |Documentary|22608|
    |Drama|2488106|
    |Family|609975|
    |Fantasy|860680|
    |Film-Noir|117250|
    |History|51441|
    |Horror|671819|
    |Lifestyle|17327|
    |Musical|336557|
    |Mystery|190321|
    |News|0|
    |Reality-TV|8290|
    |Romance|749525|
    |Sci-Fi|793888|
    |Sport|24646|
    |Thriller|909956|
    |Unknown|11814|
    |War|191657|
    |Western|45668|

    > **Note**: there is now a row for the genre "News" in the results table which shows that no news genre films were watched during 2020. When creating your own queries you will need to think carefully about the type of join needed to create the resultset you need. For the majority of examples in this workshop the JOIN requirements have been captured in the sales view created above. Now that we have our time dimension defined as a view and a view to simplify SQL queries against the fact table, we can move on to how SQL can help us explore the sales data.


## Task 4: Explore sales data with fast performance

1. Next, let's use a very simple query to look at total movie sales by year and quarter, which extends the earlier simple SQL queries by adding a GROUP BY clause.

    ```
    <copy>SELECT
    year_name,
    quarter_name,
    SUM(actual_price)
    FROM vw_movie_sales_fact
    WHERE year_name = '2020'
    GROUP BY year_name, quarter_name
    ORDER BY 1,2;</copy>
    ```
    **Note**: In this query, we have returned a resultset where the data has been aggregated (or grouped by) year then, within year, by quarter. The ORDER BY clause sorts the resultset by year and then quarter. In addition there is a filter or WHERE clause that enables us to return only data for the year 2020.    

    This should return something similar to the following:

    |YEAR_NAME|QUARTER_NAME|SUM(ACTUAL_PRICE)|
    |---|---|---|
    |2020|Q1-2020|4888603.6299999645|
    |2020|Q2-2020|6207591.609999965|
    |2020|Q3-2020|5094875.069999959|
    |2020|Q4-2020|5361403.959999974|

    *elapsed: 1.315s*

    Note the time taken to run your query. In the above example, this was 1.315 seconds to run (*when you run your query the timing may vary slightly*).

2. Now simply run the query again

    |YEAR_NAME|QUARTER_NAME|SUM(ACTUAL_PRICE)|
    |---|---|---|
    |2020|Q1-2020|4888603.6299999645|
    |2020|Q2-2020|6207591.609999965|
    |2020|Q3-2020|5094875.069999959|
    |2020|Q4-2020|5361403.959999974|

    *elapsed: 0.026*

    This time the query ran much faster, taking just 0.026 seconds! So what happened?

    When we executed the query the first time, Autonomous Data Warehouse executed the query against our movie sales table and scanned all the rows. It returned the result of our query to our worksheet and then it stored the result in something called a **result cache**. When we then ran the same query again, Autonomous Data Warehouse simply retrieved the result from its result cache! No need to scan all the rows again. This saved a lot of time and saved us money because we used hardly any compute resources.


## Task 5: Compare sales to last year

### Overview

Time comparisons are one of the most common types of analyses. MovieStream has just completed sales for December. What is the year over year comparison for this latest month? What is this breakout by movie genre? Oracle SQL has a **LAG** function that facilitates these types of analyses.  

1. Let's start by looking at sales in December for the latest two years for our major genres (we can use an INNER JOIN because there is always a current and previous year value):

    ```
    <copy>SELECT 
        g.name as genre,
        TO_CHAR(c.day_id,'YYYY-MM') as month,
        ROUND(sum(c.actual_price),0) sales
    FROM  custsales c, genre g
    WHERE g.genre_id = c.genre_id
      AND to_char(c.day_id, 'MON') in ('DEC')
      AND g.name in ('Action','Drama','Comedy')
    GROUP BY to_char(c.day_id,'YYYY-MM'), c.genre_id, g.name
    ORDER BY genre, month;</copy>
    ```

    This produces the following result:

    |GENRE|MONTH|SALES|
    |---|---|---|
    |Action|2019-12|320577|
    |Action|2020-12|280191|
    |Comedy|2019-12|183968|
    |Comedy|2020-12|169859|
    |Drama|2019-12|295584|
    |Drama|2020-12|369497|


2. The **LAG** function will allow us to compare this year vs last (or any other time comparison). In addition, we are going to leverage the SQL **WITH** clause. The **WITH** clause allows you to define in-line views - which greatly simplifies your queries. We'll be using these in-line views as "query blocks" - or named result sets that can be easily referenced. Here, we're using the **WITH** clause to set up the comparison to last year.

    ```
    <copy>WITH sales_vs_lastyear as (
    SELECT 
        g.name as genre,
        TO_CHAR(c.day_id,'YYYY-MM') as month,
        ROUND(SUM(c.actual_price),0) as sales,
        LAG(ROUND(SUM(c.actual_price),0), 1) OVER (
                PARTITION BY g.name
                ORDER BY to_char(c.day_id,'YYYY-MM') ASC
            ) as last_year         
    FROM custsales c, genre g
    WHERE g.genre_id = c.genre_id
    AND to_char(c.day_id, 'MON') in ('DEC')
    AND g.name in ('Action','Drama','Comedy')
    GROUP BY TO_CHAR(c.day_id,'YYYY-MM'), c.genre_id, g.name
    ORDER BY genre, month
    )
    SELECT 
        genre, 
        sales as sales,
        last_year as last_year,
        sales - last_year as change
    FROM  sales_vs_lastyear
    WHERE last_year is not null
    ORDER BY round(last_year - sales) DESC;</copy>
    ```
    
    The subquery **sales\_vs\_lastyear** aggregates sales by genre and month for both this year and last. The subquery is then used by the SELECT statement that calculates the sales change. 

    You can see that Adventure and Action movies have shown strong a significant drop off. This drop off was more than offset by a large increase in Drama movies:

    |GENRE|SALES|LAST_YEAR|CHANGE|
    |---|---|---|---|
    |Action|280191|320577|-40386|
    |Comedy|169859|183968|-14109|
    |Drama|369497|295584|73913|

## Task 6: Understanding sales contributions

### Overview

Drama sales are up; Action sales are down. How significant are these genres to MovieStream's success? And, which movies are important contributors within these genres?  We're going to find out.  

When customers select a movie to watch, they pick from a "shelf" that is broken out by genre. A movie may be an adventure/comedy (and the movie table contains these details) - but the customer selected a movie via a specific genre - and this genre is captured in the sales data.

1. Let's begin by looking at movie sales by genre.

    ```
    <copy>WITH sales_by_genre as (
    SELECT
        g.name as genre,
        m.title,
        round(sum(c.actual_price),0) as sales        
    FROM movie m, custsales c, genre g
    WHERE m.movie_id = c.movie_id
    AND c.genre_id = g.genre_id
    GROUP BY g.name, m.title
    )
    SELECT 
        genre, 
        title,  
        sales
    FROM sales_by_genre
    ORDER BY sales desc
    FETCH FIRST 20 ROWS ONLY;</copy>
    ```
 
    Here are the top genre-movie combinations:

    |GENRE|TITLE|SALES|
    |---|---|---|
    |Action|Avengers: Endgame|327423|
    |Sci-Fi|Captain Marvel|298493|
    |Adventure|Avengers: Endgame|289171|
    |Sci-Fi|Spider-Man: Far from Home|248109|
    |Action|Captain Marvel|240827|
    |Adventure|Captain Marvel|239246|
    |Fantasy|Aquaman|212570|
    |Action|Spider-Man: Far from Home|209282|
    |Adventure|Spider-Man: Far from Home|208749|
    |Action|Aquaman|196869|
    |Sci-Fi|Aquaman|191586|
    |Adventure|Aquaman|177126|
    |Family|The Lion King|168251|
    |Animation|The Lion King|161655|
    |Action|Avengers: Infinity War|150931|
    |Sci-Fi|Avengers: Infinity War|149532|
    |Family|Aladdin|142674|
    |Action|Venom|140091|
    |Drama|Room|138024|
    |Drama|The Lion King|137991|

    There are clearly movies - like Aquaman - that are popular across genres.

2. We'll now focus on three of MovieStream's most important genres: Drama, Action and Comedies. What are the top 20 genre/movie combinations? We are going to use the RANK function to help with this analysis:

    ```
    <copy>WITH sales_grouping as (
        SELECT
            g.name as genre,
            m.title as movie,
            round(sum(c.actual_price),0) as sales
        FROM movie m, custsales c, genre g
        WHERE m.movie_id = c.movie_id
        AND c.genre_id = g.genre_id
        AND g.name IN ('Drama','Action','Comedy')
        GROUP BY g.name, m.title
    )
    SELECT 
        genre,
        movie,
        sales,
        RANK () OVER ( order by sales desc ) as ranking
    FROM sales_grouping
    FETCH FIRST 20 ROWS ONLY;</copy>
    ```
    The result is shown below:

    |GENRE|MOVIE|SALES|RANKING|
    |---|---|---|---|
    |Action|Avengers: Endgame|327423|1|
    |Action|Captain Marvel|240827|2|
    |Action|Spider-Man: Far from Home|209282|3|
    |Action|Aquaman|196869|4|
    |Action|Avengers: Infinity War|150931|5|
    |Action|Venom|140091|6|
    |Drama|Room|138024|7|
    |Drama|The Lion King|137991|8|
    |Action|Aladdin|130577|9|
    |Drama|The Godfather|127420|10|
    |Action|Avatar|120613|11|
    |Action|Spider-Man: Homecoming|117223|12|
    |Action|Batman v Superman: Dawn of Justice|111758|13|
    |Comedy|Spider-Man: Homecoming|111384|14|
    |Action|The Incredibles|103692|15|
    |Drama|The Ten Commandments|102949|16|
    |Drama|Deadpool 2|101739|17|
    |Drama|Boogie Nights|101569|18|
    |Action|Gladiator|101229|19|
    |Drama|Jaws|101181|20|

3. Okay, we know the top 20 genre/movie combinations - but it's not quite what we want. Let's refine the query to show the top movies WITHIN each genre. The RANK's **PARTITION BY** clause will enable this type of grouping:

    ```
    <copy>WITH sales_grouping as (
        SELECT
            g.name as genre,
            m.title as movie,
            round(sum(c.actual_price),0) as sales
        FROM movie m, custsales c, genre g
        WHERE m.movie_id = c.movie_id
        AND c.genre_id = g.genre_id
        AND g.name in ('Drama','Action','Comedy')
        GROUP BY g.name, m.title
    ),
    movie_ranking_by_genre as (
        SELECT 
            genre,
            movie,
            sales,
            RANK () OVER ( PARTITION BY genre ORDER BY sales DESC ) as ranking
        FROM sales_grouping
    )
    SELECT * 
    FROM movie_ranking_by_genre
    WHERE ranking <= 5
    ORDER BY genre ASC, ranking ASC;</copy>
    ```
    We can now see the most important movies for each genre:

    |GENRE|MOVIE|SALES|RANKING|
    |---|---|---|---|
    |Action|Avengers: Endgame|327423|1|
    |Action|Captain Marvel|240827|2|
    |Action|Spider-Man: Far from Home|209282|3|
    |Action|Aquaman|196869|4|
    |Action|Avengers: Infinity War|150931|5|
    |Comedy|Spider-Man: Homecoming|111384|1|
    |Comedy|Chef|100777|2|
    |Comedy|Deadpool 2|96248|3|
    |Comedy|Lady Bird|91200|4|
    |Comedy|Jumanji: Welcome to the Jungle|76383|5|
    |Drama|Room|138024|1|
    |Drama|The Lion King|137991|2|
    |Drama|The Godfather|127420|3|
    |Drama|The Ten Commandments|102949|4|
    |Drama|Deadpool 2|101739|5|

 4. But, what is each movie's contribution to its genre? To answer this question, we need to make one more update. The **ROLLUP** function in the **GROUP BY** adds summaries (subtotals and grandtotals) for each grouping. Note, you can put the **ROLLUP** clause in different parts of the query to achieve different results. For example, do you want to see the movie's sales contribution across the total genre sales (add the ROLLUP to the subquery)? Or, its contribution based on the current selection.  Below displays the contribution for the current selection:

    ```
    <copy>WITH sales_grouping as (
        SELECT
            g.name as genre,
            m.title as movie,
            round(sum(c.actual_price),0) as sales
        FROM movie m, custsales c, genre g
        WHERE m.movie_id = c.movie_id
        AND c.genre_id = g.genre_id
        AND g.name IN ('Drama','Action','Comedy')
        GROUP BY g.name, m.title
        ),
        movie_ranking_by_genre as (
            SELECT
                genre,
                movie,
                sales,
                RANK () OVER ( partition by genre order by sales desc ) as ranking
            FROM sales_grouping
        )
        SELECT genre,
            movie,
            SUM(sales),
            ROUND(RATIO_TO_REPORT (SUM(sales)) OVER (PARTITION BY genre), 2) * 2 as ratio
        FROM movie_ranking_by_genre
        WHERE ranking <= 5
        GROUP BY ROLLUP(genre, movie)
        ORDER BY 1 ASC, 3 DESC;</copy>
    ```
    Here's the top movies within each genre and its contribution:

    |GENRE|MOVIE|SUM(SALES)|RATIO|
    |---|---|---|---|
    |Action|null|1125332|1|
    |Action|Avengers: Endgame|327423|0.3|
    |Action|Captain Marvel|240827|0.22|
    |Action|Spider-Man: Far from Home|209282|0.18|
    |Action|Aquaman|196869|0.18|
    |Action|Avengers: Infinity War|150931|0.14|
    |Comedy|null|475992|1|
    |Comedy|Spider-Man: Homecoming|111384|0.24|
    |Comedy|Chef|100777|0.22|
    |Comedy|Deadpool 2|96248|0.2|
    |Comedy|Lady Bird|91200|0.2|
    |Comedy|Jumanji: Welcome to the Jungle|76383|0.16|
    |Drama|null|608123|1|
    |Drama|Room|138024|0.22|
    |Drama|The Lion King|137991|0.22|
    |Drama|The Godfather|127420|0.2|
    |Drama|The Ten Commandments|102949|0.16|
    |Drama|Deadpool 2|101739|0.16|
    |null|null|2209447|2|

Notice, we also added the **RATIO\_TO\_REPORT** analytic function in order to compute the movie's contribution to the total within the report.

## Task 7: Finding Our Most Important Customers

### Overview
This final example will enrich our existing understanding of customer behavior by utilizing an RFM analysis. RFM is a very commonly used method for analyzing customer value. It is commonly used in general customer marketing, direct marketing, and retail sectors.

In the following steps, the scripts will build a SQL query that will identify:

- Recency: when was the last time the customer accessed the site?

- Frequency: what is the level of activity for that customer on the site?

- Monetary: how much money has the customer spent?

Customers will be categorized into 5 buckets measured (using the NTILE function) in increasing importance. For example, an RFM combined score of 551 indicates that the customer is in the highest tier of customers in terms of recent visits (R=5) and activity on the site (F=5), however the customer is in the lowest tier in terms of spend (M=1). Perhaps this is a customer that performs research on the site, but then decides to buy movies elsewhere!

1.  Binning customers' sales by value

    Use the following query to segment customers into 5 distinct bins based on the value of their purchases:

    ```
    <copy>SELECT
        m.cust_id,
        c.first_name||' '||c.last_name as cust_name,
        c.country,
        c.gender,
        c.age,
        c.income_level,
        NTILE (5) OVER (ORDER BY SUM(m.actual_price)) AS rfm_monetary
    FROM custsales m
    INNER JOIN customer c ON c.cust_id = m.cust_id
    GROUP BY m.cust_id,
        c.first_name||' '||c.last_name,
        c.country,
        c.gender,
        c.age,
        c.income_level
    ORDER BY m.cust_id,
    c.first_name||' '||c.last_name,
    c.country,
    c.gender,
    c.age,
    c.income_level;</copy>
    ```
    Below is a snapshot of the result (and your result may differ):
    |CUST_ID|CUST_NAME|COUNTRY|GENDER|AGE|INCOME_LEVEL|RFM_MONETARY|
    |---|---|---|---|---|---|---|
    |1000001|Tamara Angermeier|Mexico|Female|59|B: 30,000 - 49,999|4|
    |1000004|Gaik-Hong Pouzade|Mexico|Female|53|B: 30,000 - 49,999|4|
    |1000007|Perryn Koleyan|Mexico|Male|23|C: 50,000 - 69,999|5|
    |1000010|Tatiana Sanu|Mexico|Female|66|D: 70,000 - 89,999|2|
    |1000013|Bryan Primeau|Mexico|Male|43|B: 30,000 - 49,999|4|
    |1000015|Kung-Zheng Artamova|Mexico|Male|65|A: Below 30,000|3|
    |1000017|Bandhura Höhne|Mexico|Female|50|A: Below 30,000|3|
    |1000021|Akara Papaz|Mexico|Male|66|A: Below 30,000|1|
    |1000022|Asma Pollini|Mexico|Male|28|A: Below 30,000|2|
    |1000025|Lonan Sergeyev|Mexico|Male|34|C: 50,000 - 69,999|5|
    |1000027|Ernesto Preetish|Mexico|Male|55|A: Below 30,000|2|
    |1000028|Iliona Gallois|Mexico|Female|45|A: Below 30,000|4|
    |1000029|Gisella De Pougy|Mexico|Non-binary|58|E: 90,000 - 109,999|2|
    |1000030|Liparit Jongman|Mexico|Male|42|E: 90,000 - 109,999|3|
    |1000031|Yetar Cabrero|Mexico|Female|48|F: Above 110,000|4|
    |1000033|Zhora Xue|Mexico|Female|38|B: 30,000 - 49,999|5|
    |1000037|Olive Morgia|Mexico|Female|23|F: Above 110,000|4|
    |1000038|Reinhard Evdikimov|Mexico|Male|16|A: Below 30,000|5|
    |1000041|Carol Peck|United States|Male|41|D: 70,000 - 89,999|3|

    
    The last column in the report shows the "Bin" value. A value of 1 in this column indicates that a customer is a low spending customer and a value of 5 indicates that a customer is a high spending customer. For more information about using the `NTILE` function, see [the SQL documentation](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/NTILE.html#GUID-FAD7A986-AEBD-4A03-B0D2-F7F2148BA5E9).

2.  Binning customer sales by frequency

    The next step is to determine how frequently customers are watching movies on our platform. To do this, we simply calculate the number of movies watched by each customer and then bin that calculation across 5 buckets.

    ```
    <copy>SELECT
        cust_id,
        NTILE (5) OVER (ORDER BY max(day_ID)) AS rfm_recency,
        NTILE (5) OVER (ORDER BY count(1)) AS rfm_frequency
    FROM custsales
    GROUP BY cust_id;</copy>
    ```
    This should return a result similar to the following (again, your results may differ):

    |CUST_ID|RFM_RECENCY|RFM_FREQUENCY|
    |---|---|---|
    |1214447|2|1|
    |1271576|4|1|
    |1381292|2|1|
    |1173092|1|1|
    |1394001|1|1|
    |1033689|2|1|
    |1036695|2|1|
    |1313963|2|1|
    |1133180|1|1|
    |1087817|1|1|
    |1201112|1|1|
    |1118736|1|1|
    |1107833|1|1|
    |1243613|2|1|
    |1147187|2|1|
    |1158471|2|1|
    |1217452|1|1|
    |1391390|1|1|
    |1088817|1|1|

    Now we can identify those customers, based on when they last watched a movie (rfm\_recency). And, identify customers that watch the fewest number of movies, where the rfm\_frequency is 1, versus those customers that watch the most number of movies, where the rfm\_frequency is 5.

3.  Create an RFM query

    Now we use the **`WITH`** clause to combine these two queries to create an RFM query:

    ```
    <copy>WITH rfm AS (
    SELECT
        m.cust_id,
        NTILE (5) OVER (ORDER BY max(day_id)) AS rfm_recency,
        NTILE (5) OVER (ORDER BY count(1)) AS rfm_frequency,
        NTILE (5) OVER (ORDER BY SUM(m.actual_price)) AS rfm_monetary
    FROM custsales m
    GROUP BY m.cust_id
    )
    SELECT
        r.cust_id,
        c.first_name||' '||c.last_name AS cust_name,
        r.rfm_recency,
        r.rfm_frequency,
        r.rfm_monetary,
        c.country,
        c.gender,
        c.age,
        c.income_level
    FROM rfm r
    INNER JOIN customer c ON c.cust_id = r.cust_id
    WHERE r.rfm_monetary >= 5
      AND r.rfm_recency <= 1
    ORDER BY r.rfm_monetary desc, r.rfm_recency desc;</copy>
    ```
    The result only shows customers who have history had significant spend (equal to 5) but have not visited the site recently (equal to 1).  MovieStream does not want to lose these important customers.

    |CUST_ID|CUST_NAME|RFM_RECENCY|RFM_FREQUENCY|RFM_MONETARY|COUNTRY|GENDER|AGE|INCOME_LEVEL|
    |---|---|---|---|---|---|---|---|---|
    |1351052|Akra Schockemohle|1|5|5|Kenya|Male|23|A: Below 30,000|
    |1177510|Alicia Tilak|1|5|5|Mexico|Female|26|A: Below 30,000|
    |1028719|Gerard Carlson|1|5|5|United States|Male|32|B: 30,000 - 49,999|
    |1040970|Ward Larson|1|5|5|United States|Male|17|B: 30,000 - 49,999|
    |1066885|Monty Morris|1|5|5|United States|Male|21|A: Below 30,000|
    |1323975|Everette Cooley|1|5|5|United States|Male|24|A: Below 30,000|
    |1091259|Jennifer Kirk|1|5|5|United States|Male|24|A: Below 30,000|
    |1296904|Rubie Carosi|1|4|5|Italy|Female|27|E: 90,000 - 109,999|
    |1144796|Pap Spinello|1|5|5|Hungary|Male|37|F: Above 110,000|
    |1352324|Xuer-Nei Mendès|1|5|5|Kenya|Female|17|A: Below 30,000|
    |1339142|Zhao-Dao Lamboglio|1|5|5|Jordan|Male|33|A: Below 30,000|
    |1334789|Geet Werner|1|5|5|Jordan|Male|25|A: Below 30,000|
    |1356569|Carmen Ferrari|1|5|5|Kenya|Male|26|A: Below 30,000|
    |1355551|Tat Frommel|1|5|5|Kenya|Male|16|A: Below 30,000|
    |1299978|Lancelot Sterner|1|5|5|Kenya|Male|26|A: Below 30,000|
    |1356568|Troy Wullenweber|1|4|5|Kenya|Male|37|A: Below 30,000|
    |1057387|Dutta Tilak|1|5|5|India|Male|26|A: Below 30,000|
    |1183390|Venkatesh Kathiravan|1|5|5|India|Male|24|B: 30,000 - 49,999|
    |1008586|Elaine Burnett|1|5|5|United States|Female|21|A: Below 30,000|
    |1329199|Kris Woods|1|5|5|United States|Female|21|A: Below 30,000|

### Recap
We covered alot of ground in this lab. You learned how to use different types of analytic functions, time series functions and subqueries to answer important questions about the business. 
These features include:

- Different ways of joining tables

- Time-series functions

- Analytic functions to calculate contribution (**RATIO_TO_REPORT** and **ROLLUP**)

- **NTILE** binning functions that helps categorize customer sales and activity

Subsequent labs will showcase other types of database analytics that are equally if not more powerful.

You may now [proceed to the next lab](#next).

## **Acknowledgements**

- **Authors** - Keith Laker and Marty Gubar, Oracle Autonomous Database Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Marty Gubar, October 2021
