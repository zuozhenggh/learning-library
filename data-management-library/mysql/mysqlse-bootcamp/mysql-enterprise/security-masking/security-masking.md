# SECURITY - DATA MASKING

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
3e) Data Masking and de-identification
Objective: Install and use data masking functionalities
Notes:
•	Data masking has more functions than what we test in the lab. The full list of functions is here
o	https://dev.mysql.com/doc/refman/5.7/en/data-masking-usage.html 
Server: serverB
1. To install the data masking plugin, execute with statements (to help copy & paste here we don’t repeat mysql> prompt)
shell> mysql -uroot -p -h 127.0.0.1 -P 3307
mysql> INSTALL PLUGIN data_masking SONAME 'data_masking.so';
mysql> SHOW PLUGINS;
2. Look for data_masking and check the status? Is it active?

3. Install some masking functions
mysql> CREATE FUNCTION gen_range RETURNS INTEGER SONAME 'data_masking.so';
mysql> CREATE FUNCTION gen_rnd_email RETURNS STRING SONAME 'data_masking.so';
mysql> CREATE FUNCTION gen_rnd_us_phone RETURNS STRING SONAME 'data_masking.so';
mysql> CREATE FUNCTION mask_inner RETURNS STRING SONAME 'data_masking.so';
mysql> CREATE FUNCTION mask_outer RETURNS STRING SONAME 'data_masking.so';
4. Use data masking functions

mysql> SELECT mask_inner(NAME, 1,1) FROM world.city limit 10;

mysql> SELECT mask_outer(NAME, 1,1) FROM world.city limit 10;

5. Discuss differences between mask_inner and mask_outer

mysql> SELECT mask_inner(NAME, 1,1, '&') FROM world.city limit 1;


6. Use data masking random generators executing these statements several times

mysql> SELECT gen_range(1, 200); 

mysql> SELECT gen_rnd_us_phone();

mysql> SELECT gen_rnd_email();


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
