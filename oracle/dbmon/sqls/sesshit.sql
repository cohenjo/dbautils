REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sessions hit ratio
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col SID         for 999 trunc
col username    for a20 	head "User Name"
col "Hit Ratio" for 99.99 

prompt
prompt Users with a hit ratio < 80%

SELECT se.username "User" , se.sid "SID",
       sum(decode(name, 'consistent gets',value, 0))  "Consis Gets",
        sum(decode(name, 'db block gets',value, 0))  "Block Gets",
        sum(decode(name, 'physical reads',value, 0))  "Phys Reads",
       (sum(decode(name, 'consistent gets',value, 0))  +
        sum(decode(name, 'db block gets',value, 0))  -
        sum(decode(name, 'physical reads',value, 0))) /
       (sum(decode(name, 'consistent gets',value, 0))  +
        sum(decode(name, 'db block gets',value, 0))  ) "Hit Ratio"
FROM v$sesstat ss, v$statname sn, v$session se
WHERE ss.sid    = se.sid
  AND sn.statistic# = ss.statistic#
  AND value != 0
  AND sn.name in ('db block gets', 'consistent gets', 'physical reads')
  AND se.username is not null
GROUP BY se.username, se.sid
HAVING (sum(decode(name, 'consistent gets',value, 0))  +
        sum(decode(name, 'db block gets',value, 0))  -
        sum(decode(name, 'physical reads',value, 0))) /
       (sum(decode(name, 'consistent gets',value, 0))  +
        sum(decode(name, 'db block gets',value, 0))  ) < 0.8
;

prompt

exit

