Upgrading to 19.10 from Resource Manager install
------------------------------------------------

Prerequiste: My Oracle Support username and password on hand.



For OPatch - Have LiveLabs store the Opatch file in their tenancy so the user can do a wget.

1. Connect to your compute instance
```nohighlighting
$ <copy>ssh -i ~/.ssh/cloudshellkey opc@public-ip-address</copy>
```


2. Switch to the `oracle` user.

    ```nohighlighting
    $ <copy>sudo su - oracle</copy>
    ```

3. Set the environment variables to point to the Oracle binaries. When prompted for the SID (Oracle Database System Identifier), enter **ORCL**.

    ```nohighlighting
    $ <copy>. oraenv</copy>
    ORCL

    The Oracle base remains unchanged with value /u01/app/oracle
    ```


## Install OPatch
1. Change to the OPatch directory and check the version of OPatch

    ```nohighlighting
    $ <copy>cd $ORACLE_HOME/OPatch/</copy>
    $ <copy>./opatch version</copy>

    OPatch Version: 12.2.0.1.19

    OPatch succeeded.
    ```

1. Back up the old opatch utility.

    ```nohighlighting
    $ cd $ORACLE_HOME
    $ mv OPatch/ OPatch_backup

1. Make sure that no directory $ORACLE_HOME/OPatch exists.

    ```
    $ ls

    (no OPatch directory is listed. OPatch_backup is listed)
    ```


1. Still in the ``$ORACLE_HOME` directory, use the `wget` command to download the OPatch ZIP file from object storage (in the LiveLabs tenancy) to the `$ORACLE_HOME` directory.

    ```nohighlighting
    $ <copy>wget https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/4qYNVxluOUUPgrXMok3zH6LenxkOqzAZm7Mj1iVs1Liz4tu21MLHZpRgMwiFd31C/n/frmwj0cqbupb/b/bucket-20210401-1123/o/p6880880_190000_Linux-x86-64.zip -P $ORACLE_HOME/</copy>
    ```

1.  Unzip the OPatch ZIP file (`p6880880_190000_Linux-x86-64.zip`) into the `$ORACLE_HOME` directory.

    ```nohighlighting
    $ <copy>unzip p6880880_190000_Linux-x86-64.zip</copy>
    ```
1. List the files and folders in the `$ORACLE_HOME` directory and verify that you have an OPatch directory created.

    ```nohighlighting
    $ <copy>ls</copy>
    ```
1. View the version of the OPatch utility.
    ```nohighlighting
    $ <copy>$ORACLE_HOME/OPatch/opatch version</copy>
    OPatch Version: 12.2.0.1.24

    OPatch succeeded.
    ```



## Complete Prerequisites

1. Oracle JavaVM 19.x release update - separate patch? https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=1929745.1  
ignoring for now

1. Change to the `/usr/bin` directory and verify that the following executables are there: make, ar, ld, and nm. Find where they are located. You can find them in `/usr/bin`.

    ```
    $ cd /usr/bin
    $ ls
    ```
1. View that `/usr/bin` in the path.

    ```
    $ echo $PATH
    /usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/u01/app/oracle/product/19c/dbhome_1/bin:/u01/app/oracle/product/19c/dbhome_1/OPatch:/home/oracle/.local/bin:/home/oracle/bin
    ```

## Install the Database patch

1. Sign in to the database.

    ```nohighlighting
    $ <copy>sqlplus / as sysdba</copy>

    SQL*Plus: Release 19.0.0.0.0 - Production on Wed Apr 14 22:52:11 2021
    Version 19.7.0.0.0

    Copyright (c) 1982, 2020, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    SQL>
    ```

1. Shut down the instance.

    ```nohighlighting
    SQL> <copy>shutdown</copy>

    Database closed.
    Database dismounted.
    ORACLE instance shut down.

    SQL>
    ```

1. Exit SQL*Plus.

    ```nohighlighting
    SQL> <copy>exit</copy>

    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0

    $
    ```

1. Stop the database listener.

    ```nohighlighting
    SQL> <copy>lsnrctl stop</copy>

    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 15-APR-2021 22:03:00

    Copyright (c) 1991, 2019, Oracle.  All rights reserved.

    Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=workshop.subnet1.labvcn.oraclevcn.com)(PORT=1521)))
    The command completed successfully
    ```

1. Create a `stage` directory to store the database patch ZIP file. Grant the `oracle` user read, write, and execute permissions on the directory.

    ```nohighlighting
    $ <copy>mkdir $ORACLE_HOME/stage/</copy>
    $ <copy>cd $ORACLE_HOME/stage/</copy>
    ```

