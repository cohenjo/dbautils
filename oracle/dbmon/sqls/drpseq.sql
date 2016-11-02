REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    drop all user's sequences 
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

SELECT 'drop sequence &1..' || sequence_name || ';' 
FROM dba_sequences
WHERE sequence_owner = &1
;
spool off
;
prompt

exit
