REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show buffer cache statistics.
REM    Hit Ratio should be higher than .90 else increase db_block_buffers. 
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col lgcrd	for 99,999,999,999	head "Logical Reads  "
col phyrd 	for 999,999,999		head "Physical Reads"
col phywr	for 999,999,999		head "Physical Writes"
col hrt		for 99.9999		head "Buffer   |Hit Ratio"

SELECT a.value + b.value lgcrd, c.value phyrd, d.value phywr,
       1-(c.value / (b.value+a.value)) hrt,
       decode(sign(0.1-(c.value / (b.value+a.value))),-1,'Increase db_block_buffer',
              decode(sign(0.05-(c.value / (b.value+a.value))),1,'Decrease db_block_buffer','OK')) "Evaluation"
FROM v$sysstat a, v$sysstat b, v$sysstat c, v$sysstat d
WHERE a.name = 'db block gets'  
AND b.name = 'consistent gets' 
AND c.name = 'physical reads' 
AND d.name = 'physical writes'
;
prompt

exit
