create user frm_repqueue identified by &1;
grant connect, resource to frm_repqueue;
grant unlimited tablespace to frm_repqueue;

connect frm_repqueue/&1@&2;
@rw_server.sql

alter table frm_repqueue.RW_JOBS modify CACHEKEY varchar2(4000);
exit;
