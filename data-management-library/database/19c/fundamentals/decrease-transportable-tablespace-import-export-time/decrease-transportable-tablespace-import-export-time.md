# Decrease the Transportable Tablespace (TTS) Import and Export Time

## Introduction
In this practice, you will use new data pump parameters to decrease the transportable tablespace import time.

Estimated Lab Time: 20 minutes

### Objectives

Learn how to do the following:

- Decrease TTS Import Time
- Decrease TTS Export Time

### Prerequisites

Be sure that the following tasks are completed before you start:

- Obtain an Oracle Cloud account.
- Create SSH keys.
- Sign in to Oracle Cloud Infrastructure.

## **Task**: Decrease the Transportable Tablespace Import Time

1. Execute the` /home/oracle/labs/19cnf/create_drop_TBS.sh` shell script. The script creates another `PDB`, `PDB19_IN_ORCL`, creates the `TEST` tablespace in `PDB1` and the directory for Data Pump in `PDB1` in `ORCL`, and drops the `TEST` tablespace in `PDB19_IN_ORCL`.
```
$ /home/oracle/labs/DB/create_drop_TBS.sh
```

2. You plan to transport the `TEST` tablespace from `PDB1` into `PDB19_IN_ORCL` in `ORCL` and keep the transported tablespace in read-only mode after import.
    1. First, export the `TEST` tablespace from `PDB1` from `ORCL` with the transportable tablespace mode.
    2. Set the `TEST` user-defined tablespace that stores the HR.EMPLOYEES table to read-only before exporting.

      ```
      $ sqlplus system@PDB1
      Enter password: password

      SQL> SELECT * FROM hr.tabtest;

      LABEL
      ----------------------------------------------
      DATA FROM system.tabtest ON TABLESPACE test

      SQL> ALTER TABLESPACE test READ ONLY;

      Tablespace altered.

      SQL> EXIT
      ```
    3. 	Export the `TEST` tablespace from `PDB1` with the transportable tablespace mode.

      ```
        $ expdp \"sys@PDB1 as sysdba\" DIRECTORY=dp_pdb1 dumpfile=PDB1.dmp TRANSPORT_TABLESPACES=test TRANSPORT_FULL_CHECK=YES LOGFILE=tts.log REUSE_DUMPFILES=YES
      …
      Password: password
      Starting "SYS"."SYS_EXPORT_TRANSPORTABLE_01":  "sys/********@PDB1 AS SYSDBA" DIRECTORY=dp_pdb1 dumpfile=PDB1.dmp TRANSPORT_TABLESPACES=test TRANSPORT_FULL_CHECK=YES LOGFILE=tts.log REUSE_DUMPFILES=YES
      ORA-39396: Warning: exporting encrypted data using transportable option without password
      Processing object type TRANSPORTABLE_EXPORT/STATISTICS/TABLE_STATISTICS
      Processing object type TRANSPORTABLE_EXPORT/STATISTICS/MARKER
      Processing object type TRANSPORTABLE_EXPORT/PLUGTS_BLK
      Processing object type TRANSPORTABLE_EXPORT/POST_INSTANCE/PLUGTS_BLK
      Processing object type TRANSPORTABLE_EXPORT/TABLE
      Master table "SYS"."SYS_EXPORT_TRANSPORTABLE_01" successfully loaded/unloaded
      ****************************************************************
      Dump file set for SYS.SYS_EXPORT_TRANSPORTABLE_01 is:
        /tmp/PDB1.dmp
      ****************************************************************
      Datafiles required for transportable tablespace TEST:
        /u02/app/oracle/oradata/ORCL/pdb1/test01.dbf
      Job "SYS"."SYS_EXPORT_TRANSPORTABLE_01" successfully completed at Thu Sep 6 16:51:49 2018 elapsed 0 00:00:43
      $
      ```

3. Create the directory for Data Pump in `PDB19_IN_ORCL` in `ORCL`.

  ```
  $ sqlplus system@PDB19_IN_ORCL
  Enter password: password

  SQL> CREATE DIRECTORY dp_pdb19_in_orcl AS '/tmp';

  Directory created.

  SQL>

  ```

4. Verify that the tablespace` TEST` does not exist in `PDB19_IN_ORCL`.
  ```
  SQL> SELECT tablespace_name FROM dba_tablespaces;

  TABLESPACE_NAME
  ------------------------------
  SYSTEM
  SYSAUX
  UNDOTBS1
  TEMP
  USERS

  SQL>
  ```
