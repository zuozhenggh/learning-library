# Install Oracle Database 19c

## Introduction

In this lab, we will install the Oracle Database 19c software.

> **Note:** This workshop is available in free or paid environments only.

Estimated Time: 40 minutes

### About Oracle Database 19c Installation

In this lab, we will log in to the noVNC Desktop image as an oracle user, create required groups and directories, and install Oracle Database 19c in a GUI mode. Once the installation is complete, we will start the database listener and database. We will end this lab by creating a simple database table.

### Objectives

In this lab, you will:

* Download Oracle Database 19c
* Create required group, directories and set permissions
* Setup the Kernel parameters
* Stop and disable the firewall
* Install pre-installation packages
* Run the installer in GUI mode
* Review the success of the installation
* Start the listener and database
* Create a simple database table

### Prerequisites

This lab assumes you have:

* Compute instance created with Virtual cloud network attached to the instance
* Oracle user created
* noVNC remote desktop is available and you have already logged into the remote desktop environment
  
## Task 1: Download Oracle Database 19c

1. Sign in to the Oracle Database 19c download page

      ![Download Page](images/download-page.png "Download Page")

2. Review and accept license agreenment      

      ![Accept License](images/accept-license.png "Accept License")

3. Copy the Download link if you are using firefox or any other browser      

      ![Copy Download Link](images/download-link.png "Copy Download Link")

4. SSH into your compute instance and change directory to /tmp folder wget followed by the copied link

       ```
      <copy> 
      cd /tmp
      wget <download url copied in above step>
      </copy>
      ```

      ![Use wget to download](images/wget-download.png "Use wget to download")

      Rename the downloaded file to LINUX.X64\_193000\_db\_home.zip file

       ```
      <copy> 
      cd /tmp
      mv LINUX.X64_193000_db_home.zip.AuthParam=<Random Number> LINUX.X64_193000_db_home.zip
      </copy>
      ```

## Task 2: Hosts File and Hostname

1. The "/etc/hosts" file must contain a fully qualified name for the server.

      ```
      <copy> 
      <IP-address>  <fully-qualified-machine-name>  <machine-name>
      </copy>
      ```

      for example

      ```
      <copy> 
      127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      <private ip> <instance name>.subnet<id>.vcn<id>.oraclevcn.com <instance name>
      <private ip>   <instance name>.livelabs.oraclevcn.com  <instance name>
      </copy>
      ```

      verify hostname

      ```
      <copy> 
      hostname
      </copy>
      ```

      for example

      ```
      <copy> 
      <instance name>
      </copy>
      ```

## Task 3: Oracle Prerequisites Installation with Automatic Setup

1. you can pick up the RPM from the OL8 repository and install it. It will pull the dependencies from your normal repositories.

       ```
      <copy>
      curl -o oracle-database-preinstall-19c-1.0-2.el8.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL8/appstream/x86_64/getPackage/oracle-database-preinstall-19c-1.0-2.el8.x86_64.rpm

      yum -y localinstall oracle-database-preinstall-19c-1.0-2.el8.x86_64.rpm
      </copy>
      ```

## Task 4: Verify and setup kernel parameters  

1. Verify /etc/sysctl.conf configurations

       ```
      <copy>
      cat /etc/sysctl.conf
      </copy>
      ```

2. The system parameters should be as shown below

      ```
      <copy>  
      fs.file-max = 6815744
      kernel.sem = 250 32000 100 128
      kernel.shmmni = 4096
      kernel.shmall = 1073741824
      kernel.shmmax = 4398046511104
      kernel.panic_on_oops = 1
      net.core.rmem_default = 262144
      net.core.rmem_max = 4194304
      net.core.wmem_default = 262144
      net.core.wmem_max = 1048576
      net.ipv4.conf.all.rp_filter = 2
      net.ipv4.conf.default.rp_filter = 2
      fs.aio-max-nr = 1048576
      net.ipv4.ip_local_port_range = 9000 65500
      </copy>
      ```

3. setup the parameters

      ```
      <copy> 
      /sbin/sysctl -p
      </copy>
      ```

4. verify oracle-database-preinstall-19c.conf parameters

      ```
      <copy> 
      cat /etc/security/limits.d/oracle-database-preinstall-19c.conf
      </copy>
      ```

      Hard and soft limits should be as shown below

      ```
      <copy> 
      oracle   soft   nofile    1024
      oracle   hard   nofile    65536
      oracle   soft   nproc    16384
      oracle   hard   nproc    16384
      oracle   soft   stack    10240
      oracle   hard   stack    32768
      oracle   hard   memlock    134217728
      oracle   soft   memlock    134217728
      </copy>
      ```

