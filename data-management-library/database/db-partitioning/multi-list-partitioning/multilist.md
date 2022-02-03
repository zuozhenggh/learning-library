# Multi Column List Partitioning - PENDING VERIFICATION

## Introduction

Draft version 1.0 
 
Multi-column list partitioning enables you to partition a table based on list values of multiple columns. Similar to single-column list partitioning, individual partitions can contain sets containing lists of values. Multi-column list partitioning is supported on a table using the PARTITION BY LIST clause on multiple columns of a table.

### Business Challenges 

TBD

### Features

TBD

Estimated Lab Time: 10 minutes

To create a simple multi-column list partitioned table, you can issue the following command:

### Objectives
 
In this lab, you will:
* Create Multi Column List Partitioning 

### Prerequisites
This lab assumes you have completed the following lab:

- Provision an ADB Instance (19c, Always Free)

## Task 1: Cleanup

Let us remove all the objects that we will create. Execute the following code snippet. You can safely ignore any 'table does not exist' error message. If a table does not exist, there is nothing wrong with not being able to drop it.

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
 
## Task 2: Create a simple multi-column list partitioned table

```
<copy>
rem simple multi-column list partitioned table
create table mc (col1 number, col2 number)
partition by list (col1, col2)
(partition p1 values ((1,2),(3,4)),
 partition p2 values ((4,4)),
 partition p3 values (default));
</copy>
```
The metadata of this table is as follows. You can also identify multi-column list partitioning by looking at the number of partition keys in the table metadata
```
<copy>
rem table metadata - number of partition keys
select table_name, partitioning_type, partitioning_key_count 
from user_part_tables where table_name='MC';
</copy>
```
Looking at the partition level you will see how the multi-column key values are represented. You will see that the high value of the partitioning metadata indicates that we have multiple columns as partitioning key. Value pairs for the multi-column key are enclosed with parenthesis and multiple value pairs are separated through a comma.
```
<copy>
rem metadata of individual partitions
select partition_name, high_value
from user_tab_partitions where table_name='MC';
</copy>
```

![Image alt text](images/lab8_01.png "Multi List Partition")

Let us now insert some data into our previously created table and see where the data is actually stored, We intentionally insert some data that is explicitly aligned with the partition key values and some other data that isn't. We expect all records that do not match a specific partition to end up in the DEFAULT partition of the table.
```
<copy>
rem insert some sample data
insert into mc values (1,2);
insert into mc values (1,3);
insert into mc values (99,99);
commit;
</copy>
```
Let's now check where the data ended up. We will use first the partition extended syntax to point specifically to partition p1. The only valid records we expect to see are records that either have (1,2) or (3,4) as partition key.
```
<copy>
rem content of partition p1 using partition extended syntax
select * from mc partition (p1);
</copy>
```

![Image alt text](images/lab8_02.png "Multi Column Partition")


With multi-column partitioning you can also use the partition extended syntax with the FOR () clause. Simply point to a fully qualified record, meaning you have to specify a complete partitioning key criteria, which is a value pair in our case. Using the FOR () clause will show you the complete content of the partition that contains the specified partition keys. In the following example we chose a value pair that is not explicitly defined for any of the partitions, so it points to the DEFAULT partition.
```
<copy>
rem content of DEFAULT partition using the partitioned extended syntax PARTITION FOR ()
select * from mc partition for (1,3);
</copy>
```

![Image alt text](images/lab8_03.png "Multi Column Partition")


Note that DEFAULT is not a value, so if you were to try to use it as "value" with the partitioned extended syntax you will get an error:
```
<copy>
rem wrong usage of partition extended syntax: DEFAULT is not a valid partition key value
select * from mc partition for (default);
</copy>
```
After having introduced the basic working of a multi-column partitioned table, let's do a standard partition maintenance operation. You will see that it behaves exactly as it does for any other partitioning method; the only difference is that a fully qualified partition key now obviously consists of value pairs with values for all partition k ey columns.
```
<copy>
rem simple partition maintenance operation, demonstrating split
alter table mc split partition p3 into (partition p3 values (1,3),partition p4) online;
</copy>
```
After the split we expect all records for the newly split partition p3 to contain records with partition key (1,3), and partition p4 to contain the rest .. since this partition is now the new DEFAULT partition. Just like with a single column partitioned table, you can only add a partition to a list partitioned table with a DEFAULT partition by splitting the DEFAULT partition. Oracle cannot simply create a new partition in this case since conceptually all possible partition keys are contained in this catch-it-all partition.

Let's check the content of our "new" partition that we created by splitting the DEFAULT partition:

```
<copy>
rem content of partition p3 after split
select * from mc partition (p3);
</copy>
```

Let's quickly check the metadata of the table again to see what the split did:

```
<copy>
rem partition information for our table
select partition_name, high_value
from user_tab_partitions
where table_name='MC'
order by partition_position;
</copy>
```

The new DEFAULT partition has all the rest of the records:

```
<copy>
rem content of partition p4 after the split, our new DEFAULT partition
select * from mc partition (p4);
</copy>
```

You successfully made it to the end of module 'multi-column list partitioning'. 

## Learn More
 
* [Partitioning When Creating Tables and Indexes](https://docs.oracle.com/en/database/oracle/oracle-database/21/vldbg/partition-create-tables-indexes.html) 

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
