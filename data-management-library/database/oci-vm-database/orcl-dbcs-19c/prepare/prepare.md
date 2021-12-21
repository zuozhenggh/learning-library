# Application Data Management and Administration

## Introduction

Secure Shell (SSH) is a cryptographic network protocol for operating network services securely over the Internet. This access requires the full path to the file that contains the private key associated with the public key used when the DB system was launched.

Oracle Enterprise Manager Database Express, also referred to as EM Express, is a web-based tool for managing Oracle Database 19c. Built inside the database server, it offers support for basic administrative tasks.

The multitenant architecture enables an Oracle database to function as a multitenant container database (CDB). A CDB includes zero, one, or many customer-created pluggable databases (PDBs). A PDB is a portable collection of schemas, schema objects, and nonschema objects.

The sample database schemas provide a common platform for examples in each release of the Oracle Database. The sample schemas are a set of interlinked database schemas. The Oracle Database sample schemas are based on a fictitious sample company that sells goods through various channels. The company operates worldwide to fill orders for products. It has several divisions, each of which is represented by a sample database schema. Schema Human Resources (HR) represents Division Human Resources and tracks information about the company employees and facilities. Schema Sales History (SH) represents Division Sales and tracks business statistics to facilitate business decisions.

This lab explains how to connect to an active DB system with SSH, enable EM Express, create a new PDB in the existing CDB, and install HR sample schema.

Estimated Lab Time: 45 minutes

## Task 1: Database Node SSH Connection

1. After provisioning the DB System, Database State will be Backup In Progress... for a few minutes. Click **Nodes** on the left menu, and copy Public IP Address and Private IP Address in your notes.

    >**Note** : You can connect to the Database node using SSH from your laptop using Putty or Open SSH and ssh-key-XXXX-XX-XX.key private key file via the Public IP Address. Or you can connect to the Database node from your Compute node via the Private IP Address.

2. Use a text editor on your computer to edit ssh-key-XXXX-XX-XX.key private key file, and copy the contents. Exit root user session on the compute node and, as opc user, create a key file.

    ````
    <copy>
    exit

    vi id_rsa
    </copy>
    ````

3. Press **i** to insert text, and paste the contents of the private key.

    ````
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpAIBAAKCAQEAuL7bH4Z1T7nDmyls77gr75x5eGaHL18RxGxyDGpq/ZtPQP2d
    r+I/4ZLESVju8b7lJX1ONyS2XLPtqBCRkB/1+K3/815LA6zWj0E1Msd/XMCBlvGZ
    ...
    iuEfzTfzVDtPbc1kHsvD/todnGADB03lyGD0t7HZ+51eRKzvMmuaTg==
    -----END RSA PRIVATE KEY-----
    ````
4. Change the permissions on the private key file. 

    ````
    <copy>
    chmod 400 id_rsa 
    </copy>
    ````

5. From your Compute node, connect to the Database node using SSH.

    ````
    <copy>
    ssh -C -i id_rsa opc@<DB Node Private IP Address>
    </copy>
    ````

6. All Oracle software components are installed with **oracle** OS user. Use the substitute user command to start a session as **oracle** user.

    ````
    <copy>
    sudo su - oracle
    </copy>
    ````

7. You can verify the services provided by the Oracle Listener.

    ````
    <copy>
    lsnrctl status
    </copy>
    ````

8. You can connect to the database instance specified by environment variables.

    ````
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

9. List all pluggable databases.

    ````
    <copy>
    show pdbs
    </copy>
    ````

10. Type **exit** command tree times followed by Enter to close all sessions (SQL*Plus, oracle user, and SSH).

    ````
    <copy>
    exit
    </copy>

    exit

    exit
    ````

## Task 2: Enterprise Manager Express 

1. From your laptop, connect to the Database node Public IP Address using SSH, this time adding an SSH tunneling or SSH port forwarding option for port 5500. (Linux only)

    ````
    <copy>
    ssh -C -i Downloads/ssh-key-XXXX-XX-XX.key -L 5500:localhost:5500 opc@<DB Node Public IP Address>
    </copy>
    ````

2. Connect to Database node Public IP Address port 22. (Windows only)

    ![](./../oci/images/putty1.png "")

