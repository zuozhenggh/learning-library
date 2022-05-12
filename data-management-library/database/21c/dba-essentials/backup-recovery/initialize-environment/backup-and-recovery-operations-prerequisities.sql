alter session set container = pdb1;
CREATE user appuser IDENTIFIED BY mypassword container=current;
grant all privileges to appuser;
connect appuser/<mypassword>@//<hostname>:<port>
create tablespace oc datafile 'octs.dbf' size 32m;
create table regions (id number(2), name varchar2(20)) tablespace oc;
insert into regions values (1,'America');
insert into regions values (2,'Europe');
insert into regions values (3,'Asia');
commit;
!
mkdir /opt/oracle/oradata/CDB1
exit;