## Task 4: Install required packages

1. The following packages are listed as required

      ```
      <copy> 
      dnf install -y bc    
      dnf install -y binutils
      #dnf install -y compat-libcap1
      dnf install -y compat-libstdc++-33
      #dnf install -y dtrace-modules
      #dnf install -y dtrace-modules-headers
      #dnf install -y dtrace-modules-provider-headers
      #dnf install -y dtrace-utils
      dnf install -y elfutils-libelf
      dnf install -y elfutils-libelf-devel
      dnf install -y fontconfig-devel
      dnf install -y glibc
      dnf install -y glibc-devel
      dnf install -y ksh
      dnf install -y libaio
      dnf install -y libaio-devel
      #dnf install -y libdtrace-ctf-devel
      dnf install -y libXrender
      dnf install -y libXrender-devel
      dnf install -y libX11
      dnf install -y libXau
      dnf install -y libXi
      dnf install -y libXtst
      dnf install -y libgcc
      dnf install -y librdmacm-devel
      dnf install -y libstdc++
      dnf install -y libstdc++-devel
      dnf install -y libxcb
      dnf install -y make
      dnf install -y net-tools # Clusterware
      dnf install -y nfs-utils # ACFS
      dnf install -y python # ACFS
      dnf install -y python-configshell # ACFS
      dnf install -y python-rtslib # ACFS
      dnf install -y python-six # ACFS
      dnf install -y targetcli # ACFS
      dnf install -y smartmontools
      dnf install -y sysstat 
      dnf install -y unixODBC

      # New for OL8
      dnf install -y libnsl
      dnf install -y libnsl.i686
      dnf install -y libnsl2
      dnf install -y libnsl2.i686
      </copy>
      ```

## Task 5: Create users and groups

1. create groups oinstall, dba and oper and oracle user to these groups

      ```
      <copy> 
      groupadd -g 54321 oinstall
      groupadd -g 54322 dba
      groupadd -g 54323 oper 
      useradd -u 54321 -g oinstall -G dba,oper oracle
      </copy>
      ```

## Task 6: Setup password for oracle user and additional setup

1. Set the password for the "oracle" user.

      ```
      <copy> 
      passwd oracle
      </copy>
      ```

2. Edit "/etc/selinux/config" file, making sure the SELINUX flag is set as follows.

      ```
      <copy> 
      vi /etc/selinux/config
      </copy>
      ```

      ```
      <copy> 
      SELINUX=permissive
      </copy>
      ```

3. Restart the server   
4. Once the change is complete, restart the server or run the following command.
   
      ```
      <copy> 
      [opc@smode ~]$ sudo su
      [root@smode opc]# setenforce Permissive 
      </copy>
      ```

## Task 7: Disable firewall

1. Disable firewall

      ```
      <copy> 
      systemctl stop firewalld 
      systemctl disable firewalld 
      </copy>
      ``` 

## Task 8: Create required folders

1. Create the directories in which the Oracle software will be installed

      ```
      <copy>  
      mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
      mkdir -p /u02/oradata
      chown -R oracle:oinstall /u01 /u02
      chmod -R 775 /u01 /u02
      mkdir /home/oracle/scripts
      </copy>
      ```

## Task 9: Setup scripts

1. Create an environment file called "setEnv.sh" under /home/oracle/scripts/ folder

      ```
      <copy>  
      cat > /home/oracle/scripts/setEnv.sh <<EOF
      # Oracle Settings
      export TMP=/tmp
      export TMPDIR=\$TMP

      export ORACLE_HOSTNAME=ol8-19.localdomain
      export ORACLE_UNQNAME=cdb1
      export ORACLE_BASE=/u01/app/oracle
      export ORACLE_HOME=\$ORACLE_BASE/product/19.0.0/dbhome_1
      export ORA_INVENTORY=/u01/app/oraInventory
      export ORACLE_SID=cdb1
      export PDB_NAME=pdb1
      export DATA_DIR=/u02/oradata

      export PATH=/usr/sbin:/usr/local/bin:\$PATH
      export PATH=\$ORACLE_HOME/bin:\$PATH

      export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
      export CLASSPATH=\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
      EOF
      </copy>
      ```

2. Add a reference to the "setEnv.sh" file at the end of the "/home/oracle/.bash_profile" file.

      ```
      <copy>  
      echo ". /home/oracle/scripts/setEnv.sh" >> /home/oracle/.bash_profile
      </copy>
      ```