3. Use the `.ppk` private key. (Windows only)

    ![](./../oci/images/putty2.png "")

4. Create a SSH tunnel from Source port 5500 to Destination localhost:5500. Click **Add**. (Windows only)

    ![](./../oci/images/putty4.png "")

5. Go back to Session, give it a name, and save it. When asked if you trust this host, click **Yes**. (Windows only)

    ![](./../oci/images/putty3.png "")

6. Use the substitute user command to start a session as **oracle** user.

    ````
    <copy>
    sudo su - oracle
    </copy>
    ````

7. Connect to the database instance specified by environment variables.

    ````
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

4. Unlock **xdb** database user account.

    ````
    <copy>
    alter user xdb account unlock;
    </copy>
    ````

5. Enable Oracle Enterprise Manager Database Express (EM Express) clients to use a single port (called a global port), for the session rather than using a port dedicated to the PDB.

    ````
    <copy>
    exec dbms_xdb_config.SetGlobalPortEnabled(TRUE);
    </copy>
    ````

6. Open the web browser on your computer, and navigate to **https://localhost:5500/em**.

7. Use the following credentials:

    - Username: system
    - Password: DatabaseCloud#22_
    - Container Name: CDB$ROOT for the Container Database, or PDB011 for the Pluggable Database. Try both.

8. Explore Enterprise Manager Express console, and see what this tool has to offer.

## Task 3: Create a Pluggable Database

1. From your laptop, connect to the Compute node using SSH, if not connected already.

    ````
    <copy>
    ssh -C -i Downloads/ssh-key-XXXX-XX-XX.key opc@<Compute Public IP Address>
    </copy>
    ````

2. Use the substitute user command to start a session as **oracle** user. Or use the Terminal inside the remote desktop connection.

    ````
    <copy>
    sudo su - oracle
    </copy>
    ````

3. Connect to your DB System database using SQL*Plus.

    ````
    <copy>
    export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib
    sqlplus sys/DatabaseCloud#22_@<DB Node Private IP Address>:1521/<Database Unique Name>.<Host Domain Name> as sysdba
    </copy>
    ````

4. List pluggable databases.

    ````
    <copy>
    show pdbs
    </copy>
    ````

5. Create a new pluggable database called **PDB012**.

    ````
    <copy>
    CREATE PLUGGABLE DATABASE pdb012 ADMIN USER Admin IDENTIFIED BY DatabaseCloud#22_;
    </copy>

    Pluggable database created.
    ````

6. List pluggable databases and confirm the new pluggable database is there.

    ````
    <copy>
    show pdbs
    </copy>
    ````

7. Change the state of the new pluggable database PDB012 to **OPEN**.

    ````
    <copy>
    ALTER PLUGGABLE DATABASE pdb012 OPEN;
    </copy>

    Pluggable database altered.
    ````

8. List pluggable databases and confirm it is **OPEN**.

    ````
    <copy>
    show pdbs
    </copy>
    ````

9. Connect to the new pluggable database.

    ````
    <copy>
    conn sys/DatabaseCloud#22_@<DB Node Private IP Address>:1521/pdb012.<Host Domain Name> as sysdba
    </copy>
    ````

10. Display the current container name.

    ````
    <copy>
    show con_name
    </copy>
    ````

11. List all users in PDB012.

    ````
    <copy>
    select username from all_users order by 1;
    </copy>
    ````

12. This pluggable database doesn't have Oracle Sample Schemas either.


## Task 4: Install HR Sample Schema

1. List all tablespaces in PDB012.

    ````
    <copy>
    select name from v$tablespace;
    </copy>
    ````

2. List all datafiles.

    ````
    <copy>
    select name from v$datafile;
    </copy>
    ````

3. For the Oracle Sample Schemas, we need a tablespace called **USERS**. Try to create it.

    ````
    <copy>
    CREATE TABLESPACE users;
    </copy>

    ORA-28361: master key not yet set
    ````

4. We get an error about a Master Key. To use Oracle Transparent Data Encryption (TDE) in a pluggable database (PDB), you must create and activate a master encryption key for the PDB.

5. In a multitenant environment, each PDB has its own master encryption key which is stored in a single keystore used by all containers.

