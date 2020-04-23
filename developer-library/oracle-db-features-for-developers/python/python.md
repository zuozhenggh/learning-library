# Python Programming

## Introduction

PL/SQL is ideal for programming tasks within Oracle Database. Most Oracle professionals, however, aren't confined to working strictly within the database itself.

Python is easy to use but also easy to use well, producing code that is readable and well organized. This way, when you return to a piece of code months after it was written, you can understand it, modify it, and reuse it. Python's clean, elegant syntax is sometimes called "executable pseudocode," for its nearly self-documenting appearance. It is highly object-oriented and makes it easy to learn and follow good programming style, even for those of us without formal training in software engineering. Its smooth learning curve makes it appeal to novices and experts alike.

Python's capabilities span the whole range of software needs; the language's simplicity doesn't imply shallowness or narrowness. You won't run up against gaps in Python's abilities that send you looking for a third language.

Python is open-source, cross-platform, and free of cost. There's no excuse not to give Python a try!

To learn about how to connect to an oracle database from python, watch the video below.

[](youtube:C9op6I-4WM0)

### Objectives

-   Learn how to use Python in the Oracle Database
-   Learn how to validate Python operations

### Lab Prerequisites

This lab assumes you have completed the following labs:
* Lab: Login to Oracle Cloud
* Lab: Generate SSH Key
* Lab: Environment Setup
* Lab: Sample Schema Setup


## Step 1: Lab Setup

Python comes preinstalled on most Linux distributions, and it is available as a package on others. The Python packages can be obtained from the software repository of your Linux distribution using the package manager. 

1. Open up the Oracle Cloud shell (or terminal of your choice) and ssh into your compute instance as the opc user

        ````
        <copy>
        ssh -i <your key name> opc@<your ip address>
        </copy>
        ````

2.	Check if python3 has been installed by running the command

        ````
        <copy>
        sudo yum -y install python3 python3-tools
        </copy>
        ````

The system will either install packages or let you know they are already installed.

## Step 2: Python Programming

There are several ways to execute Python code.  In this Step we start with two examples on how to execute Python code from the command line. The first example executing code from the command prompt i.e. executing commands directly in the interpreter. The second example to save your code in a .py file and invoke the interpreter to execute the file.

1. To execute code from command line open the Python command line editor and type the following commands, one by one (each line is one command): 

        ````
        $ <copy>python3
        var1 = "hello world"</copy>
        var1
        'hello world'
        ````

2.  To create a simple script, open up a text editor (like vi) and enter the following script.

        ````
        <copy>
        var1 = "hello world"
        print(var1)
        </copy>
        ````

3. Save the file as test.py in the /home/oracle directory.

        ````
        <copy>
        $ python3 /home/oracle/test.py
        </copy>
        ````

## Step 3: Install Python Oracle module and connect

cx\_Oracle is a python module that enables access to Oracle databases.  This module is supported by Oracle 11.2 and higher and works for both Python 2.X and 3.X. There are various ways in which cx\_Oracle can be installed. In this example we will use pip (installed by default for python 3.4 and up). For more ways to install cx\_Oracle (like yum) check the documentation on [https://yum.oracle.com/oracle-linux-python.html#Aboutcx_Oracle](https://yum.oracle.com/oracle-linux-python.html#Aboutcx_Oracle "documentation").

1.  Become the Oracle user

    Since our client libraries are installed in our VM under the oracle user, we will now 'sudo' into the oracle user. (If you have an environment that does not have client libraries accessible to the user running the python3 script, install the Oracle instant client as described in the documentation)

        ````
        <copy>
                sudo su - oracle
        </copy>
        ````

2.  Install cx_Oracle using pip

    Install the module using python3 and pip for the oracle user:

        ````
        <copy>
        python3 -m pip install --user cx_Oracle
        </copy>
        ````

3.  Test your install by launching the python console and list the available modules

        ````
        $. oraenv
        ORACLE_SID = [ORCL] ? ORCL
        The Oracle base remains unchanged with value /u01/app/oracle

        $ python3
        help('modules')
````
    This command will show you a list of installed modules which should include the cx\_Oracle module we installed in the previous step.


1.  Connect to the Oracle database and print the version of the database via python.  
    (This confirms you are connected to an Oracle instance and returns the database version) 

        ````
        <copy>
        import cx_Oracle
        con = cx_Oracle.connect('system/Ora_DB4U@localhost:1521/orclpdb')
        print(con.version)
        
        quit()
        </copy>
        ````

## Step 4: Querying the Oracle database
    
Retrieving records from Oracle database using cursors is a simple as embedding the SQL statement within the cursor().execute statement. For this example we will use an existing table that was imported for the In-Memory lab.

1.  Create a script called /home/oracle/db_connect.py with the following contents:

        ````
        <copy>
        import cx_Oracle

        con = cx_Oracle.connect('ssb/Ora_DB4U@localhost:1521/orclpdb')

        cur = con.cursor()
        cur.execute('select c_name,c_address,c_city from customer where rownum < 100')

        for row in cur:
                print (row)

        cur.close()

        con.close()
        </copy>
        ````

2.  Execute the script and check the result:

        ````
        <copy>
        python3 /home/oracle/db_connect.py
        </copy>
        ````

    The result should be a list of customers.  

## Conclusion

In this Lab you had an opportunity to try out connecting Python in the Oracle Database.

## Acknowledgements

- **Author** - Database Partner Technical Services
- **Last Updated By/Date** - Troy Anthony, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request. 