3. Verify $ORACLE_HOME 

      ```
      <copy>  
      root@smode opc]# source /home/oracle/.bash_profile
      [root@smode opc]# echo $ORACLE_HOME
      /u01/app/oracle/product/19.0.0/dbhome_1
      </copy>
      ```

4. create start_all.sh under /home/oracle/scripts/ folder

      ```
      <copy>  
      root@smode opc]# source /home/oracle/.bash_profile
      [root@smode opc]# echo $ORACLE_HOME
      /u01/app/oracle/product/19.0.0/dbhome_1
      </copy>
      ```

5. create stop_all.sh under /home/oracle/scripts/ folder

      ```
      <copy>  
      root@smode opc]# source /home/oracle/.bash_profile
      [root@smode opc]# echo $ORACLE_HOME
      /u01/app/oracle/product/19.0.0/dbhome_1
      </copy>
      ```

6. change script file owner

      ```
      <copy>  
      chown -R oracle:oinstall /home/oracle/scripts
      chmod u+x /home/oracle/scripts/*.sh
      </copy>
      ```

## Task 10: Silent mode installation

1. Log into the oracle user. If you are using X emulation then set the DISPLAY environmental variable.

      ```
      <copy>  
      su oracle
      DISPLAY=smode:0.0; export DISPLAY
      </copy>
      ```

      ```
      <copy>  
      [oracle@smode tmp]$ whoami
      oracle
      [oracle@smode tmp]$ cd $ORACLE_HOME
      [oracle@smode dbhome_1]$ unzip -oq /tmp/LINUX.X64_193000_db_home.zip
      [oracle@smode dbhome_1]$ export CV_ASSUME_DISTID=OEL8.0
      </copy>
      ```

      ![List Oracle Home Directory](images/list-home.png "List Oracle Home Directory") 

      ```
      <copy>  
      ./runInstaller -ignorePrereq -waitforcompletion -silent                    \
      -responseFile ${ORACLE_HOME}/install/response/db_install.rsp               \
      oracle.install.option=INSTALL_DB_SWONLY                                    \
      ORACLE_HOSTNAME=${ORACLE_HOSTNAME}                                         \
      UNIX_GROUP_NAME=oinstall                                                   \
      INVENTORY_LOCATION=${ORA_INVENTORY}                                        \
      SELECTED_LANGUAGES=en,en_GB                                                \
      ORACLE_HOME=${ORACLE_HOME}                                                 \
      ORACLE_BASE=${ORACLE_BASE}                                                 \
      oracle.install.db.InstallEdition=EE                                        \
      oracle.install.db.OSDBA_GROUP=dba                                          \
      oracle.install.db.OSBACKUPDBA_GROUP=dba                                    \
      oracle.install.db.OSDGDBA_GROUP=dba                                        \
      oracle.install.db.OSKMDBA_GROUP=dba                                        \
      oracle.install.db.OSRACDBA_GROUP=dba                                       \
      SECURITY_UPDATES_VIA_MYORACLESUPPORT=false                                 \
      DECLINE_SECURITY_UPDATES=true
      </copy>
      ```
 
## Task 11: Root script execution

1. Run the root scripts when prompted.

      ```
      <copy>  
      [oracle@smode dbhome_1]$ exit
      exit
      [root@smode opc]# /u01/app/oraInventory/orainstRoot.sh 
      </copy>
      ```

      ```
      <copy>   
      Changing permissions of /u01/app/oraInventory.
      Adding read,write permissions for group.
      Removing read,write,execute permissions for world. 
      Changing groupname of /u01/app/oraInventory to oinstall.
      The execution of the script is complete.
      </copy>
      ```

      ```
      <copy>  
      [oracle@smode dbhome_1]$ exit
      exit
      [root@smode opc]# /u01/app/oracle/product/19.0.0/dbhome_1/root.sh
      </copy>
      ```

## Task 12: Database creation

