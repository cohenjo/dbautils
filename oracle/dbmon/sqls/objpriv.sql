REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show table's privileges
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off
set verify  off

col owner		for a&3 
col grantee		for a&3
col privilege 		for a4	head Priv
col grantor		for a&3
col table_name		for a15
col grantable		for a3	head Able

break on owner on table_name on grantor on grantee 

SELECT owner, table_name, grantor, grantee, 
       decode(privilege,'SELECT','SEL','INSERT','INS','DELETE','DEL','UPDATE','UPD','ALTER','ALT','EXECUTE','EXE','INDEX','IND','REFERENCES','REF') privilege, 
       grantable 
FROM dba_tab_privs
WHERE table_name like upper('&1')
  AND owner &2
  AND owner not in ('SYS', 'SYSTEM')
;
prompt

exit

