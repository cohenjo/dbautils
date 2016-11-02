REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show segments' segments for a given name  / owner / type
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col owner		for a&4		head Owner
col segment_name	for a25		head "Segment Name"
col tablespace_name     for a10         head "TS Name"
col segment_type	for a9 trunc	head Type
col extents             for 9999        head Ext
col blocks		for 999,999	head Blocks
col KB			for 9,999,999	
col freelists		for 999		head "Free ls"

SELECT owner, segment_name, tablespace_name, segment_type, 
       extents, blocks, bytes/1024 KB, freelists
FROM dba_segments
WHERE segment_name like upper('&1')
  AND owner &2
  AND segment_type like upper('&3')
  AND tablespace_name like upper('&5')
ORDER BY owner, segment_name, bytes
;

prompt

exit
