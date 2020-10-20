# Parallel Execution

## Introduction
This lab walks you through the operation of Parallel Execution

Estimated Lab Time: 20 Minutes

### Prerequisites
- An Oracle LiveLabs or Paid Oracle Cloud account
- Lab: Generate SSH Key
- Lab: Build a DB System

### About Parallel Execution
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

## **STEP 1:**  Grant DBA to the SH user
1.  If you aren't aady logged in to the Oracle Cloud, open up a web browser and re-login to Oracle Cloud. 

2.  Start Cloudshell
   
    *Note:* You can also use Putty or MAC Cygwin if you chose those formats in the earlier lab.  
    ![](../clusterware/images/start-cloudshell.png " ")

3.  Connect to node 1 (you identified the IP in an earlier lab). 

    ````
    ssh -i ~/.ssh/sshkeyname opc@<<Node 1 Public IP Address>>
    ````
    ![](../clusterware/images/racnode1-login.png " ")

4.  Switch to the oracle user and connect to the pluggable database, **PDB1** as SYSDBA

    ````
    <copy>
    sudo su - oracle
    sqlplus sys/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com as sysdba
    </copy>
    ````

5. Grant DBA to SH

    ````
    <copy>
    grant dba to sh;
    </copy>
    ````
## **STEP 2:** Run a parallel query operation

1. Ensure that the **testy** service created earlier is running on instance 1. Connect to this service as the SH user. Connect on node 1.
   
    ````
    sudo su - oracle
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
3.  This command will show the following
   
    ````
    SID
    -----
    343

    SQL> SQL> SQL> SQL> SQL> SQL>

    SID   USERNAME   PROGRAM                                   SERVICE_NAME
    ----- ---------- ---------------------------------------- --------------------
        343    SH        sqlplus@racnode1 (TNS V1-V3)               testy
    ````

4. Enable tracing and use a HINT to force parallel execution of a SQL query

    ![](./images/pq-1.png " " )

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

5. Look for the trace files to see which node the PX (parallel execution processes) ran on

    ````
    <copy>
    col value format a60
    select inst_id, value from gv$parameter where name='diagnostic_dest';
    </copy>
    ````    

6. The diagnostic_dest will be displayed.

    ````
    SQL>
    INST_ID     VALUE
    ---------- -------------------
       1        /u01/app/oracle/
       2        /u01/app/oracle/
    ````
7. From the operating system, search for trace files containing the client identifier set above, racpx01

    ````
    <copy>
    ls -altr /u01/app/oracle/diag/rdbms/atfdbvm_mel1nk/aTFdbVm1/trace/*racpx01*.trc
    </copy>
    ````
    ![](./images/pq-2.png " " )

    QUESTION:  Were any parallel execution processes started on node2? Look in the /u01/app/oracle/diag/rdbms/atfdbvm_mel1nk/aTFdbVm2/trace directory

7. Relocate the **testy** service to instance 2, but keep your client connection on racnode1, and repeat steps 1 - 3

    ````
    srvctl relocate service -d aTFdbVm_mel1nk -s testy -oldinst aTFdbVm1
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/testy.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    ````

8. Your connection details will now be similar to
   
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

9. Choose a new trace file identifier and run the SELECT statement again
    
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
10. Where are the trace files located now?
    ![](./images/pq-3.png " " )
    ![](./images/pq-4.png " " )

11. On racnode2
    ![](./images/pq-5.png " " )

In Oracle RAC systems, the service placement of a specific service controls parallel execution. Specifically, parallel processes run on the nodes on which the service is configured. By default, Oracle Database runs parallel processes only on an instance that offers the service used to connect to the database. This does not affect other parallel operations such as parallel recovery or the processing of GV$ queries.

You may now *proceed to the next lab*.  

## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** - Kay Malcolm
* **Last Updated By/Date** - Kay Malcolm, October 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
