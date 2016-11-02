
REM   List table and column information for LOBs for a specific user
REM   
REM   UNDO handling with LOBs is not designed for frequent updates
REM   Frequent updates are best handled with PCTVERSION at 100
REM   This means you must have a lot of space available in the LOB
REM     tablespace as all UNDO will be maintained over time.
REM  
REM   Using RETENTION does not work as expected
REM   It is set to UNDO_RETENTION at the time of the creation of the
REM   object.   It does not change over time as UNDO_RETENTION
REM   or auto-tuned undo retention changes.

set pages 999
set lines 110

spool lobdata.out

col column_name format a25 head "Column"
col table_name format a25 head "Table"
col tablespace_name format a25 head "Tablespace"
col pctversion format 999 head "PCTVersion %"
col segment_space_management format a30 head "Space|Mngmnt"
col retention format 999,999,999 head "Retention"

select l.table_name, l.column_name, l.tablespace_name, l.pctversion, l.retention, 
  t.segment_space_management
from dba_lobs l, dba_tablespaces t
where owner=upper('&USER')
and l.tablespace_name = t.tablespace_name
/

spool off



