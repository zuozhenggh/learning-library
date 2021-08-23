    A. Open a new terminal window and log in as the root user.
	
	 ```
	 $ <copy>sudo su -</copy>
	 (Requires no password)
	 ```
	 
    B. Run the script `orainstRoot.sh` located in the `oraInventory` folder.
	
	 ```
	 $ <copy>/u01/app/oraInventory/orainstRoot.sh</copy>
	 ```

	 It returns the following output. 

	 ```
	 Changing permissions of /u01/app/oraInventory.
	 Adding read,write permissions for group.
	 Removing read,write,execute permissions for world.

	 Changing groupname of /u01/app/oraInventory to dba.
	 The execution of the script is complete.
	 ```

    C. Run the script `root.sh` from Oracle home.

	 ```
	 $ <copy>/u01/app/oracle/product/21.0.0/dbhome_1/root.sh</copy>
	 ```
	 
	 It returns the following output. 

	 ```
     The following environment variables are set as:
	 ORACLE_OWNER= oracle
     ORACLE_HOME=  /u01/app/oracle/product/21.0.0/dbhome_1

	 Enter the full pathname of the local bin directory: [/usr/local/bin]: Enter
	 
	 /usr/local/bin is read only.  Continue without copy (y/n) or retry (r)? [y]: y

     Warning: /usr/local/bin is read only. No files will be copied.

	 Entries will be added to the /etc/oratab file as needed by
	 Database Configuration Assistant when a database is created
	 Finished running generic part of root script.
	 Now product-specific root actions will be performed.
	 ```
	 
	Close the terminal window.
