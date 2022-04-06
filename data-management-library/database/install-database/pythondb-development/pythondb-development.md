# Developing Python Applications for Oracle Database

## Introduction

TBD.

Estimated Time: 20 minutes

### About TBD

some content.. . 

### Difference between CDB and PDB

some content.. . 
  
### Objectives
 
In this lab, you will enable:
* some content.. . 
* some content.. .  

### Prerequisites 
This lab assumes you have:

* TBD
* A Valid SSH Key Pair
   
## Task 1: Connect to SQL Developer create database user

1. Connect to SQL Developer

      ![Accept License](images/sqldev-pdb1.png "Accept License") 

2. Create user and grant access to user

      ```
      <copy>
            [orcl:oracle@x:~/pythondb]$ sudo yum install -y python3  
            [orcl:oracle@x:~/pythondb]$ python3 -m pip install cx_Oracle --upgrade --user
            Collecting cx_Oracle
            Downloading https://files.pythonhosted.org/packages/ec/28/84cc23a2d5ada575d459a8d260286d99dde4b00cafcc34ced7877b3c9bf0/cx_Oracle-8.3.0-cp36-cp36m-manylinux_2_5_x86_64.manylinux1_x86_64.manylinux_2_12_x86_64.manylinux2010_x86_64.whl (858kB)
            100% |ââââââââââââââââââââââââââââââââ| 860kB 1.7MB/s 
            Installing collected packages: cx-Oracle
            Successfully installed cx-Oracle-8.3.0
      </copy>
      ``` 
 

      Grant access to HR schema departments table to user james, by default this table is not visible to the user that we have created in this lab. 

      ```
      <copy>
            GRANT
            SELECT,
            INSERT,
            UPDATE,
            DELETE
            ON
                  HR.employees
            TO
                  james;
      </copy>
      ``` 

## Task 2: NodeJS code to create table and insert few records
 
4. Create folder nodedb under */home/oracle/* and create following files in that folder  

      *package.json*

      ```
      <copy>
            {
            "name": "Demo",
            "version": "1.0.0",
            "private": true,
            "description": "Demo app",
            "keywords": [
                  "myapp"
            ],
            "dependencies": {
                  "oracledb": "^5.1.0"
            },
            "author": "You",
            "license": "MIT"
            }
      </copy>
      ``` 

      NodeJS code to create table, insert data and select data in file *insertdata.js*
   
      ```
      <copy>
            const oracledb = require('oracledb');

    async function run() {

      let connection;

      try {

        connection = await oracledb.getConnection({ user: "james", password: "welcome1", 
        connectionString: "lldb.livelabs.oraclevcn.com/pdb1.livelabs.oraclevcn.com" });

        console.log("Successfully connected to Oracle Database"); 

        await connection.execute(`begin
                                    execute immediate 'drop table todoitem';
                                    exception when others then if sqlcode <> -942 then raise; end if;
                                  end;`);

        await connection.execute(`create table todoitem (
                                    id number generated always as identity,
                                    description varchar2(4000),
                                    creation_ts timestamp with time zone default current_timestamp,
                                    done number(1,0),
                                    primary key (id))`);

        // Insert some data

        const sql = `insert into todoitem (description, done) values(:1, :2)`;

        const rows =
              [ ["Task 1", 0 ],
                ["Task 2", 0 ],
                ["Task 3", 1 ],
                ["Task 4", 0 ],
                ["Task 5", 1 ] ];

        let result = await connection.executeMany(sql, rows);

        console.log(result.rowsAffected, "Rows Inserted");

        connection.commit();

        // Now query the rows back

        result = await connection.execute(`select description, done from todoitem`, [],
          { 
                resultSet: true, outFormat: oracledb.OUT_FORMAT_OBJECT }); 
                const rs = result.resultSet;
                let row;

                  while ((row = await rs.getRow())) {
                  if (row.DONE)
                        console.log(row.DESCRIPTION, "is done");
                  else
                        console.log(row.DESCRIPTION, "is NOT done");
                  }

                  await rs.close(); 
            } 
            catch (err) {
                  console.error(err);
            } 
            finally  {
                  if (connection) {
                  try {
                        await connection.close();
                  } 
                  catch (err) {
                        console.error(err);
                  }
            }
            }
      }

      run();
      </copy>
      ``` 

      Launch Terminal from VSCode and run the following 

      ```
      <copy>
            [orcl:oracle@x:~/nodedb]$ node insertdata.js
      </copy>
      ``` 

      view output

      ```
      <copy>
            Successfully connected to Oracle Database
            5 Rows Inserted
            Task 1 is NOT done
            Task 2 is NOT done
            Task 3 is done
            Task 4 is NOT done
            Task 5 is done
      </copy>
      ```  

## Task 3: Node code to select data from table

1. Create *select.py* in the same directory */home/oracle/pythondb*

       
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
* **Contributors** -  
* **Last Updated By/Date** -  Madhusudhan Rao, Mar 2022 
