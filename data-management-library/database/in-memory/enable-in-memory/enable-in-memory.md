# Enabling In-Memory

## Section 2-Enabling In-Memory

The Oracle environment is already set up so sqlplus can be invoked directly from the shell environment. Since the lab is being run in a pdb called orclpdb you must supply this alias when connecting to the ssb account. 

1.  Login to the pdb as the SSB user.  
    ````
    <copy>cd /home/oracle/labs/inmemory/Part1
    sqlplus ssb/Ora_DB4U@localhost:1521/orclpdb
    set pages 9999
    set lines 200</copy>
    ````

3.  The In-Memory area is sub-divided into two pools:  a 1MB pool used to store actual column formatted data populated into memory and a 64K pool to store metadata about the objects populated into the IM columns store.  V$INMEMORY_AREA shows the total IM column store.  The COLUMN command in these scripts identifies the column you want to format and the model you want to use.  Alternative script:  `@03_im_usage.sql`

    ````
    <copy>column alloc_bytes format 999,999,999,999;
    column used_bytes format 999,999,999,999;
    column populate_status format a15;
    --QUERY

    select * from v$inmemory_area;</copy>
    ````
     ![](img/inmemory/inmemoryarea.png) 

4.  To check if the IM column store is populated with objects run the 05_im_segments.sql script. Alternative script:  `@05_im_segments.sql` 

    ````
    <copy>column name format a30
    column owner format a20
    --QUERY

    select v.owner, v.segment_name name, v.populate_status status from v$im_segments v; </copy>
    ````
     ![](img/inmemory/segments.png)   

5.  To add objects to the IM column store the inmemory attribute needs to be set.  This tells the Oracle DB these tables should be populated into the IM column store.   Alternative script:  `@06_im_alter_table.sql`

    ````
    <copy>ALTER TABLE lineorder INMEMORY;
    ALTER TABLE part INMEMORY;
    ALTER TABLE customer INMEMORY;
    ALTER TABLE supplier INMEMORY;
    ALTER TABLE date_dim INMEMORY;</copy>
    ````
     ![](img/inmemory/altertable.png)   

6.  This looks at the USER_TABLES view and queries attributes of tables in the SSB schema.  Alternative script:  `@07_im_attributes.sql`

    ````
    <copy>set pages 999
    column table_name format a12
    column cache format a5;
    column buffer_pool format a11;
    column compression heading 'DISK|COMPRESSION' format a11;
    column compress_for format a12;
    column INMEMORY_PRIORITY heading 'INMEMORY|PRIORITY' format a10;
    column INMEMORY_DISTRIBUTE heading 'INMEMORY|DISTRIBUTE' format a12;
    column INMEMORY_COMPRESSION heading 'INMEMORY|COMPRESSION' format a14;
    --QUERY    

    SELECT table_name, cache, buffer_pool, compression, compress_for, inmemory,
        inmemory_priority, inmemory_distribute, inmemory_compression 
    FROM   user_tables; </copy>
    ````
     ![](img/inmemory/imattributes.png)   

By default the IM column store is only populated when the object is accessed.

7.  Let's populate the store with some simple queries. Alternative script:  `@08_im_start_pop.sql`

    ````
    <copy>SELECT /*+ full(d)  noparallel (d )*/ Count(*)   FROM   date_dim d; 
    SELECT /*+ full(s)  noparallel (s )*/ Count(*)   FROM   supplier s; 
    SELECT /*+ full(p)  noparallel (p )*/ Count(*)   FROM   part p; 
    SELECT /*+ full(c)  noparallel (c )*/ Count(*)   FROM   customer c; 
    SELECT /*+ full(lo)  noparallel (lo )*/ Count(*) FROM   lineorder lo; </copy>
    ````
     ![](img/inmemory/startpop.png) 

8. Background processes are populating these segments into the IM column store.  To monitor this, you could query the V$IM_SEGMENTS.  Once the data population is complete, the BYTES_NOT_POPULATED should be 0 for each segment.  Alternative script:  `@09_im_populated.sql`

    ````
    <copy>column name format a20
    column owner format a15
    column segment_name format a30
    column populate_status format a20
    column bytes_in_mem format 999,999,999,999,999
    column bytes_not_populated format 999,999,999,999,999
    --QUERY

    SELECT v.owner, v.segment_name name, v.populate_status status, v.bytes bytes_in_mem, v.bytes_not_populated 
    FROM v$im_segments v;</copy>
    ````

     ![](img/inmemory/im_populated.png) 

9.  Now let's check the total space usage. Alternative script:  `@10_im_usage.sql`

    ````
    <copy>column alloc_bytes format 999,999,999,999;
    column used_bytes      format 999,999,999,999;
    column populate_status format a15;
    select * from v$inmemory_area;</copy>
    exit
    ````

    ![](img/inmemory/im_usage.png) 

In this section you saw that the IM column store is configured by setting the initialization parameter INMEMORY_SIZE. The IM column store is a new static pool in the SGA, and once allocated it can be resized dynamically, but it is not managed by either of the automatic SGA memory features. 

You also had an opportunity to populate and view objects in the IM column store and to see how much memory they use. In this Lab we populated about 1471 MB of compressed data into the  IM column store, and the LINEORDER table is the largest of the tables populated with over 23 million rows.  Remember that the population speed depends on the CPU capacity of the system as the in-memory data compression is a CPU intensive operation. The more CPU and processes you allocate the faster the populations will occur.

Finally you got to see how to determine if the objects were fully populated and how much space was being consumed in the IM column store.
