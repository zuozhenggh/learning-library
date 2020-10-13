# Services

## Introduction

This lab walks you through the steps to demonstrate many of the capabilities of Oracle Database services.

Estimated Lab Time: 20 Minutes
### Prerequisites

This lab assumes you have completed the following labs:
- Lab: Generate SSH Key
- Lab: Setup DB System
- Lab: Connected to database
- Lab: Install S

### About Oracle Database services

Services represent groups of applications with common attributes, service level thresholds, and priorities. Application functions can be divided into workloads identified by services. You can also group work by type under services. For example, online users can use one service, while batch processing can use another and reporting can use yet another service to connect to the database.

A service can span one or more instances of an Oracle database, multiple databases in a global cluster, and a single instance can support multiple services.  The number of instances that are serving the service is transparent to the application. Services provide a single system image to manage competing applications, and allow each workload to be managed as a single unit.

Response time and CPU consumption metrics, performance and resource statistics, wait events, threshold based alerts, and performance indexes are maintained by the Automatic Workload Repository automatically for all services.  Service, module and action tags are used to identify operations within a service at the server. (MODULE and ACTION are set by the application) End to end monitoring enables aggregation and tracing at Service, Module and Action levels to identify the high load operations. Oracle Enterprise Manager administers the service quality thresholds for response time and CPU consumption, monitors the top services, and provides drill down to the top modules and top actions per service.

Connect time routing and runtime routing algorithms balance the workload across the instances offering a service. RAC use services to enable uninterrupted database operations. Planned operations are supported through interfaces that allow the relocation or disabling/enabling of services.

Application Continuity is set as an attribute of a service.

Oracle recommends that all users who share a service have the same service level requirements. You can define specific characteristics for services and each service can represent a separate unit of work. There are many options that you can take advantage of when using services. Although you do not have to implement these options, using them helps optimize application operation and performance.

