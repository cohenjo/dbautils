SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************ http://top.antognini.ch **************************
REM ***************************************************************************
REM
REM File name...: px_join_bloom.sql
REM Author......: Christian Antognini
REM Date........: March 2009
REM Description.: This script shows a parallel join that uses a bloom filter.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN OFF
SET ECHO ON

COLUMN pad FORMAT A10 TRUNC

@@connect.sql

REM
REM Setup test environment
REM

DROP TABLE t1 PURGE;

DROP TABLE t2 PURGE;

CREATE TABLE t1 PARALLEL 4 AS 
SELECT rownum id, mod(rownum,100) mod, rpad('*',500,'*') pad 
FROM dual
CONNECT BY level <= 100000;

CREATE TABLE t2 PARALLEL 4 AS 
SELECT rownum id, mod(rownum,100) mod, rpad('*',500,'*') pad 
FROM dual
CONNECT BY level <= 1000;

BEGIN
  dbms_stats.gather_table_stats(ownname=>user,
                                tabname=>'T1',
                                estimate_percent=>100,
                                method_opt=>'FOR ALL COLUMNS SIZE 1');
  dbms_stats.gather_table_stats(ownname=>user,
                                tabname=>'T2',
                                estimate_percent=>100,
                                method_opt=>'FOR ALL COLUMNS SIZE 1');
END;
/

PAUSE

REM
REM Execution plan
REM

EXPLAIN PLAN FOR
SELECT /*+ ordered use_hash(t2) px_join_filter(t2) */ * 
FROM t1, t2 
WHERE t1.id = t2.id 
AND t1.mod = 42;

SELECT * FROM table(dbms_xplan.display(format=>'basic +parallel'));

PAUSE

REM
REM Runtime statistics
REM

SELECT /*+ ordered use_hash(t2) px_join_filter(t2) */ * 
FROM t1, t2 
WHERE t1.id = t2.id 
AND t1.mod = 42;

PAUSE

SELECT dfo_number, tq_id, server_type, num_rows, bytes, process 
FROM v$pq_tqstat 
WHERE dfo_number = 1 
ORDER BY dfo_number, tq_id, server_type DESC, process;

PAUSE

SELECT filtered, probed, probed-filtered AS sent
FROM v$sql_join_filter
WHERE qc_session_id = sys_context('userenv','sid');

REM
REM Cleanup
REM

DROP TABLE t1 PURGE;

DROP TABLE t2 PURGE;
