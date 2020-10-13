# Oracle Scheduler

## Introduction

This lab walks you through the operation of Oracle Scheduler in a RAC database

Estimated Lab Time: 20 Minutes
### Prerequisites

This lab assumes you have completed the following labs:
- Lab: Generate SSH Key
- Lab: Setup DB System
- Lab: Connected to database

### Introduction
Oracle Scheduler, an enterprise job scheduler to help you simplify the scheduling of hundreds or even thousands of tasks. Oracle Scheduler (the Scheduler) is implemented by the procedures and functions in the DBMS_SCHEDULER PL/SQL package.

The Scheduler enables you to control when and where various computing tasks take place in the enterprise environment. The Scheduler helps you effectively manage and plan these tasks. By ensuring that many routine computing tasks occur without manual intervention, you can lower operating costs, implement more reliable routines, minimize human error, and shorten the time windows needed.

The Scheduler provides sophisticated, flexible enterprise scheduling functionality, which you can use to:
* Run database program units
* Run external executables, (executables that are external to the database)
* Schedule job execution using the following methods:
   - Time-based scheduling
   - Event-based scheduling
   - Dependency scheduling
* Prioritize jobs based on business requirements.
* Manage and Monitor jobs
* Operate in a clustered environment

In a RAC database, PL/SQL can execute on any instance - and this must be taken into account when processes are architected. In an Oracle Real Application Clusters environment, the Scheduler uses one job table for each database and one job coordinator for each instance.

The job coordinators communicate with each other to keep information current. The Scheduler attempts to balance the load of the jobs of a job class across all available instances when the job class has no service affinity, or across the instances assigned to a particular service when the job class does have service affinity.

We will take a brief look at this property through two simple tests.

## **Step 1:**  Assign a Job Class to a service and prepare a package to be scheduled

1.  Connect to your cluster nodes with Putty or MAC CYGWIN as described earlier. Open a window to each of the nodes

    ![](./images/clusterware-1.png " ")

2. Confirm which instance is offering the service **svctest**

On node 1:
    ````
    <copy>
    sudo su -oracle
    srvctl status service -d aTFdbVm_mel1nk -s svctest
    </copy>
    ````
3.  Stop the service **svctest**
    ````
    sudo su -oracle
    srvctl stop service -d aTFdbVm_mel1nk -s svctest
    </copy>
    ````

2.  Connect to the pluggable database, **PDB1** as the SH user

    ````
    <copy>
    sudo su -oracle
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    </copy>
    ````

3. As the SH user create a job class and a PL/SQL procedure that we can execute from the job. Note that the service name is case sensitive

    ````
    <copy>
    exec dbms_scheduler.create_job_class('TESTOFF1',service=>'svctest');

    create or replace procedure traceme(id varchar2) as x number;
    begin
       execute immediate 'alter session set tracefile_identifier='||id;
       dbms_session.session_trace_enable(true,true);
	     select count(*) into x from sh.customers;
	     dbms_session.session_trace_disable();
    end traceme;
    /
    </copy>
    ````
    ![](./images/sched-1.png " " )


## **Step 2:** Schedule a job

1. Schedule the job to run immediately with the job class that's tied to the **svctest** service. From your sqlplus session connected to PDB1

    ````
    <copy>
    select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs;

     begin
        dbms_scheduler.create_job('TESTJOB1','PLSQL_BLOCK', job_action=>'begin traceme(''scheduler01''); end;', job_class=>'TESTOFF1',enabled=>true);
     end;
     /

    select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs;  
    </copy>
    ````
If you query user_scheduler_jobs several times, does anything change?

    ````
    SQL> select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs;
    JOB_NAME   SCHEDULE_TYP JOB_CLASS  ENABL AUTO_ STATE
    ---------- ------------ ---------- ----- ----- --------------------
    TESTJOB1   IMMEDIATE    TESTOFF1   TRUE  TRUE  SCHEDULED
    ````

2. Start the **svctest** service and query user_scheduler_jobs again     

    ````
    <copy>
    srvctl start service -d aTFdbVm_mel1nk -s svctest
    </copy>
    ````
    Did the job run?
    You may have to query user_scheduler_jobs several times.

3. Job details are also visible in the view user_scheduler_job_run_details

    ````
    <copy>
    SELECT to_char(log_date, 'DD-MON-YY HH24:MI:SS') TIMESTAMP, job_name, status, additional_info
    FROM user_scheduler_job_run_details ORDER BY log_date;
    </copy>
    ````    

    ````
    TIMESTAMP                   JOB_NAME   STATUS     ADDITIONAL_INFO
    --------------------------- ---------- ---------- --------------------
    25-AUG-20 07:21:46          TESTJOB1   SUCCEEDED
    25-AUG-20 09:22:32          TESTJOB1   SUCCEEDED
    ````