If the tablespace already exists, drop it.
  ```
  SQL> DROP TABLESPACE test INCLUDING CONTENTS AND DATAFILES;

  Tablespace dropped.

  SQL> EXIT
  $
```
5. Copy the data files of the TEST tablespace of `PDB1` of `ORCL` to the target directory of `PDB19_IN_ORCL`.
```
$ cp /u02/app/oracle/oradata/ORCL/pdb1/test01.dbf  /u02/app/oracle/oradata/ORCL/pdb19_in_orcl
$
```

6. Import the `PDB1 TEST` tablespace in `PDB19_IN_ORCL` in `ORCL` and keep the imported tablespace in read-only mode.
```
$ impdp \'sys@PDB19_IN_ORCL as sysdba\' DIRECTORY=dp_pdb19_in_orcl DUMPFILE=PDB1.dmp TRANSPORT_DATAFILES='/u02/app/oracle/oradata/ORCL/pdb19_in_orcl/test01.dbf' TRANSPORTABLE=KEEP_READ_ONLY
…
Password: password
Master table "SYS"."SYS_IMPORT_TRANSPORTABLE_01" successfully loaded/unloaded
Starting "SYS"."SYS_IMPORT_TRANSPORTABLE_01":  "sys/********@PDB19_IN_ORCL AS SYSDBA" DIRECTORY=dp_pdb19_in_orcl DUMPFILE=PDB1.dmp TRANSPORT_DATAFILES=/u02/app/oracle/oradata/ORCL/pdb19_in_orcl/test01.dbf TRANSPORTABLE=KEEP_READ_ONLY
Processing object type TRANSPORTABLE_EXPORT/PLUGTS_BLK
Processing object type TRANSPORTABLE_EXPORT/TABLE
Processing object type TRANSPORTABLE_EXPORT/STATISTICS/TABLE_STATISTICS
Processing object type TRANSPORTABLE_EXPORT/STATISTICS/MARKER
Processing object type TRANSPORTABLE_EXPORT/POST_INSTANCE/PLUGTS_BLK
Job "SYS"."SYS_IMPORT_TRANSPORTABLE_01" successfully completed at Thu Sep 6 17:06:15 2018 elapsed 0 00:00:27
$
```

7. Verify that `PDB19_IN_ORCL` is still in read-only mode after import. For a huge tablespace import, the `KEEP_READ_ONLY` parameter can decrease the time spent.

  ```
  $ sqlplus system@PDB19_IN_ORCL
  Enter password: password

  SQL> SELECT status FROM dba_tablespaces
       WHERE  tablespace_name='TEST';

  STATUS
  ----------
  READ ONLY

  SQL> EXIT
  $

  ```
8. Execute the` /home/oracle/labs/DB/drop_TBS.sh` shell script to drop the tablespace imported in `PDB19_IN_ORCL.`
```
$ /home/oracle/labs/DB/drop_TBS.sh
…
$
```
9. You now plan to transport the `TEST` tablespace from `PDB1` into `PDB19_IN_ORCL`. After import, the bitmaps in the data file are not rebuilt, but the tablespace can be set to read/write. This type of operation decreases the time at import time. As you already exported the tablespace in the previous steps, you can reuse the `/tmp/PDB1.dmp` dump file.
  1. Copy the data files of the `TEST` tablespace of `PDB1` of `ORCL` to the target directory of `PDB19_IN_ORCL`.
  ```
  $ cp /u02/app/oracle/oradata/ORCL/pdb1/test01.dbf  /u02/app/oracle/oradata/ORCL/pdb19_in_orcl
  $
  ```
  2. Import the `TEST` tablespace from `PDB1` into `PDB19_IN_ORCL` with no bitmap rebuild.
  ```
  $ impdp \'sys@PDB19_IN_ORCL as sysdba\' DIRECTORY=dp_pdb19_in_orcl DUMPFILE=PDB1.dmp TRANSPORT_DATAFILES='/u02/app/oracle/oradata/ORCL/pdb19_in_orcl/test01.dbf' TRANSPORTABLE=NO_BITMAP_REBUILD
…
Password: password
Master table "SYS"."SYS_IMPORT_TRANSPORTABLE_01" successfully loaded/unloaded
Starting "SYS"."SYS_IMPORT_TRANSPORTABLE_01":  "sys/********@PDB19_IN_ORCL AS SYSDBA" DIRECTORY=dp_pdb19_in_orcl DUMPFILE=PDB1.dmp TRANSPORT_DATAFILES=/u02/app/oracle/oradata/ORCL/pdb19_in_orcl/test01.dbf TRANSPORTABLE=NO_BITMAP_REBUILD
Processing object type TRANSPORTABLE_EXPORT/PLUGTS_BLK
Processing object type TRANSPORTABLE_EXPORT/TABLE
Processing object type TRANSPORTABLE_EXPORT/STATISTICS/TABLE_STATISTICS
Processing object type TRANSPORTABLE_EXPORT/STATISTICS/MARKER
Processing object type TRANSPORTABLE_EXPORT/POST_INSTANCE/PLUGTS_BLK
Job "SYS"."SYS_IMPORT_TRANSPORTABLE_01" successfully completed at Thu Sep 6 17:09:54 2018 elapsed 0 00:00:25
$
  ```
