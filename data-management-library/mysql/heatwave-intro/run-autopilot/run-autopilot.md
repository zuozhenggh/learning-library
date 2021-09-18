# Run MySQL Auto Pilot
![INTRO](./images/00_mds_heatwave_2.png " ") 


## Introduction

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Estimated Lab Time: 15 minutes


### Objectives

In this lab, you will be guided through the following tasks:

- Improve Query performance and Heatwave memory usage using AutoEncoding
- Improve Query performance using Auto Data Placement


### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell
- Completed Task 4


## Task 1: Improve Query performance and Heatwave memory usage using AutoEncoding

1.	Run the airportdb queries (Annex) on MySQL and record the time.

    ```
    <copy>time mysql --host <mysql ip addr> -u <username> --password=<pass> -e "SET SESSION use_secondary_engine=OFF; source airportdb_autodb.sql;"</copy>
    ```

    real    1m3.697s

    user    0m0.016s

    sys     0m0.005s

2.	Run the airportdb queries (Annex) on HeatWave and record the time.
    
    ```
    <copy>time mysql --host <mysql ip addr> -u <username> --password=<pass> -e "source airportdb_autodb.sql;"</copy>
    ```
    real    0m0.436s

    user    0m0.011s

    sys     0m0.009s

3.	Start a session and call the Analytics Advisor with AutoEncoding to obtain the encoding suggestions.

    ```
    <copy>SET SESSION innodb_parallel_read_threads = 32;</copy>
    ```
    ```
    <copy>SET @opts = json_object('target_schema', JSON_ARRAY('airportdb'), 'auto_enc', json_object('mode', 'recommend') );</copy>
    ```

    ```
    <copy>call sys.heatwave_advisor(@opts);</copy>
    ```
  
4.	To apply the suggestion, access the auto-generated script
    
    ```
    <copy>SET SESSION group_concat_max_len = 1000000;</copy>
    ```
    ```
    <copy>SELECT GROUP_CONCAT(log->>"$.sql" SEPARATOR ' ') AS "SQL Script" FROM sys.heatwave_advisor_report WHERE type = "sql" ORDER BY id;</copy>
    ```

5.	Copy and paste auto-generated script to apply AutoEncoding changes

6.	Run the airportdb queries (Annex) and record the time.

    ```
    <copy>time mysql --host <mysql ip addr> -u <username> --password=<pass> -e "source airportdb_autodb.sql;"</copy>
    ```
    real    0m0.351s

    user    0m0.015s

    sys     0m0.005s

AutoEncoding Notes & Known Limitations
- Please refer to official documentation to see full set of features included in Advisor and AutoLoad.
- The current example is created only to demonstrate usage steps. AutoEncoding benefits may vary depending on the table data and executed queries.
- CALL sys.heatwave_advisor(JSON_OBJECT('auto_enc', JSON_OBJECT('mode', 'recommend'))); has additional parameters that allow excluding certain queries, schemas, encodings, from suggestions.
- AutoEncoding and Auto Data Placement can't be run simultaneously, and queries need to be executed again between the two calls.
- The feature produces suggestions based on the schema/table and structure of the queries seen in the past.
- The queries executed before AutoEncoding must be representative of the queries that will be executed in the future, since recommended dictionary encodings can have an effect on the offloadability of queries. The user is responsible for adding any additional constraint in the fixed_enc parameter if they need to be taken into account by AutoEncoding.
- The feature uses the current state of the tables loaded into RAPID to provide suggestions. In case the data or schema changes or a particular table is unloaded / reloaded then the user needs to re-invoke advisor to get fresh suggestions.



## Task 2: Improve Query performance using Auto Data Placement
After the data load and AutoEncoding execution, you can run airportdb queries in HeatWave again. Based on the executed queries, Auto Data Placement provides better data placement suggestions to accelerate JOIN and GROUP BY-intensive queries.

1.	Run the airportdb queries (Annex) and record the time.

    ```
    <copy>time mysql --host <mysql ip addr> -u <username> --password=<pass> -e "source airportdb_autodb.sql;"</copy>
    ```
    real    0m0.351s

    user    0m0.015s

    sys     0m0.005s

2.	Start a session and call the Auto Data Placement Advisor to see data placement key suggestions

    ```
    <copy>SET SESSION innodb_parallel_read_threads = 32;</copy>
    ```
    ```
    <copy>SET @opts = json_object('target_schema', JSON_ARRAY('airportdb'), 'auto_dp', json_object('benefit_threshold',0) );</copy>
    ```
    ```
    <copy>call sys.heatwave_advisor(@opts);</copy>
    ```

