# Read Only Partitions - PENDING VERIFICATION

## Introduction

Draft version 1.0 

TBD

### Business Challenges 

TBD

### Features

TBD
 
### Objectives
 
In this lab, you will:
* create Read Only Partitions

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
drop table RDPT2;
</copy>
```
 
## Task 2: Create Read Only Partitions

Let's Create Read Only Partitions Table:

We will demonstrate this functionality using a single level range partitioned table.
```
<copy>
rem simple interval partitioned table with one read only partition
create table ropt (col1, col2, col3) nocompress
partition by range (col1) interval (10)
(partition p1 values less than (1) read only,
 partition p2 values less than (11))
as select rownum, rownum*10, rpad('a',rownum,'b') 
from dual connect by level <= 100;
</copy>
```
    
As you can see, we did specify read only for partition P1 but nowhere else, neither on table nor partition level. Let's see what we ended up with:

```
<copy>
rem metadata
select table_name, def_read_only from user_part_tables where table_name='ROPT';
rem currently existent partitions;
</copy>
```

![Image alt text](images/lab7_01.png "Read only Partition")

```
<copy> 
select partition_name, high_value, read_only
from user_tab_partitions
where table_name='ROPT';
</copy>
```

![Image alt text](images/lab7_02.png "Read only Partition")

As probably expected, we only have one partition that is set to read only in this example. That means that:

The table level default is (and will stay) read write.
Only partition p1 is defined as read only where it was explicitly defined.
You can change the read only/read write attribute for existing partitions.

```
<copy>
rem change the status of a partition to read only
alter table ropt modify partition for (5) read only;
</copy>
```

```
<copy> 
select partition_name, high_value, read_only
from user_tab_partitions
where table_name='ROPT';
</copy>
```

![Image alt text](images/lab7_03.png "Read only Partition")


As partition level attribute, read only can obviously be used in conjunction with other partition maintenance operations. The question now begs what does it really mean for partition maintenance operations, and especially when these PMOPs are executed in an online mode?

The answer is simple: Oracle made the conscious design decision that we do not allow the combination of an online partition maintenance operations and a scenario where either one (or multiple) of the origin partitions are read only or where one (or multiple) of the target partitions (after the PMOP) are set to read only.

So any attempt to combine issue an online PMOP with read only partitions you will get a runtime error, just like in the following split partition example:
```
<copy>
rem online PMOP will not work when one of the target partitions is read only
alter table ropt split partition for (5) into 
(partition pa values less than (7), partition pb read only) online;
</copy>
```

Read only is considered a guaranteed state for the time when a PMOP is started. It would be also ambiguous when to change the state if a change from read write to read only is taking place or vice versa. So for the statement to work you have to run it in offline mode, meaning that no data changes are allowed as soon as the PMOP starts:

```
<copy>
rem offline PMOP
alter table ropt split partition for (5) into 
(partition pa values less than (7), partition pb read only);
</copy>
```

You can also set a whole table to read only. This will change the state for all existing partitions as well as the default of the table.Note that this is in line with other attributes.

```
<copy>
rem set everything read only, including the default property
alter table ropt read only;
</copy>
```

```
<copy> 
select partition_name, high_value, read_only
from user_tab_partitions
where table_name='ROPT';
</copy>
```

![Image alt text](images/lab7_04.png "Read only Partition")

Let's now have a closer look what it means to have a partition set to read only and how Oracle describes data immutability in this context. The fundamental data immutability rule for read only tables and partitions is that only operations are allowed that must not change the data content of the partition at the point in time when a partition was set to read only. Or, in more sql-like words, the result of SELECT  column list at read only setting time  FROM  table  PARTITION  partition set to read only  within the partitioned tables must not change.

So what works?

Any operation that does not change the content, but only the physical representation on disk. A classical example is moving a partition to introduce compression. Let's demonstrate this using a partition of our now fully read only table:

```
<copy>
rem partition pb
select partition_name, high_value, read_only, compression
from user_tab_partitions
where table_name='ROPT' and partition_name='PB';
</copy>
```

Let's move and compress this partition:
```
<copy>
rem do the move and compress
alter table ropt move partition pb compress for oltp;
</copy>
```

The partition move on the read only partition succeeded without raising any error. Checking the partition attributes again you now will see that the partition is compressed.

```
<copy>
rem partition pb
select partition_name, high_value, read_only, compression
from user_tab_partitions
where table_name='ROPT' and partition_name='PB';
</copy>
```

Another operation that works on a table with read only partitions is adding a column. Such an operation works irrespective of whether the new column is nullable or not and whether the column has a default value.

```
<copy>
rem add a column to the table
alter table ropt add (newcol number default 99);
</copy>
```
 
Now, what operations are not allowed? Anything that is considered changing the data immutability as defined earlier. Examples are

Any form of DML on a read only partition:

```
<copy>
rem no DML on read only partitions
update ropt set col2=col2 where col1=88;
</copy>
```

Dropping or truncating a read only partition - since this is semantically equivalent to a DELETE FROM  table WHERE  partitioning criteria :

```
<copy>
rem no drop or truncate partition
alter table ropt drop partition for (56);
Dropping a column (or setting a column to unused):
</copy>
```

```
<copy>
rem drop column is not allowed
alter table ropt drop column col2;
Last but not least, and this is no different to existing read only tables, you can drop a table with one, multiple or all partitions in a read only state:
</copy>
```

![Image alt text](images/lab7_05.png "Read only Partition")

```
<copy>
rem drop everything succeeds
drop table ropt purge;
</copy>
```
 
## Task 3: Another example of readonly partitioned table

```
<copy>
create table RDPT2
(oid    number,
odate   date,
amount  number
)read only
partition by range(odate)
(partition q1_2016 values less than (to_date('2016-04-01','yyyy-mm-dd')),
partition q2_2016 values less than (to_date('2016-07-01','yyyy-mm-dd')),
partition q3_2016 values less than (to_date('2016-10-01','yyyy-mm-dd'))read write,
partition q4_2016 values less than (to_date('2017-01-01','yyyy-mm-dd'))read write);
</copy>
```

Data in a read-only partition or subpartition cannot be modified.

```
<copy>
insert into RDPT2 values(1,to_date('2016-01-20','yyyy-mm-dd'),100); 
</copy>
```
![Image alt text](images/lab7_06.png "Read only Partition")



```
<copy>
insert into RDPT2 values(1,to_date('2016-10-20','yyyy-mm-dd'),100);
insert into RDPT2 values(1,to_date('2016-12-20','yyyy-mm-dd'),100);
</copy>
```

```
<copy>
select * from RDPT2;
</copy>
```

![Image alt text](images/lab7_07.png "Read only Partition")

```
<copy>
rem drop everything succeeds
drop table RDPT2 purge;
</copy>
```

Semantically you are not violating any data immutability when you remove a complete object. If you want to preserve this case you should address this with proper privilege management or, under some circumstances, by disabling the table level lock. The latter one prevents a drop table, but also all other operations that require an exclusive table level lock.

You successfully made it to the end of module 'read only partitions and subpartitions'.    

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [Readonly Partition](https://livesql.oracle.com/apex/livesql/file/content_ED7LSLT4HREACY60G0K23CO9J.html)
* [Database VLDB and Partitioning Guide](https://docs.oracle.com/en/database/oracle/oracle-database/21/vldbg/partition-create-tables-indexes.html)

## Acknowledgements
- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
