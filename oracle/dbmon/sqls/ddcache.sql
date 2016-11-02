REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show data dictionary statistics.
REM    Hit Ratio Should be higher than .90 else increase shared_pool_size.
REM ------------------------------------------------------------------------

set linesize     96
set pages       100
set feedback    off

col gets	for 999,999,990 head "Gets"
col getmisses	for 999,999,990 head "Misses"
col parameter 	for a22
col "Miss Ratio" for .9999

SELECT unique parameter, gets "Gets", getmisses "Misses", 
       getmisses/(gets+getmisses) "Miss Ratio"
FROM v$rowcache
WHERE gets+getmisses <> 0
;

prompt

exit
