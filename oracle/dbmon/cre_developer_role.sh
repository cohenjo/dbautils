sqlplus -s "/ as sysdba" <<EOF
create role DEVELOPER ;                                                                                                             
grant alter session,
 create cluster,
 create database link,
 create procedure,
 create sequence,
 create session,
 create synonym,
 create table,
 create trigger,
 create view to DEVELOPER ;
EOF
