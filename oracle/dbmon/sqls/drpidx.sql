REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tabbles
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    drop all user's indexes 
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

SELECT 'drop index &1..' || index_name || ';' 
FROM dba_indexes
WHERE owner = &1
;
spool off
;
prompt

exit
