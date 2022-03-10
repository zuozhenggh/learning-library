# How do I access the database after I connect from the terminal?

Duration: 10 minutes

1. Log in as *opc* and then sudo to the grid user.
    login as: opc
    
    ```
    <copy>
    sudo su - grid
    </copy>
    ```

    In your terminal it will look like this:

    ```
    [opc@123456 ~]$ sudo su - grid
    ```

2. List all the databases on the system.

    ```
    <copy>srvctl config database -v</copy>
    ```
    your output will look like this: 

    ```

    root@exampledb ]# srvctl config database -v

    fregerg /u02/app/oracle/product/12.1.0/dbhome_2 12.1.0.2.0
    asfdsdfs /u02/app/oracle/product/11.2.0/dbhome_2 11.2.0.4.0
    ergferf /u02/app/oracle/product/12.1.0/dbhome_3 12.1.0.2.0
    ``` 

3. Connect as the oracle user and get the details about one of the databases by using the srvctl command.

    ```
    <copy>
    su - oracle
    . oraenv
    ```

    Check to make sure appropriate information is inputted. Your output will look like this: 

    ```
    ORACLE_SID = [oracle] ? cdbm01
    The Oracle base has been set to /u02/app/oracle
    [oracle@example123 ~]$ srvctl config database -d cdbm01
    Database unique name: cdbm01 <<== DB unique name
    Database name:
    Oracle home: /u02/app/oracle/product/12.1.0/dbhome_2
    Oracle user: oracle
    Spfile: +DATAC1/cdbm01/spfilecdbm01.ora
    Password file: +DATAC1/cdbm01/PASSWORD/passwd
    Domain: data.customer1.oraclevcn.com
    Start options: open
    Stop options: immediate
    Database role: PRIMARY
    Management policy: AUTOMATIC
    Server pools:
    Disk Groups: DATAC1,RECOC1
    Mount point paths:
    Services:
    Type: RAC
    Start concurrency:
    Stop concurrency:
    OSDBA group: dba
    OSOPER group: racoper
    Database instances: example11,example12 <<== SID
    Configured nodes: example01,example02
    Database is administrator managed
    ```

4. Set the *ORACLE\_SID* and *ORACLE\_UNIQUE\_NAME* using the values from the previous step.

    ```
    [oracle@example123 ~]$ <copy> export ORACLE_UNIQUE_NAME=cdbm01 </copy>
    [oracle@example123 ~]$ <copy> export ORACLE_SID=cdbm011 </copy>
    [oracle@example123 ~]$ <copy> sqlplus / as sysdba </copy>
    ```

    Your output will look like this: 

    ```
    SQL*Plus: Release 12.1.0.2.0 Production on Wed Apr 19 04:10:12 2017

    Copyright (c) 1982, 2014, Oracle. All rights reserved.

    Connected to:
    Oracle Database 12c EE Extreme Perf Release 12.1.0.2.0 - 64bit Production
    With the Partitioning, Real Application Clusters, Automatic Storage Management, Oracle Label Security,
    OLAP, Advanced Analytics and Real Application Testing options
    ```





