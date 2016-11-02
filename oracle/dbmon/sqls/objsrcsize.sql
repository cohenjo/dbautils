REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show objects size 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col owner	for a&2		head Owner
col name	for a30		head Name
col type	for a10 trunc	
col tot		for 999,999,999	head "Total Bytes"

SELECT owner, name, type, source_size+code_size+parsed_size+error_size tot 
FROM dba_object_size
WHERE owner &1
ORDER BY tot asc 
;

prompt

exit