10. Verify that `PDB19_IN_ORCL` is in read-only mode after import. For a huge tablespace import, the `NO_BITMAP_REBUILD` parameter can decrease the time spent.

  ```
  $ sqlplus sys@PDB19_IN_ORCL AS SYSDBA
  Enter password: password

  SQL> SELECT status FROM dba_tablespaces
       WHERE  tablespace_name='TEST';
   2
  STATUS
  ----------
  READ ONLY

  SQL>

  ```
  *Q1/ Can you set the tablespace to read/write although the bitmaps are not rebuilt?*
  ```
  SQL> ALTER TABLESPACE test READ WRITE;

  Tablespace altered.

  SQL>

  ```
  **A1/ Yes, the tablespace can be set to read/write. The bitmaps can be rebuilt later with the `DBMS_SPACE_ADMIN.TABLESPACE_REBUILD_BITMAPS` procedure.**
  ```
  SQL> exec DBMS_SPACE_ADMIN.TABLESPACE_REBUILD_BITMAPS('TEST')

  PL/SQL procedure successfully completed.

  SQL> EXIT

  $
  ```

> **Note**: End of Decreasing TTS Import Time Lab.

## Introduction
In this practice, you use new data pump parameters to decrease the transportable tablespace export time.

Estimated Lab Time: 10 minutes


## **Task**: Decrease the Transportable Tablespace Export Time
1. Execute the `/home/oracle/labs/DB/create_drop_TBS.sh` shell script. The script creates the TEST tablespace and the directory for Data Pump in `PDB1` in `ORCL`, and drops the `TEST` tablespace in `PDB19_IN_ORCL`.
```
$ /home/oracle/labs/DB/create_drop_TBS.sh
…
$
```
2. Create the directory for Data Pump in `PDB19_IN_ORCL` in `ORCL`.

  ```
  $ sqlplus system@PDB19_IN_ORCL
  Enter password: password

  SQL> CREATE DIRECTORY dp_pdb19_in_orcl AS '/tmp';

  Directory created.

  SQL>
  ```
