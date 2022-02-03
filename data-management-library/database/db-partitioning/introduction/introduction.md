# Introduction

Draft version 1.1 

Partitioning enables large tables and indexes to be subdivided into smaller objects that can be managed and accessed at a finer level of granularity. Oracle Partitioning enhances the manageability, performance and availability of large databases.  It offers comprehensive partitioning methods to address different business requirements and can be applied to transactional, data warehousing, and mixed workload applications without having to change any code.   

Oracle’s data management capabilities complement Oracle Database storage management and compression features to help customers reduce storage costs. Partitioning large tables and indexes in Oracle Database ensure that an optimal method is available for every business requirement and can enhance the manageability, performance and availability of almost any database application. Partitioning allows the breakdown of tables and indexes into smaller physical pieces while keeping the logical view of a single object.

### Challenges with growing Data Volume

Let's consider the financial services sector, particularly retail banking, every time we do a transaction like debit, credit, fixed deposit, recurring deposit, auto EMI payment, utility bill payments etc. It makes an entry into the transaction master table, and the data is growing exponentially, as per the business standard report of December 31, 2021. The volume of digital transactions rose to 55.54 billion in FY21 from 10.85 billion in FY17, at a compounded annual growth rate of 50.42 per cent, according to the Ministry of Electronics & Information Technology (MeitY) India.
 
According to Reserve Bank of India chief GM P Vasudevan, "Last year, around this time, daily transaction volumes were 80-85 million. If we go to June 2016, it was only 22 million. So, in the last five years, we have seen significant growth in digital payments at a CAGR of 58% in volume and 15% in value terms"

So, with the growing volume of data, we can archive a significant portion of historical data into archival storage for on-demand retrieval, however even if we consider data for the current financial year, its in millions of records at a bank level.

To run a query at this level would take a considerable amount of time and impacts the overall performance. It would be best to partition the data into smaller units as per the business requirements and run these queries against this subset of data, which we call a partitioned table.  for example, data can be partitioned based on region, and then sub partitioned based on year or quarter 

![Image alt text](images/intro_01.png "Data Volume")
 
Large tables are difficult to manage, So large databases and indexes can be split into smaller, more manageable pieces. For example, if we have too many events in our database, we can easily partition that table into events based on region and months.  
 

![Image alt text](images/intro_02.png "Data Volume")

Benefits of Partitioning
*	Increases performance by only working on the data that is relevant.
*	Improves availability through individual partition manageability.
*	Decreases costs by storing data in the most appropriate manner.
*	Is easy as to implement as it requires no changes to applications and queries.
*	Is a mature, well proven feature used by thousands of Oracle customers.
*   Partitioning Dramatically reduces amount of data retrieved from storage
*   It Performs operations only on relevant partitions
*   Transparently improves query performance and optimizes resource utilization

Partitioning enables data management operations such as…
*  Data loads, joins and pruning,
*  Index creation and rebuilding,
*  Optimizer statistics management,
*  Backup and recovery

### Manageability
Oracle Partitioning enables database administrators to take a "divide and conquer" approach to data management and perform maintenance operations such as indexing, loading data, compressing data, and purging data on a per-partition basis. For example, a database administrator could merge and compress multiple older partitions in a single operation, moving data onto a low-cost storage tier without disrupting access to data. 

### Performance
Oracle Partitioning address the challenge of performance degradation when faced with growing data volumes by limiting the amount of data to be examined or operated on, thus significantly improving performance beyond what is possible with a non-partitioned table. It fully complements Oracle Database performance features, and is used in conjunction with any indexing technique, join technique, or parallel access method. Plus, partitioning is implemented at the database level and doesn’t require any changes to application code or query statements in order to easily take advantage of performance benefits. This automatically breaks large joins into smaller joins that occur between each of the partitions, completing the overall join in less time and using less resources. This offers significant performance benefits for both serial and parallel query execution.

### Availability
Partitioned database objects provide partition independence, which is an important part of a high availability strategy. For example, if one partition in a table is unavailable, all of the other partitions of the table remain online and accessible. Applications can continue to execute queries and transactions against this partitioned table, and these database operations that do not need to access the unavailable partition will run successfully. Moreover, partitioning can reduce scheduled downtime by enabling database administrators to perform maintenance operations on large database objects in relatively short time windows

Estimated Workshop Time:  120 minutes

## About this Workshop
Oracle provides a comprehensive range of partitioning schemes to address every business requirement. Moreover, since it is entirely transparent in SQL statements, partitioning can be used with any application, from packaged OLTP applications to data warehouses. in this workshop, we will explore various partition types and their corresponding use cases.
 

### Objectives
 
In this workshop, you will learn how to create the following partitions. 

* Range Partitioning
* Interval Partitioning
* List Partitioning
* Hash Partitioning
* Auto-List Partitioning
* Read Only Partitions
* Multi-Column List Partitioning
* Convert Non-partitioned Table to Partitioned Table

### Prerequisites (Optional)

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed
  
## More information and References 

* [Partitioning whitepaper ](https://www.oracle.com/technetwork/database/options/partitioning/partitioning-wp-12c-1896137.pdf) 
* [Partitioning in Oracle Database ](https://livesql.oracle.com/apex/livesql/file/tutorial_EDVE861H5MO8DX16EGJ80HOTK.html) 
* [Business Standard Report ](https://www.business-standard.com/article/economy-policy/digital-transaction-volume-grew-at-50-in-four-years-shows-data-121123101357_1.html) 
* [Business League Report ](https://www.businessleague.in/india-sees-100m-e-payments-daily/) 
* [Database Actions ](https://s1mybyae3gstojp-adw46557.adb.uk-london-1.oraclecloudapps.com/omlusers/) 

## Acknowledgements

- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** -   
* **Last Updated By/Date** - <Name, Month Year>
