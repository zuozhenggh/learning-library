create or replace procedure lab_create_user 
(
  pwd in varchar2 default 'Welcome2Movies#'
) as
    user_name varchar2(100);
    kill_session varchar2(200);
begin
    
    user_name := 'MOVIESTREAM';
    
    -- Disconnect all moviestream sessions
    dbms_output.put_line(systimestamp || ' - disconnecting ' || user_name);
    for c in (
    select s.sid,
           s.serial#,
           s.inst_id
    from   gv$session s
    where  s.username = user_name
    )
    loop
        kill_session := 'alter system kill session ''' || c.sid || ',' || c.serial# || ',@' || c.inst_id || '''';
        -- dbms_output.put_line(kill_session);
        execute immediate kill_session;
    end loop;

    begin
        dbms_output.put_line(systimestamp || ' - dropping ' || user_name);
        execute immediate 'drop user moviestream cascade';
    exception
        when others then
            dbms_output.put_line(systimestamp || ' - no user to drop or ' || user_name || ' is connected and could not kill the session');
            dbms_output.put_line(systimestamp || ' - will keep going.');
    end;
    
    begin
        dbms_output.put_line(systimestamp || ' - creating ' || user_name);
        --execute immediate 'create user moviestream identified by ' || pwd;
        execute immediate 'create user moviestream';
    exception
        when others then
            dbms_output.put_line('Unable to create user.  Two possible issues:');
            dbms_output.put_line('1. Try a different password.');
            dbms_output.put_line('2. The ' || user_name || ' user was connected and could not be dropped and recreated.  Make sure the user is logged out.');
            raise;
    end;

    -- Provide minimal tablespace usage.  Uncomment unlimited tablespace use if desired.
    dbms_output.put_line(systimestamp || ' - granting unlimited usage on data tablespace');
    -- execute immediate 'alter user moviestream quota 20G ON data';
    execute immediate 'grant unlimited tablespace to moviestream';

    -- Grant roles/privileges to user
    dbms_output.put_line(systimestamp || ' - granting privileges');
--    execute immediate 'grant connect to ' || user_name;
    execute immediate 'grant dwrole to ' || user_name;
--    execute immediate 'grant resource to ' || user_name;
    execute immediate 'grant oml_developer to ' || user_name;
    execute immediate 'grant graph_developer to ' || user_name;
    execute immediate 'grant console_developer to ' || user_name;
  
    -- These grants are required in order to make plsql automation to work
    execute immediate 'grant select on v$services to ' || user_name;
    execute immediate 'grant select on dba_rsrc_consumer_group_privs to  ' || user_name;
    execute immediate 'grant execute on dbms_session to  ' || user_name;
    execute immediate 'grant execute on dbms_cloud to  ' || user_name;
    execute immediate 'grant read,write on directory data_pump_dir to ' || user_name;
    execute immediate 'grant ALTER  SESSION,
                                    CONNECT,
                                    RESOURCE,
                                    CREATE ANALYTIC VIEW,
                                    CREATE ATTRIBUTE DIMENSION,
                                    CREATE HIERARCHY,
                                    CREATE JOB,
                                    CREATE MATERIALIZED VIEW,
                                    CREATE MINING MODEL,
                                    CREATE PROCEDURE,
                                    CREATE SEQUENCE,
                                    CREATE SESSION,
                                    CREATE SYNONYM,
                                    CREATE TABLE,
                                    CREATE TRIGGER,
                                    CREATE TYPE,
                                    CREATE VIEW to '|| user_name;
    execute immediate 'grant inherit privileges on user admin to ' || user_name;
    execute immediate 'alter user ' || user_name || ' grant connect through OML$PROXY';
    execute immediate 'alter user ' || user_name || ' grant connect through GRAPH$PROXY_USER';
    
    dbms_output.put_line(systimestamp || ' - enabling SQL tools access');
    ords.enable_schema (
        p_enabled               => TRUE,
        p_schema                => 'moviestream',
        p_url_mapping_type      => 'BASE_PATH',
        p_auto_rest_auth        => TRUE   
    );
    commit;
    
    -- Message about password
    dbms_output.put_line('');
    dbms_output.put_line('You can not log in until you set a password!');
    dbms_output.put_line('');
    dbms_output.put_line('Please create a secure password using the following command:');
    dbms_output.put_line('  ALTER USER moviestream IDENTIFIED BY "<secure password>";');
    dbms_output.put_line('');
    
exception
    when others then
        dbms_output.put_line('ERROR.');
        dbms_output.put_line(sqlerrm);


end lab_create_user;