# Convert Non-partitioned Table to Partitioned Table - PENDING VERIFICATION

## Introduction

Draft version 1.0 

TBD

Let's quickly demonstrate this with a simple example and introduce the rules what such a conversion means to indexes. The full set of details can be found in the documentation.

### Business Challenges 

TBD

### Features

TBD
 
### Objectives
 
In this lab, you will:
* Convert Non-partitioned Table to Partitioned Table

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
 
## Task 2: Convert Non-partitioned Table to Partitioned Table

Let's Convert Non-partitioned Table to Partitioned Table:

```
<copy>
rem sample nonpartitioned table
create table soon2bpart (col1 number primary key, col2 number, col3 number not null, col4 number);
insert /*+ append */ into soon2bpart 
select rownum, mod(rownum,100), mod(rownum,1000), dbms_random.normal from dual connect by level <=10;
commit;
</copy>
```

Our sample table needs a couple of indexes, so let's create them:

```
<copy>
rem create a bunch of different indexes on it
rem some indexes, different shape and type
create index i1_prefix_soon2bpart on soon2bpart(col2);
create index i2_nonprefix_soon2bpart on soon2bpart(col4);
create index i3_prefix_but_ovrd_soon2bpart on soon2bpart(col3, col2);
create index i4_global_part_soon2bpart on soon2bpart(col3) global partition by hash(col3) partitions 4;
create bitmap index i5_bix_soon2bpart on soon2bpart (col2,col3);
</copy>
```

Let's see the index metadata for our table as it exists prior to the conversion:

```
<copy>
rem indexes in general
select index_name, index_type, uniqueness, partitioned, status 
from user_indexes
where table_name='SOON2BPART'
order by 1;
</copy>
```

```
<copy>
rem partitioned index
select index_name, partitioning_type, partition_count, locality 
from user_part_indexes
where table_name='SOON2BPART'
order by 1;
</copy>
```

The conversion is not an in-place conversion: one of the key concepts of Oracle Partitioning is that data of individual partitions is, well, stored in individual physical segments. The nonpartitioned table has data stored "wherever" in the table. So for the duration of the conversion you will need the extra space for the new table partition and index segments. After the successful conversion the space for the old nonpart itioned table and its indexes will be freed.
Let's kick off the conversion of the table. Note that we are doing an online conversion, so if you were able to spawn a second session that does DML against our table while the conversion is in place you'd experience that all your DML will go through without being blocked. We will also rely on the default index conversion rules that are defined, with the exception of one index. This helps to demonstrate the default behavior and to give you a glimpse insight into what you can do for indexes as part of the online conversion:

```
<copy>
rem do an online conversion
rem - only one index will not use default conversion
alter table soon2bpart modify
partition by list (col2) automatic
(partition p1 values (1)) online
update indexes (i3_prefix_but_ovrd_soon2bpart global);
</copy>
```

OK, the table is successfully converted. Let' see the table partitioning metadata:

```
<copy>
rem partitioning metadata
select table_name, partitioning_type, partition_count 
from user_part_tables where table_name='SOON2BPART';
select partition_name, high_value 
from user_tab_partitions where table_name='SOON2BPART'
order by partition_position asc;
</copy>
```

What happened to the indexes? Oracle is smart enough to have a couple of default index conversion rules, that can be overwritten as we demonstrate with one index. The rules are:

Global partitioned indexes are untouched and re tain their shape.
Non-prefixed indexes will become global nonpartitioned tables.
Prefixed indexes will become local partitioned indexes.
Bitmap indexes will become local partitioned indexes.
So let's check the index shape and their status:

```
<copy>
rem indexes general
select index_name, index_type, uniqueness, partitioned, status 
from user_indexes
where table_name='SOON2BPART'
order by 1;
</copy>
```

You see that the conversion rules were applied as discussed, with the exception of index I1B_SOON2BPART which was defined as becoming a global nonpartitioned index as part of the conversion.

```
<copy>
rem partitioned indexes
select index_name, partitioning_type, partition_count, locality 
from user_part_indexes
where table_name='SOON2BPART'
order by 1;
</copy>
```

All the index partitions are also in a valid state:

```
<copy>
rem status of partitioned index
select ip.index_name, ip.status, count(*) cnt
from user_ind_partitions ip, user_indexes i
where i.index_name=ip.index_name and table_name='SOON2BPART'
group by ip.index_name, ip.status
order by 1;
</copy>
```

You successfully made it to the end of module 'conversion to partitioned table'.   

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