3. You plan to transport the `TEST` tablespace from `PDB1` into `PDB19_IN_ORCL`. Because the time it takes to conduct the closure check can be long, the closure check can be unnecessary when the DBA knows that the transportable set is self-contained. Skipping the closure check allows the tablespaces to remain read-write. First, determine the length of time that tablespace files are required to be read-only during transportable operations. Running the data pump transportable operation with the `TTS_CLOSURE_CHECK` parameter in `TEST_MODE` mode provides timing estimation of the TTS export operation.

  ```
  $ expdp \"sys@PDB1 as sysdba\" DIRECTORY= dp_pdb1 dumpfile=PDB1.dmp TRANSPORT_TABLESPACES=test TRANSPORT_FULL_CHECK=YES TTS_CLOSURE_CHECK=TEST_MODE LOGFILE=tts.log REUSE_DUMPFILES=YES
  …
  Password: password
  Starting "SYS"."SYS_EXPORT_TRANSPORTABLE_01":  "sys/********@PDB1 AS SYSDBA" DIRECTORY=dp_pdb1 dumpfile=PDB1.dmp TRANSPORT_TABLESPACES=test TRANSPORT_FULL_CHECK=YES TTS_CLOSURE_CHECK=TEST_MODE LOGFILE=tts.log REUSE_DUMPFILES=YES
  Processing object type TRANSPORTABLE_EXPORT/STATISTICS/TABLE_STATISTICS
  Processing object type TRANSPORTABLE_EXPORT/STATISTICS/MARKER
  Processing object type TRANSPORTABLE_EXPORT/PLUGTS_BLK
  Processing object type TRANSPORTABLE_EXPORT/POST_INSTANCE/PLUGTS_BLK
  Processing object type TRANSPORTABLE_EXPORT/TABLE
  Master table "SYS"."SYS_EXPORT_TRANSPORTABLE_01" successfully loaded/unloaded
  ****************************************************************
  Dump file set for SYS.SYS_EXPORT_TRANSPORTABLE_01 is:
    /tmp/PDB1.dmp
  Dump file set is unusable. TEST_MODE requested.
  ****************************************************************
  Datafiles required for transportable tablespace TEST:
    /u02/app/oracle/oradata/ORCL/pdb1/test01.dbf
  Job "SYS"."SYS_EXPORT_TRANSPORTABLE_01" successfully completed at Mon Sep 10 09:34:05 2018 elapsed 0 00:00:37
  $
  ```

  **Q1/ Can you use the dump file to import the** `TEST` **tablespace into** `PDB19_IN_ORCL`**?**
  ```
  $ impdp \"sys@PDB19_IN_ORCL as sysdba\" DIRECTORY=dp_pdb19_in_orcl dumpfile=PDB1.dmp TRANSPORT_DATAFILES='/u02/app/oracle/oradata/ORCL/pdb19_in_orcl/test01.dbf' LOGFILE=tts.log
  …
  Password: password
  ORA-39001: invalid argument value
  ORA-39000: bad dump file specification
  ORA-39398: Cannot load data. Data Pump dump file "/tmp/PDB1.dmp" was created in TEST_MODE.
  $

  ```
  **A1/ The resulting export dump file is not available for use by Data Pump import.**
4. The timing estimation leads you to complete the data pump export transportable operation with the possibility to decrease the time required for data pump TTS to complete with the `TTS_CLOSURE_CHECK` parameter set to `OFF`. Of course, you are sure that the transportable tablespace set is contained.

  ```
  $ expdp \"sys@PDB1 as sysdba\" DIRECTORY= dp_pdb1 dumpfile=PDB1.dmp TRANSPORT_TABLESPACES=test TTS_CLOSURE_CHECK=OFF LOGFILE=tts.log REUSE_DUMPFILES=YES
  …
  Password: password
  Starting "SYS"."SYS_EXPORT_TRANSPORTABLE_01":  "sys/********@PDB1 AS SYSDBA" DIRECTORY=dp_pdb1 dumpfile=PDB1.dmp TRANSPORT_TABLESPACES=test TTS_CLOSURE_CHECK=OFF LOGFILE=tts.log REUSE_DUMPFILES=YES
  ORA-39396: Warning: exporting encrypted data using transportable option without password
  Processing object type TRANSPORTABLE_EXPORT/STATISTICS/TABLE_STATISTICS
  Processing object type TRANSPORTABLE_EXPORT/STATISTICS/MARKER
  ORA-39123: Data Pump transportable tablespace job aborted
  ORA-39185: The transportable tablespace failure list is

  ORA-29335: tablespace 'TEST' is not read only
  Job "SYS"."SYS_EXPORT_TRANSPORTABLE_01" stopped due to fatal error at Mon Sep 10 10:14:22 2018 elapsed 0 00:00:03
  $
```

*Q2/ Does the* `TTS_CLOSURE_CHECK` *parameter set to a value other than `TEST_MODE` allow you to export the tablespace in read/write mode?*

