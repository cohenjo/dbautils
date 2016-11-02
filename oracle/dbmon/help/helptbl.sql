rem
rem
rem  Copyright (c) Oracle Corporation 1988, 1996.  All Rights Reserved.
rem
rem    NAME
rem      helptbl.sql
rem    DESCRIPTION
rem      Builds SQL*Plus HELP table for ORACLE7 databases
rem    NOTES
rem      Connect as SYSTEM to run this script
rem    MODIFIED
rem      cjones    01/14/93 - add grant from helpindx.sql
rem      Clarke    Topic column width increased from 30 to 50 for ORACLE7
rem      Osterberg 04/11/89 - no more SYSTEM/MANAGER line
rem      Bradbury  04/04/86 - Spool after dropping table
rem      Oates     02/16/83 - Created
rem

set termout off

DROP TABLE HELP;

spool helptbl.lis

CREATE TABLE HELP
(
  TOPIC VARCHAR2 (50) NOT NULL,
  SEQ   NUMBER        NOT NULL,
  INFO  VARCHAR2 (80)
) PCTFREE 0 STORAGE (INITIAL 1600K);

GRANT SELECT ON HELP TO PUBLIC;

exit
