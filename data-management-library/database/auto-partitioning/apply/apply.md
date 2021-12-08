# Create the Recommended Partitioned Table

## Introduction

In this lab, we will accept the partitioning recommendation and create the partitioned table.

## Task 1: Accept Recommendation and Build the Partitioned Table

In the previous lab, the PL/SQL procedure displayed a recommendation ID similar to this example:

`````
=============================================
ID:     D28FC3CF09DF1E1DE053D010000AF8F8
Method: LIST(SYS_OP_INTERVAL_HIGH_BOUND("D", INTERVAL '2' MONTH, TIMESTAMP '2020-01-01 00:00:00')) AUTOMATIC 
Key   : D
=============================================
`````

The recommendation ID is also displayed at the top of the recommendation report.

Execute the following command, entering the recomendation ID when prompted:

    <copy>
       exec dbms_auto_partition.apply_recommendation('&recommendation_id');
    </copy>

A partitioned version of the table will be build on-line using an ALTER TABLE MODIFY PARTITION ONLINE command. It will take approximately 10 minutes for a 5GB table in a 19c Always Free instance.

## Task 2: Confirm that the Table Has Been Partitioned

We now have a partitioned APART table:

    <copy>
    set trims on
    set linesize 300
    column partition_name format a20
    column segment_name format a15
    
    select segment_name,
           partition_name,
           segment_type,
           bytes/(1024*1024) mb
    from   user_segments
    order by partition_name;
    </copy>

`````
SEGMENT_NAME  PARTITION_NAME       SEGMENT_TYPE               MB
------------- -------------------- ------------------ ----------
APART         P_NULL               TABLE PARTITION         .0625
APART         SYS_P1576            TABLE PARTITION           936
APART         SYS_P1577            TABLE PARTITION           952
APART         SYS_P1578            TABLE PARTITION           952
APART         SYS_P1579            TABLE PARTITION           968
APART         SYS_P1580            TABLE PARTITION           952
APART         SYS_P1581            TABLE PARTITION           816
`````