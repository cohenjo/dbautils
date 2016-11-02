REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sql cursor and proc data, for a given pid 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col osuser      for a10 trunc	head "OS User"
col process	for a10		head "Os Proc" 
col sid         for 999 trunc
col username	for a16		head "User Name"
col spid        for a7 trunc	head "Local|Shadow|Process"

col sql_text 				head "SQL Text"
col executions		for 999,999	head Exec
col loads		for 999		head Loads
col parse_calls		for 999		head "Parse Calls"
col disk_reads      	for 9,999,999	head Disk
col buffer_gets     	for 9,999,999	head "Buff Gets"
col rows_processed	for 999,999	head Rows


SELECT s.osuser , s.process , s.sid , s.username , p.spid
FROM  v$process p , v$session s
WHERE p.addr = s.paddr
  AND p.SPID = &&1 
;

SELECT b.executions, b.loads, b.parse_calls, b.disk_reads, b.buffer_gets, b.rows_processed
FROM v$session a , v$sqlarea b  , v$process p
WHERE a.sql_address = b.address
  AND a.sql_hash_value = b.hash_value
  AND p.addr = a.paddr
  AND p.SPID = &&1
;

SELECT b.sql_text 
FROM v$session a , v$sqlarea b  , v$process p
WHERE a.sql_address = b.address
  AND a.sql_hash_value = b.hash_value
  AND p.addr = a.paddr
  AND p.SPID = &&1
;

prompt

exit

