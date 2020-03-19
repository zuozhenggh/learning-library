# Enter tutorial title here
## Why Oracle?
Oracle Database In-Memory provides a unique dual-format architecture that enables tables to be simultaneously represented in memory using traditional row format and a new in-memory column format. The Oracle SQL Optimizer automatically routes analytic queries to the column format and OLTP queries to the row format, transparently delivering best-of-both-worlds performance. Oracle Database automatically maintains full transactional consistency between the row and the column formats, just as it maintains consistency between tables and indexes today. The new column format is a pure in-memory format and is not persistent on disk, so there are no additional storage costs or storage synchronization issues.

## Lab Introduction
This series of labs will guide you through the basic configuration of the In-Memory column store (IM
column store) as well as illustrating the benefits of its key features:
- In-Memory Column Store Tables
- In-Memory Joins and Aggregation
- In-Memory High Performance Features

We must first establish a performance baseline. It would be unfair to compare the IM column store with disk accessed data. After all, memory access in general is 10X faster than disk. In order to do a fair comparison the performance baseline will be established using the row store memory space, the buffer cache. For the purposes of the lab, the database environment has been sized so that the tables used will fit in both the row store and the column store. The idea is that no buffer accesses will cause physical I/O.

In the previous lab, you imported a 5 table star schema, ssb, into your compute instance.  This will be used during this lab.

![](img/inmemory/star-schema.png)  

## Required Artifacts
- Each participant has registered via the SSWorkshop system (internal)
- Each participant has obtained a free-tier account