4. What node did the job run on?
Look in the diagnostic_dest for files with the **id** set in the job schedule. The **id** will be in UPPERCASE

On node1, for example:
    ````
    ls -altr /u01/app/oracle/diag/rdbms/atfdbvm_mel1nk/aTFdbVm1/trace/*SCHEDULER01*
    ````
## Step 3 Submitting work to a uniform service
1. Modify the service **svctest** to run on both instances, and then stop this service

    ````
    <copy>
    srvctl modify service -d  aTFdbVm_mel1nk -s svctest -modifyconfig -preferred aTFdbVm1,aTFdbVm2
    srvctl stop service -d  aTFdbVm_mel1nk -s svctest
    </copy>
    ````
2. Submit multiple jobs to the job class


    ````
    <copy>
    begin
      for i in 1..10
        loop
          dbms_scheduler.create_job('TESTJOB'||i,'PLSQL_BLOCK', job_action=>'begin traceme(''scheduler01''); end;', job_class=>'TESTOFF1',enabled=>true);
        end loop;
    end;
       /
    ````    
and view that they are scheduled

    ````
    <copy>
    col job_name format a15
    col job_class format a15
    select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs order by job_name;
    </copy>
    ````

    ````
    SQL> select job_name, schedule_type, job_class, enabled, auto_drop, state from user_scheduler_jobs order by job_name;

    JOB_NAME        SCHEDULE_TYP JOB_CLASS       ENABL AUTO_ STATE
    --------------- ------------ --------------- ----- ----- --------------------
    TESTJOB1        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB10       IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB2        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB3        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB4        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB5        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB6        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB7        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB8        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED
    TESTJOB9        IMMEDIATE    TESTOFF1        TRUE  TRUE  SCHEDULED

    10 rows selected.
    ````  
3. Re-start the **svctest** service again (which will now run on both instances) and view where the jobs executed:

    ````
    srvctl start service -d  aTFdbVm_mel1nk -s svctest
    ````

The view user_scheduler_job_run_details includes the instance name on which the job executed:
    ````
    <copy>
    SELECT to_char(log_date, 'DD-MON-YY HH24:MI:SS') TIMESTAMP, job_name, status, instance_id, additional_info
    FROM user_scheduler_job_run_details ORDER BY log_date;    
    </copy>
    ````

For example
    ````
    TIMESTAMP                   JOB_NAME        INSTANCE_ID ADDITIONAL_INFO
    --------------------------- --------------- ----------- --------------------------------------------------
    28-AUG-20 03:17:01          TESTJOB2                  1
    28-AUG-20 03:17:01          TESTJOB4                  1
    28-AUG-20 03:17:01          TESTJOB1                  2
    28-AUG-20 03:17:01          TESTJOB3                  2
    28-AUG-20 03:17:01          TESTJOB6                  1
    28-AUG-20 03:17:01          TESTJOB8                  1
    28-AUG-20 03:17:02          TESTJOB10                 1
    28-AUG-20 03:17:02          TESTJOB5                  2
    28-AUG-20 03:17:02          TESTJOB7                  2
    28-AUG-20 03:17:02          TESTJOB9                  2
    ````    
Trace files will exist in the trace directory of each node:

On node1 for example:
    ````
    <copy>
    grep "ACTION NAME" `ls /u01/app/oracle/diag/rdbms/atfdbvm_mel1nk/aTFdbVm1/trace/*SCHEDULER*.trc`
    </copy>
    ````

could show for example:

    ````
    aTFdbVm1_j000_46186_SCHEDULER01.trc:*** ACTION NAME:(TESTJOB2) 2020-08-28T03:17:01.244744+00:00
    aTFdbVm1_j000_46186_SCHEDULER01.trc:*** ACTION NAME:(TESTJOB6) 2020-08-28T03:17:01.505230+00:00
    aTFdbVm1_j000_46186_SCHEDULER01.trc:*** ACTION NAME:(TESTJOB10) 2020-08-28T03:17:02.014129+00:00
    aTFdbVm1_j001_46190_SCHEDULER01.trc:*** ACTION NAME:(TESTJOB4) 2020-08-8T03:17:01.277969+00:00
    aTFdbVm1_j001_46190_SCHEDULER01.trc:*** ACTION NAME:(TESTJOB8) 2020-08-28T03:17:01.505278+00:00
    ````

## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** -
* **Last Updated By/Date** - Troy Anthony, Database Product Management, August 2020

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/oracle-maa-dataguard-rac). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
