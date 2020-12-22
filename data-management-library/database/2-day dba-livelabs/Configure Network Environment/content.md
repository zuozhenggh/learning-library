# Introduction
This Lab walks you through the steps to administer the listener using the listener control utility.

Estimated Lab Time: 15 minutes

## Background
Oracle Net Listener is a process that runs on the database server computer. It receives incoming client connection requests and manages the request traffic. Listener configuration information is stored in the listener.ora file and includes one or more listening protocol addresses, information about supported services, and parameters that control its run-time behavior. The listener is configured during the creation of the database. You can use the Listener Control Utility to administer the listener after it is configured.

### Objectives

* View the Listener Configuration to display basic status information about a listener.
* Start the Listener

### What Do You Need?

Install and Create the Oracle Database 21c.

## **STEP 1**: View the Listener Configuration

Use the Listener Control utility <code>STATUS</code> command to display basic status information about a listener, including a summary of listener configuration settings, listening protocol addresses, and a summary of services registered with the listener. To execute the ```STATUS``` command, perform the following steps:

1. Open a terminal window and execute the ```oraenv``` command to set the environment variables.

    ```
    $ . oraenv
    ORACLE_SID = [oracle] ? orcl
    The Oracle base has been set to /scratch/u01/app/oracle

    ```
2. Execute the ```lsnrctl status``` command.

    ```
    $lsnrctl status
    ```
    ```
    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 15-JUL-2019 01:09:40

      Copyright (c) 1991, 2019, Oracle.  All rights reserved.

      Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=host01.example.com)(PORT=1521)))
      STATUS of the LISTENER
      ------------------------
      Alias                     LISTENER
      Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
      Start Date                10-JUL-2019 01:32:04
      Uptime                    4 days 23 hr. 37 min. 36 sec
      Trace Level               off
      Security                  ON: Local OS Authentication
      SNMP                      OFF
      Listener Parameter File   /scratch/u01/app/oracle/product/19.0.0/dbhome_1/network/admin/listener.ora
      Listener Log File         /scratch/u01/app/oracle/diag/tnslsnr/host01/listener/alert/log.xml
      Listening Endpoints Summary...
        (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=host01.example.com)(PORT=1521)))
        (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
        (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=host01.example.com)(PORT=5500))(Security=(my_wallet_directory=/scratch/u01/app/oracle/admin/orcl/xdb_wallet))(Presentation=HTTP)(Session=RAW))
      Services Summary...                                                                                                                                                                                            
      Service "86b637b62fdf7a65e053f706e80a27ca.us.oracle.com" has 1 instance(s).                                                                                                                                    
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      Service "8d50ba5e384412fbe053193ec40a5c2c.us.oracle.com" has 1 instance(s).                                                                                                                                    
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      Service "orcl.us.oracle.com" has 1 instance(s).                                                                                                                                                                
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      Service "orclXDB.us.oracle.com" has 1 instance(s).                                                                                                                                                             
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      Service "orclpdb.us.oracle.com" has 1 instance(s).                                                                                                                                                             
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      The command completed successfully
      ```

## **STEP 2**: Start the Listener

The Oracle listener is set to start automatically whenever the host is restarted. If a problem occurs in your system or you have manually stopped the listener, you can restart it by using the `lsnrctl start` command.

1. For the purposes of this tutorial, stop the listener by executing the `lsnrctl stop` command.

     ```
     lsnrctl stop

     ```

    ```
    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 15-JUL-2019 02:58:16

    Copyright (c) 1991, 2019, Oracle.  All rights reserved.

    Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=host01.example.com)(PORT=1521)))
    The command completed successfully

    ```


2. Now that the listener is stopped, log in to SQL*Plus as the `SYSTEM` user using the `orcl` service name to determine whether you can still connect to the database. The Creation Mode window appears.

    ```
    sqlplus system@orcl
    SQL*Plus: Release 19.0.0.0.0 - Production on Mon Jul 15 03:00:11 2019
    Version 19.3.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password:
    ERROR:
    ORA-12541: TNS:no listener
    ```

    Exit the prompt by pressing Ctrl + C followed by Enter.