3.	To apply the suggestion, access the auto-generated script
    ```
    <copy>SET SESSION group_concat_max_len = 1000000;</copy>
    ```
    ```
    <copy>SELECT GROUP_CONCAT(log->>"$.sql" SEPARATOR ' ') AS "SQL Script" FROM sys.heatwave_advisor_report WHERE type = "sql" ORDER BY id;</copy>
    ```


4.	Copy and paste auto-generated script to apply data placement changes

5.	Run the airportdb queries (Annex) and record the time.

    ```
    <copy>time mysql --host <mysql ip addr> -u <username> --password=<pass> -e "source airportdb_autodb.sql;"</copy>
    ```
    ```
    <copy>real    0m0.296s</copy>
    ```
    ```
    <copy>user    0m0.013s</copy>
    ```
    ```
    <copy>sys     0m0.007s</copy>
    ```
Auto Data Placement Notes & Known Limitations
- Please refer to official documentation to see full set of features included in Advisor and Auto Data Placement.
- The current example is created only to demonstrate usage steps. The benefit of Auto Data Placement suggestions will increase with more data and larger cluster size.
- CALL sys.heatwave_advisor() has additional parameters that allow excluding certain queries, schemas, from suggestions. 
- AutoEncoding and Auto Data Placement can't be run simultaneously, and queries need to be executed again between the two calls.
- The Auto Data Placement models are constantly updated, therefore the estimated performance benefit can differ than the actual measurement.
- The feature only produces a suggestion if there are tables loaded into RAPID.
- The feature only provides a suggestion when it evaluates that the suggestion would make a significant difference in query performance. The minimum benefit threshold is provided as an argument to the advisor.
- The feature only produces suggestions when there are minimum of five queries executed by the user in RAPID. A query is counted if it includes a join or group-by on tables that are currently loaded. 
- The feature uses the current state of the tables loaded into RAPID to provide suggestions. In case the data or schema changes or a particular table is unloaded / reloaded then the user needs to re-invoke advisor to get fresh suggestions.
- The feature produces suggestions based on joins and group-by een in the past
- The expected performance improvement shown is over all the queries that have been run on the set of loaded tables, and not to any individual query
- The suggestions provided by Auto data placement would not be deterministic given the same input queries because the fractional execution time of the query might be different.

**Annex: AirportDB queries**
1. Select Database

    ```
    <copy> use airportdb;</copy>
 
    ```
2. Query a) Find per-company average age of passengers from Switzerland, Italy and France

    ```
    <copy>SELECT
    airline.airlinename,
    AVG(datediff(departure,birthdate)/365.25) as avg_age,
    count(*) as nb_people
FROM
    booking, flight, airline, passengerdetails
WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    booking.passenger_id=passengerdetails.passenger_id AND
    country IN ("SWITZERLAND", "FRANCE", "ITALY")
GROUP BY
    airline.airlinename
ORDER BY
    airline.airlinename, avg_age
LIMIT 10;</copy>
    ```
3. Query b) Find top 10 companies selling the biggest amount of tickets for planes taking off from US airports

    ```
    <copy>SELECT
    airline.airlinename,
    SUM(booking.price) as price_tickets,
    count(*) as nb_tickets
FROM
    booking, flight, airline, airport_geo
WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    flight.from=airport_geo.airport_id AND
    airport_geo.country = "UNITED STATES"
GROUP BY
    airline.airlinename
ORDER BY
    nb_tickets desc, airline.airlinename
LIMIT 10;</copy>
    ```
4. Query c) Ticket price greater than 500, grouped by price

    ```
    <copy>SELECT
    booking.price,
    count(*)
FROM
    booking
WHERE
    booking.price > 500
GROUP BY
    booking.price
ORDER BY
    booking.price
LIMIT
    10;</copy>
    ```
## Learn More

* [Oracle Cloud Infrastructure MySQL Database Service Documentation ](https://docs.cloud.oracle.com/en-us/iaas/mysql-database)
* [MySQL Database Documentation](https://www.mysql.com)
## Acknowledgements
* **Author** - Perside Foster, MySQL Solution Engineering 
* **Contributors** - Mandy Pang, MySQL Principal Product Manager,  Priscila Galvao, MySQL Solution Engineering, Nick Mader, MySQL Global Channel Enablement & Strategy Manager
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, September 2021
