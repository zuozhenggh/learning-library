create or replace procedure run_lab_prereq 
(
  lab_number in number default null 
) as 
    lab_found boolean := false;
    e_no_lab_number EXCEPTION;
    PRAGMA exception_init( e_no_lab_number, -20001 );
    
begin
  
    
    if lab_number < 4 or lab_number is null then 
        dbms_output.put_line('');
        dbms_output.put_line('Invalid lab number was specified.  Please specify the number of the lab.');
        dbms_output.put_line('Valid values are greater than 4. The earlier labs do not have prerequistes.');
        dbms_output.put_line('');
        dbms_output.put_line('For example, to run all the prerequisites for Lab 4:');
        dbms_output.put_line('');
        dbms_output.put_line('  exec run_lab_prereq(lab_number => 4)');
        
        raise e_no_lab_number;

    end if;
        
      dbms_output.put_line(''); 
      dbms_output.put_line('Finding prequisites for lab #' || lab_number);
      -- Get the list of prequisite labs
      -- Those will be lab numbers that come before the user provided lab
      for lab_rec in (
            select  json_value (doc, '$.lab_num' returning number) lab_num,
                    json_value (doc, '$.title' returning varchar2(500)) title,
                    json_value (doc, '$.script' returning varchar2(100)) script        
            from moviestream_labs ml
            where json_value (doc, '$.script' returning varchar2(100))  is not null
              and json_value (doc, '$.lab_num' returning number) > 0  -- "negative" labs are infrastructure
              and json_value (doc, '$.lab_num' returning number) < lab_number -- prerequiste labs
            order by 1 asc
            )       
        loop
        -- Run the prerequisite script
        lab_found := true;
        dbms_output.put_line('  ********');
        dbms_output.put_line('  ** Running script for ' || lab_rec.title);   
        dbms_output.put_line('  ** Script name: ' || lab_rec.script);   
        dbms_output.put_line('  ********');
        execute immediate ('begin ' || lab_rec.script || '; end;');

    end loop lab_rec; 

    
    dbms_output.put_line('Done.');
    dbms_output.put_line('');
    if lab_number >= 4  then
        dbms_output.put_line('');
        dbms_output.put_line('Don''t forget to set a password for the moviestream user!');
        dbms_output.put_line('');
        dbms_output.put_line('Please create a secure password using the following command:');
        dbms_output.put_line('');
        dbms_output.put_line('  ALTER USER moviestream IDENTIFIED BY "<secure password>";');
        dbms_output.put_line('');
    end if;
    
exception
    when others then        
        dbms_output.put_line('');
        dbms_output.put_line('* ERROR * ' || sqlerrm);
        
end run_lab_prereq;