REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show clients' count
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col machine	for a15	head "Remote|Machine"
col count	for 999	head Count

SELECT decode(machine,null,'PC',machine,machine) machine, 
       count(sess.username) count
FROM v$session sess, v$process proc
WHERE sess.paddr = proc.addr 
GROUP BY machine
;

prompt

exit

