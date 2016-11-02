SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************ http://top.antognini.ch **************************
REM ***************************************************************************
REM
REM File name...: subquery_pruning.sql
REM Author......: Christian Antognini
REM Date........: March 2009
REM Description.: This script shows different examples of partition pruning.
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

SET ECHO ON
SET TERMOUT ON
SET SERVEROUTPUT OFF
SET FEEDBACK OFF
SET LONG 1000
SET PAGESIZE 100
SET LINESIZE 80

COLUMN id FORMAT 99
COLUMN other FORMAT A70

@@connect.sql

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t (
  id NUMBER,
  d DATE,
  pad VARCHAR2(4000),
  CONSTRAINT t_pk PRIMARY KEY (id)
)
PARTITION BY RANGE (d) (
  PARTITION t_jan_2007 VALUES LESS THAN (to_date('2007-02-01','yyyy-mm-dd')),
  PARTITION t_feb_2007 VALUES LESS THAN (to_date('2007-03-01','yyyy-mm-dd')),
  PARTITION t_mar_2007 VALUES LESS THAN (to_date('2007-04-01','yyyy-mm-dd')),
  PARTITION t_apr_2007 VALUES LESS THAN (to_date('2007-05-01','yyyy-mm-dd')),
  PARTITION t_may_2007 VALUES LESS THAN (to_date('2007-06-01','yyyy-mm-dd')),
  PARTITION t_jun_2007 VALUES LESS THAN (to_date('2007-07-01','yyyy-mm-dd')),
  PARTITION t_jul_2007 VALUES LESS THAN (to_date('2007-08-01','yyyy-mm-dd')),
  PARTITION t_aug_2007 VALUES LESS THAN (to_date('2007-09-01','yyyy-mm-dd')),
  PARTITION t_sep_2007 VALUES LESS THAN (to_date('2007-10-01','yyyy-mm-dd')),
  PARTITION t_oct_2007 VALUES LESS THAN (to_date('2007-11-01','yyyy-mm-dd')),
  PARTITION t_nov_2007 VALUES LESS THAN (to_date('2007-12-01','yyyy-mm-dd')),
  PARTITION t_dec_2007 VALUES LESS THAN (to_date('2008-01-01','yyyy-mm-dd'))
);

INSERT INTO t
SELECT rownum AS id,
       trunc(to_date('2007-01-01','yyyy-mm-dd')+rownum/27.4) AS d,
       rpad('*',50,'*') AS pad
FROM dual
CONNECT BY level <= 10000
ORDER BY dbms_random.value;

execute dbms_stats.gather_table_stats(user, 't')

PAUSE

REM
REM With a nested loop join "regular" pruning is performed
REM

EXPLAIN PLAN FOR
SELECT /*+ ordered use_nl(t2) */ * 
FROM t t1, t t2 
WHERE t1.d = t2.d AND t1.id = 19;

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic partition'));

PAUSE

REM
REM With a hash join no pruning is performed
REM

ALTER SESSION SET "_bloom_pruning_enabled" = FALSE;
ALTER SESSION SET "_subquery_pruning_enabled" = FALSE;

EXPLAIN PLAN FOR
SELECT /*+ ordered use_hash(t2) */ * 
FROM t t1, t t2 
WHERE t1.d = t2.d AND t1.id = 19;

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic partition'));

PAUSE

REM
REM Up to in 10gR2, to improve the performance, hash joins can use
REM subquery pruning
REM

ALTER SESSION SET "_bloom_pruning_enabled" = FALSE;
ALTER SESSION SET "_subquery_pruning_enabled" = TRUE;
ALTER SESSION SET "_subquery_pruning_cost_factor"=1;
ALTER SESSION SET "_subquery_pruning_reduction"=100;

EXPLAIN PLAN FOR
SELECT /*+ ordered use_hash(t2) */ * 
FROM t t1, t t2 
WHERE t1.d = t2.d AND t1.id = 19;

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic partition'));

PAUSE

SELECT id, other 
FROM plan_table 
WHERE other IS NOT NULL 
AND plan_id = (SELECT max(plan_id) FROM plan_table);

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
