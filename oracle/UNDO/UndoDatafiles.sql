set lines 120
set pages 999
clear col

set termout off
set trimout on
set trimspool on

connect / as sysdba
alter session set nls_date_format='dd-Mon-yyyy hh24:mi';

spool undodatafiles.out

prompt
prompt  ############## RUNTIME ############## 
prompt

col rdate head "Run Time"

select sysdate rdate from dual;

prompt 
prompt  ############## DATAFILES ############## 
prompt 

col retention head "Retention"
col tablespace_name format a30 head "TBSP Name"
col file_id format 999 head "File #"
col a format 999,999,999,999,999 head "Bytes Alloc (MB)"
col b format 999,999,999,999,999 head "Max Bytes Used (MB)"
col autoextensible head "Auto|Ext"
col extent_management head "Ext Mngmnt"
col allocation_type head "Type"
col segment_space_management head "SSM"

select tablespace_name, file_id, sum(bytes)/1024/1024 a, 
       sum(maxbytes)/1024/1024 b, 
       autoextensible
from dba_data_files
where tablespace_name in (select tablespace_name from dba_tablespaces
   where retention like '%GUARANTEE' )
group by file_id, tablespace_name, autoextensible
order by tablespace_name
/

spool off
set termout on
set trimout off
set trimspool off
clear col