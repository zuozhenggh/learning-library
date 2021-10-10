# DATABASE DESIGN - MYSQL DOCUMENT STORE

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
4c) MySQL Document Store
Objective: Understanding the functioning of MySQL Document Store and practicing some CRUD operations.

Server: serverB

Notes:
•	Please note that we use the port for Xdev (33070) instead of usual classic protocol port (3307)



1. Please connect to MySQL Database via X Protocol

	shell> mysqlsh -uroot -h127.0.0.1 -P33070 -p

2. Create and use a test schema. (We use javascript mode, but python is available also)
	
	MySQL … JS > session.createSchema('test')

MySQL … JS > \use test

3. Now create and populate a small collection
	
	MySQL … JS > db.createCollection('posts');

	MySQL … JS > db.posts.add({"title":"MySQL 8.0 rocks", "text":"My first post!", "code": "42"})

	MySQL … JS > db.posts.add({"title":"Polyglot database", "text":"Developing both SQL and NoSQL applications"})

4. Checking the built-in JSON validation
	
	MySQL … JS > db.posts.add("This is not a valid JSON document")

5. Inspect the posts collection you have just created 
	
	MySQL … JS > db.posts.find()

What can you notice? Did the system add something to content by itself?
	
	MySQL … JS > db.posts.find().limit(1)

6.  Modify existing elements of the collection
	
	MySQL … JS > db.posts.modify("title = 'MySQL 8.0 rocks'").set("title", " MySQL 8.0 rocks!!!")

	MySQL … JS > db.posts.find()

7. Check that that a collection is just a table with 2 columns: Index and JSON Document
	
	MySQL … JS > session.sql("desc posts")

	MySQL … JS > session.sql("show create table posts")

	MySQL … JS > session.sql("select * from posts")

8. Therefore, it is possible to add indexes on specific JSON elements of the collection

	MySQL … JS > db.posts.createIndex('myIndex', {fields: [{field: "$.title", type: "TEXT(20)"}]} )

	MySQL … JS > session.sql("show create table posts")


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021