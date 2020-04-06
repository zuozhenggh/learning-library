# Python Programming

## Introduction


### Objectives

-   Learn how to enable Automatic Indexing in the Oracle Database
-   Learn how Automatic Indexing manages indexes in the Oracle Database
-   Learn how to validate Automatic Index operations

### Lab Prerequisites

This lab assumes you have completed the following labs:
* Lab: Login to Oracle Cloud
* Lab: Generate SSH Key
* Lab: Setup

### Lab Preview

Watch the video below to get an explanation of enabling the XXX feature.

[](youtube:)


## Step 1: Logging In and Examining Schema

1.  All scripts for this lab are stored in the labs/new-features-for-developers/automaticindexing folder and are run as the oracle user.  Let's navigate there now.  We recommend you type the commands to get a feel for working with In-Memory. But we will also allow you to copy the commands via the COPY button.

    ````
    <copy>
    sudo su - oracle
    cd ~/labs/new-features-for-developers/automaticindexing
    ls
    </copy>
    ````

2. Automatic Indexing is integrated into Oracle Database 19c and higher.  Automatic indexing requires little to no manual intervention, but a package called DBMS_AUTO_INDEX package is provided for changing a small number of defaults. 
Create a new tablespace and make this the default for Automatic Indexing (Note that this is not necessary - it is just to illustrate use)

    ````
    <copy>
    . oraenv
    ORCL
    sqlplus SYS/Ora_DB4U/localhost:1521/orclpdb as sysdba
       CREATE TABLESPACE TBS_AUTO_IDX
       DATAFILE '/u01/app/oracle/oradata/DEVCDB/PDB01/tbs_auto_idx01.dbf'
       SIZE 200M REUSE
       AUTOEXTEND ON 
       NEXT 50M MAXSIZE 10G; 
	   
	   exec DBMS_AUTO_INDEX.CONFIGURE('AUTO_INDEX_DEFAULT_TABLESPACE','TBS_AUTO_IDX');

    </copy>
    ````
    Note that this can only be enabled on EXADATA systems. Attempting to enable Automatic Indexing on non-EXADATA machines will result in ORA-40216


3.  Enter the commands to enable Automatic Indexing
    ````
    <copy>
    exec DBMS_AUTO_INDEX.CONFIGURE('AUTO_INDEX_MODE','IMPLEMENT');
    </copy>

    ````
There are three possible values for AUTO_INDEX_MODE configuration setting: OFF (default), IMPLEMENT, and REPORT ONLY. 
   - OFF disables automatic indexing in a database, so that no new auto indexes are created, and the existing auto indexes are disabled. 
   - IMPLEMENT enables automatic indexing in a database and creates any new auto indexes as visible indexes, so that they can be used in SQL statements. 
   - REPORT ONLY enables automatic indexing in a database, but creates any new auto indexes as invisible indexes, so that they cannot be used in SQL statements.

4.  Now let's take a look at the parameters.
    ````
    <copy>
    show sga;
    show parameter inmemory; 
    show parameter keep;
    exit
    </copy>
    ````


## Step 2: Enabling 


## Conclusion

In this Lab you had an opportunity to try out Oracle’s In-Memory performance claims with queries that run against a table with over 23 million rows (i.e. LINEORDER), which resides in both the IM column store and the buffer cache. From a very simple aggregation, to more complex queries with multiple columns and filter predicates, the IM column store was able to out perform the buffer cache queries. Remember both sets of queries are executing completely within memory, so that’s quite an impressive improvement.

These significant performance improvements are possible because of Oracle’s unique in-memory columnar format that allows us to only scan the columns we need and to take full advantage of SIMD vector processiong. We also got a little help from our new in-memory storage indexes, which allow us to prune out unnecessary data. Remember that with the IM column store, every column has a storage index that is automatically maintained for you.

## Acknowledgements

- **Author** - 
- **Last Updated By/Date** - Troy Anthony, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).