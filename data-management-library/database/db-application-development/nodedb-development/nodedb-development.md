# Developing Node.js Applications for Oracle Database

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
            alter database open;
      create user james identified by welcome1; 
      </copy>
      ``` 

      ```
      <copy> 
            alter user james
            default tablespace users
            temporary tablespace temp
            quota unlimited on users; 
      </copy>
      ``` 

      ```
      <copy> 
            grant create session,
            create view,
            create sequence,
            create procedure,
            create table,
            create trigger,
            create type,
            create materialized view
            to james;
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
                  HR.departments
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

1. Create *select.js* in the same directory */home/oracle/nodedb*

      
 
      ```
      <copy>
      const oracledb = require('oracledb');

      async function run() {

            let connection;

            try {

            connection = await oracledb.getConnection({ user: "james", password: "welcome1", 
            connectionString: "lldb.livelabs.oraclevcn.com/pdb1.livelabs.oraclevcn.com" });

            console.log("Connected to DB and select from table departments"); 
 
            // Now query the rows back

            result = await connection.execute(`select department_id, department_name from HR.departments`,
            [],{ resultSet: true, outFormat: oracledb.OUT_FORMAT_OBJECT });

            const rs = result.resultSet;
            let row;

            while ((row = await rs.getRow())) 
            { 
                  console.log(row);
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

      run select.js to view the data in todoitems table

      ```
      <copy>
      [orcl:oracle@x:~/nodedb]$ node select.js
            Connected to DB and select from table departments
            { DEPARTMENT_ID: 10, DEPARTMENT_NAME: 'Administration' }
            { DEPARTMENT_ID: 20, DEPARTMENT_NAME: 'Marketing' }
            { DEPARTMENT_ID: 30, DEPARTMENT_NAME: 'Purchasing' }
            { DEPARTMENT_ID: 40, DEPARTMENT_NAME: 'Human Resources' }
            </copy>
      ``` 
 
   You successfully made it to the end this lab. You may now  *proceed to the next lab* .  

## Learn More

* [Quick Start: Developing Node.js Applications for Oracle Database](https://www.oracle.com/database/technologies/appdev/quickstartnodeonprem.html) 
* [How do I start with Node.js](https://nodejs.org/en/docs/guides/getting-started-guide/) 
* [Node Oracle DB examples](https://github.com/oracle/node-oracledb) 
* [Node API Examples](https://oracle.github.io/node-oracledb/doc/api.html#getstarted)   
 
## Acknowledgements

- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** -  
* **Last Updated By/Date** -  Madhusudhan Rao, Mar 2022 
