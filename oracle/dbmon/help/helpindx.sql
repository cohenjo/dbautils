rem
rem
rem  Copyright (c) Oracle Corporation 1988, 1996.  All Rights Reserved.
rem
rem    NAME
rem      helpindx.sql
rem    DESCRIPTION
rem      Builds SQL*Plus Help TOPICS entry and creates index on HELP table
rem    NOTES
rem      Connect as SYSTEM to run this script
rem      Run this script after data has been loaded
rem      into the HELP table.
rem    MODIFIED
rem      sjhala    01/07/97 - use PRIMARY KEY constraint instead of UNIQUE
rem                           INDEX creation
rem      cjones    01/14/93 - moved grant to helptbl.sql, make index unique
rem      Jacobs    04/30/83 - Build TOPICS Help
rem      Fisher    10/23/86 - One Unique Concatinated Index.
rem      Osterberg 04/11/89 - Update for V6
rem      Oates     02/16/83 - Created
rem

set termout off

ALTER TABLE HELP DROP CONSTRAINT HELP_TOPIC_SEQ;
DROP VIEW HELP_TEMP_VIEW;
DELETE FROM HELP WHERE TOPIC = 'TOPICS';

spool helpindx.lis

rem
rem Create the index
rem

ALTER TABLE HELP
  ADD CONSTRAINT HELP_TOPIC_SEQ
  PRIMARY KEY ( TOPIC , SEQ )
  USING INDEX STORAGE ( INITIAL 900K );

rem
rem Create the HELP TOPICS entry
rem

INSERT INTO HELP
  VALUES ('TOPICS', -2, NULL);
INSERT INTO HELP 
  VALUES ('TOPICS', -1, 'Help is available on the following topics: ');
INSERT INTO HELP
  VALUES ('TOPICS', 0, NULL);

CREATE VIEW HELP_TEMP_VIEW (TOPIC) AS
  SELECT DISTINCT UPPER(TOPIC)
  FROM HELP;

INSERT INTO HELP 
  SELECT 'TOPICS', ROWNUM, TOPIC
  FROM HELP_TEMP_VIEW;

DROP VIEW HELP_TEMP_VIEW;

exit
