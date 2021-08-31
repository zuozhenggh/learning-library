# Create Container Database (<if type="typical">Typical</if><if type="advanced">Advanced</if> Mode)

## Introduction

This lab shows how to create a single instance container database with <if type="typical">typical</if><if type="advanced">advanced</if> configuration. It does not install the Oracle Database software.

Estimated Lab Time: <if type="typical">20</if><if type="advanced">30</if> minutes

### Objective

Create an additional Oracle Database using Oracle Database Configuration Assistant (Oracle DBCA).

### Assumptions

- The Oracle Database software is installed and a starter database may already be created.

- You logged in as *oracle*, the user who is authorized to install the Oracle Database software and create Oracle Database.  

- In the terminal window, you changed the current working directory to `$ORACLE_HOME/bin` where Oracle DBCA is located.

	```
	$ <copy>cd /u01/app/oracle/product/21.0.0/dbhome_1/bin</copy>
	```

- From ```$ORACLE_HOME/bin```, you launched Oracle DBCA with this command.

	```
	$ <copy>./dbca</copy>
	```

## Task 1: Create<if type="advanced"> and Configure</if> a Container Database

The `dbca` command from ```$ORACLE_HOME/bin``` starts Oracle DBCA with the Database Operation window.

At any point, you can go **Back** to the previous window or **Cancel** database creation. You can click **Help** to view more information on the current window.

1. The Database Operation window opens with the default option **Create a database** selected. Click **Next**.

    ![Create Database](../common/images/dbca21c-common-001-createdb.png)

	> With Oracle DBCA, you can perform other administrative tasks, such as configure or delete an existing Oracle Database and manage PDBs and templates.

<if type="typical">

2. Oracle DBCA displays the default creation mode, **Typical configuration**, selected with the pre-filled configuration parameters. 

	For this lab, specify the **Administrative password** and enter the following.  
	**Global database name** - *orcl1.us.oracle.com*  
	**Pluggable database name** - *orclpdb1*  

	For the remaining fields, leave the defaults and click **Next**.

   ![Typical Configuration](images/dbca21c-typical-002-typmode.png)

	> You cannot create multiple Oracle Databases with the same Global database name. If an Oracle Database with the specified name already exists, enter a different name.  

	The password created in this window is associated with admin user accounts, namely SYS, SYSTEM, and PDBADMIN. After you create Oracle Database, enter the admin username and use this password to connect to the database.

	**Note**: The password must conform to the Oracle recommended standards. 

	The default **Database Character set** for Oracle Database is *AL32UTF8 - Unicode UTF-8 Universal character set*. 
	
	> *AL32UTF8* is Oracle's name for the standard Unicode encoding UTF-8, which enables universal support for virtually all languages of the world. 

</if>

<if type="advanced">

2. In the Creation Mode window, select **Advanced configuration** and click **Next**.  
	This option allows you to customize Oracle Database configurations, such as storage locations, initialization parameters, management options, database options, passwords for administrator accounts, and so on.

   ![Advanced Configuration](images/dbca21c-adv-002-advmode.png)

3. You can select the database type and a template suitable for your Oracle Database in the Deployment Type window.  
	For this lab, leave the default type *Oracle Single Instance database* and the template *General Purpose or Transaction Processing*. Click **Next**.

   ![Deployment Type](images/dbca21c-adv-003-template.png)

	<!-- Removed this section on RAC from the lab. Will use this information in other relevant documents.

	If your database type is Real Application Cluster, you can select the Database Management Policy as:
	- **Automatic** and allow Oracle clusterware to manage your database automatically, or
	- **Rank**, if you want to define ranks for your database.

	Removed this note as per review comments from Malai Stalin

	**Note**: The General Purpose or Transaction Processing template and the Data Warehouse template create an Oracle Database with the `COMPATIBLE` initialization parameter set to `12.2.0.0.0`. This ensures that the new features in Oracle Database 21c are compatible with older versions of the database up to version 12c Release 2.  
	-->

	> For more complex environments, you can select the Custom Database option. This option does not use any templates and it usually increases the time taken to create an Oracle Database. 
	>> For this lab, do not select this option.

