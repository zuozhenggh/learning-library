# Install Oracle Database (<if type="desktop">Desktop</if><if type="server">Server</if> Class)

## Introduction

This lab walks you through the steps for installing Oracle Database 21c with <if type="desktop">minimal</if><if type="server">detailed</if> configuration.

Estimated Lab Time: <if type="desktop">20</if><if type="server">30</if> minutes

### Objective

Install the Oracle Database software<if type="desktop"> and </if><if type="server">, </if>create a container database<if type="server">, and configure it</if> using Oracle Database Setup Wizard (Installer).

### Assumptions

- You logged in as *oracle*, the user who is authorized to install the Oracle Database software and create Oracle Database.  

- In the terminal window, the current working directory is Oracle home where the database installer is located.

	```
	$ <copy>cd /u01/app/oracle/product/21.0.0/dbhome_1</copy>
	```

- From Oracle home, you launched Oracle Database Setup Wizard with this command.

	```
	$ <copy>./runInstaller</copy>
	```

## Task 1: Install<if type="server"> and Configure</if> Oracle Database

The `runInstaller` command from Oracle home starts the database installer with the Configuration Option window.

At any point, you can go **Back** to the previous window or **Cancel** the installation. You can click **Help** to view more information on the current window.

1. The Configuration Option window opens with the default option **Create and configure a single instance database** selected. This option helps you create a starter database. Click **Next**.

   ![Configuration Option](../common/images/db21c-common-001-createdb.png)

	> If you select *Set Up Software Only*, the setup wizard installs only the Oracle Database software but does not create the database. To create a container database, run Oracle DBCA after you complete the software installation.

	>> For this lab, do not select this option.

<if type="desktop">
2. The System Class window displays the default option **Desktop class** selected. Using this option, you can perform the installation with minimal configuration. Click **Next**.

   ![Desktop class](images/db21c-desk-002-desktopclass.png)

	The *Server class* option is used for advanced installation with detailed configuration.

3. The Typical Install Configuration window displays the pre-filled names and values for configuration parameters. Set the **Password** for Oracle Database.

  ![Typical Configuration](images/db21c-desk-003-config.png)

	The password created in this window is associated with admin user accounts, namely SYS, SYSTEM, and PDBADMIN. After you create Oracle Database, enter the admin username and use this password to connect to the database.

	**Note**: The password must conform to the Oracle recommended standards. 

	> You cannot create multiple Oracle Databases on a host with the same **Global database name**. If an Oracle Database with the specified name already exists, enter a different name, for example, *orcl2.us.oracle.com*.  

	Along with CDB, Oracle DBCA also creates a PDB as per the **Pluggable database name** field. For this lab, leave the defaults and click **Next**.

</if>

<if type="server">
2. Select **Server class** in the System Class window to customize your installation and perform advanced configuration. Click **Next**.

   ![Server Class](images/db21c-srv-002-serverclass.png)

	The *Desktop class* option is used for basic installation with minimal configuration.

3. The default option, **Enterprise Edition**, installs a database suitable for large enterprises. Click **Next**.

   ![Advanced Configuration](images/db21c-srv-003-edition.png)

	*Standard Edition 2* is suitable for small and medium-sized businesses.

4. The Installation Location window prompts you to select the Oracle base location. For this lab, leave the default value and click **Next**.

   ![Oracle Base Location](images/db21c-srv-004-baseloc.png)

</if>

5. The first time you install Oracle Database on your host, the installer prompts you to specify the location of `oraInventory`, the directory for Oracle Database inventory. This directory provides a centralized inventory for all Oracle software products installed on the host. The default operating system group for Oracle inventory is *dba*.  

	For this lab, leave the defaults and click **Next**.

	<if type="desktop"> ![oraInventory Location](images/db21c-desk-004-inventory.png)</if>

	<if type="server"> ![oraInventory Location](images/db21c-srv-005-inventory.png)</if>

	> If you have installed Oracle Database earlier, the next time you run the database installer, it does not display the Create Inventory window. The inventory location for Oracle Database is already set. 

<if type="server">
6. The Configuration Type window displays the default option **General Purpose / Transaction Processing** selected. Click **Next**.

   ![Configuration Type](images/db21c-srv-006-configtemplate.png)

	<!--
	Removed this note as per review comments from Malai Stalin

	**Note**: The General Purpose or Transaction Processing template and the Data Warehouse template create an Oracle Database with the `COMPATIBLE` initialization parameter set to `12.2.0.0.0`. This ensures that the new features in Oracle Database 21c are compatible with older versions of the database up to version 12c Release 2.
	-->

7. The Database Identifiers window displays pre-filled names and the System Identifier (SID) for Oracle Database. Leave the defaults and click **Next**.

   ![Oracle SID](images/db21c-srv-007-id.png)

	> _**Oracle SID**_ is a unique name given to an Oracle Database. It distinguishes this instance of Oracle Database from other instances on the host.

	>> You cannot create multiple Oracle Databases on a host with the same SID. If an Oracle Database with the specified SID already exists, enter a different SID, for example, *orcl3*. 

	> Similarly, specify a *unique Global database name* for each Oracle Database on the same host.


