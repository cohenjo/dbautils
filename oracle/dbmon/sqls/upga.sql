REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show user global area status
REM ------------------------------------------------------------------------

set linesize	96
set pages	100
set feedback    off

col username	for a25 head "User Name"
col name	for a20

SELECT nvl(username,'internal oracle procs') Username, 
       sum(round(value/1024)) "Memory Use KB", name
FROM v$session sess, v$sesstat stat, v$statname name
WHERE sess.sid = stat.sid 
AND stat.statistic# = name.statistic#
AND (name.name = 'session uga memory'
OR   name.name = 'session pga memory')
GROUP BY username,name
;

prompt

set head off

SELECT 'Sum UGA Use KB:', sum(round(value/1024)) 
FROM v$sesstat stat, v$statname name
WHERE stat.statistic# = name.statistic#
AND   name.name = 'session uga memory'
;
SELECT 'Sum PGA Use KB:', sum(round(value/1024)) 
FROM v$sesstat stat, v$statname name
WHERE stat.statistic# = name.statistic#
AND   name.name = 'session pga memory'
;

prompt

exit
