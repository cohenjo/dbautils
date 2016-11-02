REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show fat sql 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col osuser      for a10 trunc		head "OS User"
col process     for a9 trunc            head "Remote|Process"
col sid         for 999 trunc
col username    for a15                 head "User Name"
col spid        for a6 trunc            head "Local|Shadow|Process"
col sql_text    for a60			head "Sql Text"

set head 	off

SELECT to_char(sysdate, 'mon-dd-yyyy hh24:mi') FROM dual;
SELECT 'Start Time: &2  CPU Time: &3' FROM dual;
SELECT 'Parent Exec: &4' FROM dual;

set head	on

SELECT s.osuser , s.PROCESS , s.SID , s.USERNAME , p.spid
FROM  v$process p , v$session s
WHERE p.addr = s.paddr
AND   p.SPID = &1
;

SELECT b.sql_text 
FROM v$session a , v$sqlarea b  , v$process p
WHERE   a.sql_address = b.address
AND     a.sql_hash_value = b.hash_value
AND     p.addr = a.paddr
AND     p.SPID = &1
;

prompt

exit

