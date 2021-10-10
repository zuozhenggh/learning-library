# DATABASE DESIGN - MYSQL TABLES 

## Introduction

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### About <Product/Technology> (Optional)
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than to sections/paragraphs, please utilize the "Learn More" section.

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is necessary to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Task 1: Concise Step Description
4a) Database Design
Objective: Working with SQL
Server: serverB

1.	Now the lab start: connect to your mysql-advanced with admin user 
shell> mysql -uroot -p -P3307 -h127.0.0.1

2.	Create a new table poi
mysql> use world; 

mysql> CREATE TABLE if not exists poi (x Int, y INT, z INT);

3.	Add to the table a new column for id used for large integer values
mysql> alter table poi add id bigint;

mysql> ALTER TABLE poi ADD PRIMARY KEY (id); 

4.	Create a copy of your city table
mysql> create table city_part as select * from city;

5.	How many records does it contain?
mysql> SELECT count(*) FROM city_part; 

6.	How many records city table contain?
mysql> SELECT count(*) FROM city; 

7.	Verify the difference of the two table creation (there is a big one!)
mysql> show create table city\G 

mysql> show create table city_part\G

8.	Create an index on new table

mysql> CREATE INDEX myidindex ON city_part (ID); 

9.	Check table statistics. What is the Cardinality (=unique records) of primary key?

mysql> SELECT * FROM INFORMATION_SCHEMA.STATISTICS WHERE table_name = 'city' and table_schema='world'\G

10.	Create a new index

mysql> CREATE INDEX myccindex ON city_part (CountryCode);

11.	Delete some columns (Population and CountryCode)
mysql> ALTER TABLE city_part DROP COLUMN Population;

mysql> ALTER TABLE city_part DROP COLUMN CountryCode;

12.	Optimize the table
mysql> OPTIMIZE TABLE city_part;
warning is expected: https://dev.mysql.com/doc/refman/8.0/en/optimize-table.html

13.	Update table statistics

mysql> ANALYZE TABLE city_part;

14.	Create partitions:
a.	Check the files for the city_part table on your disk. We can do it from the mysql client using the built-in function “system”

mysql> system ls -l /mysql/data/world 

b.	Partition your table into 5 segments based on hash

mysql> ALTER TABLE world.city_part PARTITION BY HASH (id) PARTITIONS 5;

c.	Check the file of the city_part table on your disk

mysql> system ls -l /mysql/data/world 


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021