3. Restart the listener by using the `lsnrctl start` command.

    ```
    lsnrctl start

    ```
  ```
  LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 15-JUL-2019 03:01:00

    Copyright (c) 1991, 2019, Oracle.  All rights reserved.

    Starting /scratch/u01/app/oracle/product/19.0.0/dbhome_1/bin/tnslsnr: please wait...

    TNSLSNR for Linux: Version 19.0.0.0.0 - Production
    System parameter file is /scratch/u01/app/oracle/product/19.0.0/dbhome_1/network/admin/listener.ora
    Log messages written to /scratch/u01/app/oracle/diag/tnslsnr/host01/listener/alert/log.xml
    Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=host01.example.com)(PORT=1521)))
    Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))

    Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=host01.example.com)(PORT=1521)))
    STATUS of the LISTENER
    ------------------------
    Alias                     LISTENER
    Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
    Start Date                15-JUL-2019 03:01:01
    Uptime                    0 days 0 hr. 0 min. 0 sec
    Trace Level               off
    Security                  ON: Local OS Authentication
    SNMP                      OFF
    Listener Parameter File   /scratch/u01/app/oracle/product/19.0.0/dbhome_1/network/admin/listener.ora
    Listener Log File         /scratch/u01/app/oracle/diag/tnslsnr/host01/listener/alert/log.xml
    Listening Endpoints Summary...
      (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=host01.example.com)(PORT=1521)))
      (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
    The listener supports no services
    The command completed successfully

    ```

4. Check the listener status by executing the `lsnrctl status` command.

       ```
       $ lsnrctl status

       ```
       ```
       LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 15-JUL-2019 01:09:40

      Copyright (c) 1991, 2019, Oracle.  All rights reserved.

      Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=host01.example.com)(PORT=1521)))
      STATUS of the LISTENER
      ------------------------
      Alias                     LISTENER
      Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
      Start Date                10-JUL-2019 01:32:04
      Uptime                    4 days 23 hr. 37 min. 36 sec
      Trace Level               off
      Security                  ON: Local OS Authentication
      SNMP                      OFF
      Listener Parameter File   /scratch/u01/app/oracle/product/19.0.0/dbhome_1/network/admin/listener.ora
      Listener Log File         /scratch/u01/app/oracle/diag/tnslsnr/host01/listener/alert/log.xml
      Listening Endpoints Summary...
        (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=host01.example.com)(PORT=1521)))
        (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
        (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=host01.example.com)(PORT=5500))(Security=(my_wallet_directory=/scratch/u01/app/oracle/admin/orcl/xdb_wallet))(Presentation=HTTP)(Session=RAW))
      Services Summary...                                                                                                                                                                                            
      Service "86b637b62fdf7a65e053f706e80a27ca.us.oracle.com" has 1 instance(s).                                                                                                                                    
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      Service "8d50ba5e384412fbe053193ec40a5c2c.us.oracle.com" has 1 instance(s).                                                                                                                                    
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      Service "orcl.us.oracle.com" has 1 instance(s).                                                                                                                                                                
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      Service "orclXDB.us.oracle.com" has 1 instance(s).                                                                                                                                                             
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      Service "orclpdb.us.oracle.com" has 1 instance(s).                                                                                                                                                             
        Instance "orcl", status READY, has 1 handler(s) for this service...                                                                                                                                          
      The command completed successfully

      ```
Note: If the PDB is configured, you will see a service for each PDB.

5. Once again log in to SQL*Plus as the `SYSTEM` user to verify you can now connect to the database.

     ```
     $ sqlplus system@orcl
     ```

    ```
    SQL*Plus: Release 19.0.0.0.0 - Production on Mon Jul 15 03:01:37 2019 Version 19.3.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Enter password:
    Last Successful login time: Mon Jul 15 2019 03:01:34 -07:00

    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0


    SQL>
    ```

## Acknowledgements
* **Last Updated By/Date** - Dimpi Sarmah, Senior UA Developer

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
