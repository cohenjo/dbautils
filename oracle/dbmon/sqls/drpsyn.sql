REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
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

SELECT 'drop synonym &1..' || synonym_name || ';' 
FROM dba_synonyms
WHERE owner = &1
;
spool off
;
prompt

exit
