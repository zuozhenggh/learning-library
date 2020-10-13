# Parallel Execution

## Introduction

This lab walks you through the operation of Parallel Execution

Estimated Lab Time: 20 Minutes
### Prerequisites

This lab assumes you have completed the following labs:
- Lab: Generate SSH Key
- Lab: Setup DB System
- Lab: Connected to database

### Introduction
Parallel execution enables the application of multiple CPU and I/O resources to the execution of a single SQL statement. Parallel execution is sometimes called parallelism. Parallelism is the idea of breaking down a task so that, instead of one process doing all of the work in a query, many processes do part of the work at the same time.

Parallel execution improves processing for:
* Queries requiring large table scans, joins, or partitioned index scans
* Creation of large indexes
* Creation of large tables, including materialized views
* Bulk insertions, updates, merges, and deletions

Parallel execution benefits systems with all of the following characteristics:
* Symmetric multiprocessors (SMPs), clusters, or massively parallel systems
* Sufficient I/O bandwidth
* Underutilized or intermittently used CPUs (for example, systems where CPU usage is typically less than 30%)
* Sufficient memory to support additional memory-intensive processes, such as sorting, hashing, and I/O buffers

If your system lacks any of these characteristics, parallel execution might not significantly improve performance. In fact, parallel execution may reduce system performance on overutilized systems or systems with small I/O bandwidth.

The benefits of parallel execution can be observed in DSS and data warehouse environments. OLTP systems can also benefit from parallel execution during batch processing and during schema maintenance operations such as creation of indexes. The average simple DML or SELECT statements that characterize OLTP applications would not experience any benefit from being executed in parallel.

## **Step 1:**  Grant DBA to the SH user

1.  Connect to your cluster nodes with Putty or MAC CYGWIN as described earlier. Open a window to one of the nodes

    ![](./images/clusterware-1.png " ")

2.  Connect to the pluggable database, **PDB1** as SYSDBA

    ````
    <copy>
    sudo su -oracle
    sqlplus sys/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com as sysdba
    </copy>
    ````

3. Grant DBA to SH

    ````
    <copy>
    grant dba to sh;
    </copy>
    ````
## **Step 2:** Run a parallel query operation

1. Ensure that the **testy** service created earlier is running on instance 1. Connect to this service as the SH user

On node 1:
    ````
    sudo su -oracle
    srvctl status service -d aTFdbVm_mel1nk -s testy
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/testy.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    </copy>
    ````
2. Show your connection details
    ````
    <copy>
    select sid from v$mystat where rownum=1;
    col sid format 9999
    col username format a10
    col program format a40
    col service_name format a20
    set linesize 100
    select sid, username, program, service_name from v$session where username='SH';
    </copy>
    ````
    which will show similar to
    ````
    SID
   -----
    343

    SQL> SQL> SQL> SQL> SQL> SQL>

    SID   USERNAME   PROGRAM                                   SERVICE_NAME
    ----- ---------- ---------------------------------------- --------------------
     343    SH        sqlplus@racnode1 (TNS V1-V3)               testy
    ````

3. Enable tracing and use a HINT to force parallel execution of a SQL query
    ````
    <copy>
    exec dbms_session.set_identifier('racpx01');
    alter session set tracefile_identifier = 'racpx01';
    exec dbms_monitor.client_id_trace_enable(client_id=>'racpx01');

    select /*+parallel*/ p.prod_name, sum(s.amount_sold) from products p, sales s
    where p.prod_id = s.prod_id group by p.prod_name;

    exec dbms_monitor.client_id_trace_disable(client_id=>'racpx01');    
    </copy>
    ````
    ![](./images/pq-1.png " " )

3. Look for the trace files to see which node the PX (parallel execution processes) ran on

    ````
    <copy>
    col value format a60
    select inst_id, value from gv$parameter where name='diagnostic_dest';
    </copy>
    ````    

diagnostic_dest will be displayed:
    ````
    SQL>
    INST_ID     VALUE
    ---------- -------------------
       1        /u01/app/oracle/
       2        /u01/app/oracle/
    ````
    From the operating system, search for trace files containing the client identifier set above, racpx01

    ````
    <copy>
    ls -altr /u01/app/oracle/diag/rdbms/atfdbvm_mel1nk/aTFdbVm1/trace/*racpx01*.trc
    </copy>
    ````
    ![](./images/pq-2.png " " )

    Were any parallel execution processes started on node2? Look in the /u01/app/oracle/diag/rdbms/atfdbvm_mel1nk/aTFdbVm2/trace directory

4. Relocate the testy service to instance 2, but keep your client connection on racnode1, and repeat steps 1 - 3

    ````
    srvctl relocate service -d aTFdbVm_mel1nk -s testy -oldinst aTFdbVm1
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/testy.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    ````
Your connection details will now be similar to
    ````
    SQL> select sid from v$mystat where rownum=1;

        SID
       ----------
        332

    SQL>     col sid format 9999
    SQL>     col username format a10
    SQL>     col program format a40
    SQL>     col service_name format a20
    SQL>     set linesize 100
    SQL>     select sid, username, program, service_name from v$session where username='SH';

    SID   USERNAME   PROGRAM                                  SERVICE_NAME
    ----- ---------- ---------------------------------------- --------------------
     332   SH         sqlplus@racnode1 (TNS V1-V3)             testy
    ````

Choose a new trace file identifier and run the SELECT statement again
    ````
    <copy>
    exec dbms_session.set_identifier('racpx05');
    alter session set tracefile_identifier = 'racpx05';
    exec dbms_monitor.client_id_trace_enable(client_id=>'racpx05');

    select /*+parallel*/ p.prod_name, sum(s.amount_sold) from products p, sales s
    where p.prod_id = s.prod_id group by p.prod_name;

    exec dbms_monitor.client_id_trace_disable(client_id=>'racpx05');
    </copy>
    ````  
Where are the trace files located now?
    ![](./images/pq-3.png " " )
    ![](./images/pq-4.png " " )

On racnode2
    ![](./images/pq-5.png " " )

In Oracle RAC systems, the service placement of a specific service controls parallel execution. Specifically, parallel processes run on the nodes on which the service is configured. By default, Oracle Database runs parallel processes only on an instance that offers the service used to connect to the database. This does not affect other parallel operations such as parallel recovery or the processing of GV$ queries.


## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** -
* **Last Updated By/Date** - Troy Anthony, Database Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
