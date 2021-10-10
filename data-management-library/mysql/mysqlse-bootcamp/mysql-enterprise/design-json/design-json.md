# DATABASE DESIGN - MYSQL JSON 

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
4b) MySQL JSON datatype 
Objective: practice with JSON
Server: serverB

1.	Create a database for JSON tests

mysql> CREATE DATABASE json_test;

mysql> USE json_test;

2.	Create a JSON table

mysql> CREATE TABLE jtest (id bigint NOT NULL AUTO_INCREMENT, doc JSON, PRIMARY KEY (id)); 

mysql> SELECT * FROM jtest;

3.	add data to this table

mysql> INSERT INTO jtest(doc) VALUE('{"A": "hello", "b": "test", "c": {"hello": 1}}');

mysql> INSERT INTO jtest(doc) VALUE('{"b": "hello"}'),('{"c": "help"}');

mysql> SELECT * FROM jtest;

4.	Retrieve json documents with these commands (note the shortcut “->”)

mysql> SELECT json_extract (doc, "$.b") FROM jtest;

mysql> SELECT doc->"$.b" FROM jtest;

mysql> SELECT json_extract (doc, "$.c") FROM jtest;

mysql> SELECT doc->"$.b" from jtest;

mysql> SELECT doc->>"$.b" from jtest;

5.	Create Index on the virtual column

mysql>  alter table jtest add column gencol CHAR(7) AS (doc->"$.b");

mysql> CREATE INDEX myvirtindex ON jtest(gencol);

mysql> SELECT * FROM jtest;


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021