***A2/ No. Only the `TEST_MODE` value allows you to test the export operation timing. If you use other values such as `ON`, `OFF`, and `FULL`, the tablespace needs to be set to read-only.***


  1. Set the `TEST` user-defined tablespace that stores the `HR.EMPLOYEES` table to read-only before exporting.

    ```
      $ sqlplus system@PDB1
      Enter password: password

      SQL> SELECT * FROM hr.tabtest;

      LABEL
      ----------------------------------------------
      DATA FROM system.tabtest ON TABLESPACE test

      SQL> ALTER TABLESPACE test READ ONLY;

      Tablespace altered.

      SQL> EXIT
      $

    ```

  2. Export the tablespace.
      ```
        $ expdp \"sys@PDB1 as sysdba\" DIRECTORY= dp_pdb1 dumpfile=PDB1.dmp TRANSPORT_TABLESPACES=test TTS_CLOSURE_CHECK=OFF LOGFILE=tts.log REUSE_DUMPFILES=YES
        …
        Password: password
        Starting "SYS"."SYS_EXPORT_TRANSPORTABLE_01":  "sys/********@PDB1 AS SYSDBA" DIRECTORY=dp_pdb1 dumpfile=PDB1.dmp TRANSPORT_TABLESPACES=test TTS_CLOSURE_CHECK=OFF LOGFILE=tts.log REUSE_DUMPFILES=YES
        ORA-39396: Warning: exporting encrypted data using transportable option without password
        Processing object type TRANSPORTABLE_EXPORT/STATISTICS/TABLE_STATISTICS
        Processing object type TRANSPORTABLE_EXPORT/STATISTICS/MARKER
        Processing object type TRANSPORTABLE_EXPORT/PLUGTS_BLK
        Processing object type TRANSPORTABLE_EXPORT/POST_INSTANCE/PLUGTS_BLK
        Processing object type TRANSPORTABLE_EXPORT/TABLE
        Master table "SYS"."SYS_EXPORT_TRANSPORTABLE_01" successfully loaded/unloaded
        ****************************************************************
        Dump file set for SYS.SYS_EXPORT_TRANSPORTABLE_01 is:
          /tmp/PDB1.dmp
        ****************************************************************
        Datafiles required for transportable tablespace TEST:
          /u02/app/oracle/oradata/ORCL/pdb1/test01.dbf
        Job "SYS"."SYS_EXPORT_TRANSPORTABLE_01" successfully completed at Mon Sep 10 10:26:47 2018 elapsed 0 00:00:11
        $
      ```

5. Copy the data files of the `TEST` tablespace of `PDB1` of `ORCL` to the target directory of `PDB19_IN_ORCL`.
```
$ cp /u02/app/oracle/oradata/ORCL/pdb1/test01.dbf  /u02/app/oracle/oradata/ORCL/pdb19_in_orcl
$
```
6. Import the `PDB1 TEST` tablespace in `PDB19_IN_ORCL`.
```
$ impdp \'sys@PDB19_IN_ORCL as sysdba\' DIRECTORY=dp_pdb19_in_orcl DUMPFILE=PDB1.dmp TRANSPORT_DATAFILES='/u02/app/oracle/oradata/ORCL/pdb19_in_orcl/test01.dbf'
…
Password: password
Master table "SYS"."SYS_IMPORT_TRANSPORTABLE_01" successfully loaded/unloaded
Starting "SYS"."SYS_IMPORT_TRANSPORTABLE_01":  "sys/********@PDB19_IN_ORCL AS SYSDBA" DIRECTORY=dp_pdb19_in_orcl DUMPFILE=PDB1.dmp TRANSPORT_DATAFILES=/u02/app/oracle/oradata/ORCL/pdb19_in_orcl/test01.dbf
Processing object type TRANSPORTABLE_EXPORT/PLUGTS_BLK
Processing object type TRANSPORTABLE_EXPORT/TABLE
Processing object type TRANSPORTABLE_EXPORT/STATISTICS/TABLE_STATISTICS
Processing object type TRANSPORTABLE_EXPORT/STATISTICS/MARKER
Processing object type TRANSPORTABLE_EXPORT/POST_INSTANCE/PLUGTS_BLK
Job "SYS"."SYS_IMPORT_TRANSPORTABLE_01" successfully completed at Mon Sep 10 10:34:49 2018 elapsed 0 00:00:24
$
```
7. Verify that `PDB19_IN_ORCL` is in read-only mode after import. For a huge tablespace to export, the `TTS_CLOSURE_CHECK` parameter can decrease the time spent during the export operation.

  ```
  $ sqlplus system@PDB19_IN_ORCL
  Enter password: password

  SQL> SELECT status FROM dba_tablespaces
       WHERE  tablespace_name='TEST';
   2
  STATUS
  ----------
  READ ONLY

  SQL> EXIT
  $
  ```


> **Note**: End of Decreasing TTS Export Time Lab.


## Acknowledgements

* **Author: Dominique Jeunot's, Consulting User Assistance Developer**
* **Last Updated By: Blake Hendricks, Solutions Engineer, 7/13/21**
