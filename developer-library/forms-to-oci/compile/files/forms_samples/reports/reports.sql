create user rwadmin identified by &1;
grant connect, resource to rwadmin;
grant unlimited tablespace to rwadmin;

connect rwadmin/&1@&2;
@rw_server.sql

alter table rwadmin.RW_JOBS modify CACHEKEY varchar2(4000);
exit;
