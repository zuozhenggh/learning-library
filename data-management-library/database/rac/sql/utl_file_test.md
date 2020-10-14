# Oracle Scheduler

## Introduction

This lab walks you through the operation of PL/SQL packages in a clustered environment

Estimated Lab Time: 10 Minutes
### Prerequisites

This lab assumes you have completed the following labs:
- Lab: Generate SSH Key
- Lab: Setup DB System
- Lab: Connected to database

### Introduction
With any PL/SQL operations on RAC you must be aware that the code could execute on any node where its service lives. This could also impact packages like DBMS_PIPE, UTL_MAIL, UTL_HTTP (proxy server source IP rules for example), or even DBMS_RLS (refreshing policies).

In this example we will use the **UTL_FILE** package as representative of any PL/SQL package that actions outside the database.

In using the **UTL_FILE** package, PL/SQL programs can read and write operating system text files. UTL_FILE provides a restricted version of operating system stream file I/O.

The set of files and directories that are accessible to the user through UTL_FILE is controlled by a number of factors and database parameters. Foremost of these is the set of directory objects that have been granted to the user.

Assuming the user has both READ and WRITE access to the directory object USER_DIR, the user can open a file located in the operating system directory described by USER_DIR, but not in subdirectories or parent directories of this directory.

Lastly, the client (text I/O) and server implementations are subject to operating system file permission checking.

UTL_FILE provides file access both on the client side and on the server side. When run on the server, UTL_FILE provides access to all operating system files that are accessible from the server. On the client side, UTL_FILE provides access to operating system files that are accessible from the client.

## **Step 1:**  Create a DIRECTORY OBJECT and write a file in this location

1.  Connect to your cluster nodes with Putty or MAC CYGWIN as described earlier. Open a window to each of the nodes

    ![](./images/clusterware-1.png " ")

2. Connect to the pluggable database, **PDB1** as the SH user

    ````
    <copy>
    sudo su -oracle
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com
    </copy>
    ````

3. As the SH user create a DIRECTORY OBJECT and use UTL_FILE to write a file in this directory

    ````
    <copy>
    create directory orahome as '/home/oracle';

    declare fl utl_file.file_type;
    begin
        fl := utl_file.fopen('ORAHOME','data.txt','w');
        utl_file.put_line(fl, 'Some sample data for an oracle test.', TRUE);
        utl_file.fclose(fl);  
    end;
    /
    </copy>
    ````
    ![](./images/sched-1.png " " )

4. Exit SQL\*Plus

## **Step 2:** Reconnect to SQL\*Plus and read the file you just created

1. Connect to the pluggable database, **PDB1** as the SH user and read the file **data.txt** 10 or 20 times

    ````
    <copy>
    sudo su -oracle
    sqlplus sh/W3lc0m3#W3lc0m3#@//racnode-scan.tfexsubdbsys.tfexvcndbsys.oraclevcn.com/pdb1.tfexsubdbsys.tfexvcndbsys.oraclevcn.com <<EOF
    declare fl utl_file.file_type;
    begin
        fl := utl_file.fopen('ORAHOME','data.txt','r');
        utl_file.get_line(fl, data);
        utl_file.fclose(fl);  
    end;
    /
    exit;
    EOF
    </copy>
    ````

2. Did some of the *get_line* commands fail? Why?

   Use operating system commands to examine the directory **\/home\/oracle** on each of the cluster nodes
    ````
    <copy>
    cd /home/oracle
    ls -al data.txt
    </copy>
    ````
    ![](./images/sched-1.png " " )


## Acknowledgements
* **Authors** - Troy Anthony, Anil Nair
* **Contributors** -
* **Last Updated By/Date** - Troy Anthony, Database Product Management, August 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like for us to follow up with you, enter your email in the *Feedback Comments* section.