8. In the Configuration Options window, you can specify the amount of memory you want to allocate and select the character sets.

    - **Memory** - For this lab, the allocated memory specified is *5906* MB. You may choose a different value based on your requirement.  
	For more information on memory management, see [About Automatic Memory Management Installation Options](https://docs.oracle.com/en/database/oracle/oracle-database/21/ladbi/about-automatic-memory-management-installation-options.html#GUID-38F46564-B167-4A78-A974-8C7CEE34EDFE).

     ![Memory](images/db21c-srv-008a-memory.png)

	- **Character sets** - The *Use Unicode (AL32UTF8)* option is selected by default. 
	
	    > *AL32UTF8* is Oracle's name for the standard Unicode encoding UTF-8, which enables universal support for virtually all languages of the world.

	 ![Character sets](images/db21c-srv-008b-charset.png)

	For this lab, leave the defaults and click **Next**.

9. In the Database Storage window, leave the default **File system** option and click **Next**.

    ![Storage File System](images/db21c-srv-009-storagefilesys.png)

	> Oracle Automatic Storage Management (Oracle ASM) allows you to store your data files in ASM disk groups. 
	>> For this lab, do not select this option.

10. In the Management Options window, do not select the checkbox **Register with Enterprise Manager (EM) Cloud Control**. Leave the default settings and click **Next**.

    ![Register with EMCC](images/db21c-srv-010-emcc.png)

	> If you have Oracle EMCC details, such as OMS hostname, port number, and the admin credentials, you can specify in this window and register your Oracle Database.  

	>> However, instead of registering from this window, it is much easier to use the discovery process from Oracle EMCC and add your Oracle Database 21c as a managed target.

   <!-- Add a link to WS2 lab on how to add managed targets.
   For more information on managed targets, see [Manage your targets in EMCC](?lab=lab-2-manage-your-targets).
   -->

11. Select **Enable Recovery** in the Recovery Options window to allow restoration of Oracle Database in event of a failure. Leave the default settings for recovery area storage and click **Next**.

    ![Enable Recovery](images/db21c-srv-011-recovery.png)

12. Set the password for admin user accounts, namely SYS, SYSTEM, and PDBADMIN, in the Schema Passwords window.  

	Though you can specify different passwords for each admin user, for this lab, select **Use the same password for all accounts**. Note the **Password** you entered in this window and click **Next**.

	![Set Admin Password](images/db21c-srv-012-syspwd.png)

	> After you install Oracle Database, enter the admin username and use this password to connect to the database. 

	**Note**: The password must conform to the Oracle recommended standards. 
 
13. In the Privileged Operating System groups window, you can grant your user account administrative access to Oracle Database. For this, you select the value for each OS Group listed below. The values represent the OS groups to which your user belong.  

    For this lab, select the Database Operator group as *dba*. For rest of the groups, *dba* is selected by default.

    ![OS Groups](images/db21c-srv-013-osgroups.png)

<!--13. You need to run a root script to configure the database. If you select **Automatically run configuration scripts** skip step 16-A.  
	For this lab, do not select this option and run the script manually as root user. Click **Next**.-->

</if>

14. You need to run root scripts to configure your Oracle Database.  
	<!--If you select **Automatically run configuration scripts** then skip step 7-A.-->
	For this lab, do not select the checkbox and run the scripts manually as explained in step <if type="desktop">8</if><if type="server">17</if>. Click **Next**.

	<if type="desktop"> ![Root Scripts](images/db21c-desk-005-rootscript.png)</if>

	<if type="server"> ![Root Scripts](images/db21c-srv-014-rootscript.png)</if>

15. The database installer performs prerequisite checks to verify the installation and configuration requirements on the target environment.  
	If the verification result shows failure to meet a requirement, click **Fix & Check Again**.  
	If the issues are minor in nature, you may **Ignore All** and proceed with the installation.

	<if type="desktop"> ![Prerequisite Checks](images/db21c-desk-006a-prereqcheck.png)</if>
	<if type="server"> ![Prerequisite Checks](images/db21c-srv-015-prereq-check.png)</if>

16. Review the summary and click **Install** to start the installation.

	<if type="desktop"> ![Summary](images/db21c-desk-006b-summary.png)</if>
	<if type="server"> ![Summary](images/db21c-srv-016-summary.png)</if>

17.	The Install Product window displays the status of Oracle Database installation process.	Run the scripts displayed in the Execute Configuration Scripts window as the root user. Do not close this window.

   ![Execute Scripts](../common/images/db21c-common-002-rootscript.png)

    A. Open a new terminal window and log in as root.

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

	> This step is applicable for Linux and UNIX operating systems only. If you have installed Oracle Database earlier, the next time you run the database installer, it displays only one script ```root.sh```.

	<!--B. If you provided the privileged user credentials in step 13, click **Yes** in the dialog box to run the configuration script automatically.

   ![Image alt text](images/db21c_common_016b_autoscript.png)-->

18. Return to the Execute Configuration Scripts window and click **OK** to continue. The installer proceeds with creating Oracle Database as per your configuration.

	<if type="desktop"> ![Finish Installation](images/db21c-desk-008-installsuccess.png)</if>
	<if type="server"> ![Finish Installation](images/db21c-srv-018-install-success.png)</if>

	Congratulations! You have installed the Oracle Database software and configured the database successfully.

Click **Close** to exit Oracle Database Setup Wizard.

You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author**: Manish Garodia, Principal User Assistance Developer, Database Technologies

- **Contributors**: Suresh Rajan (Senior Manager, User Assistance Development), Prakash Jashnani (Manager, User Assistance Development), Subhash Chandra (Principal User Assistance Developer), Subrahmanyam Kodavaluru (Principal Member Technical Staff), Dharma Sirnapalli (Principal Member Technical Staff)<if type="server">, Malai Stalin (Senior Manager, Software Development)</if>

- **Last Updated By/Date**: Manish Garodia, August 2021
