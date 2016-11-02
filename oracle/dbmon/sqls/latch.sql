REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show latch contention
REM    The PCT should be less than 1%.
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col name	for a29		 trunc head Name
col rt		for 99.999	 trunc head Ratio
col rt1 	for 99.999	 trunc head Ratio
col gets 	for 999,999,999	 trunc head Gets
col misses 	for 999999	 trunc head Miss
col Imm_Gets 	for 99999999	 trunc head "Imm Gets"
col Imm_Miss    for 999999	 trunc head "Imm Miss"

SELECT ln.name, gets, misses, 
       decode(gets,0,0,(misses/(gets+misses)) * 100) rt,
       immediate_gets Imm_Gets, immediate_misses Imm_Miss,
       decode(immediate_misses+immediate_gets,0,0,
                  immediate_misses/(immediate_misses+immediate_gets)*100) rt1
FROM v$latch l, v$latchname ln
WHERE l.latch# = ln.latch#
  AND (misses > 0 OR immediate_misses > 0)
ORDER BY l.name
;

prompt

exit
