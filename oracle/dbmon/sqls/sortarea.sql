REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show Statistics on sort area
REM    If Disk > Rows, then increase sort_area_size.
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col mem_s	for 999,999,999	head "Memory Sorts"
col disk_s	for 999,999,999	head "Disk Sorts"
col row_s	for 999,999,999	head "Rows Sorts"

SELECT a.value mem_s, b.value disk_s, c.value row_s,
       decode(sign(b.value-a.value),1,'Increase sort_area_size','OK') "Evaluation"
FROM v$sysstat a, v$sysstat b, v$sysstat c
WHERE a.name = 'sorts (memory)'
AND b.name = 'sorts (disk)'
AND c.name = 'sorts (rows)'
;
prompt

exit
