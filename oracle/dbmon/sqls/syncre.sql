REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Create synonyms
REM ------------------------------------------------------------------------

set linesize	120
set pages       0
set head 	off
set verify	off
set wrap	off
set termout	off
set echo	off
set feedback	off

spool &2 
prompt spool &2.log

SELECT 'create '||decode(owner,'PUBLIC','PUBLIC ','')|| 'synonym '
       ||decode(owner,'PUBLIC','',owner)
       ||decode(owner,'PUBLIC','','.')||synonym_name||' for '
       ||decode(nvl(table_owner,0),'0','',table_owner||'.')
       ||table_name||decode(nvl(db_link,0),'0',';','@'||db_link||';')
FROM dba_synonyms 
WHERE owner &1
;
prompt spool off
prompt exit

spool off

REM set heading	on
REM set feedback	on
REM @&1
;
prompt

exit