For more information on Oracle Database Services visit http://www.oracle.com/goto/ac

 [](https://youtu.be/dIMgaujSydQ)

## **Step 1:**  Create a Service

**NOTE** For simplicity we will often use the EZConnect syntax to specify connect strings to the database:
    user\/password@**\/\/hostname\:port\/servicename**
    EZConnect does not support all service characteristics. A fully specified URL or TNS Connect String is required for Application Continuity and other service characteristics.

1.  Connect to your cluster nodes with Putty or MAC CYGWIN as described earlier. Open a window to each node

    ![](./images/clusterware-1.png " ")

2.  Create a new service **svctest** with *instance1* as a **preferred** instance and *instance2* as an **available instance**. This means that the service will normally run on the *instance1* but will failover to *instance2* if the first instance becomes unavailable.

    ````
    <copy>
    sudo su -oracle
    srvctl add service -d aTFdbVm_mel1nk -s svctest -preferred aTFdbVm1 -available aTFdbVm2 -pdb pdb1
    srvctl start service -d aTFdbVm_mel1nk -s svctest
    </copy>
    ````
    ![](./images/add_service.png " ")

3. Examine where the service is running by using **lsnrctl** to check the SCAN listener or a local listener on each node. **srvctl** will also show you where the service is running.

    ````
    <copy>
    srvctl status service -d aTFdbVm_mel1nk -s svctest
    </copy>
    ````
will show something similar to    
    ````
    [oracle@racnode1 ~]$ srvctl status service -d aTFdbVm_mel1nk -s svctest
    Service svctest is running on instance(s) aTFdbVm1
    ````
    ````
    lsnrctl services
    ````
will show similar to:
    ````
    [oracle@racnode1 ~]$ lsnrctl services
    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 21-AUG-2020 07:22:21
    Copyright (c) 1991, 2019, Oracle.  All rights reserved.
    Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
    Services Summary...

    << Information deleted >>

    Service "svctest.tfexsubdbsys.tfexvcndbsys.oraclevcn.com" has 1 instance(s).
    Instance "aTFdbVm1", status READY, has 1 handler(s) for this service...
    Handler(s):
      "DEDICATED" established:199 refused:0 state:ready
         LOCAL SERVER

    The command completed successfully
    ````    

Note that this service is only active on one instance at a time, so both **local** listeners will not include an entry for this service. In the example shown here, the listener on racnode2 would **not** have an entry for **Service "svctest.tfexsubdbsys.tfexvcndbsys.oraclevcn.com"**

Any of the SCAN listeners will show where the service is offered. Note that SCAN Listeners run from the GI HOME so you have to change the ORACLE_HOME environment variable in order to view the information in the SCAN Listeners

    ````
    <copy>
    export ORACLE_HOME=/u01/app/19.0.0.0/grid
    $ORACLE_HOME/bin/lsnrctl service LISTENER_SCAN2
    </copy>
    ````

which will show something similar to

    ````
    [oracle@racnode2 ~]$ export ORACLE_HOME=/u01/app/19.0.0.0/grid
    [oracle@racnode2 ~]$ $ORACLE_HOME/bin/lsnrctl service LISTENER_SCAN2

    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 21-AUG-2020 07:40:37
    Copyright (c) 1991, 2019, Oracle.  All rights reserved.

    Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=IPC)(KEY=LISTENER_SCAN2)))

    Services Summary...

    Service "aTFdbVmXDB.tfexsubdbsys.tfexvcndbsys.oraclevcn.com" has 2 instance(s).
    Instance "aTFdbVm1", status READY, has 1 handler(s) for this service...
    Handler(s):
      "D000" established:0 refused:0 current:0 max:1022 state:ready
         DISPATCHER <machine: racnode1, pid: 58628>
         (ADDRESS=(PROTOCOL=tcp)(HOST=racnode1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)(PORT=56685))
    Instance "aTFdbVm2", status READY, has 1 handler(s) for this service...
    Handler(s):
      "D000" established:0 refused:0 current:0 max:1022 state:ready
         DISPATCHER <machine: racnode2, pid: 29940>
         (ADDRESS=(PROTOCOL=tcp)(HOST=racnode2.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)(PORT=18719))

    Service "aTFdbVm_mel1nk.tfexsubdbsys.tfexvcndbsys.oraclevcn.com" has 2 instance(s).
    Instance "aTFdbVm1", status READY, has 1 handler(s) for this service...
    Handler(s):
      "DEDICATED" established:0 refused:0 state:ready
         REMOTE SERVER
         (ADDRESS=(PROTOCOL=TCP)(HOST=10.1.20.4)(PORT=1521))
    Instance "aTFdbVm2", status READY, has 1 handler(s) for this service...
    Handler(s):
      "DEDICATED" established:0 refused:0 state:ready
         REMOTE SERVER
         (ADDRESS=(PROTOCOL=TCP)(HOST=10.1.20.5)(PORT=1521))

    Service "pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com" has 2 instance(s).
    Instance "aTFdbVm1", status READY, has 1 handler(s) for this service...
    Handler(s):
      "DEDICATED" established:0 refused:0 state:ready
         REMOTE SERVER
         (ADDRESS=(PROTOCOL=TCP)(HOST=10.1.20.4)(PORT=1521))
    Instance "aTFdbVm2", status READY, has 1 handler(s) for this service...
    Handler(s):
      "DEDICATED" established:0 refused:0 state:ready
         REMOTE SERVER
         (ADDRESS=(PROTOCOL=TCP)(HOST=10.1.20.5)(PORT=1521))

    Service "svctest.tfexsubdbsys.tfexvcndbsys.oraclevcn.com" has 1 instance(s).
    Instance "aTFdbVm1", status READY, has 1 handler(s) for this service...
    Handler(s):
      "DEDICATED" established:0 refused:0 state:ready
         REMOTE SERVER
         (ADDRESS=(PROTOCOL=TCP)(HOST=10.1.20.4)(PORT=1521))
   The command completed successfully
    ````


## **Step 2:** Service Failover

1. Cause the service to fail over

After identifying which instance the service is being offered on, kill that instance by removing the SMON process at the operating system level

    ````
    <copy>
    ps -ef | grep ora_smon
    </copy>
    ````
will show the SMON process id of your database  

    ````
    [oracle@racnode1 ~]$ ps -ef | grep smon
    oracle   39851 39000  0 23:56 pts/0    00:00:00 grep --color=auto smon
    oracle   58569     1  0 Aug18 ?        00:00:13 ora_smon_aTFdbVm1

    ````
In this example the process ID is 585689, which I can pass to the **kill -9 <process id>** command

    ````
    kill -9 586589
    ````

This will cause the instance to fail, any connections to the database on this instance would be lost. The CRS component of Grid Infrastructure would detect the instance failure, and immediately start the service on an **available** instance (based on the service definition). CRS would then restart the database instance.

Rerun the *srvctl status service* command and notice that the service has failed over to the other instance:

    ````
    <copy>
    srvctl status service -d aTFdbVm_mel1nk -s svctest
    </copy>
    ````    

Depending on where your service was running beforehand, you will notice something similar to

    ````
    [oracle@racnode1 ~]$ kill -9 58569
    [oracle@racnode1 ~]$ srvctl status service -d aTFdbVm_mel1nk -s svctest
    Service svctest is running on instance(s) aTFdbVm2
    ````    
2. Manually relocate the service

Open a connection (with SQL*Plus) to the instance where the service is running

    use the SCAN address and the domain qualified service name in the format:

    **sqlplus user/password@//SCAN Address Name/service-name**

    ````
     sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/svctest.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    ````

