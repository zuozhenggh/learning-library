# Introduction
This lab walks you through the steps to use SQL Developer to create a database connection.

Estimated Lab Time: 5 minutes

## Background
A schema is a collection of database objects. A schema is owned by a database user and shares the same name as the user. Schema objects are logical structures created by users. Some objects, such as tables or indexes, hold data. Other objects, such as views or synonyms, consist of a definition only.

### What Do You Need?

* Oracle Database 21c
* SQL Developer 19.1


## **STEP 1**: Create a Database Connection

A database connection is a SQL Developer object that specifies the necessary information for connecting to a specific database, as a specific user of that database. You must have at least one database connection (existing, created, or imported) to use SQL Developer. To create a database connection , perform the following steps:

1. In a terminal window, set the environment variable. Change directories to the sqldeveloper directory under $ORACLE_HOME. Invoke SQL Developer by executing the sh sqldeveloper.sh command.

    ```
    $ . oraenv
    ORACLE_SID = [oracle] ? orcl
    The Oracle base has been set to /u01/app/oracle
    $ cd $ORACLE_HOME/sqldeveloper
    $ sh sqldeveloper.sh

    Oracle SQL Developer
    Copyright (c) 1997, 2015, Oracle and/or its affiliates. All rights reserved.

    ```
2. In the Connections navigator, right-click the Connections node and select New Connection.

3. Enter a connection name of your choice, username of system and password for the SYSTEM user. Select "Save Password" if you want to save your password for future connections as this user. Accept the default connection type and role. Enter the hostname, port, and SID. You can click Test to ensure that the connection works correctly. Click Connect.

4. Your connection is displayed in the Connections tab on the left side and a SQL worksheet is opened automatically.


## Acknowledgements
* **Last Updated By/Date** - Dimpi Sarmah, Senior UA Developer


## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.
