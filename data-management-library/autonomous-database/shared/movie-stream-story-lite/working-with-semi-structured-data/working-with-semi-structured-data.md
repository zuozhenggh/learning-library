# Work with JSON movie data

## Introduction

#### Video Preview

[] (youtube:0_BOgvJw4N0)

JSON provides an extremely flexible and powerful data model.  No wonder that it is such a popular storage format for developers. Oracle SQL allows you to analyze JSON data - including complex data types like arrays - in combination with structured tabular data.

Up to this point in our workshop, all the data we have been using has been **structured**. Structured data comes with a pre-determined definition. In our movie sales data, each record in our sales data files has a reference ID, a timestamp, a customer ID, associated customer demographic information, movie purchases, payment information, and more. Each field in our data set has a clearly defined purpose, which makes it very quick and easy to query. In most real-world situations, you will need to deal with other types of data such as **semi-structured**.

Estimated time: 10 minutes

### Objectives

- Learn how our Autonomous Data Warehouse makes it very easy to query unstructured data sets such as JSON data

- Understand how Oracle's JSON helper functions can convert JSON data into a normal table of rows and columns making it easier to join with our movie sales data

- Learn How SQL's analytic functions can be used in queries that also contain JSON data

### Prerequisites

- This lab requires completion of these previous labs: **Provision an ADB Instance**, **Create a Database User**, **Use Data Tools to Create a User and Load Data**.

### What is semi-structured data

Semi-structured data does not have predefined fields that have a clearly defined purpose. Typically most semi-structured data looks similar to a text-based document but most types of semi-structured data lack a precise structural definition and come in all shapes and sizes. This can make it very challenging to work with this type of data.