Using a different putty window (connected to either node) open a SQL*Plus connection as SYS to the PDB associated with this service

    ````
    sqlplus sys/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com as sysdba
    ````
and run the following SQL statement

    ````
    <copy>
    set wrap off
    col service_name format  a20
    select inst_id, service_name, count(*) from gv$session where service_name = 'svctest' group by inst_id, service_name;
    </copy>
    ````
This statement will show you the instance this service is running and the number of open connections on this service. For example:

    ````

    SQL> set wrap off
    SQL> col service_name format  a20
    select inst_id, service_name, count(*) from gv$session where service_name = 'svctest' group by inst_id, service_name; SQL>

    INST_ID     SERVICE_NAME         COUNT(*)
    ---------- -------------------- ----------
       1         svctest                1

    ````

Relocate the service using srvctl

    ````
    <copy>
     srvctl relocate service -d aTFdbVm_mel1nk -s svctest -oldinst aTFdbVm1 -newinst aTFdbVm2
    </copy>
    ````
which will move the service from one instance to another:

    ````
    [oracle@racnode2 ~]$ srvctl status service -d aTFdbVm_mel1nk -s svctest
    Service svctest is running on instance(s) aTFdbVm1
    [oracle@racnode2 ~]$ srvctl relocate service -d aTFdbVm_mel1nk -s svctest -oldinst aTFdbVm1 -newinst aTFdbVm2
    [oracle@racnode2 ~]$ srvctl status service -d aTFdbVm_mel1nk -s svctest
    Service svctest is running on instance(s) aTFdbVm2
    ````
Re-examine the v$session information:

    ````

    SQL> /
    INST_ID     SERVICE_NAME         COUNT(*)
    ---------- -------------------- ----------
       1         svctest                1
    ````
It has not changed.
The relocate service command will not disconnect active sessions unless a force option (**-force**) is specified. A stop service command will allow a drain timeout to be specified to allow applications to complete their work during the drain interval.

## Step 3 **Connection Load Balancing:**
This exercise will demonstrate connection load balancing and why it is important to use the SCAN address and the VIPs as integral parts of your connection strategy

1. Create a uniform service, named \"unisrv\", that is **available** on both instances of your RAC database.

    ````
    <copy>
    srvctl add service srvctl add service -d aTFdbVm_mel1nk -s unisrv -preferred aTFdbVm1,aTFdbVm2 -pdb pdb1
    srvctl start service -d aTFdbVm_mel1nk -s unisrv
    </copy>
    ````
2. Look at the entry for this server in the **lsnrctl service LISTENER_SCAN2** output. Note that any of the SCAN listeners can be used here

    ````
    <copy>
    export ORACLE_HOME=/u01/app/19.0.0.0/grid
    $ORACLE_HOME/bin/lsnrctl service LISTENER_SCAN2
    </copy>
    ````    
where you will see similar to:

    ````
    Service "unisrv.tfexsubdbsys.tfexvcndbsys.oraclevcn.com" has 2 instance(s).
    Instance "aTFdbVm1", status READY, has 1 handler(s) for this service...
    Handler(s):
      "DEDICATED" established:0 refused:0 state:ready
         REMOTE SERVER
         (ADDRESS=(PROTOCOL=TCP)(HOST=10.1.20.4)(PORT=1521))
    Instance "aTFdbVm2", status READY, has 1 handler(s) for this service...
    Handler(s):
      "DEDICATED" established:0 refused:0 state:ready
         REMOTE SERVER
         (ADDRESS=(PROTOCOL=TCP)(HOST=10.1.20.5)(PORT=1521))
    ````
You should notice that an entry for this service is configured for each instance.

2. Edit your tnsnames.ora file (in $ORACLE_HOME/network/admin wherever you are running your client connections from). Add the following two entries:

Note that these tnsnames entries do not comply with the recommended format for continuous availability. They are only used to be illustrative of connection load balancing (CLB)

    ````
    CLBTEST = (DESCRIPTION =
       (ADDRESS = (PROTOCOL = TCP)(HOST = racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)(PORT = 1521))
       (LOAD_BALANCE = no) (FAILOVER = yes)
       (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = unisrv.tfexsubdbsys.tfexvcndbsys.oraclevcn.com) ) )


    CLBTEST-LOCAL = (DESCRIPTION =
        (LOAD_BALANCE = on) (FAILOVER = off)
        (ADDRESS = (PROTOCOL = TCP)(HOST = racnode1)(PORT = 1521))
        (ADDRESS = (PROTOCOL = TCP)(HOST = racnode2)(PORT = 1521))
        (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = unisrv.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)))

    ````
