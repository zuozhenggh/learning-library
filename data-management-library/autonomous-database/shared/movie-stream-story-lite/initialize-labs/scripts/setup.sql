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