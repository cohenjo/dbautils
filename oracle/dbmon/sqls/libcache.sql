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

col "Hit Ratio"		for 99.9999
col "Pin Hit Ratio"	for 99.9999

SELECT namespace, gethitratio "Hit Ratio", pinhitratio "Pin Hit Ratio", 
       reloads "Reloads"
FROM v$librarycache
;
prompt

exit