There are many different types of semi-structured and unstructured data, so most cloud vendors offer separate database services to manage each type of data: document store databases, graph store databases, spatial store databases, XML databases, NoSQL databases, and more. These separate database engines create data silos by locking data inside each type of database, making it almost impossible to do joined-up analysis across all your data. (If you want to learn more about the differences between structured, semi-structured and unstructured data then read the following blog post on [blogs.oracle.com](http://blogs.oracle.com) by Michael Chen: [Structured vs. Unstructured Data](https://blogs.oracle.com/bigdata/structured-vs-unstructured-data)).

Oracle takes a very different approach to managing these different types of data.

### A converged database model for managing all your data

The Autonomous Data Warehouse is based on a converged database model that has native support for all modern data types and the latest development paradigms built into one product. It supports spatial data for location awareness, JSON and XML for document store type content streams for IoT device integration, in-memory technologies for real-time analytics, and of course, traditional relational data. By providing support for all of these data types, the converged Autonomous Data Warehouse can run all sorts of workloads from analysis of event streams to discovery of relationships across domains to blockchain processing to time series analysis and machine learning.

In this section of the workshop, you are going to work with some semi-structured data which is in a common format called **JSON**.

### What is JSON

This format is probably the most commonly used way to manage data sets that are typically semi-structured in terms of the way they are organized. This format is an open standard file format which is typically used to simplify the way information can be moved around the web. It resembles human-readable text where data points consist of attribute–value pairs and/or arrays. It is a very common data format and it has a wide range of applications.

JSON is a language-independent data format. It was derived from JavaScript, but many modern programming languages include code to generate and parse JSON-format data. For more information see here: [https://en.wikipedia.org/wiki/JSON](https://en.wikipedia.org/wiki/JSON).

Oracle's SQL language contains specific keywords that help you process JSON data. In this lab, you will learn how to process and query JSON data formats.

### Overview of the business problem

The marketing team would like to create themed bundles of movies based on the scriptwriters. Our movie data set has a series of columns that contain more detailed information. Each movie has a **crew** associated with it and that crew is comprised of **jobs**, such as "producer," "director," "writer," along with the names of the individuals. An example of how this information is organized is shown below:

![JSON example](images/lab-3-json-doc.png " ")


This is in a format known as JSON and you can see that it is organized very differently from some other data that you have loaded into your new data warehouse. There is a single entry for "producer" but the corresponding key "names" actually has multiple values. This is referred to as an **array** - specifically a JSON array. Fortunately, the Autonomous Data Warehouse allows you to query this type of data (JSON arrays) using normal SQL as you will see below.

Let's better understand the sales performance of our movies. We'll start by simply looking at our movie profiles and sales of those movies. Then, we'll examine how different events - in particular the Academy Awards - impacts sales of high profile movies.

## Task 1: Review JSON movie data

In the previous labs of this workshop, we loaded the data we want to use into our data warehouse. Autonomous Data Warehouse also allows you to leave your data in the Object Store and query it directly without having to load it first. This uses a feature called an External Table. There is a whole chapter on this topic in the documentation, [see here](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/query-external.html#GUID-ABF95242-3E04-42FF-9361-52707D14E833), which explains all the different types of file formats (including JSON) that are supported.

Although queries on external data will not be as fast as queries on database tables, you can use this approach to quickly start running queries on your external source files and external data. In the public Object Storage buckets, there is a file called **movies.json** which contains information about each movie, as outlined above.  An external table called **JSON\_MOVIE\_DATA\_EXT** has been created over this json file.

1. Let's see how many rows are in this table:

    ```
    <copy>SELECT count(*) FROM json_movie_data_ext;</copy>
    ```
    This query returns the following result:

    |COUNT(*)|
    |---|
    |3800|

2. Go to the SQL Worksheet Navigator panel and click the arrow to the left of the name, **JSON\_MOVIE\_DATA\_EXT**, to show the list of columns in our table.  Notice that there is a single column called **DOC** that contains the JSON data:

    ![See the table in the tree](images/3038282401.png " ")

    This external table behaves just like an ordinary table. Let's run a simple query to show the rows in the table:

    ```
    <copy>SELECT * FROM json_movie_data_ext WHERE rownum < 10;</copy>
    ```

    |DOC|
    |---|
    |{  "movie\_id" : 1, "sku" : "COO3790", "list\_price" : 3.99, "wiki\_article" : "'Gator\_Bait\_II:\_Cajun\_J...|
    |{  "movie\_id" : 10, "sku" : "WSD96478", "list\_price" : 1.99, "wiki\_article" : "101\_Dalmatians\_(1996\_...|
    |{  "movie\_id" : 17, "sku" : "KLI27554", "list\_price" : 0.0, "wiki\_article" : "127\_Hours", "title" : ...|
    |{  "movie\_id" : 24, "sku" : "FNF32465", "list\_price" : 2.99, "wiki\_article" : "1945\_(2017\_film)", "t...|
    |{  "movie\_id" : 32, "sku" : "BYH40340", "list\_price" : 4.99, "wiki\_article" : "2012:\_Supernova", "ti...|
    |{  "movie\_id" : 40, "sku" : "NTV55017", "list\_price" : 1.99, "wiki\_article" : "2BR02B:\_To\_Be\_or\_Naug...|
    |{  "movie\_id" : 47, "sku" : "QYJ8171", "list\_price" : 4.99, "wiki\_article" : "30\_Beats", "title" : "...|
    |{  "movie\_id" : 55, "sku" : "ETA20766", "list\_price" : 1.99, "wiki\_article" : "3\_Backyards", "title"...|
    |{  "movie\_id" : 62, "sku" : "FMX14446", "list\_price" : 2.99, "wiki\_article" : "48\_Shades", "title" :...|
    

    As you can see, the data is shown in its native JSON format; that is, there are no columns in the table for each identifier (movie_id, sku, list price, and more). So how can we query this table if there is only one column?

## Task 2: Simple queries over JSON data


1. As a first step, let's show you how to query  JSON data using SQL. Use the dot notation within our SQL query to convert the content above into a more normal looking table containing columns and rows. This approach is known as Simple Dot Notation and it looks very similar to the way we have constructed previous queries. Here is our first query which you can run in your SQL Worksheet:

    ```
    <copy>SELECT
        m.doc.movie_id,
        m.doc.title,
        m.doc.budget,
        m.doc.runtime
    FROM json_movie_data_ext m
    WHERE rownum < 10;</copy>
    ```
    It should return a result set that looks similar to this:

    |MOVIE_ID|TITLE|BUDGET|RUNTIME|
    |---|---|---|---|
    |1|'Gator Bait II: Cajun Justice|null|95|
    |10|101 Dalmatians|+54000000|+103|
    |17|127 Hours|+18000000|+94|
    |24|1945|null|+91|
    |32|2012: Supernova|200000|+84|
    |40|2BR02B: To Be or Naught to Be|null|18|
    |47|30 Beats|1000000|88|
    |55|3 Backyards|null|88|
    |62|48 Shades|null|96|
    

    > **Note:** Each column has three components:

    - the name of the source table - **json\_movie\_data\_ext** which is referenced using the letter **m**

    - the column containing our json data - **doc**

    - the name of the json attribute - **movie_id**, **title**, **budget** and **runtime**

2. Now that movie queries return data in column format, you can join that data with data stored in other Oracle Database tables.  Let's find the top 10 movies (JSON) based on customer sales (tabular).  This requires joining the **MOVIE\_ID** column from the **CUSTSALES** table with the json document's **movie\_id** attribute.

    ```
    <copy>SELECT 
        m.doc.title, 
        round(sum(c.actual_price),0) as sales
    FROM json_movie_data_ext m, custsales c
    WHERE m.doc.movie_id = c.movie_id
    GROUP BY m.doc.title
    ORDER BY 2 desc
    FETCH FIRST 10 ROWS ONLY;</copy>
    ```

    This produces the following - and not surprising - result:
    |TITLE|SALES|
    |---|---|
    |Aladdin|825080|
    |Captain Marvel|778566|
    |Aquaman|778151|
    |Spider-Man: Far from Home|666140|
    |The Lion King|665654|
    |Avengers: Endgame|616594|
    |Avatar|456188|
    |Avengers: Infinity War|431297|
    |Frozen|372896|
    |The Godfather|371966|

3. We'll query movies frequently - it will be useful to store the data in Autonomous Data Warehouse. Create a table containing the movie data.  Some of the fields will still be in JSON format - specifically those fields containing arrays.  For those fields, add a constraint that ensures the columns contain valid JSON:

    ```
    <copy>CREATE table t_movie AS
    SELECT
        CAST(m.doc.movie_id as number) as movie_id,
        CAST(m.doc.title as varchar2(200 byte)) as title,   
        CAST(m.doc.budget as number) as budget,
        CAST(m.doc.gross as number) gross,
        CAST(m.doc.genre as varchar2(4000)) as genres,
        CAST(m.doc.year as number) as year,
        TO_DATE(m.doc.opening_date, 'YYYY-MM-DD') as opening_date,
        CAST(m.doc.views as number) as views,
        CAST(m.doc.cast as varchar2(4000 byte)) as cast,
        CAST(m.doc.crew as varchar2(4000 byte)) as crew,
        CAST(m.doc.awards as varchar2(4000 byte)) as awards,
        CAST(m.doc.nominations as varchar2(4000 byte)) as nominations
    FROM json_movie_data_ext m;
            
    ALTER TABLE t_movie add CONSTRAINT t_movie_cast_json CHECK (cast IS JSON);
    ALTER TABLE t_movie add CONSTRAINT t_movie_genre_json CHECK (genres IS JSON);
    ALTER TABLE t_movie add CONSTRAINT t_movie_crew_json CHECK (crew IS JSON);
    ALTER TABLE t_movie add CONSTRAINT t_movie_awards_json CHECK (awards IS JSON);
    ALTER TABLE t_movie add CONSTRAINT t_movie_nominations_json CHECK (nominations IS JSON);</copy>
    ```

3. Some attributes in our JSON data set contain multiple entries. For example, cast has a list of names and nominations a list of nominated awards. Take a look at the cast, crew,  names of the crew and awards for a couple of popular movies:

    ```
    <copy>SELECT
        m.movie_id,
        m.title,
        m.budget,
        m.cast,
        m.crew,
        m.awards
    FROM t_movie m
    WHERE m.title in ('Rain Man','The Godfather');</copy>
    ```

    It will return:
    |MOVIE_ID|TITLE|BUDGET|CAST|CREW|AWARDS|
    |---|---|---|---|---|---|
    |2472|Rain Man|25|["Dustin Hoffman","Tom Cruise","Valeria Golino","Gerald R. Molen","Jack Murdock","Michael D. Roberts","Bonnie Hunt","Barry Levinson","Beth Grant","Lucinda Jenney","Jake Hoffman","Chris Mulkey","Ray Baker"]|[{"job":"producer","names":["Mark Johnson"]},{"job":"director","names":["Barry Levinson"]},{"job":"screenwriter","names":["Barry Morrow","Ronald Bass"]}]|["Academy Award for Best Picture","Golden Bear","Academy Award for Best Director","Academy Award for Best Actor","Academy Award for Best Writing, Original Screenplay"]|
    |3244|The Godfather|6000000|["Marlon Brando","Al Pacino","James Caan","Richard S. Castellano","Robert Duvall","Sterling Hayden","John Cazale","Diane Keaton","Talia Shire","Abe Vigoda","Al Lettieri","Gianni Russo","Corrado Gaipa","Al Martino","John Marley","Johnny Martino","Lenny Montana","Richard Conte","Alex Rocco","Julie Gregg","Simonetta Stefanelli","Saro Urzì","Angelo Infanti","Franco Citti","Joe Spinell","Morgana King","Richard Bright","Rudy Bond","Vito Scotti","Carmine Coppola","Roman Coppola","Sofia Coppola","Ron Gilbert","Tony King","Raymond Martino","Nick Vallelonga","Tony Giorgio","Victor Rendina"]|[{"job":"producer","names":["Albert S. Ruddy"]},{"job":"executive producer","names":["Robert Evans"]},{"job":"director","names":["Francis Ford Coppola"]},{"job":"screenwriter","names":["Mario Puzo","Francis Ford Coppola"]}]|["Academy Award for Best Picture","National Film Registry","Academy Award for Best Actor","Academy Award for Best Writing, Adapted Screenplay","National Board of Review: Top Ten Films"]|

This is good - but the arrays are still part of a single record.  What if you want to ask questions that need to look at the values within the arrays?  

## Task 3: More sophisticated JSON queries

The Academy Awards is an exciting time for the movie industry. It would be interesting to understand movie sales during that time. What happens to movie sales before and after the event? Specifically, what happens to sales for those movies that have won the Academy Award? This can be a challenging question. A movie has an **awards** column - but it is an array.  How do you find sales for a movie that's won the best picture?

Your Autonomous Data Warehouse includes a number of helper packages that can simplify access to your JSON data. The **JSON_TABLE** function can be used to automatically translate JSON data into a row-column format so you can query the JSON data in exactly the same way as our movie sales data.

1. Let's use the JSON_TABLE function to create a row for each movie -> award combination. Run the following command in your SQL Worksheet:

    ```
    <copy>SELECT 
        title, 
        award    
    FROM t_movie, 
         JSON_TABLE(awards, '$[*]' columns (award path '$')) jt
    WHERE title IN ('Rain Man','The Godfather');</copy>
    ```
    You can now see the movie and its award in tabular format:
    |TITLE|AWARD|
    |---|---|
    |Rain Man|Academy Award for Best Picture|
    |Rain Man|Golden Bear|
    |Rain Man|Academy Award for Best Director|
    |Rain Man|Academy Award for Best Actor|
    |Rain Man|Academy Award for Best Writing, Original Screenplay|
    |The Godfather|Academy Award for Best Picture|
    |The Godfather|National Film Registry|
    |The Godfather|Academy Award for Best Actor|
    |The Godfather|Academy Award for Best Writing, Adapted Screenplay|
    |The Godfather|National Board of Review: Top Ten Films|

2. Now that we have rows for each value of the array, it is straightforward to find all Academy Award winners for Best Picture:

    ```
    <copy>SELECT 
        year,
        title, 
        award    
    FROM t_movie, 
        JSON_TABLE(awards, '$[*]' columns (award path '$')) jt
    WHERE award = 'Academy Award for Best Picture'
    ORDER BY year
    FETCH FIRST 10 ROWS ONLY;</copy>
    ```

    Below are the oldest award winners that MovieStream offers:

    |YEAR|TITLE|AWARD|
    |---|---|---|
    |1950|All About Eve|Academy Award for Best Picture|
    |1951|An American in Paris|Academy Award for Best Picture|
    |1952|The Greatest Show on Earth|Academy Award for Best Picture|
    |1953|From Here to Eternity|Academy Award for Best Picture|
    |1956|Around the World in 80 Days|Academy Award for Best Picture|
    |1957|The Bridge on the River Kwai|Academy Award for Best Picture|
    |1958|Gigi|Academy Award for Best Picture|
    |1959|Ben-Hur|Academy Award for Best Picture|
    |1960|The Apartment|Academy Award for Best Picture|
    |1961|West Side Story|Academy Award for Best Picture|

3. What were sales before and after the Academy Awards?  Let's see the results for past winners of the major awards.

    ```
    <copy>WITH academyAwardedMovies as (
        -- Find movies that won significant awards
        SELECT 
            m.movie_id
        FROM t_movie m, JSON_TABLE(awards, '$[*]' columns (award path '$')) jt
        WHERE jt.award in ('Academy Award for Best Picture','Academy Award for Best Actor','Academy Award for Best Actress','Academy Award for Best Director')
        ),
    academyMovieSales as (
        -- what were those movies' sales?
        SELECT 
            sales.movie_id, 
            sales.day_id
        FROM custsales sales
        WHERE sales.movie_id in 
          (SELECT movie_id FROM academyAwardedMovies)
        ),
    before2020Award as (
        -- how about 14 days prior to the event
        SELECT 
            ams1.movie_id, 
            count(1) as before_count
        FROM academyMovieSales ams1 
        WHERE day_id BETWEEN to_date('09/02/2020', 'DD/MM/YYYY') -14
          AND to_date('09/02/2020', 'DD/MM/YYYY')
        GROUP BY ams1.movie_id
        ),
    after2020Award as (
        -- and 14 days after the event
        SELECT 
            ams2.movie_id, 
            count(1) as after_count
        from academyMovieSales ams2 
        WHERE day_id BETWEEN to_date('09/02/2020', 'DD/MM/YYYY')
          AND to_date('09/02/2020', 'DD/MM/YYYY') +14
        GROUP BY ams2.movie_id
    )
    -- join the before and after
    SELECT 
        title, 
        year, 
        bef.before_count as "before event", 
        aft.after_count as "after event", 
        ROUND((aft.after_count - bef.before_count)/bef.before_count * 100) as  "percent change"
    FROM after2020Award aft, before2020Award bef, t_movie m
    WHERE aft.movie_id = bef.movie_id
      AND aft.movie_id = m.movie_id
    ORDER BY "percent change" DESC;</copy>
    ```

    Looks like the Academy Awards is good for business!

    |TITLE|YEAR|before event|after event|percent change|
    |---|---|---|---|---|
    |The Lion in Winter|1968|109|652|498|
    |Giant|1956|144|504|250|
    |Gigi|1958|133|336|153|
    |The Goodbye Girl|1977|43|105|144|
    |Around the World in 80 Days|1956|83|202|143|
    |Terms of Endearment|1983|300|717|139|
    |Come Back, Little Sheba|1952|1|2|100|
    |An American in Paris|1951|145|290|100|
    |Gladiator|2000|1370|2326|70|
    |Guess Who's Coming to Dinner|1967|338|540|60|
    |12 Years a Slave|2013|1231|1956|59|
    |True Grit|1969|365|565|55|
    |As Good as It Gets|1997|544|816|50|
    |Kiss of the Spider Woman|1985|55|77|40|
    |Rocky|1976|607|848|40|
    |Dallas Buyers Club|2013|612|857|40|
    |Lawrence of Arabia|1962|699|943|35|
    |On Golden Pond|1982|148|199|34|
    |Bohemian Rhapsody|2018|1481|1972|33|
    |Dances with Wolves|1990|718|952|33|
    |The Lord of the Rings: The Return of the King|2003|777|1030|33|
    |Room|2015|936|1220|30|
    |A Man for All Seasons|1966|193|249|29|
    |Shakespeare in Love|1998|463|596|29|
    |Rain Man|1988|554|698|26|
    |The Greatest Show on Earth|1952|91|115|26|
    |Butterfield 8|1960|60|75|25|
    |The Godfather|1972|2385|2975|25|
    |Saving Private Ryan|1998|1408|1729|23|
    |Blue Jasmine|2013|202|243|20|
    |Platoon|1986|543|645|19|
    |Monster|2004|489|575|18|
    |Titanic|1997|2994|3525|18|
    |Black Swan|2010|1051|1243|18|
    |The Godfather Part II|1974|1376|1630|18|
    |All About Eve|1950|216|252|17|
    |Oliver!|1968|152|176|16|
    |Gravity|2013|537|618|15|
    |The Graduate|1967|539|618|15|
    |Patton|1970|165|189|15|
    |Out of Africa|1985|320|365|14|
    |The Sting|1973|231|261|13|
    |The Country Girl|1954|23|26|13|
    |The Bridge on the River Kwai|1957|384|433|13|
    |Chariots of Fire|1981|387|436|13|
    |To Kill a Mockingbird|1962|285|313|10|
    |The King and I|1956|136|150|10|
    |The Quiet Man|1952|209|228|9|
    |The Silence of the Lambs|1991|1933|2112|9|
    |Cabaret|1972|335|357|7|
    |West Side Story|1961|481|509|6|
    |Ben-Hur|1959|541|568|5|
    |High Noon|1952|257|271|5|
    |The Sound of Music|1965|1191|1243|4|
    |Who's Afraid of Virginia Woolf?|1966|151|155|3|
    |American Beauty|1999|1291|1335|3|
    |Coal Miner's Daughter|1980|157|162|3|
    |The French Connection|1971|329|328|0|
    |Forrest Gump|1994|2140|2138|0|
    |Mary Poppins|1964|797|798|0|
    |Kramer vs. Kramer|1979|503|498|-1|
    |The Deer Hunter|1978|673|667|-1|
    |The African Queen|1951|232|228|-2|
    |Annie Hall|1977|354|345|-3|
    |Midnight Cowboy|1969|509|483|-5|
    |My Fair Lady|1964|380|347|-9|
    |Born Yesterday|1950|11|10|-9|
    |Schindler's List|1993|1683|1455|-14|
    |From Here to Eternity|1953|440|378|-14|
    |Philadelphia|1993|644|543|-16|
    |One Flew Over the Cuckoo's Nest|1975|1065|887|-17|
    |Tom Jones|1963|110|86|-22|
    |Born on the Fourth of July|1989|363|252|-31|
    |Funny Girl|1968|277|169|-39|
    |Cat Ballou|1965|130|79|-39|
    |Moonstruck|1987|491|282|-43|
    |The Apartment|1960|471|211|-55|


## Recap

In this lab, we covered the following topics:

- How our Autonomous Data Warehouse makes it very easy to query unstructured data sets such as JSON data

- Using JSON helper functions to convert the JSON data into a normal table of rows and columns so that it can be easily joined with our movie sales data

- How SQL's analytic functions can be used in queries that also contain JSON data

Please *proceed to the next lab*

## **Acknowledgements**

- **Author** - Keith Laker, Oracle Autonomous Database Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Last Updated By/Date** - Keith Laker, August 3, 2021