4. The Database Identification window displays pre-filled names and the System Identifier (SID) for Oracle Database.  

	For this lab, enter the following and click **Next**.  
	**Global database name** - *orcl2.us.oracle.com*  
	**SID** - *orcl2*  
	**PDB name** - *orcl2pdb1*  

	![Oracle SID](images/dbca21c-adv-004-id.png)

	> _**Oracle SID**_ is a unique name given to an Oracle Database. It distinguishes this instance of Oracle Database from other instances on the host.

	>> You cannot create multiple Oracle Databases on a host with the same SID. If an Oracle Database with the specified SID already exists, enter a different SID, for example, *orcl3*. 

	> Similarly, specify a *unique Global database name* for each Oracle Database on the same host.

5. The Storage Option window displays the default option **Use template file for database storage attributes** selected. This option allows Oracle Database to use the directory information specified in the *General Purpose or Transaction Processing* template.

	For this lab, leave the defaults and click **Next**.

    ![Storage Option](images/dbca21c-adv-005-storage.png)

	You can specify another location to store the database files with the **Use following for the database storage attributes** option. With this option, you can select the storage type as File system or Oracle Automatic Storage Management (Oracle ASM).  
	For this lab, do not select these options.

	<!-- Removed this section on ASM and OMF from the lab as per review comments from Subhash Chandra. Content outside the scope of this workshop.

	- *File system* to manage the database files by the file system of your operating system, or
	- *Automatic Storage Management (ASM)* to store your data files in the ASM disk groups.

	The *Use Oracle-Managed Files (OMF)* option gives complete control of files to the database. It allows the database to create and delete files in the default location. The database directly manages the filenames, their size, and location.  
	For this lab, do not select these options. -->

6. Select **Specify Fast Recovery Area** to set up a backup and recovery area, its directory location, and size.  
	For this lab, leave the defaults and click **Next**.

    ![Fast Recovery](images/dbca21c-adv-006-recovery.png)

	The Fast Recovery Option window displays the default parameters pre-filled.  
	 **Recovery files storage type** - *File System*  
	 **Fast Recovery Area** the directory for recovery-related files  
	 **Fast Recovery Area size** the size of the recovery area  
	 For this lab, leave the default values.

	The **Enable archiving** checkbox allows archiving the online redo log files. These files are useful during Oracle Database recovery. For this lab, do not select this option.

7. Select the listener for your Oracle Database in the Network Configuration window.  

	For this lab, de-select the existing listener if already selected. Select the checkbox **Create a new listener** and enter the following values:  
	 **Listener name** - *LISTENER1*  
	 **Listener port** - *1526*

    ![Listener Selection](images/dbca21c-adv-007-listener.png)

	> A _**Listener**_ is a network service that runs on Oracle Database server. It is responsible for receiving incoming connection requests to and from the database and for managing the network traffic.

	>> If you have created an Oracle Database earlier, a listener already exists. You can select the existing listener in the window. On the other hand, if you have installed only the Oracle Database software and did not create a database, the listener does not exist. You need to create a new listener from this window. 

	> You cannot use the same listener name to create multiple Oracle Databases. If an Oracle Database with the specified listener already exists, enter a different name for the listener, for example, *LISTENER2*.

	Similarly, specify a *unique port number* for each Oracle listener on the same host. 

8. You can configure Oracle Database Vault and Oracle Label Security to control administrative access to your data and to individual table rows.  

	For this lab, do not select these checkboxes and click **Next**.

    ![Oracle Data Vault Security](images/dbca21c-adv-008-vault.png)

