REM ------------------------------------------------------------------------
REM PURPOSE:
REM    rebuild all user's indexes
REM ------------------------------------------------------------------------
set pages 0 
set linesize 130
set feedback off
set verify off

spool &2 
prompt
prompt set echo on
prompt

select 'REM REBUILDING ' ||a.owner ||'.'||a.index_name|| ' INDEX...  '|| chr(10) || 
       'alter index '||a.owner||'.'||a.index_name||' rebuild'||chr(10)||
       'tablespace &3 '||chr(10)||
       'unrecoverable;' || chr(10)
from dba_indexes a
where a.tablespace_name='&4' 
and OWNER &1
/

prompt
prompt spool off
prompt
prompt exit

spool off

exit
