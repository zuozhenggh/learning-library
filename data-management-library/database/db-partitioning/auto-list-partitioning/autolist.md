# Auto-list Partitioning - PENDING VERIFICATION

## Introduction

Draft version 1.1 

 The automatic list partitioning method enables list partition creation on demand.

An auto-list partitioned table is similar to a regular list partitioned table, except that this partitioned table is easier to manage. You can create an auto-list partitioned table using only the partitioning key values that are known. As data is loaded into the table, the database automatically creates a new partition if the loaded partitioning key value does not correspond to any of the existing partitions. Because partitions are automatically created on demand, the auto-list partitioning method is conceptually similar to the existing interval partitioning method.

Automatic list partitioning on data types whose value changes very frequently are less suitable for this method unless you can adjust the data. For example, a SALES\_DATE field with a date value, when the format is not stripped, would increase every second. Each of the SALES\_DATE values, such as 05-22-2016 08:00:00, 05-22-2016 08:00:01, and so on, would generate its own partition. To avoid the creation of a very large number of partitions, you must be aware of the data that would be entered and adjust accordingly. As an example, you can truncate the SALES_DATE date value to a day or some other time period, depending on the number of partitions required.

The CREATE and ALTER TABLE SQL statements are updated with an additional clause to specify AUTOMATIC or MANUAL list partitioning. An automatic list-partitioned table must have at least one partition when created. Because new partitions are automatically created for new, and unknown, partition key values, an automatic list partition cannot have a DEFAULT partition.

 ![Image alt text](images/lab5_01.png "Auto List Partition")

### Features

*	Partitions are created automatically as data arrives
*	Extension to LIST partitioning
*	Every distinct partition key value will be stored in separate partition
*	System generated partition names for auto-created partitions
*	Only requirement is having no DEFAULT partition

### Business Challenges 

TBD 
 
 
### Objectives
 
In this lab, you will:
* Auto-list Partitioning 

### Prerequisites
This lab assumes you have completed the following lab:

- Provision an ADB Instance (19c, Always Free)

## Task 1: Cleanup

Let us remove all the objects that we will create. Execute the following code snippet. You can safely ignore any 'table does not exist' error message. If a table does not exist, there is nothing wrong with not being able to drop it  .

```
<copy>
rem cleanup of all objects
drop table mc purge;
drop table alp purge;
drop table soon2bpart purge;
drop table part4filter purge;
drop table ropt purge;
drop table part4xchange purge;
drop table np4xchange purge;
drop table compart4xchange purge;
drop table p4xchange purge;
</copy>
```
 
## Task 2: Create a simple auto-list partitioned table

Create an automatic list partitioned table with one required partition:
 

```
<copy>
CREATE TABLE sales_auto_list  
(  
   salesman_id   NUMBER(5)    NOT NULL,  
   salesman_name VARCHAR2(30),  
   sales_state   VARCHAR2(20) NOT NULL,  
   sales_amount  NUMBER(10),  
   sales_date    DATE         NOT NULL  
)  
 PARTITION BY LIST (sales_state) AUTOMATIC  
 (PARTITION P_CAL VALUES ('CALIFORNIA')  
);
 </copy>
```
 
```
<copy>
SELECT TABLE_NAME, PARTITIONING_TYPE, AUTOLIST, PARTITION_COUNT FROM USER_PART_TABLES WHERE TABLE_NAME ='SALES_AUTO_LIST';
</copy>
```

 ![Image alt text](images/lab5_01.png "Auto List Partition")

```
<copy>
SELECT TABLE_NAME, PARTITION_NAME, HIGH_VALUE FROM USER_TAB_PARTITIONS WHERE TABLE_NAME ='SALES_AUTO_LIST';
</copy>
```

 ![Image alt text](images/lab5_03.png "Auto List Partition")

Insert data with new SALES_STATE values

```
<copy>
INSERT INTO SALES_AUTO_LIST VALUES(021, 'Mary Smith', 'FLORIDA', 41000, TO_DATE ('21-DEC-2018','DD-MON-YYYY'));
INSERT INTO SALES_AUTO_LIST VALUES(032, 'Luis Vargas', 'MICHIGAN', 42000, TO_DATE ('31-DEC-2018','DD-MON-YYYY'))

</copy>
```

```
<copy>
select * from SALES_AUTO_LIST;
</copy>
```

![Image alt text](images/lab5_04.png "Auto List Partition")

 ```
<copy>
SELECT TABLE_NAME, PARTITIONING_TYPE, AUTOLIST, PARTITION_COUNT FROM USER_PART_TABLES WHERE TABLE_NAME ='SALES_AUTO_LIST';
</copy>
```

![Image alt text](images/lab5_05.png "Auto List Partition")

```
<copy>
INSERT INTO SALES_AUTO_LIST VALUES(015, 'Simone Blair', 'CALIFORNIA', 45000, TO_DATE ('11-JAN-2019','DD-MON-YYYY'));
INSERT INTO SALES_AUTO_LIST VALUES(015, 'Simone Blair', 'OREGON', 38000, TO_DATE ('18-JAN-2019','DD-MON-YYYY'));
</copy>
```

```
<copy>
SELECT TABLE_NAME, PARTITIONING_TYPE, AUTOLIST, PARTITION_COUNT FROM USER_PART_TABLES WHERE TABLE_NAME ='SALES_AUTO_LIST';
</copy>
```

![Image alt text](images/lab5_06.png "Auto List Partition")

```
<copy>
SELECT TABLE_NAME, PARTITION_NAME, HIGH_VALUE FROM USER_TAB_PARTITIONS WHERE TABLE_NAME ='SALES_AUTO_LIST';
</copy>
```

![Image alt text](images/lab5_07.png "Auto List Partition")

```
<copy>
select * from SALES_AUTO_LIST PARTITION(SYS_P1775);
</copy>
```

![Image alt text](images/lab5_08.png "Auto List Partition")

You successfully made it to the end of module 'auto-list partitioning'.  

## Learn More

* [Automatic List Partitioning](https://livesql.oracle.com/apex/livesql/file/content_HU7JYQY0PKB0PHLIGNXWWEYLO.html)
* [Database VLDB and Partitioning Guide](https://docs.oracle.com/en/database/oracle/oracle-database/21/vldbg/create-composite-partition-table.html#GUID-9ECF0F94-57BB-45F8-824F-48B320F23D9C)

## Acknowledgements
- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
