REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show segments' segments for a given tablespace
REM ------------------------------------------------------------------------

set linesize    80
set pages       100
set feedback    off
set verify 	off

col owner		for a15		head Owner
col segment_name	for a30		head "Segment Name"
col tablespace_name     for a10         head "TS Name"
col segment_type	for a9 trunc	head Type
col extents             for 999         head Ext
col KB			for 99,999  	head KB

set termout off
spool &2

break on tablespace_name

SELECT owner, segment_name, tablespace_name, segment_type, 
       extents, bytes/1024 KB
FROM dba_segments
WHERE tablespace_name like upper('&1')
ORDER BY tablespace_name, bytes
;

prompt
spool off 

exit
