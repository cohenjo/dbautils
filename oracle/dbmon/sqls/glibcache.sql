REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show Library Cache statistics.
REM    Library Cache Miss Ratio should be less than .01 (More than 1% of the
REM    pins resulted in reloads), else increase the shared_pool_size.
REM    Namespace hit ration sould be in the high 90s.
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col exec	for 999,999,999	head "Executions  |(Pins)      "
col reload 	for 999,999,999	head "Cache Misses while|Executing(Reloads)"
col miss	for 99.9999 head "Library Cache|Miss Ratio   "

SELECT sum(pins) exec, sum(reloads) reload, sum(reloads)/sum(pins) miss, 
       decode(sign(0.01-sum(reloads)/sum(pins)),-1,'Increase shared_pool_size','OK') "Evaluation"
FROM v$librarycache
;

prompt

exit
