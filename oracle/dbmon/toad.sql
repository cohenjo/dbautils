set echo on

-- Create Toad User
CREATE USER TOAD
  IDENTIFIED BY VALUES '1020304050BA3F6EC3E3CE0C'
  DEFAULT TABLESPACE SYSAUX
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

  -- 5 Roles for TOAD 
  GRANT CONNECT TO TOAD;
  GRANT RESOURCE TO TOAD;
  ALTER USER TOAD DEFAULT ROLE ALL;

GRANT UNLIMITED TABLESPACE TO TOAD;
GRANT SELECT ON  SYS.DBA_OBJECTS TO TOAD;
GRANT SELECT ON  SYS.DBA_SOURCE TO TOAD;
GRANT SELECT ON  SYS.DBA_TRIGGERS TO TOAD;

--------------------------------
-- Create Quest SQLab Role
--------------------------------
CREATE ROLE QUEST_SL_SQLAB_ROLE;
CREATE OR REPLACE PUBLIC SYNONYM QUEST_SL_EXPLAIN FOR TOAD.QUEST_SL_EXPLAIN;
CREATE or replace PUBLIC SYNONYM TOAD_PLAN_SQL FOR TOAD.TOAD_PLAN_SQL;
CREATE or replace PUBLIC SYNONYM TOAD_PLAN_TABLE FOR TOAD.TOAD_PLAN_TABLE;

GRANT SELECT ON SYS.V_$INSTANCE TO QUEST_SL_SQLAB_ROLE;
GRANT SELECT ON SYS.V_$MYSTAT TO QUEST_SL_SQLAB_ROLE;
GRANT SELECT ON SYS.V_$PARAMETER TO QUEST_SL_SQLAB_ROLE;
GRANT SELECT ON SYS.V_$PROCESS TO QUEST_SL_SQLAB_ROLE;
GRANT SELECT ON SYS.V_$SESSION TO QUEST_SL_SQLAB_ROLE;
GRANT SELECT ON SYS.V_$STATNAME TO QUEST_SL_SQLAB_ROLE;

-----------------------------
-- Create Toad Tables
-----------------------------
@$AUTO_CONN toad

CREATE TABLE toad_plan_sql (
	username     VARCHAR2(30),
	statement_id VARCHAR2(32),
	timestamp    DATE,
	statement   VARCHAR2(2000) );

CREATE UNIQUE INDEX tpsql_idx ON toad_plan_sql ( STATEMENT_ID );

CREATE TABLE toad_plan_table (
	statement_id    VARCHAR2(32),
	timestamp       DATE,
	remarks         VARCHAR2(80),
	operation       VARCHAR2(30),
	options         VARCHAR2(30),
	object_node     VARCHAR2(128),
	object_owner    VARCHAR2(30),
	object_name     VARCHAR2(30),
	object_instance NUMBER,
	object_type     VARCHAR2(30),
	search_columns  NUMBER,
	id              NUMBER,
	cost            NUMBER,
	parent_id       NUMBER,
	position        NUMBER,
	cardinality     NUMBER,
	optimizer       VARCHAR2(255),
	bytes           NUMBER,
	other_tag       VARCHAR2(255),
	partition_id    NUMBER,
	partition_start VARCHAR2(255),
	partition_stop  VARCHAR2(255),
	distribution    VARCHAR2(30),
	other           LONG);

CREATE INDEX tptbl_idx ON toad_plan_table ( STATEMENT_ID );

CREATE TABLE quest_sl_explain (
   statement_id                   VARCHAR2(60),
    timestamp                      DATE,
    remarks                        VARCHAR2(2000),
    operation                      VARCHAR2(30),
    options                        VARCHAR2(30),
    object_node                    VARCHAR2(128),
    object_owner                   VARCHAR2(30),
    object_name                    VARCHAR2(30),
    object_instance                NUMBER(*,0),
    object_type                    VARCHAR2(30),
    search_columns                 NUMBER(*,0),
    id                             NUMBER(*,0),
    parent_id                      NUMBER(*,0),
    position                       NUMBER(*,0),
    other                          LONG,
    collector                      VARCHAR2(31),
    address                        VARCHAR2(16),
    hash_value                     NUMBER,
    optimizer                      VARCHAR2(255),
    cost                           NUMBER(*,0),
    cardinality                    NUMBER(*,0),
    bytes                          NUMBER(*,0),
    other_tag                      VARCHAR2(255),
    join_text                      VARCHAR2(1000),
    filter_text                    VARCHAR2(1000),
    view_text                      VARCHAR2(1000),
    partition_start                VARCHAR2(255),
    partition_stop                 VARCHAR2(255),
    partition_id                   NUMBER(*,0),
    distribution                   VARCHAR2(30),
    cpu_cost                       NUMBER(*,0),
    io_cost                        NUMBER(*,0),
    temp_space                     NUMBER(*,0),
    access_predicates              VARCHAR2(2000),
    filter_predicates              VARCHAR2(2000));

    
