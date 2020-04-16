# Oracle Database 19c JSON Documents

## Environment Preparation

This workshop requires an Oracle Database 19c installation. The virtual machine, built during any of the workshop labs, contains Oracle Database 19c installed with Multitenant architecture, and one pluggable database that will be used for the execution of the following exercises.

## Lab Prerequisites

This lab assumes you have completed the following labs:

Lab: Login to Oracle Cloud  
Lab: Generate SSH Key   
Lab: Setup   

## Lab User Schema

For this lab we will use the ***Order Entry (OE)*** sample schema that is provided with the Oracle Database installation. If you have completed the setup previously you will already have the ***OE*** schema installed.

### Grant Required Privileges

Connect to the **ORCLPDB** pluggable database, as SYSDBA.

````
$ <copy>sqlplus sys/Ora_DB4U@localhost:1521/orclpdb as SYSDBA</copy>
````

Grant **OE** user some privileges required for the tasks we will execute in this lab.

````
<copy>GRANT SELECT ON v_$session TO oe;
GRANT SELECT ON v_$sql_plan_statistics_all TO oe;
GRANT SELECT ON v_$sql_plan TO oe;
GRANT SELECT ON v_$sql TO oe;
GRANT ALTER SYSTEM TO oe;
</copy>
````

>**Note**: The ***ALTER SYSTEM*** privilege is required to flush the Shared Pool in one exercise about performance.

### Create Network Access Control List

Our database needs to connect to a web service, and retrieve information over HTTP, and this requires an ***Access Control List (ACL)***. This ACL can be created by a user with SYSDBA privileges, SYS in this case, from the Pluggable Database called **ORCLPDB**, by executing the following procedure.

````
<copy>begin
  DBMS_NETWORK_ACL_ADMIN.append_host_ace (
    host       => 'api.geonames.org',
    ace        => xs$ace_type(privilege_list => xs$name_list('http','connect','resolve'),
                              principal_name => 'OE',
                              principal_type => xs_acl.ptype_db));
end;
/</copy>
````

    ![](images/p_addACL.png)
Ensure the execution is successful.

### SQL*Plus Formatting

Close the SYSDBA connection and connect as the **OE** user to pluggable database ORCLPDB. From this point, all tasks on the database side will be performed using the **OE** user. For SQL*Plus, it is also useful to format the output. Feel free to use your own formatting, or just run these formatting commands every time you connect.

````
> <copy>conn oe/Ora_DB4U@localhost:1521/orclpdb</copy>
````

````
<copy>set linesize 130
set serveroutput on
set pages 9999
set long 90000
column WORKSHOPNAME format a50
column LOCATION format a20
column COUNTRY format a8
column GEONAMEID format a10
column TITLE format a35
column NAME format a32
column REGION format a20
column SUB_REGION format a22
column REGION format a12
</copy>
````

For the purpose of this exercise we will use a web service, that return information in JSON format, provided by GeoNames - [geonames.org](http://www.geonames.org/). GeoNames is licensed under a [Creative Commons Attribution 4.0 License](https://creativecommons.org/licenses/by/4.0/). You are free to:

- Share — copy and redistribute the material in any medium or format;
- Adapt — remix, transform, and build upon the material for any purpose, even commercially.

Click '**login**' link on the upper right corner of GeoNames website, and create a new account. **Note:** When you create your GeoNames account you will receive an email to activate the account. You also have to enable the account for web services on the account page [GeoNames Account Page](http://www.geonames.org/manageaccount)

---
