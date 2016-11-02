REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show free segments for a given tablespace
REM ------------------------------------------------------------------------

set linesize    90
set pages       100
set feedback    off
set verify 	off

col tablespace_name     for a10         head "TS Name"
col file_name           for a50         head "Data File Name"
col MB			for 99,999
col KB                  for 99,999,999  head "Free KB" 
col Pct                 for 999.99      head "% Free"

set termout off
spool &2

break on tablespace_name on file_name on MB

SELECT f.tablespace_name, d.file_name, (d.bytes/1024/1024) MB,
       (f.bytes/d.bytes * 100) "Pct", f.bytes/1024 KB
FROM dba_free_space f, dba_data_files d, dba_tablespaces t
WHERE f.tablespace_name like upper('&1')
  AND f.tablespace_name = d.tablespace_name 
  AND f.file_id (+) = d.file_id
  AND f.tablespace_name = t.tablespace_name
  AND t.contents = 'PERMANENT'
ORDER BY tablespace_name, file_name
;

prompt
spool off 

exit
