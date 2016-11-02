REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Give unlimited quota 
REM ------------------------------------------------------------------------

set linesize	80
set pages       0
set head 	off
set verify	off
set wrap	off
set termout	off
set echo	off
set feedback	off

spool &1 

SELECT 'alter user ' || us.username || ' quota unlimited on '
       ||tbs.Tablespace_name||';'
FROM dba_tablespaces tbs , dba_users us
WHERE tablespace_name not in ('SYSTEM','SYS','RBS','TEMP')
AND   us.username not in ('SYSTEM', 'SYS', 'DBSNMP')
;
spool off

set heading on
set feedback on
REM @&1
;
prompt

exit
