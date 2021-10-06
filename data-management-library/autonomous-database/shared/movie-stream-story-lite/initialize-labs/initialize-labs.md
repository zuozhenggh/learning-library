# Add this to Lab 2

## Getting Started

## Task 1:  Create the MOVIESTREAM user
1. As the ADMIN user, **Create User** using SQL Tools UI
2. In the SQL Worksheet, add specific privileges to enable automation (i.e. creation of tables thru PLSQL scripts).  Copy and paste the following commands:
    
```
<copy>
grant execute on dbms_cloud to moviestream;
grant create table to moviestream;
grant create view to moviestream;
grant all on directory data_pump_dir to moviestream;
grant create procedure to moviestream;
grant create sequence to moviestream;
</copy>
```
3. Log out of SQL Worksheet

## Task 2: Create and Load tables using SQL Tools
1. Log into SQL Tools as MOVIESTREAM
1. Create and load `genre` and `customer_contact`

## Task 3:  Load the rest of the data using scripts

1. Open the SQL Worksheet from the Hamburger menu
2. Copy the script below into the worksheet and click Run Script (F5).

```
<copy>
-- Run the following in order to add all the data sets required for the workshop
-- Click F5 to run all the scripts at once

-- drop this table with the lab listings

drop table moviestream_labs; -- ignore error if table did not exist
drop table moviestream_log;  -- ignore error if table did not exist

-- Add the log table
create table moviestream_log
   (	execution_time timestamp (6), 
	    message varchar2(32000 byte)
   );

-- Create the MOVIESTREAM_LABS table that allows you to query all of the labs and their associated scripts
begin
    dbms_cloud.create_external_table(table_name => 'moviestream_labs',
                file_uri_list => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/adwc4pm/b/moviestream_lite_scripts/o/moviestream-lite-labs.json',
                format => '{"skipheaders":"0", "delimiter":"\n", "ignoreblanklines":"true"}',
                column_list => 'doc varchar2(30000)'
            );
end;
/

-- Define the scripts found in the labs table.
declare
    b_plsql_script blob;            -- binary object
    c_plsql_script clob;    -- converted to clob
    uri_scripts varchar2(2000) := 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/adwc4pm/b/moviestream_lite_scripts/o'; -- location of the scripts
    uri varchar2(2000);
begin

    -- Add privilege to run dbms_cloud
    -- Run a query to get each lab and then create the procedures that generate the output
    for lab_rec in (
        select  json_value (doc, '$.lab_num' returning number) as lab_num,
                json_value (doc, '$.title' returning varchar2(500)) as title,
                json_value (doc, '$.script' returning varchar2(100)) as proc        
        from moviestream_labs ml
        where json_value (doc, '$.script' returning varchar2(100))  is not null
        order by 1 asc
        ) 
    loop
        -- The plsql procedure DDL is contained in a file in object store
        -- Create the procedure
        dbms_output.put_line(lab_rec.title);
        dbms_output.put_line('....downloading plsql procedure ' || lab_rec.proc);
            
        -- download the script into this binary variable        
        uri := uri_scripts || '/' || lab_rec.proc || '.sql';
        
        dbms_output.put_line('....the full uri is ' || uri);        
        b_plsql_script := dbms_cloud.get_object(object_uri => uri);
        
        dbms_output.put_line('....creating plsql procedure ' || lab_rec.proc);
        -- convert the blob to a varchar2 and then create the procedure
        c_plsql_script :=  to_clob( b_plsql_script );
        
        -- generate the procedure
        execute immediate c_plsql_script;

    end loop lab_rec;  
    
    execute immediate 'grant execute on moviestream_write to public';

    exception 
        when others then
            dbms_output.put_line('Unable to add the data sets.');
            dbms_output.put_line('');
            dbms_output.put_line(sqlerrm);
 end;
 /
 
begin
    add_datasets();
end;
/
 </copy>
```


This will take a few minutes to run; the script is running thru many steps :). Once complete, the MOVIESTREAM schema contains all of the data required for the workshop.

## Acknowledgements

* **Author** - Marty Gubar, Product Manager - Server Technologies
* **Last Updated By/Date** - Marty Gubar, October 2021
