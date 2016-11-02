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

col get		for 999,999,999	head "Gets        "
col miss	for 999,999,999	head "Cache Misses"
col hrt		for .9999	head "Data Dict.     |Cache Hit Ratio"

SELECT sum(gets) get, sum(getmisses) miss, 1-(sum(getmisses)/sum(gets)) hrt,
       decode(sign((sum(getmisses)/sum(gets))-0.1),1,'Increase shared_pool_size','OK') "Evaluation"
FROM v$rowcache
;
prompt

exit
