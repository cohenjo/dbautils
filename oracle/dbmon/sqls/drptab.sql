REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ table 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    drop all user's tables 
REM ------------------------------------------------------------------------

set linesize	80
set pages       0
set head 	off
set verify	off
set wrap	off
set termout	off
set echo	off
set feedback	off

spool &2 

SELECT 'drop table &1..' || table_name || ' cascade constraints;' 
FROM dba_tables
WHERE owner = '&1'
;
spool off
;
prompt

exit
