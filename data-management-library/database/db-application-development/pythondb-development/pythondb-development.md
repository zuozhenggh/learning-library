# Developing Python Applications for Oracle Database

## Introduction

In this lab we will connect a Python application to Oracle Database using the cx\_Oracle interface. This interface lets you quickly develop applications that execute SQL or PL/SQL statements. Your applications can also use Oracle's document storage SODA calls. The cx_Oracle API conforms to the Python Database API v2.0 Specification with many additions and a couple of exclusions.

Estimated Time: 20 minutes
 
### Objectives
 
In this lab, you will: 

* Write Python code to access Oracle Database 
* Run the code

### Prerequisites 
This lab assumes you have:

* Python3 and SQL Developer has been installed 
* Database user has been created
* Access to Oracle Database 19c instance
* A valid SSH key pair
   
## Task 1: write *Python* code to select data from table

1. Create *select.py* in the directory */home/oracle/pythondb*

       
      ```
      <copy>
       import cx_Oracle

      connection = cx_Oracle.connect(
      user="james",
      password="welcome1",
      dsn="lldb.livelabs.oraclevcn.com/pdb1.livelabs.oraclevcn.com")

      print("Successfully connected to Oracle Database")

      cursor = connection.cursor()

      connection.commit()

      # Now query the rows back
      for row in cursor.execute('select department_id, department_name from HR.departments'):
      if (row[1]):
            print(row[0], "->", row[1])
      </copy>
      ``` 

      run select.py to view the data in todoitems table

      ```
      <copy>
      [orcl:oracle@lldb:~/pythondb]$ python3 select.py
            Successfully connected to Oracle Database
            10 -> Administration
            20 -> Marketing
            30 -> Purchasing
            40 -> Human Resources
            50 -> Shipping
      </copy>
      ``` 
 
   You successfully made it to the end this lab. You may now  *proceed to the next lab* .  

## Learn More

* [Developing Python Applications for Oracle Autonomous Database](https://www.oracle.com/database/technologies/appdev/python/quickstartpythononprem.html#linux-tab) 
* [How do I start with Node.js](https://nodejs.org/en/docs/guides/getting-started-guide/) 
* [Node Oracle DB examples](https://github.com/oracle/node-oracledb) 
* [Node API Examples](https://oracle.github.io/node-oracledb/doc/api.html#getstarted)   
 
## Acknowledgements

- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** - Kevin Lazarz, Senior Principal Product Manager, Database 
* **Last Updated By/Date** -  Madhusudhan Rao, Mar 2022 
