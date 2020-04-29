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


## Step 1: Install Python

Python comes preinstalled on most Linux distributions, and it is available as a package on others. The Python packages can be obtained from the software repository of your Linux distribution using the package manager.

1. Open up the Oracle Cloud shell (or terminal of your choice) and ssh into your compute instance as the opc user

        ssh -i <your key name> opc@<your ip address>

2.	Check if python3 has been installed by running the command

````
    python -V
````

3. If Python is not installed then install it
````
    sudo yum -y install python3 python3-tools
````

There is no harm in running this command multiple times, the system will either install packages or let you know they are already installed.

![](./images/p_installPython.jpg)

## Step 2: The Python Interpreter

There are several ways to execute Python code.  In this Step we start with two examples on how to execute Python code from the command line. The first example executing code from the command prompt i.e. executing commands directly in the interpreter. The second example to save your code in a .py file and invoke the interpreter to execute the file.

1. To execute code from command line open the Python command line editor and type the following commands, one by one (each line is one command):

        $ python3
        >>> var1 = "hello world"
        >>> var1
        'hello world'

![](./images/p_python-1.png)

*quit()* from the Python interpreter

2.  To create a simple script, open up a text editor (like vi) and enter the following script.

        var1 = "hello world"
        print(var1)

3. Save the file as *test.py* in the /home/oracle directory.

        $ python3 /home/oracle/test.py

        hello world

1[](./images/p_python-2.png)

## Step 3: Install Python Oracle module and connect to a database

