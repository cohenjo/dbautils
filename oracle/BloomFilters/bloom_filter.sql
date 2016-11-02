SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************ http://top.antognini.ch **************************
REM ***************************************************************************
REM
REM File name...: bloom_filter.sql
REM Author......: Christian Antognini
REM Date........: March 2009
REM Description.: This script shows a very simple (in other words, neither space
REM               nor time efficient) bloom filter implementation in PL/SQL.
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

@@connect.sql

REM
REM Create package specification
REM

CREATE OR REPLACE PACKAGE bloom_filter IS
  PROCEDURE init (p_m IN BINARY_INTEGER, p_n IN BINARY_INTEGER);
  FUNCTION add_value (p_value IN VARCHAR2) RETURN BINARY_INTEGER;
  FUNCTION contain (p_value IN VARCHAR2) RETURN BINARY_INTEGER;
END bloom_filter;
/

PAUSE

REM
REM Create package body
REM

CREATE OR REPLACE PACKAGE BODY bloom_filter IS
  TYPE t_bitarray IS TABLE OF BOOLEAN;
  g_bitarray t_bitarray;
  g_m BINARY_INTEGER;
  g_k BINARY_INTEGER;

  PROCEDURE init (p_m IN BINARY_INTEGER, p_n IN BINARY_INTEGER) IS
  BEGIN
    g_m := p_m;
    g_bitarray := t_bitarray();
    g_bitarray.extend(p_m);
    FOR i IN g_bitarray.FIRST..g_bitarray.LAST
    LOOP
      g_bitarray(i) := FALSE;
    END LOOP;
    g_k := ceil(p_m / p_n * ln(2));
  END init;
  
  FUNCTION add_value (p_value IN VARCHAR2) RETURN BINARY_INTEGER IS
  BEGIN
    dbms_random.seed(p_value);
    FOR i IN 0..g_k
    LOOP
      g_bitarray(dbms_random.value(1, g_m)) := TRUE;
    END LOOP;
    RETURN 1;
  END add_value;
  
  FUNCTION contain (p_value IN VARCHAR2) RETURN BINARY_INTEGER IS
    l_ret BINARY_INTEGER := 1;
  BEGIN
    dbms_random.seed(p_value);
    FOR i IN 0..g_k
    LOOP
      IF NOT g_bitarray(dbms_random.value(1, g_m))
      THEN
        l_ret := 0;
        EXIT;
      END IF;
    END LOOP;
    RETURN l_ret;
  END contain;
END bloom_filter;
/

PAUSE

REM
REM To test the package, a table containing 10000 rows is created
REM

DROP TABLE t PURGE;

CREATE TABLE t AS
SELECT dbms_random.string('u',100) AS value
FROM dual
CONNECT BY level <= 10000;

PAUSE

SELECT *
FROM t
WHERE rownum <= 10;

PAUSE

REM
REM Initialize bloom filter (m=16384)
REM

execute bloom_filter.init(16384, 1000)

PAUSE

REM
REM Add 1000 elements to the bloom filter
REM

SELECT count(bloom_filter.add_value(value))
FROM t
WHERE rownum <= 1000;

PAUSE

REM
REM How many false positives there are?
REM

SELECT count(*)
FROM t
WHERE bloom_filter.contain(value) = 1;

PAUSE

REM
REM Check the number of false positives for different values of m
REM

SET SERVEROUTPUT ON

DECLARE
  l_count BINARY_INTEGER;
BEGIN
  FOR i IN 10..20
  LOOP
    bloom_filter.init(power(2,i),1000);
    
    SELECT count(bloom_filter.add_value(value))
    INTO l_count
    FROM t
    WHERE rownum <= 1000;
    
    SELECT count(*)
    INTO l_count
    FROM t
    WHERE bloom_filter.contain(value) = 1;
    
    dbms_output.put_line(power(2,i) || ' ' || l_count);
  END LOOP;
END;
/

PAUSE

REM
REM Cleanup
REM

DROP PACKAGE bloom_filter;
DROP TABLE t PURGE;
