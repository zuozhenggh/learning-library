# Check that Table is Suitable for Auto Partition Recommendation

## Introduction

 In this Lab, we check to see whether a table is a suitable for the recommendation step.

## Task 1: Call the Validate API

We can check to see if auto partitioning will consider the table:

    <copy>
     declare
     ret varchar2(1000);
     begin
         ret := dbms_auto_partition.validate_candidate_table (table_owner=>user,table_name=>'APART');
         dbms_output.put_line(' ');
         dbms_output.put_line(' ');
         dbms_output.put_line('Auto partitioning validation: ' || ret);
     end;
     /
    </copy>

Auto partitioning needs a workload to test against the candidate table. Currently the workload does not exist, so this message is returned:

`````
 Auto partitioning validation: INVALID: table is referenced by 0 full table scan queries in the SQL tuning set; 5 queries required
`````

## Task 2: Generate a Workload - Execute Test Queries

We will now create a workload that accesses the table. 

Execute queries that scan the APART table. This will generate a workload auto partitioning can test against a partitioned version of the table.

    <copy>
     select /*+ TEST_QUERY */ sum(a) from apart 
     where d between to_date('01-MAR-2020') and to_date('05-mar-2020');
     select /*+ TEST_QUERY */ sum(a) from apart 
     where d = to_date('01-MAR-2020');
     select /*+ TEST_QUERY */ sum(b) from apart 
     where d between to_date('01-JAN-2020') and to_date('05-JAN-2020');
     select /*+ TEST_QUERY */ sum(c) from apart 
     where d between to_date('01-APR-2020') and to_date('05-APR-2020');
     select /*+ TEST_QUERY */ sum(a) from apart 
     where d between to_date('01-JUN-2020') and to_date('02-JUN-2020');
     select /*+ TEST_QUERY */ sum(b) from apart 
     where d between to_date('01-DEC-2020') and to_date('31-DEC-2020');
     select /*+ TEST_QUERY */ sum(a) from apart 
     where d between to_date('01-AUG-2020') and to_date('31-AUG-2020');
     select /*+ TEST_QUERY */ sum(b) from apart 
     where d between to_date('01-OCT-2020') and to_date('01-OCT-2020');
     select /*+ TEST_QUERY */ sum(c) from apart 
     where d between to_date('01-FEB-2020') and to_date('05-FEB-2020');
     select /*+ TEST_QUERY */ sum(a) from apart 
     where d between to_date('01-MAY-2020') and to_date('02-MAY-2020');
     select /*+ TEST_QUERY */ avg(a) from apart 
     where d between to_date('01-JUL-2020') and to_date('02-JUL-2020');
    </copy>

## Task 2: Wait for Automatic SQL Tuning Set (ASTS) Population

The Auto STS Capture Task is responsible for capturing workload SQL in a SQL tuning set called SYS\_AUTO\_STS. This is the _automatic SQL tuning set_ or ASTS and is maintained automatically in Autonomous Database environments. 

Use the following query to monitor the last schedule time and wait until the task has executed again - i.e. _after_ the workload queries were executed.

    <copy>
     select current_timestamp now from dual;
     
     select task_name,
            status,
            enabled,
            interval,
            last_schedule_time, 
            systimestamp-last_schedule_time ago 
     from dba_autotask_schedule_control 
     where dbid = sys_context('userenv','con_dbid') 
     and   task_name like '%STS%';
    </copy>

The interval is 900 seconds by default, so you will need to wait for up to 15 minutes.

`````
NOW
------------------------------------------
07-DEC-21 13.37.15.285689000 EUROPE/LONDON

TASK_NAME                                                        STATUS     ENABL   INTERVAL LAST_SCHEDULE_TIME               AGO                
---------------------------------------------------------------- ---------- ----- ---------- -------------------------------- -------------------
Auto STS Capture Task                                            SUCCEEDED  TRUE         900 07-DEC-21 13.23.14.891000000 GMT +00 00:14:00.492985

`````
Now confirm that the workload queries have been captured in the autmatic SQL tuning set.

    <copy>
     select sql_text 
     from   dba_sqlset_statements 
     where  sql_text like '%TEST_QUERY%'
     and    sqlset_name = 'SYS_AUTO_STS';
    </copy>

`````
SQL_TEXT                                                                                                                                              
---------------------------------------------------
select /*+ TEST_QUERY */ sum(b) from apart where d between to_date('01-OCT-2020'                                                                      
select /*+ TEST_QUERY */ sum(a) from apart where d = to_date('01-MAR-2020')                                                                           
select /*+ TEST_QUERY */ sum(b) from apart where d between to_date('01-JAN-2020'                                                                      
select /*+ TEST_QUERY */ avg(a) from apart where d between to_date('01-JUL-2020'   
...etc
`````

## Task 4: Call the Validate API Again

We'll try validating again:

    <copy>
     declare
     ret varchar2(1000);
     begin
         ret := dbms_auto_partition.validate_candidate_table (table_owner=>user,table_name=>'APART');
         dbms_output.put_line(' ');
         dbms_output.put_line(' ');
         dbms_output.put_line('Auto partitioning validation: ' || ret);
     end;
     /
    </copy>

When the following message is returned, we are ready to run the auto partitioning _recommend_ step:

`````
Auto partitioning validation: VALID
`````
