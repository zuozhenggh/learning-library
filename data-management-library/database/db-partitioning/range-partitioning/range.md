# Range Partitioning - PENDING VERIFICATION - 01 Done

## Introduction

Draft version 1.1 

Range partitioning is useful when we have distinct data ranges that we want to store together. For example, we can partition data based on the date range if we have vast sales data. Range partitioning is useful when we have distinct data ranges that we want to store together. For example, we can partition data based on the date range if we have vast sales data. Another example is if we have substantial student data at a university level, based on the year of admission or subject chosen, data can be partitioned by range. 

The PARTITION BY RANGE clause of the CREATE TABLE statement specifies that the table or index is to be range-partitioned. The PARTITION clauses identify the individual partition ranges, and the optional subclauses of a PARTITION clause can specify physical and other attributes specific to a partition segment. If not overridden at the partition level, partitions inherit the attributes of their underlying table.

### Features

*	Introduced with Oracle 8.0
*	Range Partition Is a single level partition 
*	Ideal for chronological data
*	Data is organized by ranges 
*	Data can be Split and merge as necessary 

### Challenges with Sales Data in E-Commerce

Here are some interesting facts about US Retail industry, US e-commerce sales are projected to continue to grow by double digits, up 17.9% in 2021 to $933.30 billion. Ecommerce penetration will continue to increase, more than doubling from 2019 to 23.6% in 2025. It means the growing volume of Customer and Sales Data and challenges with its manageability.

The solution to managing such a vast volume of chronological or sales data would be to partition it based on date range or use Range partitioning

![Image alt text](images/lab1_04.png "Range Partition")


This Lab will teach you how to create Range Partitioning. 

### Objectives
 
In this lab, you will:
* Create a Range Partitioned Table  

### Prerequisites
This lab assumes you have completed the following lab:

- Provision an ADB Instance (19c, Always Free)

## Task 1: Cleanup

Let us remove all the objects that we will create. Execute the following code snippet. You can safely ignore any 'table does not exist' error message. If a table does not exist, there is nothing wrong with not being able to drop it  .

```
<copy>
rem cleanup of all objects;
drop table sales_range_partition purge; 
</copy>
```
 
## Task 2: Create Range Partitioning

Let's Create Range Partitioned Table:

The table is partitioned by range using the values of the sales_date column. The partition bound is determined by the VALUES LESS THAN clause. For example, a value for sales\_date that is less than 01-OCT-2014 would be stored in the sales\_q3\_2014 partition.

```
<copy>
CREATE TABLE sales_range_partition ( 
    product_id       NUMBER(6), 
    customer_id      NUMBER, 
    channel_id       CHAR(1), 
    promo_id         NUMBER(6), 
    sale_date        DATE, 
    quantity_sold    INTEGER, 
    amount_sold      NUMBER(10,2) 
) 
PARTITION BY RANGE (sale_date) 
( PARTITION sales_q1_2014 VALUES LESS THAN (TO_DATE('01-APR-2014','dd-MON-yyyy')), 
   PARTITION sales_q2_2014 VALUES LESS THAN (TO_DATE('01-JUL-2014','dd-MON-yyyy')), 
   PARTITION sales_q3_2014 VALUES LESS THAN (TO_DATE('01-OCT-2014','dd-MON-yyyy')), 
   PARTITION sales_q4_2014 VALUES LESS THAN (TO_DATE('01-JAN-2015','dd-MON-yyyy')) 
);
</copy>
```  

Display the partitions in the table with this SQL query.

```
<copy> 
SELECT TABLE_NAME,PARTITION_NAME, PARTITION_POSITION, HIGH_VALUE FROM USER_TAB_PARTITIONS WHERE TABLE_NAME ='SALES_RANGE_PARTITION';
</copy>
```

Add a new partition to the table.

```
<copy>
ALTER TABLE sales_range_partition 
ADD PARTITION sales_q1_2015 VALUES LESS THAN (TO_DATE('01-APR-2015','dd-MON-yyyy'));
</copy>
```

Display the partitions in the table after adding the new partition.

```
<copy>
SELECT TABLE_NAME,PARTITION_NAME, PARTITION_POSITION, HIGH_VALUE FROM USER_TAB_PARTITIONS WHERE TABLE_NAME ='SALES_RANGE_PARTITION';
</copy>
```

![Image alt text](images/lab1_01.png "USER_TAB_PARTITIONS Data")

Insert values into the table.

```
<copy>
INSERT INTO sales_range_partition VALUES (1001,100,'A',150,'10-FEB-2014',500,2000);
INSERT INTO sales_range_partition VALUES (1002,110,'B',180,'15-JUN-2014',100,1000);
INSERT INTO sales_range_partition VALUES (1001,100,'A',150,'20-AUG-2014',500,2000);
</copy>
```
  
Display data from a specified partition in the table. (DROP TABLE sales\_range\_partition).

```
<copy>
SELECT * FROM sales_range_partition PARTITION(sales_q1_2014);
</copy>
```

![Image alt text](images/lab1_02.png "sales_range_partition Data with Partition")

Display all the data in the table.

```
<copy>
SELECT * FROM sales_range_partition;
</copy>
```

Data in sales\_range\_partition table with and without Partition

![Image alt text](images/lab1_03.png "sales_range_partition Data")
 
When you are finished testing the example, you can clean up the environment by dropping the table 

```
<copy>
DROP TABLE sales_range_partition; 
</copy>
```
  
You successfully made it to the end this lab Range Partitions.   

## Learn More

* [Range Partitioning](https://livesql.oracle.com/apex/livesql/docs/vldbg/partitioning/range-partitioning-example.html)
* [Database VLDB and Partitioning Guide](https://docs.oracle.com/en/database/oracle/oracle-database/21/vldbg/partition-create-tables-indexes.html)
* [US E-commerce Forecast](https://www.emarketer.com/content/us-ecommerce-forecast-2021)


## Acknowledgements
- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
