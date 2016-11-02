SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM Script......: connect.sql
REM Author......: Christian Antognini
REM Date........: March 2009
REM Description.: This script is called by all other scripts to open a
REM               connection.
REM Notes.......: The user connecting the database must be a DBA.
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************
SET ECHO ON

CONNECT &user/&password@&service
REM CONNECT /

REM
REM Display working environment
REM

SELECT user, instance_name, host_name
FROM v$instance;

SELECT *
FROM v$version
WHERE rownum = 1;
