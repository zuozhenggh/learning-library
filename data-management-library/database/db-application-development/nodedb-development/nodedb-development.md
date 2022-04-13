# Developing Node.js Applications for Oracle Database

## Introduction

Node.js an asynchronous event-driven JavaScript runtime, It is designed to build scalable network applications. Thread-based networking is relatively inefficient and very difficult to use. Furthermore, users of Node.js are free from worries of dead-locking the process, since there are no locks. Almost no function in Node.js directly performs I/O, so the process never blocks except when the I/O is performed using synchronous methods of Node.js standard library. Because nothing blocks, scalable systems are very reasonable to develop in Node.js.

### About this Lab

This Lab shows you how to connect Node.js applications to Oracle Database using the node-oracledb module. This module lets you quickly develop applications that execute SQL or PL/SQL statements. Your applications can also use Oracle's document storage SODA calls. Node-oracledb can be used with TypeScript or directly with Node.js. The steps below show connecting to an on-premise database

Estimated Time: 20 minutes
 
### Objectives
 
In this lab, you will: 

* Write Node.js code to access Oracle Database 
* Run the code

### Prerequisites 
This lab assumes you have:

* Node.js and SQL Developer has been installed 
* Database user has been created
* Access to Oracle Database 19c instance
* A valid SSH key pair
    
## Task 1: write *Node.js* code to create table and insert few records in *Oracle Database 19c On-Premise*
 
4. Create folder nodedb under */home/oracle/* and create following files in that    

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

      *Node.js* code to create table, insert data and select data in file *insertdata.js* please note Hostname, Service Name, Database username and password need to be changed as per your installation and configurations
   
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

## Task 2: write *Node.js* code to select data from table

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

## Task 3: Download ADB Wallet and upload it to Object storage bucket

1. Below are the instructions to download the client credentials from the Oracle Cloud Console. The credentials give mutual TLS, providing enhanced security for authentication and encryption.

      * From the Oracle Cloud Console, go to the Autonomous Database Details page of your Oracle Autonomous Database instance.
      Click the DB Connection button.
      * Click the Download Wallet button.
      * Enter a wallet password in the Password field and confirm the password in the Confirm password field. Then, click the Download button. The password must be at least 8 characters long and include at least 1 letter and either 1 numeric character or 1 special character. Although not required for Node.js, this password protects the downloaded client credentials wallet.
      * Save the credentials zip file to a secure location.

2. Create Bucket and Upload wallet

      * Create a Bucket and Upload the wallet that has been downloaded 
      * Create a PAR link from the uploaded wallet file,  
      * Use wget to download the wallet file from the PAR file link 
      * Remove the PAR link and delete the wallet file from Object storage
      * Delete the Bucket

      ![Download Autonomous database wallet](images/download-wallet.png "Download Autonomous database wallet") 

      ![Wallet password](images/wallet-password.png "Wallet password") 

3. Move wallet to network/admin/ location 

      ```
      <copy>
            sudo cp Wallet_*.zip /usr/lib/oracle/19c/client64/lib/network/admin/
            sudo sh -c 'cd /usr/lib/oracle/19c/client64/lib/network/admin/ && unzip -B Wallet_*.zip'
      </copy>
      ``` 
 
## Task 4: write *Node.js* code to select data from table in *Autonomous Database*

1. Create *selectadb.js* in the same directory */home/oracle/nodedb*


      ```
      <copy>
      const oracledb = require('oracledb');

      async function run() {

      let connection;

      try {

      connection = await oracledb.getConnection({ user: "admin", password: "XXXX", connectionString: "XXX_high" });

      // Create a table

      await connection.execute(`begin
                                    execute immediate 'drop table nodetab';
                                    exception when others then if sqlcode <> -942 then raise; end if;
                                    end;`);

      await connection.execute(`create table nodetab (id number, data varchar2(20))`);

      // Insert some rows 
      const sql = `INSERT INTO nodetab VALUES (:1, :2)`;

      const binds =
            [ [1, "First" ],
            [2, "Second" ],
            [3, "Third" ],
            [4, "Fourth" ],
            [5, "Fifth" ],
            [6, "Sixth" ],
            [7, "Seventh" ] ];

      await connection.executeMany(sql, binds);

      // connection.commit();     // uncomment to make data persistent

      // Now query the rows back

      const result = await connection.execute(`SELECT * FROM nodetab`);

      console.dir(result.rows, { depth: null }); 
            } 
            catch (err) {
                  console.error(err);
            } 
            finally {
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



      
 
 
   You successfully made it to the end this lab. You may now  *proceed to the next lab* .  

## Learn More

* [Quick Start: Developing Node.js Applications for Oracle Database](https://www.oracle.com/database/technologies/appdev/quickstartnodeonprem.html) 
* [How do I start with Node.js](https://nodejs.org/en/docs/guides/getting-started-guide/) 
* [Node Oracle DB examples](https://github.com/oracle/node-oracledb) 
* [Node API Examples](https://oracle.github.io/node-oracledb/doc/api.html#getstarted)   
* [Quick Start: Developing Node.js Applications for Oracle Autonomous Database](https://www.oracle.com/database/technologies/appdev/quickstartnodejs.html)
 
## Acknowledgements

- **Author** - Madhusudhan Rao, Principal Product Manager, Database
* **Contributors** -  
* **Last Updated By/Date** -  Madhusudhan Rao, Mar 2022 