9. You can specify the following configuration options for Oracle Database. For this lab, leave the defaults for each tab and continue.

	A. **Memory** - The *Use Automatic Shared Memory Management* method enables you to allocate specific volume of memory to SGA and aggregate PGA. Oracle Database enables automatic shared memory for SGA, and distributes the remaining memory among individual PGAs as needed.  
	For more information on memory management, see [About Automatic Shared Memory Management](https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/managing-memory.html#GUID-B8B8923C-4213-42A9-8ED3-4ABE48C23914).

    ![Memory](images/dbca21c-adv-009a-memory.png)

	- *Manual Shared Memory Management* allows you to enter specific values for each SGA component and the aggregate PGA. It is useful for advanced database administration.  

	- *Automatic Memory Management* allows you to set the usable memory in the memory target. The system then dynamically configures the memory components of both SGA and PGA instances.

	> If the total physical memory of your Oracle Database instance is greater than 4 GB, you cannot select the 'Use Automatic Memory Management' option. Instead, *Use Automatic Shared Memory Management* to distribute the available memory among various components as required, thereby allowing the system to maximize the use of all available SGA memory.

	B. **Sizing** - For this lab, a maximum of *320* processes can connect simultaneously to your Oracle Database. You can change this as per your requirement.  

	> While using predefined templates, the **Block size** option is not enabled. Oracle DBCA creates an Oracle Database with the default block size of *8 KB*.

    ![Size](images/dbca21c-adv-009b-size.png)

	C. **Character sets** - The *Use Unicode (AL32UTF8)* option is selected by default. 

	> *AL32UTF8* is Oracle's name for the standard Unicode encoding UTF-8, which enables universal support for virtually all languages of the world. 

    ![Character Sets](images/dbca21c-adv-009c-charset.png)

	D. **Connection mode** - *Dedicated server mode* allows a dedicated server process for each user process.

    ![Connection Mode](images/dbca21c-adv-009d-connmode.png)

10. The Management Options window allows you to configure EM Express and register your Oracle Database with Oracle EMCC. 

	For this lab, de-select the checkbox **Configure Enterprise Manager (EM) database express** and leave the checkbox **Register with Enterprise Manager (EM) Cloud Control** unselected. Click **Next**.

    ![Register with EMCC](images/dbca21c-adv-010-emcc.png)

	> If you have Oracle EMCC details, such as OMS hostname, port number, and the admin credentials, you can specify in this window and register your Oracle Database.  

	>> However, instead of registering from this window, it is much easier to use the discovery process from Oracle EMCC and add your Oracle Database 21c as a managed target.

	<!-- Add a link to WS2 lab on how to add managed targets.
	For more information on managed targets, see [Manage your targets in EMCC](?lab=lab-2-manage-your-targets).
	-->

11. Set the password for admin user accounts, namely SYS, SYSTEM, and PDBADMIN, in the User Credentials window.   

	Though you can specify different passwords for each admin user, for this lab, select **Use the same administrative password for all accounts**. Note the **Password** you entered in this window and click **Next**.

	![Set Admin Password](images/dbca21c-adv-011-syspwd.png)

	**Note**: The password must conform to the Oracle recommended standards. 

12. The Creation Option window displays the default option **Create database** selected.  
	For the remaining fields, leave the defaults and click **Next**.

    ![Create Options](images/dbca21c-adv-012-createoptions.png)

</if>

13. Review the summary and click **Finish** to create your Oracle Database.

	<if type="typical"> ![Summary](images/dbca21c-typical-003-summary.png) </if>
	<if type="advanced"> ![Summary](images/dbca21c-adv-013-summary.png) </if>

	The Progress Page window displays the status of Oracle Database creation process.

	<if type="typical"> ![Finish Creation](images/dbca21c-typical-005-finish.png) </if>
	<if type="advanced"> ![Finish Creation](images/dbca21c-adv-015-finish.png) </if>

	The confirmation message in the Finish window indicates that you created an Oracle Database successfully

	## Password Management

	In the Finish window, click **Password Management** to view the status of Oracle Database user accounts. Except SYS and SYSTEM, all other users are initially in locked state.

	![Password Management](../common/images/dbca21c-common-002-pwd-mgmt.png)

	> To unlock a user, click the **Lock Account** column. You can also change the default password for the users in this window. However, you can do these tasks later.

	Click **OK** to save any changes you made and to close the Password Management window.

Click **Close** to exit Oracle Database Configuration Assistant.

<if type="typical">You may now [proceed to the next lab](#next).</if>

## Acknowledgements

- **Author**: Manish Garodia, Principal User Assistance Developer, Database Technologies

- **Contributors**: Suresh Rajan (Senior Manager, User Assistance Development), Prakash Jashnani (Manager, User Assistance Development), Subhash Chandra (Principal User Assistance Developer), Subrahmanyam Kodavaluru (Principal Member Technical Staff), Dharma Sirnapalli (Principal Member Technical Staff)<if type="advanced">, Malai Stalin (Senior Manager, Software Development)</if>

- **Last Updated By/Date**: Manish Garodia, August 2021
