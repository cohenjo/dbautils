REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show objects' storage for a given owner (and name)
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col owner		for a&3		head Owner
col table_name		for a25		head "Table Name"
col index_name          for a25         head "Index Name"
col ix			for 99,999	head "Initial|(KB)"
col nx			for 99,999	head "Next|(KB)"
col max_extents		for 999         head Max
col pct_increase 	for 99		head "Pct|Inc."
col pct_free		for 99		head "Pct|free"
col pct_used            for 99		head "Pct|Used"
col pct_threshold	for 99		head "Pct|Thr."
col extents		for 999         head Ext
col bytes		for 99,999	head "Size|(KB)"
 
SELECT t.owner, table_name, t.initial_extent/1024 ix, t.next_extent/1024 nx, 
       s.extents, t.max_extents, 
       s.bytes/1024 bytes, t.pct_increase, pct_free, pct_used
FROM dba_tables t , dba_segments s
WHERE t.owner &2 
  AND table_name like upper('&1')
  AND t.owner=s.owner
  AND t.table_name=s.segment_name
;
SELECT index_name, i.initial_extent/1024 ix, i.next_extent/1024 nx, 
       s.extents, i.max_extents, 
       s.bytes/1024 bytes, i.pct_increase, pct_free, pct_threshold
FROM dba_indexes i, dba_segments s
WHERE i.owner &2 
  AND index_name like upper('&1')
  AND i.owner=s.owner
  AND i.index_name=s.segment_name 
;

prompt

exit