1. Use the `wget` command to download the 19.10 upgrade ZIP file from My Oracle Support into the `stage` directory. In the following command, replace `MOSusername` and `MOSpassword` with your My Oracle Support username and password.

    ```nohighlighting
    $ <copy>wget --http-user=MOSusername --http-password=MOSpassword --no-check-certificate --output-document=p32218454_190000_Linux-x86-64.zip "https://updates.oracle.com/Orion/Services/download/p32218454_190000_Linux-x86-64.zip?aru=24018797&patch_file=p32218454_190000_Linux-x86-64.zip" -P $ORACLE_HOME/stage/</copy>
        ```

    REMOVE LATER: wget --http-user=jody.glover@oracle.com --http-password=J0415gjj --no-check-certificate --output-document=p32218454_190000_Linux-x86-64.zip "https://updates.oracle.com/Orion/Services/download/p32218454_190000_Linux-x86-64.zip?aru=24018797&patch_file=p32218454_190000_Linux-x86-64.zip" -P $ORACLE_HOME/stage/


1. Extract `p32218454_190000_Linux-x86-64.zip` into the `stage` folder.

    ```nohighlighting
    $ <copy>unzip p32218454_190000_Linux-x86-64.zip</copy>
    ```

1. Change to the 32218454 directory

    ```nohighlighting
    $ <copy>cd 32218454</copy>
    ```

1. Determine whether any currently installed interim patches conflict with the patch being installed.

    ```nohighlighting
    $ <copy>opatch prereq CheckConflictAgainstOHWithDetail -ph ./</copy>

    Oracle Interim Patch Installer version 12.2.0.1.24
    Copyright (c) 2021, Oracle Corporation.  All rights reserved.

    PREREQ session

    Oracle Home       : /u01/app/oracle/product/19c/dbhome_1
    Central Inventory : /u01/app/oraInventory
    from           : /u01/app/oracle/product/19c/dbhome_1/oraInst.loc
    OPatch version    : 12.2.0.1.24
    OUI version       : 12.2.0.7.0
    Log file location : /u01/app/oracle/product/19c/dbhome_1/cfgtoollogs/opatch/opatch2021-04-15_21-42-04PM_1.log

    Invoking prereq "checkconflictagainstohwithdetail"

    Prereq "checkConflictAgainstOHWithDetail" passed.

    OPatch succeeded.
    ```