3. Create 10 connections using the alias CLBTEST and look at where the connections were established

    ````
    SQL> select inst_id, service_name, count(*) from gv$session where service_name = 'unisrv' group by inst_id, service_name;

    INST_ID SERVICE_NAME             COUNT(*)
    ---------- -------------------- ----------
         1     unisrv                   4
         2     unisrv                   4

    ````
The SCAN listener attempts to distribute connections based on SESSION COUNT by default. The connections will not always end up equally balanced across instances. You can instruct the listener to use the load on an instance to balance connection attempts (the listener will store run queue information), but this is not the default.

4. Now do the same with the CLBTEST-LOCAL alias (close the first sessions as it will make it easier to illustrate what happens)

    ````  
    INST_ID     SERVICE_NAME          COUNT(*)
    ---------- -------------------- ----------
         1      unisrv                   8
         2      unisrv                   2
    ````
This second case illustrates client-side load balancing. The TNS alias defined, through FAILOVER=ON, instructs an address to be selected at random from the available ADDRESS entries. There is no guarantee of connection balancing. If you disable load balancing \(FAILOVER=OFF\), then the addresses will be tried sequentially until one succeeds. In the case where all instances are available all connections will go to the first ADDRESS in the list:

    ````
    INST_ID    SERVICE_NAME           COUNT(*)
    ---------- -------------------- ----------
      1         unisrv                   10
    ````
5. What if an instance is not available?

Shutdown one of the instances with srvctl - specify \"-f\" as you want to forcibly close services if any are running.
    ````
    <copy>
    srvctl stop instance -d aTFdbVm_mel1nk -i aTFdbVm2 -f
    </copy>
    ````
Attempt to use the CLBTEST-LOCAL alias to connect. If the ADDRESS to the instance you just stopped is chosen, you will see:

    ````
    [oracle@racnode1 ~]$ $ORACLE_HOME/bin/sqlplus sh/W3lc0m3#W3lc0m3#@CLBTEST-LOCAL
    SQL*Plus: Release 19.0.0.0.0 - Production on Mon Aug 24 08:34:32 2020
    Version 19.7.0.0.0
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.

    ERROR:
    ORA-12514: TNS:listener does not currently know of service requested in connect descriptor
    Enter user-name:
    ````
This address could be repeatedly tried \(it is a random access\)    

The CLBTEST alias uses the SCAN address and will only send requests to the available instances

    ````
    [oracle@racnode1 ~]$ $ORACLE_HOME/bin/sqlplus sh/W3lc0m3#W3lc0m3#@CLBTEST
    SQL*Plus: Release 19.0.0.0.0 - Production on Mon Aug 24 08:38:56 2020
    Version 19.7.0.0.0
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.
    Last Successful login time: Mon Aug 24 2020 08:37:33 +00:00

    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0
    SQL>
    ````
6. The Recommended connect string

The recommended connect string for all Oracle Drivers of version 12.2 or later is:

    ````
    Alias (or URL) = (DESCRIPTION =
   (CONNECT_TIMEOUT=90)(RETRY_COUNT=20)(RETRY_DELAY=3)(TRANSPORT_CONNECT_TIMEOUT=3)
   (ADDRESS_LIST =(LOAD_BALANCE=on)
      (ADDRESS = (PROTOCOL = TCP)(HOST=primary-scan)(PORT=1521)))
   (ADDRESS_LIST =(LOAD_BALANCE=on)
      (ADDRESS = (PROTOCOL = TCP)(HOST=secondary-scan)(PORT=1521)))
   (CONNECT_DATA=(SERVICE_NAME = gold-cloud))
    ````    
This is showing how a RAC and Data Guard environment would be specified. The assumption is that both the PRIMARY and SECONDARY sites are clustered environments, hence specifying a SCAN ADDRESS for each one.
Oracle recommends the connection string configuration for successfully connecting at failover, switchover, fallback and basic startup. Set RETRY_COUNT, RETRY_DELAY, CONNECT_TIMEOUT and TRANSPORT_CONNECT_TIMEOUT parameters in the tnsnames.ora file or in the URL to allow connection requests to wait for service availability and connect successfully. Use values that allow for your RAC and Data Guard failover times.

Update your tnsnames.ora file to specify a configuration similar to that above. This connect string will be used in later labs

    ````
    RECSRV=(DESCRIPTION =
   (CONNECT_TIMEOUT=90)(RETRY_COUNT=20)(RETRY_DELAY=3)(TRANSPORT_CONNECT_TIMEOUT=3)
   (ADDRESS_LIST =(LOAD_BALANCE=on)
      (ADDRESS = (PROTOCOL = TCP)(HOST=racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)(PORT=1521)))
   (CONNECT_DATA=(SERVICE_NAME = testy.tfexsubdbsys.tfexvcndbsys.oraclevcn.com)))
    ````
Verify you can connect using this alias.


## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** -
* **Last Updated By/Date** - Troy Anthony, Database Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