CREATE INDEX quest_sl_explain_n1 ON quest_sl_explain (collector  ASC,id   ASC  );
CREATE UNIQUE INDEX quest_sl_explain_u1 ON quest_sl_explain  (statement_id   ASC, parent_id ASC, id ASC);

--------------------
-- Grants
--------------------
grant select, insert, update, delete on quest_sl_explain to public;
grant select, insert, update, delete on quest_sl_explain to public;

GRANT SELECT, INSERT, UPDATE, DELETE ON TOAD_PLAN_SQL TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON TOAD_PLAN_TABLE TO PUBLIC;

CREATE TABLE TOAD.TOAD_RESTRICTIONS
(
  USER_NAME  VARCHAR2(32 BYTE)                  NOT NULL,
  FEATURE    VARCHAR2(20 BYTE)                  NOT NULL
)
TABLESPACE SYSAUX;

CREATE UNIQUE INDEX TOAD.TOAD_RES_PK ON TOAD.TOAD_RESTRICTIONS (FEATURE, USER_NAME)
TABLESPACE SYSAUX;

ALTER TABLE TOAD.TOAD_RESTRICTIONS ADD CONSTRAINT TOAD_RES_PK PRIMARY KEY (FEATURE, USER_NAME) USING INDEX ;
GRANT SELECT ON TOAD.TOAD_RESTRICTIONS TO PUBLIC;
GRANT ALTER, DELETE, INDEX, INSERT, REFERENCES, SELECT, UPDATE ON TOAD.TOAD_RESTRICTIONS TO SYSTEM WITH GRANT OPTION;
conn /

CREATE PUBLIC SYNONYM TOAD_RESTRICTIONS FOR TOAD.TOAD_RESTRICTIONS;
create role no_toad_role;

grant no_toad_role to AAM_USER                ;
grant no_toad_role to AAM_WORK                ;
grant no_toad_role to ACMS_USER               ;
grant no_toad_role to ACMS_WORK               ;
grant no_toad_role to AFL_USER                ;
grant no_toad_role to AFL_WORK                ;
grant no_toad_role to ANONYMOUS               ;
grant no_toad_role to AUTHWORK                ;
grant no_toad_role to BC_ALFRESCO_WORK        ;
grant no_toad_role to CNV_DOWNLOAD_BATCH      ;
grant no_toad_role to CTXSYS                  ;
grant no_toad_role to DBA_OPER                ;
grant no_toad_role to DBSNMP                  ;
grant no_toad_role to DIP                     ;
grant no_toad_role to DLV_USER                ;
grant no_toad_role to DLV_WORK                ;
grant no_toad_role to EAI_USER                ;
grant no_toad_role to EAI_WORK                ;
grant no_toad_role to OP_USER                 ;
grant no_toad_role to OP_WORK                 ;
grant no_toad_role to OUTLN                   ;
grant no_toad_role to PARAM_WORK              ;
grant no_toad_role to PC_USER                 ;
grant no_toad_role to PC_WORK                 ;
grant no_toad_role to PD_USER                 ;
grant no_toad_role to PD_WORK                 ;
grant no_toad_role to PERFSTAT                ;
grant no_toad_role to REFREAD                 ;
grant no_toad_role to REFRESH_MNGR            ;
grant no_toad_role to REFWORK                 ;
grant no_toad_role to REF_APPL                ;
grant no_toad_role to REF_UPDATE              ;
grant no_toad_role to SO_USER                 ;
grant no_toad_role to SO_WORK                 ;
grant no_toad_role to TOAD                    ;
grant no_toad_role to UAMS_WORK               ;
grant no_toad_role to XDB                     ;