1. Install the update. Enter *y* when prompted to proceed and when asked if the system is ready for patching.

    ```nohighting
    $ <copy>opatch apply</copy>

    Oracle Interim Patch Installer version 12.2.0.1.24
Copyright (c) 2021, Oracle Corporation.  All rights reserved.


Oracle Home       : /u01/app/oracle/product/19c/dbhome_1
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/oracle/product/19c/dbhome_1/oraInst.loc
OPatch version    : 12.2.0.1.24
OUI version       : 12.2.0.7.0
Log file location : /u01/app/oracle/product/19c/dbhome_1/cfgtoollogs/opatch/opatch2021-04-15_22-10-56PM_1.log

Verifying environment and performing prerequisite checks...
OPatch continues with these patches:   32218454  

Do you want to proceed? [y|n]
y
User Responded with: Y
All checks passed.

Please shutdown Oracle instances running out of this ORACLE_HOME on the local system.
(Oracle Home = '/u01/app/oracle/product/19c/dbhome_1')


Is the local system ready for patching? [y|n]
y
User Responded with: Y
Backing up files...
Applying interim patch '32218454' to OH '/u01/app/oracle/product/19c/dbhome_1'
ApplySession: Optional component(s) [ oracle.network.gsm, 19.0.0.0.0 ] , [ oracle.rdbms.ic, 19.0.0.0.0 ] , [ oracle.rdbms.tg4db2, 19.0.0.0.0 ] , [ oracle.tfa, 19.0.0.0.0 ] , [ oracle.net.cman, 19.0.0.0.0 ] , [ oracle.network.cman, 19.0.0.0.0 ] , [ oracle.oid.client, 19.0.0.0.0 ] , [ oracle.options.olap.api, 19.0.0.0.0 ] , [ oracle.options.olap, 19.0.0.0.0 ] , [ oracle.xdk.companion, 19.0.0.0.0 ] , [ oracle.jdk, 1.8.0.191.0 ]  not present in the Oracle Home or a higher version is found.

Patching component oracle.rdbms, 19.0.0.0.0...

Patching component oracle.rdbms.rsf, 19.0.0.0.0...

Patching component oracle.rdbms.util, 19.0.0.0.0...

Patching component oracle.assistants.acf, 19.0.0.0.0...

Patching component oracle.assistants.deconfig, 19.0.0.0.0...

Patching component oracle.assistants.server, 19.0.0.0.0...

Patching component oracle.buildtools.rsf, 19.0.0.0.0...

Patching component oracle.ctx, 19.0.0.0.0...

Patching component oracle.dbjava.ic, 19.0.0.0.0...

Patching component oracle.dbjava.jdbc, 19.0.0.0.0...

Patching component oracle.dbjava.ucp, 19.0.0.0.0...

Patching component oracle.dbtoolslistener, 19.0.0.0.0...

Patching component oracle.ldap.owm, 19.0.0.0.0...

Patching component oracle.ldap.rsf, 19.0.0.0.0...

Patching component oracle.network.rsf, 19.0.0.0.0...

Patching component oracle.oracore.rsf, 19.0.0.0.0...

Patching component oracle.rdbms.dbscripts, 19.0.0.0.0...

Patching component oracle.rdbms.deconfig, 19.0.0.0.0...

Patching component oracle.sdo, 19.0.0.0.0...

Patching component oracle.sdo.locator.jrf, 19.0.0.0.0...

Patching component oracle.sqlplus, 19.0.0.0.0...

Patching component oracle.xdk, 19.0.0.0.0...

Patching component oracle.marvel, 19.0.0.0.0...

Patching component oracle.xdk.rsf, 19.0.0.0.0...

Patching component oracle.ctx.atg, 19.0.0.0.0...

Patching component oracle.rdbms.scheduler, 19.0.0.0.0...

Patching component oracle.rdbms.lbac, 19.0.0.0.0...

Patching component oracle.duma, 19.0.0.0.0...

Patching component oracle.ldap.rsf.ic, 19.0.0.0.0...

Patching component oracle.odbc, 19.0.0.0.0...

Patching component oracle.ctx.rsf, 19.0.0.0.0...

Patching component oracle.oraolap.api, 19.0.0.0.0...

Patching component oracle.xdk.parser.java, 19.0.0.0.0...

Patching component oracle.oraolap, 19.0.0.0.0...

Patching component oracle.sdo.locator, 19.0.0.0.0...

Patching component oracle.sqlplus.ic, 19.0.0.0.0...

Patching component oracle.mgw.common, 19.0.0.0.0...

Patching component oracle.ons, 19.0.0.0.0...

Patching component oracle.dbdev, 19.0.0.0.0...

Patching component oracle.network.listener, 19.0.0.0.0...

Patching component oracle.nlsrtl.rsf, 19.0.0.0.0...

Patching component oracle.ovm, 19.0.0.0.0...

Patching component oracle.oraolap.dbscripts, 19.0.0.0.0...

Patching component oracle.xdk.xquery, 19.0.0.0.0...

Patching component oracle.precomp.rsf, 19.0.0.0.0...

Patching component oracle.javavm.client, 19.0.0.0.0...

Patching component oracle.precomp.common.core, 19.0.0.0.0...

Patching component oracle.ldap.security.osdt, 19.0.0.0.0...

Patching component oracle.rdbms.oci, 19.0.0.0.0...

Patching component oracle.rdbms.rman, 19.0.0.0.0...

Patching component oracle.rdbms.crs, 19.0.0.0.0...

Patching component oracle.rdbms.install.common, 19.0.0.0.0...

Patching component oracle.javavm.server, 19.0.0.0.0...

Patching component oracle.rdbms.drdaas, 19.0.0.0.0...

Patching component oracle.rdbms.install.plugins, 19.0.0.0.0...

Patching component oracle.rdbms.dv, 19.0.0.0.0...

Patching component oracle.ldap.client, 19.0.0.0.0...

Patching component oracle.network.client, 19.0.0.0.0...

Patching component oracle.rdbms.rsf.ic, 19.0.0.0.0...

Patching component oracle.precomp.common, 19.0.0.0.0...

Patching component oracle.precomp.lang, 19.0.0.0.0...

Patching component oracle.jdk, 1.8.0.201.0...
Patch 32218454 successfully applied.
Sub-set patch [30869156] has become inactive due to the application of a super-set patch [32218454].
Please refer to Doc ID 2161861.1 for any possible further required actions.
Log file location: /u01/app/oracle/product/19c/dbhome_1/cfgtoollogs/opatch/opatch2021-04-15_22-10-56PM_1.log

OPatch succeeded.




1. Load modified SQL files into the database. For each separate database running on the same shared Oracle home being patched, run the datapatch utility. The datapatch utility runs the necessary apply scripts to load the modified SQL files into the database. An entry is added to the dba_registry_sqlpatch view reflecting the patch application. In the dba_registry_sqlpatch view, verify the Status for the APPLY is "SUCCESS". For the last step, be patient as it takes a while to install the patches.   


a) $ sqlplus /nolog

SQL*Plus: Release 19.0.0.0.0 - Production on Thu Apr 15 22:37:09 2021
Version 19.10.0.0.0

Copyright (c) 1982, 2020, Oracle.  All rights reserved.


b) SQL> connect / as sysdba

Connected to an idle instance.


c) SQL> startup

ORACLE instance started.

Total System Global Area 1.0033E+10 bytes
Fixed Size                 12684712 bytes
Variable Size            1543503872 bytes
Database Buffers         8455716864 bytes
Redo Buffers               20869120 bytes
Database mounted.
Database opened.


d) SQL> alter pluggable database all open;
Pluggable database altered.

e) SQL> quit
Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.10.0.0.0

f) $ cd $ORACLE_HOME/OPatch
g) $ ./datapatch -verbose


SQL Patching tool version 19.10.0.0.0 Production on Thu Apr 15 22:39:12 2021
Copyright (c) 2012, 2020, Oracle.  All rights reserved.

Log file for this invocation: /u01/app/oracle/cfgtoollogs/sqlpatch/sqlpatch_21943_2021_04_15_22_39_12/sqlpatch_invocation.log

Connecting to database...OK
Gathering database info...done

Note:  Datapatch will only apply or rollback SQL fixes for PDBs
       that are in an open state, no patches will be applied to closed PDBs.
       Please refer to Note: Datapatch: Database 12c Post Patch SQL Automation
       (Doc ID 1585822.1)

Bootstrapping registry and package to current versions...done
Determining current state...done

Current state of interim SQL patches:
Interim patch 30805684 (OJVM RELEASE UPDATE: 19.7.0.0.200414 (30805684)):
  Binary registry: Installed
  PDB CDB$ROOT: Applied successfully on 14-APR-21 10.04.08.812171 PM
  PDB ORCLPDB: Applied successfully on 14-APR-21 10.27.44.969053 PM
  PDB PDB$SEED: Applied successfully on 14-APR-21 10.27.44.969053 PM

Current state of release update SQL patches:
  Binary registry:
    19.10.0.0.0 Release_Update 210108185017: Installed
  PDB CDB$ROOT:
    Applied 19.7.0.0.0 Release_Update 200404035018 successfully on 14-APR-21 10.04.08.553735 PM
  PDB ORCLPDB:
    Applied 19.7.0.0.0 Release_Update 200404035018 successfully on 14-APR-21 10.27.44.961738 PM
  PDB PDB$SEED:
    Applied 19.7.0.0.0 Release_Update 200404035018 successfully on 14-APR-21 10.27.44.961738 PM

Adding patches to installation queue and performing prereq checks...done
Installation queue:
  For the following PDBs: CDB$ROOT PDB$SEED ORCLPDB
    No interim patches need to be rolled back
    Patch 32218454 (Database Release Update : 19.10.0.0.210119 (32218454)):
      Apply from 19.7.0.0.0 Release_Update 200404035018 to 19.10.0.0.0 Release_Update 210108185017
    No interim patches need to be applied

Installing patches...
Patch installation complete.  Total patches installed: 3

Validating logfiles...done
Patch 32218454 apply (pdb CDB$ROOT): SUCCESS
  logfile: /u01/app/oracle/cfgtoollogs/sqlpatch/32218454/24018797/32218454_apply_ORCL_CDBROOT_2021Apr15_22_39_49.log (no errors)
Patch 32218454 apply (pdb PDB$SEED): SUCCESS
  logfile: /u01/app/oracle/cfgtoollogs/sqlpatch/32218454/24018797/32218454_apply_ORCL_PDBSEED_2021Apr15_22_44_33.log (no errors)
Patch 32218454 apply (pdb ORCLPDB): SUCCESS
  logfile: /u01/app/oracle/cfgtoollogs/sqlpatch/32218454/24018797/32218454_apply_ORCL_ORCLPDB_2021Apr15_22_44_32.log (no errors)

Automatic recompilation incomplete; run utlrp.sql to revalidate.
  PDBs: CDB$ROOT

SQL Patching tool complete on Thu Apr 15 22:48:37 2021





1. Notice the message "Automatic recompilation incomplete; run utlrp.sql to revalidate.
  PDBs: CDB$ROOT". Any databases that have invalid objects after the execution of datapatch should have utlrp.sql run to revalidate those objects.

  a)  cd $ORACLE_HOME/rdbms/admin
  b)  sqlplus /nolog

  SQL*Plus: Release 19.0.0.0.0 - Production on Thu Apr 15 22:54:29 2021
Version 19.10.0.0.0

Copyright (c) 1982, 2020, Oracle.  All rights reserved.

  c) SQL> CONNECT / AS SYSDBA

  Connected.

  d) SQL> @utlrp.sql

  Session altered.


  TIMESTAMP
  --------------------------------------------------------------------------------
  COMP_TIMESTAMP UTLRP_BGN              2021-04-15 22:55:30

  DOC>   The following PL/SQL block invokes UTL_RECOMP to recompile invalid
  DOC>   objects in the database. Recompilation time is proportional to the
  DOC>   number of invalid objects in the database, so this command may take
  DOC>   a long time to execute on a database with a large number of invalid
  DOC>   objects.
  DOC>
  DOC>   Use the following queries to track recompilation progress:
  DOC>
  DOC>   1. Query returning the number of invalid objects remaining. This
  DOC>      number should decrease with time.
  DOC>         SELECT COUNT(*) FROM obj$ WHERE status IN (4, 5, 6);
  DOC>
  DOC>   2. Query returning the number of objects compiled so far. This number
  DOC>      should increase with time.
  DOC>         SELECT COUNT(*) FROM UTL_RECOMP_COMPILED;
  DOC>
  DOC>   This script automatically chooses serial or parallel recompilation
  DOC>   based on the number of CPUs available (parameter cpu_count) multiplied
  DOC>   by the number of threads per CPU (parameter parallel_threads_per_cpu).
  DOC>   On RAC, this number is added across all RAC nodes.
  DOC>
  DOC>   UTL_RECOMP uses DBMS_SCHEDULER to create jobs for parallel
  DOC>   recompilation. Jobs are created without instance affinity so that they
  DOC>   can migrate across RAC nodes. Use the following queries to verify
  DOC>   whether UTL_RECOMP jobs are being created and run correctly:
  DOC>
  DOC>   1. Query showing jobs created by UTL_RECOMP
  DOC>         SELECT job_name FROM dba_scheduler_jobs
  DOC>            WHERE job_name like 'UTL_RECOMP_SLAVE_%';
  DOC>
  DOC>   2. Query showing UTL_RECOMP jobs that are running
  DOC>         SELECT job_name FROM dba_scheduler_running_jobs
  DOC>            WHERE job_name like 'UTL_RECOMP_SLAVE_%';
  DOC>#

  PL/SQL procedure successfully completed.


  TIMESTAMP
  --------------------------------------------------------------------------------
  COMP_TIMESTAMP UTLRP_END              2021-04-15 22:55:35

  DOC> The following query reports the number of invalid objects.
  DOC>
  DOC> If the number is higher than expected, please examine the error
  DOC> messages reported with each object (using SHOW ERRORS) to see if they
  DOC> point to system misconfiguration or resource constraints that must be
  DOC> fixed before attempting to recompile these objects.
  DOC>#

  OBJECTS WITH ERRORS
  -------------------
                    0

  DOC> The following query reports the number of exceptions caught during
  DOC> recompilation. If this number is non-zero, please query the error
  DOC> messages in the table UTL_RECOMP_ERRORS to see if any of these errors
  DOC> are due to misconfiguration or resource constraints that must be
  DOC> fixed before objects can compile successfully.
  DOC> Note: Typical compilation errors (due to coding errors) are not
  DOC>       logged into this table: they go into DBA_ERRORS instead.
  DOC>#

  ERRORS DURING RECOMPILATION
  ---------------------------
                            0


  Function created.


  PL/SQL procedure successfully completed.


  Function dropped.


  PL/SQL procedure successfully completed.
  SQL>

  e) exit SQL Plus

  SQL> exit

##  STEP: Upgrade Oracle Recovery Manager Catalog
  If you are using the Oracle Recovery Manager, the catalog needs to be upgraded. Enter the following command to upgrade it. The UPGRADE CATALOG command must be entered twice to confirm the upgrade.


1. $ rman catalog username/password@alias

1. RMAN> UPGRADE CATALOG;

1. RMAN> UPGRADE CATALOG;

1. RMAN> EXIT;
