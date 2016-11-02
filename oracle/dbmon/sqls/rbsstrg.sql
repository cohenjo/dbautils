SET ECHO off
REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show rollback segments storage
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off

col segment_name        for a8		head Segment
col tablespace_name	for a8 		head TS
col min_extents		for 999		head Min
col max_extents		for 999 	head Max
col extents             for 999 	head Ext
col bytes		for 99,999,999
col initial_extent      for 99,999,999  head Initial
col next_extent         for 99,999,999  head Next
col pct_increase	for 9999	head "% Inc"

SELECT segment_name, tablespace_name, min_extents, max_extents, extents, 
       bytes, initial_extent, next_extent, pct_increase
FROM dba_segments
WHERE segment_type = 'ROLLBACK'
;
prompt

exit

