REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show shared cursors statistics, order by buffer gets.
REM    Allow you to see the full sql at a spesific addres, and the user who 
REM    run it. 
REM ------------------------------------------------------------------------

set linesize	96
set pages	100
set feedback    off
set verify 	off

col text            for	a20	   head Text
col loads           for 9,999      head Loads
col executions      for 999,999    head Exec
col disk_reads      for 9,999,999  head Disk
col buffer_gets     for 9,999,999  head "Buff Gets"
col rows_processed  for	999,999    head Rows
col address 	    for	99999999   head Address

SELECT substr(SQL_TEXT,1,20) text, loads, executions, disk_reads, 
       buffer_gets ,rows_processed, address
FROM v$sqlarea
WHERE buffer_gets > 1000
ORDER by buffer_gets 
;
prompt 

SELECT sql_text  
FROM v$sqlarea
WHERE address = '&&addr' 
;
SELECT distinct o.user_name
FROM v$open_cursor o, v$sqlarea s
WHERE s.address = '&&addr'  
AND   s.address=o.address
;
prompt

exit