1. start listener

      ```
      <copy>  
      [root@smode opc]# su oracle
      [oracle@smode opc]$ clear

      [oracle@smode opc]$ echo $ORACLE_HOME
      /u01/app/oracle/product/19.0.0/dbhome_1
      [oracle@smode opc]$ cd $ORACLE_HOME/bin
      [oracle@smode bin]$ lsnrctl start
      </copy>
      ```

      ```
      <copy>  
      LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 12-APR-2022 13:12:41 
      Copyright (c) 1991, 2019, Oracle.  All rights reserved.

      Starting /u01/app/oracle/product/19.0.0/dbhome_1/bin/tnslsnr: please wait...

      TNSLSNR for Linux: Version 19.0.0.0.0 - Production
      Log messages written to /u01/app/oracle/diag/tnslsnr/smode/listener/alert/log.xml
      Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=smode.subnet03081620.vcn03081620.oraclevcn.com)(PORT=1521)))

      Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
      STATUS of the LISTENER
      ------------------------
      Alias                     LISTENER
      Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
      Start Date                12-APR-2022 13:12:41
      Uptime                    0 days 0 hr. 0 min. 0 sec
      Trace Level               off
      Security                  ON: Local OS Authentication
      SNMP                      OFF
      Listener Log File         /u01/app/oracle/diag/tnslsnr/smode/listener/alert/log.xml
      Listening Endpoints Summary...
      (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=smode.subnet03081620.vcn03081620.oraclevcn.com)(PORT=1521)))
      The listener supports no services
      The command completed successfully
      </copy>
      ```

      ```
      <copy>  
      # Interactive mode.
      dbca

      # Silent mode.
      dbca -silent -createDatabase                                              \
      -templateName General_Purpose.dbc                                         \
      -gdbname ${ORACLE_SID} -sid  ${ORACLE_SID} -responseFile NO_VALUE         \
      -characterSet AL32UTF8                                                    \
      -sysPassword SysPassword1                                                 \
      -systemPassword SysPassword1                                              \
      -createAsContainerDatabase true                                           \
      -numberOfPDBs 1                                                           \
      -pdbName ${PDB_NAME}                                                      \
      -pdbAdminPassword PdbPassword1                                            \
      -databaseType MULTIPURPOSE                                                \
      -memoryMgmtType auto_sga                                                  \
      -totalMemory 2000                                                         \
      -storageType FS                                                           \
      -datafileDestination "${DATA_DIR}"                                        \
      -redoLogFileSize 50                                                       \
      -emConfiguration NONE                                                     \
      -ignorePreReqs
      </copy>
      ```

      Verify for *Database creation complete* message

      ![Install success message](images/db-complete.png "Install success message") 


## Task 13:  Post Installation

1. Edit the "/etc/oratab" file setting the restart flag for each instance to 'Y'.

      ```
      <copy>  
      vi /etc/oratab
      </copy>
      ```

      Update the file as shown below

      ```
      <copy>  
      cdb1:/u01/app/oracle/product/19.0.0/dbhome_1:Y
      </copy>
      ```

2. Enable Oracle Managed Files (OMF) and make sure the PDB starts when the instance starts.

      ```
      <copy>  
      sqlplus / as sysdba <<EOF
      alter system set db_create_file_dest='${DATA_DIR}';
      alter pluggable database ${PDB_NAME} save state;
      exit;
      EOF
      </copy>
      ```

## Task 14:  CRUD Operation on a sample table

1. Run the following commands at the sqlplus prompt *SQL>* to create a table
    
      ```
      <copy>   
      CREATE TABLE emp  ( emp_id NUMBER , first_name VARCHAR2(128) , last_name VARCHAR2(128)  ); 
      </copy>
      ``` 

2. Insert few records 
   
      ```
      <copy>   
      insert into emp  ( emp_id, first_name, last_name) values (1, 'James','Smith'); 
      </copy>
      ``` 
      ```
      <copy>   
      insert into emp  ( emp_id, first_name, last_name) values (2, 'Jon','Doe'); 
      </copy>
      ``` 

3. Update a record
   
      ```
      <copy>   
      update emp set first_name='Jane' where emp_id=2; 
      </copy>
      ``` 

      Verify table for updated record

      ```
      <copy>   
      select * from emp; 
      </copy>
      ``` 

4. Delete a record
   
      ```
      <copy>   
      delete from emp where emp_id=2  ; 
      </copy>
      ``` 

5. Verify table for deleted record. 

      ```
      <copy>   
      select * from emp; 
      </copy>
      ``` 

6. exit sqlplus
   
      ```
      <copy>   
      exit; 
      Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
      Version 19.3.0.0.0
      </copy>
      ```  

   You successfully made it to the end this lab. You may now  *proceed to the next lab* .  

## Learn More

* [Oracle Database 19c Installation On Oracle Linux 8](https://oracle-base.com/articles/19c/oracle-db-19c-installation-on-oracle-linux-8)
* [Download Oracle Database 19c](https://www.oracle.com/in/database/technologies/oracle19c-linux-downloads.html)
* [Creating Linux services](https://oracle-base.com/articles/linux/linux-services-systemd#creating-linux-services)

## Acknowledgements

* **Author** - Madhusudhan Rao, Principal Product Manager, Database

* **Contributors** - Kevin Lazarz, Senior Principal Product Manager, Database
* **Last Updated By/Date** -  Madhusudhan Rao, Apr 2022
