REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show segments' extents for a given name  / owner / type
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col owner		for a&3		head Owner
col segment_name	for a30		head "Segment Name"
col tablespace_name     for a10         head "TS Name"
col segment_type	for a9 trunc	head Type
col extents             for 999         head Ext
col KB			for 99,999	

break on owner on segment_name on tablespace_name on file_id

SELECT owner, segment_name, tablespace_name, file_id, bytes/1024 KB
FROM dba_extents
WHERE segment_name like upper('&1')
  AND owner &2
ORDER BY extent_id
;

prompt

exit