cx\_Oracle is a python module that enables access to Oracle databases.  This module is supported by Oracle 11.2 and higher and works for both Python 2.X and 3.X. There are various ways in which cx\_Oracle can be installed. In this example we will use pip (installed by default for python 3.4 and up). For more ways to install cx\_Oracle (like yum) check the documentation on [https://yum.oracle.com/oracle-linux-python.html#Aboutcx_Oracle](https://yum.oracle.com/oracle-linux-python.html#Aboutcx_Oracle "documentation").

1.  Become the Oracle user

    Since our client libraries are installed in our VM under the oracle user, we will now 'sudo' into the oracle user. (If you have an environment that does not have client libraries accessible to the user running the python3 script, install the Oracle instant client as described in the documentation)

        sudo su - oracle

2.  Install cx_Oracle using pip

    Install the module using python3 and pip for the oracle user:

        python3 -m pip install --user cx_Oracle

![](./images/p_installcxOracle.png)

3.  Test your install by launching the python console and list the available modules

        $. oraenv
        ORACLE_SID = [ORCL] ? ORCL
        The Oracle base remains unchanged with value /u01/app/oracle

        $ python3
        >>> help('modules')

    This command will show you a list of installed modules which should include the cx\_Oracle module we installed in the previous step.

![](./images/p_installcxOracle-2.png)

4.  Connect to the Oracle database and print the version of the database via python.  
    (This confirms you are connected to an Oracle instance and returns the database version)


        >>> import cx_Oracle
        >>> con = cx_Oracle.connect('system/Ora_DB4U@localhost:1521/orclpdb')
        >>> print(con.version)

        19.5.0.0.0 (example output)

        >>> quit()

![](./images/p_python-3.png)

## Step 4: Querying the Oracle database

Retrieving records from Oracle database using cursors is a simple as embedding a SQL statement within a cursor().execute statement. For this example we will use an existing table from with the SH sample schema.

1.  Create a script called /home/oracle/db_connect.py with the following contents:

````
    <copy>import cx_Oracle

        con = cx_Oracle.connect('sh/Ora_DB4U@localhost:1521/orclpdb')

        cur = con.cursor()
        cur.execute('select cust_first_name, cust_last_name,  cust_street_address, cust_city from customer where rownum < 100')

        for row in cur:
          print (row)

        cur.close()

        con.close()
    </copy>    
````

2.  Execute the script and check the result:

        python3 /home/oracle/db_connect.py

    The result should be a list of customers.  
![](./images/p_python-4.png)

Querying Oracle database from Python leverages cursor technology and follows the standard cursor execution cycle: opening a cursor, the fetching stage and closing a cursor to flush the allocated memory. The cursor syntax cx_Oracle uses can be found under: http://cx-oracle.readthedocs.org/en/latest/index.html

Retrieving records from Oracle database using cursors is a simple as embedding the SQL statement within the cursor().execute statement.

**Note** that closing the cursor is considered good practice. Oracle will automatically close the cursor after the execution of its parent block finishes.

## Step 5: Query a JSON table from PYTHON

This section provides detail on how to work with JSON data in Oracle Database 19c using Python’s interface. The exercises include creating a table in the pluggable database ORCLPDB, loading data into the table, validating documents with IS JSON check, and querying data from Python.

1. Create a table to hold our data using the Python Interpreter

Open the Python interpreter and enter the following statements one by one:
````
python3
````
![](./images/p_pythQuery-1.png)

````
import cx_Oracle

con = cx_Oracle.connect('sh/Ora_DB4U@localhost:1521/orclpdb')

cur = con.cursor()

cur.execute('create table test_json (id number generated always as identity, json_data clob)')

````
![](./images/p_pythQuery-2.png)

2. Query the table data.

**Note** the three spaces in front of the *‘print row’* command. These three spaces are a code indentation that indicate a block of code in Python, you must indent each line of the block by the same amount. In this case, ‘print row’ is the block of code we execute in the loop ‘for row in cur:’. Make sure you have those spaces when you execute the command. Hit Enter to close the block of code in the loop.

````
<copy>
cur.execute('select * from test_json')
for row in cur:
   print (row)       
</copy>
````
![](./images/p_pythQuery-3.png)

Python returns an empty row

3. Insert a row in to the table

````
cur.execute('insert into test_json(json_data) values (\'{rating: "3.0 out of 5 stars",title: "Quality product",customer_name: "Geir Gjorven",date: "on 29 January 2020",colour: "Colour Name: Envoy colour",purchase_type: "Verified Purchase",comment: "Good service"}\')')

cur.execute('commit')
````
![](./images/p_pythQuery-4.png)

4. Query the table again

````
<copy>
cur.execute('select * from test_json')
for row in cur:
   print (row)       
</copy>
````
![](./images/p_pythQuery-5.png)
We retrieve the LOB pointer

5. Retrieve the *rating* portion of the JSON document

````
<copy>
cur.execute('select json_value(json_data, \'$.rating\') from test_json')       
</copy>
````

6. Print the current cursor (the rating information)
````
<copy>
for row in cur:
   print (row)       
</copy>
````
![](./images/p_pythQuery-6.png)

7. Retrieve the *comment titles*

````
<copy>
cur.execute('select json_value(json_data, \'$.title\') from test_json')

for row in cur:
   print (row)       
</copy>
````
![](./images/p_pythQuery-7.png)

7. JSON_VALUE and JSON_QUERY
To retrieve a single value of a JSON document, the JSON_VALUE function was used. JSON_VALUE retrieves only one value. JSON_VALUE uses dot-notation syntax – JSON Path Expression – to navigate through a JSON document hierarchy. The dot-notation syntax is a table alias (represented by the ‘$’ sign) followed by a dot (.) and the name of a JSON column we want to retrieve (or more if the document structure includes nested values).
Every cursor.execute() call has to be committed to the database with a ‘commit’ statement. Finally, the results of the query are retrieved by a simple print row call.
Now try retrieving the complete JSON document using JSON_VALUE:

````
<copy>
cur.execute('select json_value(json_data, \'$\') from test_json')

for row in cur:
   print (row)       
</copy>
````
![](./images/p_pythQuery-8.png)

You will notice that no records are returned even though we know they have been populated with data. This is due to JSON_VALUE being able to work only with scalar SQL data types (that is, not an object or collection data type). To retrieve fragments of a JSON document, JSON_QUERY has to be used:

````
<copy>
cur.execute('select json_query(json_data, \'$\') from test_json')

for row in cur:
   print (row)       
</copy>
````
![](./images/p_pythQuery-9.png)

8. Is it JSON? Or NOT?

Insert a second row in to the  *test_json* table in a non-JSON formatted

````
<copy>
cur.execute('insert into test_json (json_data) values (\'<rating> 3.0 out of 5 stars </rating> <title> Quality product </title> <customer_name> "Geir Gjorven </customer_name> <date> on 29 September 2014 </date> <colour> Colour Name: Envoy colour </colour> <purchase_type> Verified Purchase </purchase_type> <comment> Good service </comment>\')')

cur.execute('commit')
</copy>
````
The record is committed to the database without an error because the table does not specifically define its input has to be of JSON format. Check that the record has been added to the table by counting the number of rows *test_json*:

````
<copy>
cur.execute('select count(*) from test_json')

for row in cur: print (row)       

</copy>
````
![](./images/p_pythQuery-10.png)

You can filter out records that do not follow JSON format with IS JSON and IS NOT JSON SQL extensions. First, check if there are any non-JSON records in the table:
````
<copy>
cur.execute('select id from test_json where json_data IS NOT JSON')

for row in cur: print (row)       
</copy>
````
![](./images/p_pythQuery-11.png)
**Note** that the index number may be different in the query executed, in which case change the id from *2* specified in the delete statement following.
Delete the non-JSON row(s) from *test_json*

````
<copy>
cur.execute('delete from test_json where id=2')

cur.execute('commit')
</copy>
````

9. Close the cursor and close the connection
````
<copy>
cur.close()

con.close()
</copy>
````
## Step 6: Load JSON data into a table using PYTHON
It is likely that rather than writing one JSON row at a time to the database, you will want to load many JSON records at once. In this example we will leverage Oracle External Tables functionality to do this.

In the following section we will create a new JSON external table that points to a JSON document and query the records from Python’s shell.

The access driver requires that a DIRECTORY object is defined to specify the location from which to read and write files. A DIRECTORY object assigns a name to a directory name on the file system. For example, the following statement creates a directory object named downloads that is mapped to a directory located at */home/oracle/labs/python/External*. Usually, all directories are created by the SYSDBA user, DBAs, or any user with the CREATE ANY DIRECTORY privilege.

**Note** If you have already completed the HYBRID PARTITIONINING lab the *SH* user has been granted the CREATE ANY DIRECTORY privilege.

1. Connect to the database as SYS and create a new DIRECTORY object
````
sqlplus sys/Ora_DB4U@localhost:1521/orclpdb as sysdba
````

````
<copy>
create directory samples as '/home/oracle/labs/python/External';

grant read,write on directory samples to sh;
</copy>
````
![](./images/p_pyth_cr_dir.png)

2. Open the python interpreter and connect to the Oracle database as the SH user. Open a cursor

````
python3
````

````
import cx_Oracle

con = cx_Oracle.connect('sh/Ora_DB4U@localhost:1521/orclpdb')

cur=con.cursor()
````
3. To create an external table pointing to the JSON document, execute the following in the Python shell:

````
<copy>
cur.execute('create table json (doc clob) organization external (type oracle_loader default directory samples access parameters (records delimited by newline nobadfile nologfile fields (doc char(50000))) location (samples:\'departments.dmp\')) parallel reject limit unlimited')
</copy>
````

4. Query the JSON table retrieving all the documents
````
<copy>
cur.execute('select json_query(doc, \'$\') from json')

for row in cur: print (row)
</copy>
````
![](./images/p_pythQuery-12.png)

5. Top retrieve individual attributes use JSON_QUERY with dot notation

````
<copy>
cur.execute('select json_query(doc, \'$.department\') from json')

for row in cur: print(row)
</copy>
````
![](./images/p_pythQuery-13.png)

6. To count how many employees per department change the query to:
````
<copy>
cur.execute('select json_query(doc, \'$.department\'), count(*)  from json group by json_value(doc, \'$.departments\')')

for row in cur: print(row)
</copy>
````

## Conclusion

In this Lab you had an opportunity to try out connecting Python in the Oracle Database.

## Acknowledgements

- **Author** - Database Partner Technical Services
- **Last Updated By/Date** - Troy Anthony, March 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).   Please include the workshop name and lab in your request.
