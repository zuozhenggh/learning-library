# Introduction
This Lab walks you through the steps to the listener control utility which enables you to administer the listener.

Estimated Lab Time: 15 minutes

### About the Product/Technology
Oracle Net Listener is a process that runs on the database server computer. It receives incoming client connection requests and manages the request traffic. Listener configuration information is stored in the listener.ora file and includes one or more listening protocol addresses, information about supported services, and parameters that control its run-time behavior. The listener is configured during the creation of the database. You can use the Listener Control Utility to administer the listener after it is configured.

### Objectives

* View the Listener Configuration
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

The Oracle listener is set to start automatically whenever the host is restarted. If a problem occurs in your system or you have manually stopped the listener, you can restart it by using the ```lsnrctl start``` command.

3. For the purposes of this tutorial, stop the listener by executing the ```lsnrctl stop``` command.

   ```
   lsnrctl stop
   ```

    ```
    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 15-JUL-2019 02:58:16

    Copyright (c) 1991, 2019, Oracle.  All rights reserved.

    Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=host01.example.com)(PORT=1521)))
    The command completed successfully

    ```


    ![Image alt text](images/001_adv.png)

4. The Creation Mode window appears. Select Advanced configuration and click Next.

    ![Image alt text](images/002_adv.png)

5. The Deployment Type window appears. Select the template suited to the type of workload your database will support. If you are not sure which to choose, then select the default General Purpose or Transaction Processing template and click Next.  

    ![Image alt text](images/003_adv.png)

6. The Database Identification window appears. Enter a value in the Global Database Name field. Check "Create as Container database" and click Next.

    ![Image alt text](images/004_adv.png)

7. The Storage Option window appears. Ensure that "Use template file for database storage attributes" is selected and click Next. If you want to specify your own location to store database files select "Use following for the database storage attributes" option.

    ![Image alt text](images/005_adv.png)

8. In the Fast Recovery Option window, select Specify Fast Recovery Area. Accept the default value for the Specify Fast Recovery Area region and click Next.

    ![Image alt text](images/006_adv.png)

9. The Network Configuration window appears. This page displays the listeners in the current home. Select the listener from the list and click Next. If no listeners are listed, create a new listener by selecting the Create a new listener checkbox, provide a Listener name and port, and click Next.

    ![Image alt text](images/007_adv.png)

10. The Data Vault Option window appears. Select Configure Database Vault and/or Configure Label Security if appropriate for your installation. Click Next.

    ![Image alt text](images/008_adv.png)

11. The Configuration Options window appears. Select the Use Automatic Shared Memory Management option. Modify the value for SGA size and PGA size if necessary for your installation and click the Sizing tab.

    ![Image alt text](images/009_adv.png)

12. On the Sizing tab accept the default value in the Processes field or change it as appropriate for your installation. Click the Character sets tab.

    ![Image alt text](images/010_adv.png)

13. On the Character sets tab select Use Unicode (AL32UTF8) or change it as appropriate for your installation. Click the Connection mode tab.
character sets.

    ![Image alt text](images/011_adv.png)

14. On the Connection mode tab accept the default of Dedicated server mode. Click the Sample schemas tab.

     ![Image alt text](images/012_adv.png)

15. The Sample schemas tab appears. Select Add sample schemas to the database and click Next.

     ![Image alt text](images/013_adv.png)

16. The Management Options window appears. Accept the defaults and click Next.

    ![Image alt text](images/014_adv.png)

17. The User Credentials window appears. Select "Use the same administrative password for all accounts." Enter your password in the Password and Confirm password fields. Click Next.

    ![Image alt text](images/015_adv.png)

18. The Creation Option window appears. Review the details and click Next.

     ![Image alt text](images/016_adv.png)

19.  The Summary window appears. Review the information. Click **Finish**.

    ![Image alt text](images/017_adv.png)

20. The Progress Page window appears.

    ![Image alt text](images/018_adv.png)

21. The Database Configuration Assistant window appears indicating that the database has been successfully created. You can click Password Management to unlock the user accounts or you can perform this task at a later time. Click **Close**.

    ![Image alt text](images/019_adv.png)

**Note**: The Create as Container Database option is enabled to create the database as a CDB that can support zero, one, or many user-created PDBs. If you want DBCA to create a PDB when it creates the CDB, specify the PDB name in the Pluggable database name field.


## Acknowledgements
* **Author** - Dimpi Sarmah, Senior UA Developer
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
