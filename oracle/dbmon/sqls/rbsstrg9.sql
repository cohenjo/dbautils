clear buffer

set feed off
set verify off
set linesize 90
set pagesize 90

column bytes 		format 999,999,999
column segment_name 	format a11 		heading "Segment"
column extents 		format 999 truncate 	heading "Ext"
column initial_extent 	format 99,999,999 	heading "Initial"
column next_extent 	format 99,999,999 	heading "Next"
column min_extents   	format 999 		heading "Min"
column max_extents   	format 99,999 		heading "Max"
column segment_type 	format a8

select  a.segment_name, min_extents, max_extents,a.extents, bytes, initial_extent, next_extent 
   from dba_segments a 
 where segment_type in ('ROLLBACK','TYPE2 UNDO'); 

exit
/
