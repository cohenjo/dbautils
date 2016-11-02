SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************ http://top.antognini.ch **************************
REM ***************************************************************************
REM
REM File name...: join-filter_pruning.sql
REM Author......: Christian Antognini
REM Date........: March 2009
REM Description.: This script shows a query executed with and without 
REM               join-filter pruning.
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

COLUMN pad FORMAT A10 TRUNC

@@connect.sql

DROP TABLE t1 PURGE;

DROP TABLE t2 PURGE;

CREATE TABLE t1 PARTITION BY HASH (id) PARTITIONS 8 AS 
SELECT rownum id, mod(rownum,100) mod, rpad('*',500,'*') pad 
FROM dual
CONNECT BY level <= 100000;

CREATE TABLE t2 PARTITION BY HASH (id) PARTITIONS 4 AS 
SELECT rownum id, mod(rownum,100) mod, rpad('*',500,'*') pad 
FROM dual
CONNECT BY level <= 100000;

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

ALTER SESSION SET "_bloom_pruning_enabled" = FALSE;

EXPLAIN PLAN FOR
SELECT /*+ ordered use_hash(t2) */ *
FROM t1, t2 
WHERE t1.id = t2.id
AND t1.mod = 42;

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic partition'));

PAUSE

ALTER SESSION SET "_bloom_pruning_enabled" = TRUE;

EXPLAIN PLAN FOR
SELECT /*+ ordered use_hash(t2) */ *
FROM t1, t2 
WHERE t1.id = t2.id
AND t1.mod = 42;

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic partition'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t1 PURGE;

DROP TABLE t2 PURGE;
