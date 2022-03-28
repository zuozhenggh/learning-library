begin
  
  -- drop tables if they exist
  for rec in (
            select table_name
            from user_tables
            where table_name in ('MOVIESTREAM_LABS', 'MOVIESTREAM_LOG')
            )
    loop
        dbms_output.put_line('drop ' || rec.table_name);
        execute immediate 'drop table ' || rec.table_name;
    end loop;
    
    -- create the tables
    dbms_output.put_line('create table moviestream_labs');
    dbms_cloud.create_external_table(table_name => 'moviestream_labs',
                file_uri_list => 'https://raw.githubusercontent.com/oracle/learning-library/master/data-management-library/autonomous-database/shared/movie-stream-story-lite/add-data-scripts/moviestream-lite-labs.json',
                format => json_object('skipheaders' value '0', 'delimiter' value '\n','ignoreblanklines' value 'true'),
                column_list => 'doc varchar2(30000)'
            );
  
    dbms_output.put_line('create table moviestream_log');
    execute immediate ('create table moviestream_log (
                            execution_time timestamp (6),
                            message varchar2(32000 byte)
                        )'
                        );

  
end;
/