6. Create and activate a master encryption key in the PDB by executing the following command:

    ````
    <copy>
    ADMINISTER KEY MANAGEMENT SET KEY FORCE KEYSTORE IDENTIFIED BY DatabaseCloud#22_ WITH BACKUP;
    </copy>
    ````

7. Now we can create tablespace **USERS**.

    ````
    <copy>
    CREATE TABLESPACE users;
    </copy>
    ````

8. List all tablespaces to confirm the new tablespace was created.

    ````
    <copy>
    select name from v$tablespace;
    </copy>
    ````

9. List all datafiles and see the corresponding files.

    ````
    <copy>
    select name from v$datafile;
    </copy>
    ````

10. Exit SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

11. Download Oracle Sample Schemas installation package from GitHub.

    ````
    <copy>
    wget https://github.com/oracle/db-sample-schemas/archive/v19c.zip
    </copy>
    ````

12. Unzip the archive.

    ````
    <copy>
    unzip v19c.zip
    </copy>
    ````

13. Open the unzipped folder.

    ````
    <copy>
    cd db-sample-schemas-19c
    </copy>
    ````

14. Run this Perl command to replace `__SUB__CWD__` tag in all scripts with your current working directory, so all embedded paths to match your working directory path.

    ````
    <copy>
    perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat
    </copy>
    ````

15. Go back to the parent folder (this should be /home/opc).

    ````
    <copy>
    cd ..
    </copy>
    ````

16. Create a new folder for logs.

    ````
    <copy>
    mkdir logs
    </copy>
    ````

17. Connect to the **PDB012** pluggable database.

    ````
    <copy>
    sqlplus sys/DatabaseCloud#22_@<DB Node Private IP Address>:1521/pdb012.<Host Domain Name> as sysdba
    </copy>
    ````

19. Run the HR schema installation script. For more information about [Oracle Database Sample Schemas](https://github.com/oracle/db-sample-schemas) installation process, please follow the link. Make sure to replace **DB Node Private IP Address** and **Host Domain Name** with the actual values.

    ````
    <copy>
    @db-sample-schemas-19c/human_resources/hr_main.sql DatabaseCloud#22_ USERS TEMP DatabaseCloud#22_ /home/oracle/logs/ <DB Node Private IP Address>:1521/pdb012.<Host Domain Name>
    </copy>
    ````

## Task 5: Verify HR Sample Schema

1. Display current user. If all steps were followed, the current user should be **HR**.

    ````
    <copy>
    show user
    </copy>
    ````

2. Select tables from **HR** schema and their row numbers.

    ````
    <copy>
    select TABLE_NAME, NUM_ROWS from USER_TABLES;
    </copy>
    ````

3. Some SQL*Plus formatting.

    ````
    <copy>
    set linesize 130
    </copy>
    ````

4. Select all rows from the **HR.EMPLOYEES** table.

    ````
    <copy>
    select * from EMPLOYEES;
    </copy>
    ````

5. If everything is fine, exit SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

## Task 6: Install SH Sample Schema

1. Connect to the **PDB012** pluggable database.

    ````
    <copy>
    sqlplus sys/DatabaseCloud#22_@<DB Node Private IP Address>:1521/pdb012.<Host Domain Name> as sysdba
    </copy>
    ````

2. Run the SH schema installation script. Make sure to replace **DB Node Private IP Address** and **Host Domain Name** with the actual values.

    ````
    <copy>
    @db-sample-schemas-19c/sales_history/sh_main.sql DatabaseCloud#22_ USERS TEMP DatabaseCloud#22_ /home/oracle/db-sample-schemas-19c/sales_history/ /home/oracle/logs/ v3 <DB Node Private IP Address>:1521/pdb012.<Host Domain Name>
    </copy>
    ````

3. Display current user. If all steps were followed, the current user should be **SH**.

    ````
    <copy>
    show user
    </copy>
    ````

4. Select tables from **SH** schema and their row numbers.

    ````
    <copy>
    select TABLE_NAME, NUM_ROWS from USER_TABLES;
    </copy>
    ````

5. If everything is fine, exit SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2021

See an issue? Please open up a request [here](https://github.com/oracle/learning-library/issues). Please include the workshop name and lab in your request.

