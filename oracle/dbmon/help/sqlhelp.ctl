--
-- Copyright (c) 1997 by Oracle Corporation. All Rights Reserved.
--
load data
infile *
preserve blanks
into table help append
fields terminated by '^'
TRAILING NULLCOLS
(
    topic, seq, info
)
BEGINDATA
ALLOCATE (Embedded SQL)^1^ 
ALLOCATE (Embedded SQL)^2^ ALLOCATE (Embedded SQL)
ALLOCATE (Embedded SQL)^3^ -----------------------
ALLOCATE (Embedded SQL)^4^ 
ALLOCATE (Embedded SQL)^5^ Use this command to allocate a cursor variable to be referenced in
ALLOCATE (Embedded SQL)^6^ a PL/SQL block.
ALLOCATE (Embedded SQL)^7^ 
ALLOCATE (Embedded SQL)^8^ EXEC SQL ALLOCATE cursor_variable
ALLOCATE (Embedded SQL)^9^ 
ALLOCATE (Embedded SQL)^10^ For detailed information on this command, see the Oracle8 Server SQL
ALLOCATE (Embedded SQL)^11^ Reference.
ALLOCATE (Embedded SQL)^12^ 
ALTER CLUSTER^1^ 
ALTER CLUSTER^2^ ALTER CLUSTER
ALTER CLUSTER^3^ -------------
ALTER CLUSTER^4^ 
ALTER CLUSTER^5^ Use this command to redefine storage and parallelism characteristics
ALTER CLUSTER^6^ for a cluster.
ALTER CLUSTER^7^ 
ALTER CLUSTER^8^ ALTER CLUSTER [schema.]cluster
ALTER CLUSTER^9^   { PCTUSED integer
ALTER CLUSTER^10^   | PCTFREE integer
ALTER CLUSTER^11^   | SIZE integer [K | M]
ALTER CLUSTER^12^   | INITRANS integer
ALTER CLUSTER^13^   | MAXTRANS integer
ALTER CLUSTER^14^   | STORAGE storage_clause
ALTER CLUSTER^15^   | ALLOCATE EXTENT [({ SIZE integer [K | M]
ALTER CLUSTER^16^                       | DATAFILE 'filename'
ALTER CLUSTER^17^                       | INSTANCE integer} ...)]
ALTER CLUSTER^18^   | DEALLOCATE UNUSED [KEEP integer [K | M]]} ...
ALTER CLUSTER^19^   [PARALLEL parallel_clause | NOPARALLEL]
ALTER CLUSTER^20^ 
ALTER CLUSTER^21^ For detailed information on this command, see the Oracle8 Server SQL
ALTER CLUSTER^22^ Reference.
ALTER CLUSTER^23^ 
ALTER DATABASE^1^ 
ALTER DATABASE^2^ ALTER DATABASE
ALTER DATABASE^3^ --------------
ALTER DATABASE^4^ 
ALTER DATABASE^5^ Use this command to alter an existing database in one of these ways:
ALTER DATABASE^6^
ALTER DATABASE^7^   *  mount the database or standby database
ALTER DATABASE^8^   *  convert an Oracle7 data dictionary when migrating to Oracle8
ALTER DATABASE^9^   *  open the database
ALTER DATABASE^10^   *  choose archivelog or noarchivelog mode for redo log file groups
ALTER DATABASE^11^   *  perform media recovery
ALTER DATABASE^12^   *  add or drop a redo log file group or a member of a redo log
ALTER DATABASE^13^      file group
ALTER DATABASE^14^   *  clear and initialize an online redo log file
ALTER DATABASE^15^   *  rename a redo log file member or a datafile
ALTER DATABASE^16^   *  back up the current control file
ALTER DATABASE^17^   *  back up SQL commands (that can be used to re-create the
ALTER DATABASE^18^      database) to the database's trace file
ALTER DATABASE^19^   *  take a datafile online or offline
ALTER DATABASE^20^   *  enable or disable a thread of redo log file groups
ALTER DATABASE^21^   *  change the database's global name
ALTER DATABASE^22^   *  prepare to downgrade to an earlier release of Oracle
ALTER DATABASE^23^   *  change the MAC mode
ALTER DATABASE^24^   *  equate the predefined label DBHIGH or DBLOW with an operating
ALTER DATABASE^25^      system label
ALTER DATABASE^26^   *  resize one or more datafiles
ALTER DATABASE^27^   *  create a new datafile in place of an old one for recovery
ALTER DATABASE^28^      purposes
ALTER DATABASE^29^   *  enable or disable the autoextending of the size of datafiles
ALTER DATABASE^30^ 
ALTER DATABASE^31^ ALTER DATABASE [database]
ALTER DATABASE^32^   { MOUNT [STANDBY DATABASE] [EXCLUSIVE | PARALLEL]
ALTER DATABASE^33^   | CONVERT
ALTER DATABASE^34^   | OPEN [RESETLOGS | NORESETLOGS]
ALTER DATABASE^35^   | ACTIVATE STANDBY DATABASE
ALTER DATABASE^36^   | ARCHIVELOG
ALTER DATABASE^37^   | NOARCHIVELOG
ALTER DATABASE^38^   | RECOVER recover_clause
ALTER DATABASE^39^   | ADD LOGFILE [THREAD integer] [GROUP integer] filespec
ALTER DATABASE^40^       [, [GROUP integer] filespec] ...
ALTER DATABASE^41^   | ADD LOGFILE MEMBER 'filename' [REUSE]
ALTER DATABASE^42^       [, 'filename' [REUSE] ] ...
ALTER DATABASE^43^     TO { GROUP integer
ALTER DATABASE^44^        | ('filename' [, 'filename'] ...)
ALTER DATABASE^45^        | 'filename'}
ALTER DATABASE^46^       [, 'filename' [REUSE] [, 'filename' [REUSE] ] ...
ALTER DATABASE^47^     TO { GROUP integer
ALTER DATABASE^48^        | ('filename' [, 'filename'] ...)
ALTER DATABASE^49^        | 'filename' } ] ...
ALTER DATABASE^50^   | DROP LOGFILE
ALTER DATABASE^51^     { GROUP integer
ALTER DATABASE^52^     | ('filename' [, 'filename'] ...)
ALTER DATABASE^53^     | 'filename'}
ALTER DATABASE^54^       [, { GROUP integer
ALTER DATABASE^55^          | ('filename' [,'filename'] ...)
ALTER DATABASE^56^          | 'filename' } ] ...
ALTER DATABASE^57^   | DROP LOGFILE MEMBER 'filename' [, 'filename'] ...
ALTER DATABASE^58^   | CLEAR [UNARCHIVED] LOGFILE
ALTER DATABASE^59^     { GROUP integer
ALTER DATABASE^60^     | ('filename' [, 'filename'] ...)
ALTER DATABASE^61^     | 'filename'}
ALTER DATABASE^62^       [, { GROUP integer
ALTER DATABASE^63^          | ('filename' [, 'filename'] ...)
ALTER DATABASE^64^          | 'filename'} ] ...
ALTER DATABASE^65^       [UNRECOVERABLE DATAFILE]
ALTER DATABASE^66^   | RENAME FILE 'filename' [, 'filename'] ...
ALTER DATABASE^67^     TO 'filename' [, 'filename'] ...
ALTER DATABASE^68^   | CREATE STANDBY CONTROLFILE AS 'filename' [REUSE]
ALTER DATABASE^69^   | BACKUP CONTROLFILE { TO 'filename' [REUSE]
ALTER DATABASE^70^                        | TO TRACE [RESETLOGS | NORESETLOGS] }
ALTER DATABASE^71^   | RENAME GLOBAL_NAME TO database [.domain] ...
ALTER DATABASE^72^   | RESET COMPATIBILITY
ALTER DATABASE^73^   | SET { DBLOW = 'TEXT'
ALTER DATABASE^74^         | DBHIGH = 'TEXT'
ALTER DATABASE^75^         | DBMAC {ON | OFF} }
ALTER DATABASE^76^   | ENABLE [PUBLIC] THREAD integer
ALTER DATABASE^77^   | DISABLE THREAD integer
ALTER DATABASE^78^   | CREATE DATAFILE 'filename' [, filename] ...
ALTER DATABASE^79^       [AS filespec [, filespec] ...]
ALTER DATABASE^80^   | DATAFILE 'filename' ['filename'] ...
ALTER DATABASE^81^       { ONLINE
ALTER DATABASE^82^       | OFFLINE [DROP]
ALTER DATABASE^83^       | RESIZE integer [K | M]
ALTER DATABASE^84^       | AUTOEXTEND { OFF | ON
ALTER DATABASE^85^                    [NEXT integer [K | M] ]
ALTER DATABASE^86^                    [MAXSIZE {UNLIMITED | integer [K | M] } }
ALTER DATABASE^87^       | END BACKUP} }
ALTER DATABASE^88^ 
ALTER DATABASE^89^ For detailed information on this command, see the Oracle8 Server SQL
ALTER DATABASE^90^ Reference.
ALTER DATABASE^91^ 
ALTER FUNCTION^1^ 
ALTER FUNCTION^2^ ALTER FUNCTION
ALTER FUNCTION^3^ --------------
ALTER FUNCTION^4^ 
ALTER FUNCTION^5^ Use this command to recompile a stand-alone stored function.
ALTER FUNCTION^6^ 
ALTER FUNCTION^7^ ALTER FUNCTION [schema.]function COMPILE
ALTER FUNCTION^8^ 
ALTER FUNCTION^9^ For detailed information on this command, see the Oracle8 Server SQL
ALTER FUNCTION^10^ Reference.
ALTER FUNCTION^11^ 
ALTER INDEX^1^ 
ALTER INDEX^2^ ALTER INDEX
ALTER INDEX^3^ -----------
ALTER INDEX^4^ 
ALTER INDEX^5^ Use this command to:
ALTER INDEX^6^ 
ALTER INDEX^7^   *  change storage allocation for, rebuild, or rename an index
ALTER INDEX^8^   *  rename, split, remove, mark as unusable, or rebuild a partition
ALTER INDEX^9^      of a partitioned index
ALTER INDEX^10^   *  modify the physical, parallel, or logging attributes of a non-
ALTER INDEX^11^      partitioned index
ALTER INDEX^12^   *  modify the default physical, parallel, or logging attributes of
ALTER INDEX^13^      a partitioned index
ALTER INDEX^14^   *  rebuild an index to store the bytes of the index block in 
ALTER INDEX^15^      reverse order
ALTER INDEX^16^   *  modify a nested table index
ALTER INDEX^17^ 
ALTER INDEX^18^ ALTER INDEX [schema.]index
ALTER INDEX^19^   [REBUILD [ {PARALLEL parallel_clause | NOPARALLEL}
ALTER INDEX^20^            | {LOGGING | NOLOGGING}
ALTER INDEX^21^            | {REVERSE | NOREVERSE}
ALTER INDEX^22^            | physical_attributes_clause
ALTER INDEX^23^            | TABLESPACE tablespace] ...]
ALTER INDEX^24^   [ DEALLOCATE UNUSED [KEEP integer [K | M] ]
ALTER INDEX^25^   | ALLOCATE EXTENT [ ( { SIZE integer [K | M]
ALTER INDEX^26^                         | DATAFILE 'filename'
ALTER INDEX^27^                         | INSTANCE integer} ...) ]
ALTER INDEX^28^   | {PARALLEL parallel_clause | NOPARALLEL}
ALTER INDEX^29^   | physical_attributes_clause
ALTER INDEX^30^   | {LOGGING | NOLOGGING}
ALTER INDEX^31^   | RENAME TO new_index_name
ALTER INDEX^32^   | MODIFY PARTITION partition_name [ physical_attributes_clause
ALTER INDEX^33^                                     | {LOGGING | NOLOGGING}
ALTER INDEX^34^                                     | UNUSABLE ]
ALTER INDEX^35^   | RENAME PARTITION partition_name TO new_partition_name
ALTER INDEX^36^   | DROP PARTITION partition_name
ALTER INDEX^37^   | SPLIT PARTITION partition_name_old AT (value_list)
ALTER INDEX^38^     [ INTO ( PARTITION [split_partition_1]
ALTER INDEX^39^                        [ physical_attributes_clause
ALTER INDEX^40^                        | TABLESPACE tablespace
ALTER INDEX^41^                        | {LOGGING | NOLOGGING} ... ]
ALTER INDEX^42^              PARTITION [split_partition_2]
ALTER INDEX^43^                        [ physical_attributes_clause
ALTER INDEX^44^                        | TABLESPACE tablespace
ALTER INDEX^45^                        | {LOGGING | NOLOGGING} ... ] ) ]
ALTER INDEX^46^     [ PARALLEL parallel_clause | NOPARALLEL ]
ALTER INDEX^47^   | REBUILD PARTITION partition_name [ physical_attributes_clause
ALTER INDEX^48^                                      | TABLESPACE tablespace
ALTER INDEX^49^                                      | {PARALLEL parallel_clause
ALTER INDEX^50^                                        | NOPARALLEL}
ALTER INDEX^51^                                      | {LOGGING | NOLOGGING} ... ]
ALTER INDEX^52^   | UNUSABLE
ALTER INDEX^53^
ALTER INDEX^54^ physical_attributes_clause
ALTER INDEX^55^   [ PCTFREE integer
ALTER INDEX^56^   | INITRANS integer
ALTER INDEX^57^   | MAXTRANS integer
ALTER INDEX^58^   | STORAGE storage_clause ] ...
ALTER INDEX^59^ 
ALTER INDEX^60^ For detailed information on this command, see the Oracle8 Server SQL
ALTER INDEX^61^ Reference.
ALTER INDEX^62^ 
ALTER PACKAGE^1^ 
ALTER PACKAGE^2^ ALTER PACKAGE
ALTER PACKAGE^3^ -------------
ALTER PACKAGE^4^ 
ALTER PACKAGE^5^ Use this command to recompile a stored package.
ALTER PACKAGE^6^ 
ALTER PACKAGE^7^ ALTER PACKAGE [schema.]package COMPILE [PACKAGE | BODY]
ALTER PACKAGE^8^ 
ALTER PACKAGE^9^ For detailed information on this command, see the Oracle8 Server SQL
ALTER PACKAGE^10^ Reference.
ALTER PACKAGE^11^ 
ALTER PROCEDURE^1^ 
ALTER PROCEDURE^2^ ALTER PROCEDURE
ALTER PROCEDURE^3^ ---------------
ALTER PROCEDURE^4^ 
ALTER PROCEDURE^5^ Use this command to recompile a stand-alone stored procedure.
ALTER PROCEDURE^6^ 
ALTER PROCEDURE^7^ ALTER PROCEDURE [schema.]procedure COMPILE
ALTER PROCEDURE^8^ 
ALTER PROCEDURE^9^ For detailed information on this command, see the Oracle8 Server SQL
ALTER PROCEDURE^10^ Reference.
ALTER PROCEDURE^11^ 
ALTER PROFILE^1^ 
ALTER PROFILE^2^ ALTER PROFILE
ALTER PROFILE^3^ -------------
ALTER PROFILE^4^ 
ALTER PROFILE^5^ Use this command to add, modify, or remove a resource limit or
ALTER PROFILE^6^ password management in a profile.
ALTER PROFILE^7^ 
ALTER PROFILE^8^ ALTER PROFILE profile LIMIT
ALTER PROFILE^9^   { { SESSIONS_PER_USER
ALTER PROFILE^10^     | CPU_PER_SESSION
ALTER PROFILE^11^     | CPU_PER_CALL
ALTER PROFILE^12^     | CONNECT_TIME
ALTER PROFILE^13^     | IDLE_TIME
ALTER PROFILE^14^     | LOGICAL_READS_PER_SESSION
ALTER PROFILE^15^     | LOGICAL_READS_PER_CALL
ALTER PROFILE^16^     | COMPOSITE_LIMIT}
ALTER PROFILE^17^        {integer | UNLIMITED | DEFAULT}
ALTER PROFILE^18^   | { PRIVATE_SGA { integer [K | M]
ALTER PROFILE^19^                   | UNLIMITED
ALTER PROFILE^20^                   | DEFAULT}
ALTER PROFILE^21^   | FAILED_LOGIN_ATTEMPTS
ALTER PROFILE^22^   | PASSWORD_LIFETIME
ALTER PROFILE^23^   | {PASSWORD_REUSE_TIME
ALTER PROFILE^24^     |PASSWORD_REUSE_MAX}
ALTER PROFILE^25^   | ACCOUNT_LOCK_TIME
ALTER PROFILE^26^   | PASSWORD_GRACE_TIME}
ALTER PROFILE^27^       {integer | UNLIMITED | DEFAULT}
ALTER PROFILE^28^   | PASSWORD_VERIFY_FUNCTION
ALTER PROFILE^29^       {function | NULL | DEFAULT} } ...
ALTER PROFILE^30^ 
ALTER PROFILE^31^ For detailed information on this command, see the Oracle8 Server SQL
ALTER PROFILE^32^ Reference.
ALTER PROFILE^33^ 
ALTER RESOURCE COST^1^ 
ALTER RESOURCE COST^2^ ALTER RESOURCE COST
ALTER RESOURCE COST^3^ -------------------
ALTER RESOURCE COST^4^ 
ALTER RESOURCE COST^5^ Use this command to specify a formula to calculate the total
ALTER RESOURCE COST^6^ resource cost used in a session. For any session, this cost is
ALTER RESOURCE COST^7^ limited by the value of the COMPOSITE_LIMIT parameter in the user's
ALTER RESOURCE COST^8^ profile.
ALTER RESOURCE COST^9^ 
ALTER RESOURCE COST^10^ ALTER RESOURCE COST
ALTER RESOURCE COST^11^   { CPU_PER_SESSION integer
ALTER RESOURCE COST^12^   | CONNECT_TIME integer
ALTER RESOURCE COST^13^   | LOGICAL_READS_PER_SESSION integer
ALTER RESOURCE COST^14^   | PRIVATE_SGA integer} ...
ALTER RESOURCE COST^15^ 
ALTER RESOURCE COST^16^ For detailed information on this command, see the Oracle8 Server SQL
ALTER RESOURCE COST^17^ Reference.
ALTER RESOURCE COST^18^ 
ALTER ROLE^1^ 
ALTER ROLE^2^ ALTER ROLE
ALTER ROLE^3^ ----------
ALTER ROLE^4^ 
ALTER ROLE^5^ Use this command to change the authorization needed to enable a
ALTER ROLE^6^ role.
ALTER ROLE^7^ 
ALTER ROLE^8^ ALTER ROLE role
ALTER ROLE^9^   { NOT IDENTIFIED
ALTER ROLE^10^   | IDENTIFIED {BY password | EXTERNALLY | GLOBALLY} }
ALTER ROLE^11^ 
ALTER ROLE^12^ For detailed information on this command, see the Oracle8 Server SQL
ALTER ROLE^13^ Reference.
ALTER ROLE^14^ 
ALTER ROLLBACK SEGMENT^1^ 
ALTER ROLLBACK SEGMENT^2^ ALTER ROLLBACK SEGMENT
ALTER ROLLBACK SEGMENT^3^ ----------------------
ALTER ROLLBACK SEGMENT^4^ 
ALTER ROLLBACK SEGMENT^5^ Use this command to alter a rollback segment in one of these ways:
ALTER ROLLBACK SEGMENT^6^
ALTER ROLLBACK SEGMENT^7^   *  by bringing it online
ALTER ROLLBACK SEGMENT^8^   *  by taking it offline
ALTER ROLLBACK SEGMENT^9^   *  by changing its storage characteristics
ALTER ROLLBACK SEGMENT^10^   *  by shrinking it to an optimal or given size
ALTER ROLLBACK SEGMENT^11^ 
ALTER ROLLBACK SEGMENT^12^ ALTER ROLLBACK SEGMENT rollback_segment
ALTER ROLLBACK SEGMENT^13^   { ONLINE
ALTER ROLLBACK SEGMENT^14^   | OFFLINE
ALTER ROLLBACK SEGMENT^15^   | STORAGE storage_clause
ALTER ROLLBACK SEGMENT^16^   | SHRINK [TO integer [K | M] ] }
ALTER ROLLBACK SEGMENT^17^ 
ALTER ROLLBACK SEGMENT^18^ For detailed information on this command, see the Oracle8 Server SQL
ALTER ROLLBACK SEGMENT^19^ Reference.
ALTER ROLLBACK SEGMENT^20^ 
ALTER SEQUENCE^1^ 
ALTER SEQUENCE^2^ ALTER SEQUENCE
ALTER SEQUENCE^3^ --------------
ALTER SEQUENCE^4^ 
ALTER SEQUENCE^5^ Use this command to change the sequence in one of these ways:
ALTER SEQUENCE^6^ 
ALTER SEQUENCE^7^   *  changing the increment between future sequence values
ALTER SEQUENCE^8^   *  setting or eliminating the minimum or maximum value
ALTER SEQUENCE^9^   *  changing the number of cached sequence numbers
ALTER SEQUENCE^10^   *  specifying whether sequence numbers must be ordered
ALTER SEQUENCE^11^ 
ALTER SEQUENCE^12^ ALTER SEQUENCE [schema.]sequence
ALTER SEQUENCE^13^   { INCREMENT BY integer
ALTER SEQUENCE^14^   | {MAXVALUE integer | NOMAXVALUE}
ALTER SEQUENCE^15^   | {MINVALUE integer | NOMINVALUE}
ALTER SEQUENCE^16^   | {CYCLE | NOCYCLE}
ALTER SEQUENCE^17^   | {CACHE integer | NOCACHE}
ALTER SEQUENCE^18^   | {ORDER | NOORDER} } ...
ALTER SEQUENCE^19^ 
ALTER SEQUENCE^20^ For detailed information on this command, see the Oracle8 Server SQL
ALTER SEQUENCE^21^ Reference.
ALTER SEQUENCE^22^ 
ALTER SESSION^1^ 
ALTER SESSION^2^ ALTER SESSION
ALTER SESSION^3^ -------------
ALTER SESSION^4^ 
ALTER SESSION^5^ Use this command to alter your current session in one of the
ALTER SESSION^6^ following:
ALTER SESSION^7^ 
ALTER SESSION^8^   *  to enable or disable the SQL trace facility
ALTER SESSION^9^   *  to enable or disable global name resolution
ALTER SESSION^10^   *  to change the values of NLS parameters
ALTER SESSION^11^   *  to change your DBMS session label in Trusted Oracle
ALTER SESSION^12^   *  to change the default label format for your session
ALTER SESSION^13^   *  to specify the size of the cache used to hold frequently used
ALTER SESSION^14^      cursors
ALTER SESSION^15^   *  to enable or disable the closing of cached cursors on COMMIT or
ALTER SESSION^16^      ROLLBACK
ALTER SESSION^17^   *  in a parallel server, to indicate that the session must access
ALTER SESSION^18^      database files as if the session was connected to another 
ALTER SESSION^19^      instance
ALTER SESSION^20^   *  to enable, disable, and change the behavior of hash join 
ALTER SESSION^21^      operations
ALTER SESSION^22^   *  to change the handling of remote procedure call dependencies
ALTER SESSION^23^   *  to change transaction level handling
ALTER SESSION^24^   *  to close a database link
ALTER SESSION^25^   *  to send advice to remote databases for forcing an in-doubt
ALTER SESSION^26^      distributed transaction
ALTER SESSION^27^   *  to permit or prohibit stored procedures and functions from
ALTER SESSION^28^      issuing COMMIT and ROLLBACK statements
ALTER SESSION^29^   *  to change the goal of the cost-based optimization approach
ALTER SESSION^30^   *  in a parallel server, to enable DML statements to be considered
ALTER SESSION^31^      for parallel execution
ALTER SESSION^32^   *  to insert, update, or delete from tables with indexes or index
ALTER SESSION^33^      partitions marked as unusable
ALTER SESSION^34^   *  to allow deferrable constraints to be checked either 
ALTER SESSION^35^      immediately following every DML statement or at the end of a
ALTER SESSION^36^      transaction
ALTER SESSION^37^ 
ALTER SESSION^38^ ALTER SESSION
ALTER SESSION^39^   {SET { {SQL_TRACE | GLOBAL_NAMES | SKIP_UNUSABLE_INDEXES}={TRUE |
ALTER SESSION^40^     FALSE}
ALTER SESSION^41^        | NLS_LANGUAGE = language
ALTER SESSION^42^        | NLS_TERRITORY = territory
ALTER SESSION^43^        | NLS_DATE_FORMAT = 'fmt'
ALTER SESSION^44^        | NLS_DATE_LANGUAGE = language
ALTER SESSION^45^        | NLS_NUMERIC_CHARACTERS = 'text'
ALTER SESSION^46^        | NLS_ISO_CURRENCY = territory
ALTER SESSION^47^        | NLS_CURRENCY = 'text'
ALTER SESSION^48^        | NLS_SORT = {sort | BINARY}
ALTER SESSION^49^        | NLS_CALENDAR = 'text'
ALTER SESSION^50^        | LABEL = {'text' | DBHIGH | DBLOW | OSLABEL}
ALTER SESSION^51^        | MLS_LABEL_FORMAT = fmt
ALTER SESSION^52^        | OPTIMIZER_GOAL = {ALL_ROWS | FIRST_ROWS | RULE | CHOOSE}
ALTER SESSION^53^        | FLAGGER = {ENTRY | INTERMEDIATE | FULL | OFF}
ALTER SESSION^54^        | SESSION_CACHED_CURSORS = integer
ALTER SESSION^55^        | CLOSE_CACHED_OPEN_CURSORS = {TRUE | FALSE}
ALTER SESSION^56^        | INSTANCE = integer
ALTER SESSION^57^        | HASH_AREA_SIZE = integer
ALTER SESSION^58^        | HASH_MULTILBLOCK_IO_COUNT = integer
ALTER SESSION^59^        | REMOTE_DEPENDENCIES_MODE = {TIMESTAMP | SIGNATURE}
ALTER SESSION^60^        | ISOLATION_LEVEL {SERIALIZABLE | READ COMMITTED}
ALTER SESSION^61^        | CONSTRAINT[S] = {IMMEDIATE | DEFERRED | DEFAULT} } ...
ALTER SESSION^62^   | CLOSE DATABASE LINK dblink
ALTER SESSION^63^   | ADVISE {COMMIT | ROLLBACK | NOTHING}
ALTER SESSION^64^   | {ENABLE | DISABLE} COMMIT IN PROCEDURE}
ALTER SESSION^65^   | {ENABLE | DISABLE} PARALLEL DML
ALTER SESSION^66^ 
ALTER SESSION^67^ For detailed information on this command, see the Oracle8 Server SQL
ALTER SESSION^68^ Reference.
ALTER SESSION^69^ 
ALTER SNAPSHOT^1^ 
ALTER SNAPSHOT^2^ ALTER SNAPSHOT
ALTER SNAPSHOT^3^ --------------
ALTER SNAPSHOT^4^ 
ALTER SNAPSHOT^5^ Use this command to alter a snapshot in one of the following ways:
ALTER SNAPSHOT^6^ 
ALTER SNAPSHOT^7^   *  changing its storage characteristics
ALTER SNAPSHOT^8^   *  changing its automatic refresh mode and times
ALTER SNAPSHOT^9^ 
ALTER SNAPSHOT^10^ ALTER SNAPSHOT [schema.]snapshot
ALTER SNAPSHOT^11^   [ physical_attributes_clause ] ...
ALTER SNAPSHOT^12^   [USING {INDEX [physical_attributes_clause] ...
ALTER SNAPSHOT^13^          | [DEFAULT] MASTER ROLLBACK SEGMENT [rollback_segment] }
ALTER SNAPSHOT^14^   [REFRESH [FAST | COMPLETE | FORCE]
ALTER SNAPSHOT^15^   [START WITH date] [NEXT date] [WITH PRIMARY KEY ]
ALTER SNAPSHOT^16^ 
ALTER SNAPSHOT^17^ physical_attributes_clause
ALTER SNAPSHOT^18^   [ PCTFREE integer
ALTER SNAPSHOT^19^   | PCTUSED integer
ALTER SNAPSHOT^20^   | INITRANS integer
ALTER SNAPSHOT^21^   | MAXTRANS integer
ALTER SNAPSHOT^22^   | STORAGE storage_clause ]
ALTER SNAPSHOT^23^ 
ALTER SNAPSHOT^24^ For detailed information on this command, see the Oracle8 Server SQL
ALTER SNAPSHOT^25^ Reference.
ALTER SNAPSHOT^26^ 
ALTER SNAPSHOT LOG^1^ 
ALTER SNAPSHOT LOG^2^ ALTER SNAPSHOT LOG
ALTER SNAPSHOT LOG^3^ ------------------
ALTER SNAPSHOT LOG^4^ 
ALTER SNAPSHOT LOG^5^ Use this command to change the storage characteristics of a snapshot
ALTER SNAPSHOT LOG^6^ log.
ALTER SNAPSHOT LOG^7^ 
ALTER SNAPSHOT LOG^8^ ALTER SNAPSHOT LOG ON [schema.]table
ALTER SNAPSHOT LOG^9^   [ ADD {[PRIMARY KEY] [,ROWID]
ALTER SNAPSHOT LOG^10^         [,(filter_column) | ,(filter_column)] ...}
ALTER SNAPSHOT LOG^11^   [ PCTFREE integer
ALTER SNAPSHOT LOG^12^   | PCTUSED integer
ALTER SNAPSHOT LOG^13^   | INITRANS integer
ALTER SNAPSHOT LOG^14^   | MAXTRANS integer
ALTER SNAPSHOT LOG^15^   | STORAGE storage_clause] ...
ALTER SNAPSHOT LOG^16^ 
ALTER SNAPSHOT LOG^17^ For detailed information on this command, see the Oracle8 Server SQL
ALTER SNAPSHOT LOG^18^ Reference.
ALTER SNAPSHOT LOG^19^ 
ALTER SYSTEM^1^ 
ALTER SYSTEM^2^ ALTER SYSTEM
ALTER SYSTEM^3^ ------------
ALTER SYSTEM^4^ 
ALTER SYSTEM^5^ Use this command to dynamically alter your Oracle instance in one of
ALTER SYSTEM^6^ the following ways:
ALTER SYSTEM^7^ 
ALTER SYSTEM^8^   *  to restrict log ons to Oracle to only those users with
ALTER SYSTEM^9^      RESTRICTED SESSION system privilege
ALTER SYSTEM^10^   *  to clear all data from the shared pool in the System Global
ALTER SYSTEM^11^      Area (SGA)
ALTER SYSTEM^12^   *  to explicitly perform a checkpoint
ALTER SYSTEM^13^   *  to verify access to data files
ALTER SYSTEM^14^   *  to enable or disable resource limits
ALTER SYSTEM^15^   *  to enable or disable global name resolution
ALTER SYSTEM^16^   *  to manage shared server processes or dispatcher processes for
ALTER SYSTEM^17^      the multi-threaded server architecture
ALTER SYSTEM^18^   *  to dynamically change or disable limits or thresholds for 
ALTER SYSTEM^19^      concurrent usage licensing and named user licensing
ALTER SYSTEM^20^   *  to explicitly switch redo log file groups
ALTER SYSTEM^21^   *  to enable distributed recovery in a single-process environment
ALTER SYSTEM^22^   *  to disable distributed recovery
ALTER SYSTEM^23^   *  to manually archive redo log file groups or to enable or
ALTER SYSTEM^24^      disable automatic archiving
ALTER SYSTEM^25^   *  to terminate a session
ALTER SYSTEM^26^ 
ALTER SYSTEM^27^ ALTER SYSTEM
ALTER SYSTEM^28^   { {ENABLE | DISABLE} RESTRICTED SESSION
ALTER SYSTEM^29^   | FLUSH SHARED_POOL
ALTER SYSTEM^30^   | {CHECKPOINT | CHECK DATAFILES} [GLOBAL | LOCAL]
ALTER SYSTEM^31^   | SET { {RESOURCE_LIMIT | GLOBAL_NAMES} = {TRUE | FALSE}
ALTER SYSTEM^32^           | SCAN_INSTANCES = integer
ALTER SYSTEM^33^           | CACHE_INSTANCES = integer
ALTER SYSTEM^34^           | MTS_SERVERS = integer
ALTER SYSTEM^35^           | MTS_DISPATCHERS = 'protocol, integer'
ALTER SYSTEM^36^           | LICENSE_MAX_SESSIONS = integer
ALTER SYSTEM^37^           | LICENSE_SESSIONS_WARNING = integer
ALTER SYSTEM^38^           | LICENSE_MAX_USERS = integer
ALTER SYSTEM^39^           | REMOTE_DEPENDENCIES_MODE = {TIMESTAMP | SIGNATURE} } ...
ALTER SYSTEM^40^   | SWITCH LOGFILE
ALTER SYSTEM^41^   | {ENABLE | DISABLE} DISTRIBUTED RECOVERY
ALTER SYSTEM^42^   | ARCHIVE LOG archive_log_clause
ALTER SYSTEM^43^   | KILL SESSION 'integer1, integer2'}
ALTER SYSTEM^44^ 
ALTER SYSTEM^45^ For detailed information on this command, see the Oracle8 Server SQL
ALTER SYSTEM^46^ Reference.
ALTER SYSTEM^47^ 
ALTER TABLE^1^ 
ALTER TABLE^2^ ALTER TABLE
ALTER TABLE^3^ -----------
ALTER TABLE^4^ 
ALTER TABLE^5^ Use this command to alter the definition of a table in one of the
ALTER TABLE^6^ following ways:
ALTER TABLE^7^ 
ALTER TABLE^8^   *  to add a column
ALTER TABLE^9^   *  to add an integrity constraint
ALTER TABLE^10^   *  to redefine a column (datatype, size, default value)
ALTER TABLE^11^   *  to modify storage characteristics or other parameters
ALTER TABLE^12^   *  to modify the real storage attributes of a non-partitioned
ALTER TABLE^13^      table or the default attributes of a partitioned table
ALTER TABLE^14^   *  to enable, disable, or drop an integrity constraint or trigger
ALTER TABLE^15^   *  to explicitly allocate an extent
ALTER TABLE^16^   *  to explicitly deallocate the unused space of a table
ALTER TABLE^17^   *  to allow or disallow writing to a table
ALTER TABLE^18^   *  to modify the degree of parallelism for a table
ALTER TABLE^19^   *  to modify the LOGGING/NOLOGGING attributes
ALTER TABLE^20^   *  add, modify, split, move, drop, or truncate table partitions
ALTER TABLE^21^   *  rename a table or a table partition
ALTER TABLE^22^   *  add or modify index-only table characteristics
ALTER TABLE^23^   *  add or modify LOB columns
ALTER TABLE^24^   *  add or modify object type, nested table type, or VARRAY type
ALTER TABLE^25^      column to a table
ALTER TABLE^26^   *  add integrity constraints to object type columns
ALTER TABLE^27^ 
ALTER TABLE^28^ ALTER TABLE [schema.]table
ALTER TABLE^29^   {ADD ( {column datatype [DEFAULT expr] [WITH ROWID]
ALTER TABLE^30^          [SCOPE IS [schema.]scope_table_name]
ALTER TABLE^31^          [column_constraint] ...}
ALTER TABLE^32^        | table_constraint | REF (ref_column_name) WITH ROWID
ALTER TABLE^33^        | SCOPE FOR (ref_column_name) IS [schema.]
ALTER TABLE^34^          scope_table_name ...) }
ALTER TABLE^35^   | MODIFY ( [column [datatype] [DEFAULT expr] 
ALTER TABLE^36^              [column_constraint] ...] ...)
ALTER TABLE^37^   | [physical_attributes_clause]
ALTER TABLE^38^   | {LOB_storage_clause [, LOB_storage_clause...]}
ALTER TABLE^39^   | {MODIFY_LOB_storage_clause [, MODIFY_LOB_storage_clause]}
ALTER TABLE^40^   | {NESTED_TABLE_storage_clause [, NESTED_TABLE_storage_clause...]}
ALTER TABLE^41^   | DROP drop_clause
ALTER TABLE^42^   | ALLOCATE EXTENT [ ( {SIZE integer [K | M]
ALTER TABLE^43^                         | DATAFILE 'filename'
ALTER TABLE^44^                         | INSTANCE integer} ...) ]
ALTER TABLE^45^   | DEALLOCATE UNUSED [KEEP integer [K | M] ] ...
ALTER TABLE^46^   [ { [ENABLE {enable_clause | TABLE LOCK}
ALTER TABLE^47^       | DISABLE {disable_clause | TABLE LOCK} ] ...
ALTER TABLE^48^     | [PARALLEL parallel_clause] {NOCACHE | CACHE} }  ]
ALTER TABLE^49^   | RENAME TO new_table_name
ALTER TABLE^50^   | OVERFLOW {physical_attributes_clause
ALTER TABLE^51^              | INCLUDING column_name
ALTER TABLE^52^              | ALLOCATE EXTENT
ALTER TABLE^53^                [ ( {SIZE integer [K | M]
ALTER TABLE^54^                    | DATAFILE filename
ALTER TABLE^55^                    | INSTANCE integer} ...) ]
ALTER TABLE^56^              | DEALLOCATE UNUSED [KEEP integer [K | M] ] } ...
ALTER TABLE^57^   | ADD OVERFLOW [ {physical_attributes_clause
ALTER TABLE^58^                    | PCTTHRESHOLD integer
ALTER TABLE^59^                    | INCLUDING column_name
ALTER TABLE^60^                    | TABLESPACE tablespace} ...]
ALTER TABLE^61^   | MODIFY PARTITION partition_name { physical_attributes_clause
ALTER TABLE^62^                                     | [LOGGING | NOLOGGING] } ...
ALTER TABLE^63^   | MOVE PARTITION partition_name { physical_attributes_clause
ALTER TABLE^64^                                   | [LOGGING | NOLOGGING]
ALTER TABLE^65^                                   | TABLESPACE tablespace
ALTER TABLE^66^                                   | PARALLEL parallel_clause} ...
ALTER TABLE^67^   | ADD PARTITION [new_partition_name]
ALTER TABLE^68^     VALUES LESS THAN (value_list) { physical_attributes_clause
ALTER TABLE^69^                                   | [LOGGING | NOLOGGING]
ALTER TABLE^70^                                   | TABLESPACE tablespace } ...
ALTER TABLE^71^   | DROP PARTITION partition_name
ALTER TABLE^72^   | TRUNCATE PARTITION partition_name [DROP STORAGE | REUSE STORAGE]
ALTER TABLE^73^   | SPLIT PARTITION partition_name_old AT (value_list)
ALTER TABLE^74^     [INTO ( PARTITION [split_partition_1]
ALTER TABLE^75^                       [physical_attributes_clause
ALTER TABLE^76^                       | [LOGGING | NOLOGGING]
ALTER TABLE^77^                       | TABLESPACE tablespace ] ...
ALTER TABLE^78^           , PARTITION [split_partition2]
ALTER TABLE^79^                       [physical_attributes_clause
ALTER TABLE^80^                       | [LOGGING | NOLOGGING]
ALTER TABLE^81^                       | TABLESPACE tablespace ] ...) ]
ALTER TABLE^82^           [ PARALLEL parallel_clause ] ...
ALTER TABLE^83^   | EXCHANGE PARTITION partition_name
ALTER TABLE^84^     WITH TABLE non_partitioned_table_name
ALTER TABLE^85^     [{INCLUDING | EXCLUDING} INDEXES]
ALTER TABLE^86^     [{WITH | WITHOUT} VALIDATION]
ALTER TABLE^87^   | MODIFY PARTITION UNUSABLE LOCAL INDEXES
ALTER TABLE^88^   | MODIFY PARTITION REBUILD UNUSABLE LOCAL INDEXES }
ALTER TABLE^89^ 
ALTER TABLE^90^ physical_attributes_clause
ALTER TABLE^91^   [ PCTFREE integer
ALTER TABLE^92^   | PCTUSED integer
ALTER TABLE^93^   | INITRANS integer
ALTER TABLE^94^   | MAXTRANS integer
ALTER TABLE^95^   | STORAGE storage_clause ]
ALTER TABLE^96^ 
ALTER TABLE^97^ LOB_storage_clause
ALTER TABLE^98^   LOB (lob_item [, lob_item ...]) STORE AS
ALTER TABLE^99^       [lob_segname]
ALTER TABLE^100^       [( TABLESPACE tablespace
ALTER TABLE^101^        | STORAGE storage_clause
ALTER TABLE^102^        | CHUNK integer
ALTER TABLE^103^        | PCTVERSION integer
ALTER TABLE^104^        | CACHE
ALTER TABLE^105^        | NOCACHE LOGGING | NOCACHE NOLOGGING
ALTER TABLE^106^        | INDEX [lob_index_name]
ALTER TABLE^107^          [( TABLESPACE tablespace
ALTER TABLE^108^          |  STORAGE storage_clause
ALTER TABLE^109^          |  INITRANS integer
ALTER TABLE^110^          |  MAXTRANS integer ) ] )]
ALTER TABLE^111^ 
ALTER TABLE^112^ MODIFY_LOB_storage_clause
ALTER TABLE^113^   MODIFY LOB (lob_item)
ALTER TABLE^114^     ( STORAGE storage_clause
ALTER TABLE^115^     | PCTVERSION integer
ALTER TABLE^116^     | CACHE
ALTER TABLE^117^     | NOCACHE LOGGING | NOCACHE NOLOGGING
ALTER TABLE^118^     | ALLOCATE EXTENT [ ( {SIZE integer [K | M]
ALTER TABLE^119^                           | DATAFILE 'filename'
ALTER TABLE^120^                           | INSTANCE integer} ) ]
ALTER TABLE^121^     | DEALLOCATE UNUSED [KEEP integer [K | M] ]
ALTER TABLE^122^     | INDEX [lob_index_name]
ALTER TABLE^123^       [ ( STORAGE storage_clause
ALTER TABLE^124^         | INITRANS integer
ALTER TABLE^125^         | MAXTRANS integer
ALTER TABLE^126^         | ALLOCATE EXTENT [ ( {SIZE integer [K | M]
ALTER TABLE^127^                               | DATAFILE 'filename'
ALTER TABLE^128^                               | INSTANCE integer} ) ]
ALTER TABLE^129^         | DEALLOCATE UNUSED [KEEP integer [K | M] ] ) ]
ALTER TABLE^130^ 
ALTER TABLE^131^ NESTED_TABLE_storage_clause
ALTER TABLE^132^   NESTED TABLE nested_item STORE AS storage_table
ALTER TABLE^133^ 
ALTER TABLE^134^ For detailed information on this command, see the Oracle8 Server SQL
ALTER TABLE^135^ Reference.
ALTER TABLE^136^ 
ALTER TABLESPACE^1^ 
ALTER TABLESPACE^2^ ALTER TABLESPACE
ALTER TABLESPACE^3^ ----------------
ALTER TABLESPACE^4^ 
ALTER TABLESPACE^5^ Use this command to alter an existing tablespace in one of the
ALTER TABLESPACE^6^ following ways:
ALTER TABLESPACE^7^ 
ALTER TABLESPACE^8^   *  to add datafile(s)
ALTER TABLESPACE^9^   *  to rename datafiles
ALTER TABLESPACE^10^   *  to change default storage parameters
ALTER TABLESPACE^11^   *  to take the tablespace online or offline
ALTER TABLESPACE^12^   *  to begin or end a backup
ALTER TABLESPACE^13^   *  to allow or disallow writing to a tablespace
ALTER TABLESPACE^14^   *  to change the default logging attribute of the tablespace
ALTER TABLESPACE^15^   *  to change the minimum tablespace extent length
ALTER TABLESPACE^16^ 
ALTER TABLESPACE^17^ ALTER TABLESPACE tablespace [LOGGING | NOLOGGING]
ALTER TABLESPACE^18^   {ADD DATAFILE 'filespec'
ALTER TABLESPACE^19^     [AUTOEXTEND {OFF | ON [NEXT integer [K | M] ]
ALTER TABLESPACE^20^                           [MAXSIZE { UNLIMITED
ALTER TABLESPACE^21^                                    | integer [K | M] } ] } ]
ALTER TABLESPACE^22^   [, 'filespec'
ALTER TABLESPACE^23^     [AUTOEXTEND {OFF | ON [NEXT integer [K | M] ]
ALTER TABLESPACE^24^                           [MAXSIZE {UNLIMITED
ALTER TABLESPACE^25^                                    | integer [K | M] } ] } ] ] ...
ALTER TABLESPACE^26^   | RENAME DATAFILE 'filename' [, 'filename'] ...
ALTER TABLESPACE^27^     TO 'filename' ['filename'] ...
ALTER TABLESPACE^28^   | COALESCE
ALTER TABLESPACE^29^   | DEFAULT STORAGE storage_clause
ALTER TABLESPACE^30^   | MINIMUM EXTENT integer [K | M]
ALTER TABLESPACE^31^   | ONLINE
ALTER TABLESPACE^32^   | OFFLINE [NORMAL | TEMPORARY | IMMEDIATE]
ALTER TABLESPACE^33^   | {BEGIN | END} BACKUP
ALTER TABLESPACE^34^   | READ {ONLY | WRITE}
ALTER TABLESPACE^35^   | PERMANENT
ALTER TABLESPACE^36^   | TEMPORARY}
ALTER TABLESPACE^37^ 
ALTER TABLESPACE^38^ For detailed information on this command, see the Oracle8 Server SQL
ALTER TABLESPACE^39^ Reference.
ALTER TABLESPACE^40^ 
ALTER TRIGGER^1^ 
ALTER TRIGGER^2^ ALTER TRIGGER
ALTER TRIGGER^3^ -------------
ALTER TRIGGER^4^ 
ALTER TRIGGER^5^ Use this command to enable, disable, or compile a database trigger:
ALTER TRIGGER^6^ 
ALTER TRIGGER^7^ ALTER TRIGGER [schema.]trigger {ENABLE | DISABLE | COMPILE [DEBUG]}
ALTER TRIGGER^8^ 
ALTER TRIGGER^9^ For detailed information on this command, see the Oracle8 Server SQL
ALTER TRIGGER^10^ Reference.
ALTER TRIGGER^11^ 
ALTER TYPE^1^ 
ALTER TYPE^2^ ALTER TYPE
ALTER TYPE^3^ ----------
ALTER TYPE^4^ 
ALTER TYPE^5^ Use this command to recompile the specification and/or body, or to
ALTER TYPE^6^ change the specification of an object type by adding new object 
ALTER TYPE^7^ member subprogram specifications.
ALTER TYPE^8^ 
ALTER TYPE^9^ ALTER TYPE [schema.]type_name
ALTER TYPE^10^   { COMPILE [SPECIFICATION | BODY] | REPLACE }
ALTER TYPE^11^     (attribute_name  datatype[, attribute_name  datatype]... 
ALTER TYPE^12^     | [{MAP | ORDER} MEMBER function_specification]
ALTER TYPE^13^     | [MEMBER {procedure_specification | function_specification}
ALTER TYPE^14^     [, MEMBER {procedure_specification | function_specification}]... ]
ALTER TYPE^15^     | [PRAGMA RESTRICT_REFERENCES (method_name, constraints)
ALTER TYPE^16^     [, PRAGMA RESTRICT_REFERENCES (method_name, constraints)]... ] )
ALTER TYPE^17^ 
ALTER TYPE^18^ 
ALTER TYPE^19^ For detailed information on this command, see the Oracle8 Server SQL
ALTER TYPE^20^ Reference.
ALTER TYPE^21^ 
ALTER USER^1^ 
ALTER USER^2^ ALTER USER
ALTER USER^3^ ----------
ALTER USER^4^ 
ALTER USER^5^ Use this command to change any of the following characteristics of a
ALTER USER^6^ database user:
ALTER USER^7^ 
ALTER USER^8^   *  authentication mechanism of the user
ALTER USER^9^   *  password
ALTER USER^10^   *  default tablespace for object creation
ALTER USER^11^   *  tablespace for temporary segments created for the user
ALTER USER^12^   *  tablespace access and tablespace quotas
ALTER USER^13^   *  limits on database resources
ALTER USER^14^   *  default roles
ALTER USER^15^ 
ALTER USER^16^ ALTER USER user
ALTER USER^17^   { IDENTIFIED {BY password | EXTERNALLY
ALTER USER^18^                | GLOBALLY AS 'CN=user'}
ALTER USER^19^   | DEFAULT TABLESPACE tablespace
ALTER USER^20^   | TEMPORARY TABLESPACE tablespace
ALTER USER^21^   | QUOTA { integer [K | M] | UNLIMITED} ON tablespace
ALTER USER^22^   [ QUOTA { integer [K | M] | UNLIMITED} ON tablespace] ...
ALTER USER^23^   | PROFILE profile
ALTER USER^24^   | PASSWORD EXPIRE
ALTER USER^25^   | ACCOUNT { LOCK | UNLOCK }
ALTER USER^26^   | DEFAULT ROLE { role [, role] ...
ALTER USER^27^                  | ALL [EXCEPT role [, role] ...]
ALTER USER^28^                  | NONE} } ...
ALTER USER^29^ 
ALTER USER^30^ For detailed information on this command, see the Oracle8 Server SQL
ALTER USER^31^ Reference.
ALTER USER^32^ 
ALTER VIEW^1^ 
ALTER VIEW^2^ ALTER VIEW
ALTER VIEW^3^ ----------
ALTER VIEW^4^ 
ALTER VIEW^5^ Use this command to recompile a view or an object view.
ALTER VIEW^6^ 
ALTER VIEW^7^ ALTER VIEW [schema.]view COMPILE
ALTER VIEW^8^ 
ALTER VIEW^9^ For detailed information on this command, see the Oracle8 Server SQL
ALTER VIEW^10^ Reference.
ALTER VIEW^11^ 
ANALYZE^1^ 
ANALYZE^2^ ANALYZE
ANALYZE^3^ -------
ANALYZE^4^ 
ANALYZE^5^ Use this command to perform one of the following functions on an
ANALYZE^6^ index or index partition, table or table partition, index-only
ANALYZE^7^ table, or cluster:
ANALYZE^8^ 
ANALYZE^9^   *  to collect statistics about the schema object used by the
ANALYZE^10^      optimizer and store them in the data dictionary
ANALYZE^11^   *  to delete statistics about the schema object from the data
ANALYZE^12^      dictionary
ANALYZE^13^   *  to validate the structure of the schema object
ANALYZE^14^   *  to identify migrated and chained rows of the table or cluster
ANALYZE^15^   *  to collect statistics on scalar object attributes
ANALYZE^16^   *  to validate and update object references (REFs)
ANALYZE^17^ 
ANALYZE^18^ ANALYZE {INDEX | TABLE | CLUSTER}
ANALYZE^19^         [schema.]{index [PARTITION (partition_name)]
ANALYZE^20^                   | table [PARTITION (partition_name)]
ANALYZE^21^                   | cluster}
ANALYZE^22^   { COMPUTE STATISTICS [FOR for_clause]
ANALYZE^23^   | ESTIMATE STATISTICS [FOR for_clause]
ANALYZE^24^                         [SAMPLE integer {ROWS | PERCENT} ]
ANALYZE^25^   | DELETE STATISTICS
ANALYZE^26^   | VALIDATE REF UPDATE
ANALYZE^27^   | VALIDATE STRUCTURE [CASCADE]
ANALYZE^28^   | LIST CHAINED ROWS [INTO [schema.]table] }
ANALYZE^29^ 
ANALYZE^30^ for_clause
ANALYZE^31^   [ FOR TABLE
ANALYZE^32^   | FOR ALL [INDEXED] COLUMNS [SIZE integer]
ANALYZE^33^   | FOR COLUMNS [SIZE integer] column | attribute [SIZE integer]
ANALYZE^34^                             [column | attribute [SIZE integer] ] ...
ANALYZE^35^   | FOR ALL [LOCAL] INDEXES]
ANALYZE^36^ 
ANALYZE^37^ For detailed information on this command, see the Oracle8 Server SQL
ANALYZE^38^ Reference.
ANALYZE^39^ 
ARCHIVE LOG clause^1^ 
ARCHIVE LOG clause^2^ ARCHIVE LOG clause
ARCHIVE LOG clause^3^ ------------------
ARCHIVE LOG clause^4^ 
ARCHIVE LOG clause^5^ Use this command to manually archive redo log file groups or to
ARCHIVE LOG clause^6^ enable or disable automatic archiving.
ARCHIVE LOG clause^7^ 
ARCHIVE LOG clause^8^ ARCHIVE LOG [THREAD integer]
ARCHIVE LOG clause^9^   { { SEQUENCE integer
ARCHIVE LOG clause^10^     | CHANGE integer
ARCHIVE LOG clause^11^     | CURRENT
ARCHIVE LOG clause^12^     | GROUP integer
ARCHIVE LOG clause^13^     | LOGFILE 'filename'
ARCHIVE LOG clause^14^     | NEXT
ARCHIVE LOG clause^15^     | ALL
ARCHIVE LOG clause^16^     | START} [TO 'location']
ARCHIVE LOG clause^17^   | STOP}
ARCHIVE LOG clause^18^ 
ARCHIVE LOG clause^19^ For detailed information on this command, see the Oracle8 Server SQL
ARCHIVE LOG clause^20^ Reference.
ARCHIVE LOG clause^21^ 
AUDIT (SQL Statements)^1^ 
AUDIT (SQL Statements)^2^ AUDIT (SQL Statements)
AUDIT (SQL Statements)^3^ ----------------------
AUDIT (SQL Statements)^4^ 
AUDIT (SQL Statements)^5^ Use this command to choose specific SQL statements for auditing in
AUDIT (SQL Statements)^6^ subsequent user sessions. To choose particular schema objects for
AUDIT (SQL Statements)^7^ auditing, use the AUDIT command (Schema Objects).
AUDIT (SQL Statements)^8^ 
AUDIT (SQL Statements)^9^ AUDIT {statement_opt | system_priv}
AUDIT (SQL Statements)^10^   [, {statement_opt | system_priv} ] ...
AUDIT (SQL Statements)^11^   [BY user [, user] ...]
AUDIT (SQL Statements)^12^   [BY {SESSION | ACCESS} ]
AUDIT (SQL Statements)^13^   [WHENEVER [NOT] SUCCESSFUL]
AUDIT (SQL Statements)^14^ 
AUDIT (SQL Statements)^15^ For detailed information on this command, see the Oracle8 Server SQL
AUDIT (SQL Statements)^16^ Reference.
AUDIT (SQL Statements)^17^ 
AUDIT (Schema Objects)^1^ 
AUDIT (Schema Objects)^2^ AUDIT (Schema Objects)
AUDIT (Schema Objects)^3^ ----------------------
AUDIT (Schema Objects)^4^ 
AUDIT (Schema Objects)^5^ Use this command to choose a specific schema object for auditing. To
AUDIT (Schema Objects)^6^ choose particular SQL commands for auditing, use the AUDIT command
AUDIT (Schema Objects)^7^ (SQL Statements).
AUDIT (Schema Objects)^8^ 
AUDIT (Schema Objects)^9^ AUDIT object_opt [, object_opt] ...
AUDIT (Schema Objects)^10^   ON { [schema. | DIRECTORY] object | DEFAULT }
AUDIT (Schema Objects)^11^   [BY {SESSION | ACCESS} ]
AUDIT (Schema Objects)^12^   [WHENEVER [NOT] SUCCESSFUL]
AUDIT (Schema Objects)^13^ 
AUDIT (Schema Objects)^14^ For detailed information on this command, see the Oracle8 Server SQL
AUDIT (Schema Objects)^15^ Reference.
AUDIT (Schema Objects)^16^ 
CLOSE (Embedded SQL)^1^ 
CLOSE (Embedded SQL)^2^ CLOSE (Embedded SQL)
CLOSE (Embedded SQL)^3^ --------------------
CLOSE (Embedded SQL)^4^ 
CLOSE (Embedded SQL)^5^ Use this command to disable a cursor, freeing the resources acquired
CLOSE (Embedded SQL)^6^ by opening the cursor, and releasing parse locks.
CLOSE (Embedded SQL)^7^ 
CLOSE (Embedded SQL)^8^ EXEC SQL CLOSE cursor
CLOSE (Embedded SQL)^9^ 
CLOSE (Embedded SQL)^10^ For detailed information on this command, see the Oracle8 Server SQL
CLOSE (Embedded SQL)^11^ Reference.
CLOSE (Embedded SQL)^12^ 
COMMENT^1^ 
COMMENT^2^ COMMENT
COMMENT^3^ -------
COMMENT^4^ 
COMMENT^5^ Use this command to add a comment about a table, view, snapshot, or
COMMENT^6^ column into the data dictionary.
COMMENT^7^ 
COMMENT^8^ COMMENT ON
COMMENT^9^   { TABLE [schema.]{table | view | snapshot}
COMMENT^10^   | COLUMN [schema.]{ table.column
COMMENT^11^                      | view.column
COMMENT^12^                      | snapshot.column} } IS 'text'
COMMENT^13^ 
COMMENT^14^ For detailed information on this command, see the Oracle8 Server SQL
COMMENT^15^ Reference.
COMMENT^16^ 
COMMIT^1^ 
COMMIT^2^ COMMIT
COMMIT^3^ ------
COMMIT^4^ 
COMMIT^5^ Use this command to end your current transaction and make permanent
COMMIT^6^ all changes performed in the transaction. This command also erases
COMMIT^7^ all savepoints in the transaction and releases the transaction's
COMMIT^8^ locks.
COMMIT^9^ 
COMMIT^10^ You can also use this command to manually commit an in-doubt
COMMIT^11^ distributed transaction.
COMMIT^12^ 
COMMIT^13^ COMMIT [WORK] [COMMENT 'text' | FORCE 'text' [, integer] ]
COMMIT^14^ 
COMMIT^15^ For detailed information on this command, see the Oracle8 Server SQL
COMMIT^16^ Reference.
COMMIT^17^ 
COMMIT (Embedded SQL)^1^ 
COMMIT (Embedded SQL)^2^ COMMIT (Embedded SQL)
COMMIT (Embedded SQL)^3^ ---------------------
COMMIT (Embedded SQL)^4^ 
COMMIT (Embedded SQL)^5^ Use this command to end your current transaction, making permanent
COMMIT (Embedded SQL)^6^ all its changes to the database and optionally freeing all resources
COMMIT (Embedded SQL)^7^ and disconnecting from Oracle.
COMMIT (Embedded SQL)^8^ 
COMMIT (Embedded SQL)^9^ EXEC SQL [AT {db_name | :host_variable} ]
COMMIT (Embedded SQL)^10^ COMMIT [WORK] [{ [COMMENT 'text'] [RELEASE]
COMMIT (Embedded SQL)^11^                | FORCE 'text' [, integer] }]
COMMIT (Embedded SQL)^12^ 
COMMIT (Embedded SQL)^13^ For detailed information on this command, see the Oracle8 Server SQL
COMMIT (Embedded SQL)^14^ Reference.
COMMIT (Embedded SQL)^15^ 
CONNECT (Embedded SQL)^1^ 
CONNECT (Embedded SQL)^2^ CONNECT (Embedded SQL)
CONNECT (Embedded SQL)^3^ ----------------------
CONNECT (Embedded SQL)^4^ 
CONNECT (Embedded SQL)^5^ Use this command to log on to an Oracle database.
CONNECT (Embedded SQL)^6^ 
CONNECT (Embedded SQL)^7^ EXEC SQL CONNECT {:user IDENTIFIED BY :password | :user_password}
CONNECT (Embedded SQL)^8^   [ [AT {db_name | :host_variable} ] USING :dbstring]
CONNECT (Embedded SQL)^9^ 
CONNECT (Embedded SQL)^10^ For detailed information on this command, see the Oracle8 Server SQL
CONNECT (Embedded SQL)^11^ Reference.
CONNECT (Embedded SQL)^12^ 
CONSTRAINT clause^1^ 
CONSTRAINT clause^2^ CONSTRAINT clause
CONSTRAINT clause^3^ -----------------
CONSTRAINT clause^4^ 
CONSTRAINT clause^5^ Use this command to define an integrity constraint. An integrity
CONSTRAINT clause^6^ constraint is a rule that restricts the values for one or more
CONSTRAINT clause^7^ columns in a table or an index-only table.
CONSTRAINT clause^8^ 
CONSTRAINT clause^9^ table_constraint
CONSTRAINT clause^10^   [CONSTRAINT constraint]
CONSTRAINT clause^11^     { {UNIQUE | PRIMARY KEY} (column [, column] ...)
CONSTRAINT clause^12^     | FOREIGN KEY (column [, column] ...)
CONSTRAINT clause^13^     | REFERENCES [schema.]table [(column [column] ...) ]
CONSTRAINT clause^14^      [ON DELETE CASCADE]
CONSTRAINT clause^15^     | CHECK (condition) }
CONSTRAINT clause^16^     [ [ [NOT] DEFERRABLE ] [INITIALLY [IMMEDIATE | DEFERRED]] ]
CONSTRAINT clause^17^   | [ [INITIALLY [IMMEDIATE | DEFERRED]] [ [NOT] DEFERRABLE ] ]
CONSTRAINT clause^18^     [ { USING INDEX [ physical_attributes_clause
CONSTRAINT clause^19^                     | NOSORT
CONSTRAINT clause^20^                     | {LOGGING | NOLOGGING} ] ... [ EXCEPTIONS INTO
CONSTRAINT clause^21^                                                     [schema.]table]
CONSTRAINT clause^22^       | DISABLE}]
CONSTRAINT clause^23^ 
CONSTRAINT clause^24^ column_constraint
CONSTRAINT clause^25^   [CONSTRAINT constraint]
CONSTRAINT clause^26^     { [NOT] NULL
CONSTRAINT clause^27^     | {UNIQUE | PRIMARY KEY}
CONSTRAINT clause^28^     | REFERENCES [schema.]table [(column)] [ON DELETE CASCADE]
CONSTRAINT clause^29^     | CHECK (condition)}
CONSTRAINT clause^30^     [ [ [NOT] DEFERRABLE ] [INITIALLY [IMMEDIATE | DEFERRED]] ]
CONSTRAINT clause^31^   | [ [INITIALLY [IMMEDIATE | DEFERRED]] [ [NOT] DEFERRABLE ] ]
CONSTRAINT clause^32^     [ { USING INDEX [ physical_attributes_clause
CONSTRAINT clause^33^                     | NOSORT
CONSTRAINT clause^34^                     | {LOGGING | NOLOGGING} ] ...] [ EXCEPTIONS INTO
CONSTRAINT clause^35^                                                      [schema.]table]
CONSTRAINT clause^36^       | DISABLE}]
CONSTRAINT clause^37^ 
CONSTRAINT clause^38^ For detailed information on this command, see the Oracle8 Server SQL
CONSTRAINT clause^39^ Reference.
CONSTRAINT clause^40^ 
CREATE CLUSTER^1^ 
CREATE CLUSTER^2^ CREATE CLUSTER
CREATE CLUSTER^3^ --------------
CREATE CLUSTER^4^ 
CREATE CLUSTER^5^ Use this command to create a cluster. A cluster is a schema object
CREATE CLUSTER^6^ that contains one or more tables that all have one or more columns
CREATE CLUSTER^7^ in common.
CREATE CLUSTER^8^ 
CREATE CLUSTER^9^ CREATE CLUSTER [schema.]cluster (column datatype
CREATE CLUSTER^10^        [, column datatype] ...)
CREATE CLUSTER^11^   [ PCTUSED integer
CREATE CLUSTER^12^   | PCTFREE integer
CREATE CLUSTER^13^   | INITRANS integer
CREATE CLUSTER^14^   | MAXTRANS integer
CREATE CLUSTER^15^   | SIZE integer [K | M]
CREATE CLUSTER^16^   | TABLESPACE tablespace
CREATE CLUSTER^17^   | STORAGE storage_clause
CREATE CLUSTER^18^   | {INDEX | HASHKEYS integer [HASH IS expr] } ] ...
CREATE CLUSTER^19^   [PARALLEL parallel_clause]
CREATE CLUSTER^20^   [CACHE | NOCACHE]
CREATE CLUSTER^21^ 
CREATE CLUSTER^22^ For detailed information on this command, see the Oracle8 Server SQL
CREATE CLUSTER^23^ Reference.
CREATE CLUSTER^24^ 
CREATE CONTROLFILE^1^ 
CREATE CONTROLFILE^2^ CREATE CONTROLFILE
CREATE CONTROLFILE^3^ ------------------
CREATE CONTROLFILE^4^ 
CREATE CONTROLFILE^5^ Use this command to recreate a control file in one of the following
CREATE CONTROLFILE^6^ cases:
CREATE CONTROLFILE^7^ 
CREATE CONTROLFILE^8^   *  All copies of your existing control files have been lost
CREATE CONTROLFILE^9^      through media failure.
CREATE CONTROLFILE^10^   *  You want to change the name of the database.
CREATE CONTROLFILE^11^ 
CREATE CONTROLFILE^12^ You want to change the maximum number of redo log file groups, redo
CREATE CONTROLFILE^13^ log file members, archived redo log files, data files, or instances
CREATE CONTROLFILE^14^ that can concurrently have the database mounted and open.
CREATE CONTROLFILE^15^ 
CREATE CONTROLFILE^16^ Warning: It is recommended that you perform a full backup of all
CREATE CONTROLFILE^17^ files in the database before using this command.
CREATE CONTROLFILE^18^ 
CREATE CONTROLFILE^19^ CREATE CONTROLFILE [REUSE] [SET] DATABASE database
CREATE CONTROLFILE^20^ LOGFILE [GROUP integer] filespec
CREATE CONTROLFILE^21^      [, [GROUP integer] filespec] ... {RESETLOGS | NORESETLOGS}
CREATE CONTROLFILE^22^ DATAFILE filespec [, filespec] ... [ MAXLOGFILES integer
CREATE CONTROLFILE^23^                                    | MAXLOGMEMBERS integer
CREATE CONTROLFILE^24^                                    | MAXLOGHISTORY integer
CREATE CONTROLFILE^25^                                    | MAXDATAFILES integer
CREATE CONTROLFILE^26^                                    | MAXINSTANCES integer
CREATE CONTROLFILE^27^                                    | {ARCHIVELOG | NOARCHIVELOG} ] ...
CREATE CONTROLFILE^28^ 
CREATE CONTROLFILE^29^ For detailed information on this command, see the Oracle8 Server SQL
CREATE CONTROLFILE^30^ Reference.
CREATE CONTROLFILE^31^ 
CREATE DATABASE^1^ 
CREATE DATABASE^2^ CREATE DATABASE
CREATE DATABASE^3^ ---------------
CREATE DATABASE^4^ 
CREATE DATABASE^5^ Use this command to create a database, making it available for
CREATE DATABASE^6^ general use, with the following options:
CREATE DATABASE^7^ 
CREATE DATABASE^8^   *  to establish a maximum number of instances, data files, redo
CREATE DATABASE^9^      log files groups, or redo log file members
CREATE DATABASE^10^   *  to specify names and sizes of data files and redo log files
CREATE DATABASE^11^   *  to choose a mode of use for the redo log
CREATE DATABASE^12^   *  to specify the national and database character sets
CREATE DATABASE^13^ 
CREATE DATABASE^14^ Warning: This command prepares a database for initial use and erases
CREATE DATABASE^15^ any data currently in the specified files. Only use this command
CREATE DATABASE^16^ when you understand its ramifications.
CREATE DATABASE^17^ 
CREATE DATABASE^18^ CREATE DATABASE [database]
CREATE DATABASE^19^   { CONTROLFILE REUSE
CREATE DATABASE^20^   | LOGFILE [GROUP integer] filespec
CREATE DATABASE^21^           [,[GROUP integer] filespec] ...
CREATE DATABASE^22^   | MAXLOGFILES integer
CREATE DATABASE^23^   | MAXLOGMEMBERS integer
CREATE DATABASE^24^   | MAXLOGHISTORY integer
CREATE DATABASE^25^   | MAXDATAFILES integer
CREATE DATABASE^26^   | MAXINSTANCES integer
CREATE DATABASE^27^   | {ARCHIVELOG | NOARCHIVELOG}
CREATE DATABASE^28^   | EXCLUSIVE
CREATE DATABASE^29^   | CHARACTER SET charset
CREATE DATABASE^30^   | NATIONAL CHARACTER SET charset
CREATE DATABASE^31^   | DATAFILE filespec [AUTOEXTEND {OFF | ON [NEXT integer [K | M] ]
CREATE DATABASE^32^                       [MAXSIZE { UNLIMITED | integer [K | M]} ] } ]
CREATE DATABASE^33^           [, filespec [AUTOEXTEND {OFF | ON [NEXT integer [K | M] ]
CREATE DATABASE^34^                       [MAXSIZE { UNLIMITED | integer [K | M]} ] } ] ] ...} ...
CREATE DATABASE^35^ 
CREATE DATABASE^36^ For detailed information on this command, see the Oracle8 Server SQL
CREATE DATABASE^37^ Reference.
CREATE DATABASE^38^ 
CREATE DATABASE LINK^1^ 
CREATE DATABASE LINK^2^ CREATE DATABASE LINK
CREATE DATABASE LINK^3^ --------------------
CREATE DATABASE LINK^4^ 
CREATE DATABASE LINK^5^ Use this command to create a database link. A database link is a
CREATE DATABASE LINK^6^ schema object in the local database that allows you to access
CREATE DATABASE LINK^7^ objects on a remote database or to mount a secondary database in
CREATE DATABASE LINK^8^ read-only mode. The remote database can be either an Oracle or a
CREATE DATABASE LINK^9^ non-Oracle system.
CREATE DATABASE LINK^10^ 
CREATE DATABASE LINK^11^ CREATE [PUBLIC] DATABASE LINK dblink
CREATE DATABASE LINK^12^   [CONNECT TO user IDENTIFIED BY password]
CREATE DATABASE LINK^13^   [USING 'connect_string']
CREATE DATABASE LINK^14^ 
CREATE DATABASE LINK^15^ For detailed information on this command, see the Oracle8 Server SQL
CREATE DATABASE LINK^16^ Reference.
CREATE DATABASE LINK^17^ 
CREATE DIRECTORY^1^ 
CREATE DIRECTORY^2^ CREATE DIRECTORY
CREATE DIRECTORY^3^ ----------------
CREATE DIRECTORY^4^ 
CREATE DIRECTORY^5^ Use CREATE DIRECTORY to create a schema object (directory), which
CREATE DIRECTORY^6^ represents an operating system directory for administering access
CREATE DIRECTORY^7^ to, and the use of, BFILEs stored outside the database. A directory
CREATE DIRECTORY^8^ is an alias for a directory name on the server's file system where
CREATE DIRECTORY^9^ the files are actually located.
CREATE DIRECTORY^10^ 
CREATE DIRECTORY^11^ CREATE [OR REPLACE] DIRECTORY directory AS 'path_name'
CREATE DIRECTORY^12^ 
CREATE DIRECTORY^13^ For detailed information on this command, see the Oracle8 Server SQL
CREATE DIRECTORY^14^ Reference.
CREATE DIRECTORY^15^ 
CREATE FUNCTION^1^ 
CREATE FUNCTION^2^ CREATE FUNCTION
CREATE FUNCTION^3^ ---------------
CREATE FUNCTION^4^ 
CREATE FUNCTION^5^ Use this command to create a user function or to register an
CREATE FUNCTION^6^ external function.
CREATE FUNCTION^7^ 
CREATE FUNCTION^8^ A user function or stored function is a set of PL/SQL statements you
CREATE FUNCTION^9^ can call by name. Stored functions are very similar to procedures,
CREATE FUNCTION^10^ except that a function returns a value to the environment in which
CREATE FUNCTION^11^ it is called. User functions can be used as part of a SQL
CREATE FUNCTION^12^ expression.
CREATE FUNCTION^13^ 
CREATE FUNCTION^14^ An external function is a third generation language (3GL) routine
CREATE FUNCTION^15^ stored in a shared library which can be called from SQL or PL/SQL.
CREATE FUNCTION^16^ To call an external function, you must provide information in your
CREATE FUNCTION^17^ PL/SQL function about where to find the external function, how to
CREATE FUNCTION^18^ call it, and what to pass to it.
CREATE FUNCTION^19^ 
CREATE FUNCTION^20^ CREATE [OR REPLACE] FUNCTION [schema.]function
CREATE FUNCTION^21^   [(argument [IN | OUT | IN OUT] datatype
CREATE FUNCTION^22^   [, argument [IN | OUT | IN OUT] datatype] ...)]
CREATE FUNCTION^23^ RETURN datatype {IS | AS} pl/sql_subprogram_body
CREATE FUNCTION^24^   | external_body
CREATE FUNCTION^25^ 
CREATE FUNCTION^26^ external_body
CREATE FUNCTION^27^   EXTERNAL LIBRARY [schema.]library_name
CREATE FUNCTION^28^   [NAME external_proc_name]
CREATE FUNCTION^29^   [LANGUAGE language_name]
CREATE FUNCTION^30^   [CALLING STANDARD [C | PASCAL] ]
CREATE FUNCTION^31^   PARAMETERS (external_parameter_list) [WITH CONTEXT]
CREATE FUNCTION^32^ 
CREATE FUNCTION^33^ external_parameter_list
CREATE FUNCTION^34^   { { parameter_name [property]
CREATE FUNCTION^35^     | RETURN property }
CREATE FUNCTION^36^     [BY REF]
CREATE FUNCTION^37^     [external_datatype]
CREATE FUNCTION^38^     | CONTEXT }
CREATE FUNCTION^39^   [,{ parameter_name [property]
CREATE FUNCTION^40^     | RETURN property } [BY REF] [external_datatype]] ...
CREATE FUNCTION^41^ 
CREATE FUNCTION^42^ property
CREATE FUNCTION^43^   INDICATOR | LENGTH | MAXLEN | CHARSETID | CHARSETFORM
CREATE FUNCTION^44^ 
CREATE FUNCTION^45^ For detailed information on this command, see the Oracle8 Server SQL
CREATE FUNCTION^46^ Reference.
CREATE FUNCTION^47^ 
CREATE INDEX^1^ 
CREATE INDEX^2^ CREATE INDEX
CREATE INDEX^3^ ------------
CREATE INDEX^4^ 
CREATE INDEX^5^ Use this command to create an index on:
CREATE INDEX^6^ 
CREATE INDEX^7^   *  one or more columns of a table, a partitioned table, or a
CREATE INDEX^8^      cluster
CREATE INDEX^9^   *  one or more scalar typed object attributes of a table or a
CREATE INDEX^10^      cluster
CREATE INDEX^11^   *  a nested table storage table for indexing a nested table column
CREATE INDEX^12^ 
CREATE INDEX^13^ An index is a schema object that contains an entry for each value
CREATE INDEX^14^ that appears in the indexed column(s) of the table or cluster and
CREATE INDEX^15^ provides direct, fast access to rows. A partitioned index consists
CREATE INDEX^16^ of partitions containing an entry for each value that appears in the
CREATE INDEX^17^ indexed column(s) of the table.
CREATE INDEX^18^ 
CREATE INDEX^19^ CREATE [UNIQUE | BITMAP] INDEX [schema.]index
CREATE INDEX^20^ ON { [schema.]table ( column [ASC | DESC]
CREATE INDEX^21^                     [, column [ASC | DESC] ] ...)
CREATE INDEX^22^    | CLUSTER [schema.]cluster}
CREATE INDEX^23^    [ physical_attributes_clause
CREATE INDEX^24^    | {LOGGING | NOLOGGING}
CREATE INDEX^25^    | {TABLESPACE tablespace | DEFAULT}
CREATE INDEX^26^    | {NOSORT | REVERSE} ] ...
CREATE INDEX^27^    [ GLOBAL PARTITION BY RANGE (column_list)
CREATE INDEX^28^      ( PARTITION [partition_name]
CREATE INDEX^29^      | VALUES LESS THAN (value_list)
CREATE INDEX^30^      [ physical_attributes_clause
CREATE INDEX^31^      | {LOGGING | NOLOGGING} ], ...)
CREATE INDEX^32^    | LOCAL [(PARTITION [partition_name]
CREATE INDEX^33^      [ physical_attributes_clause
CREATE INDEX^34^      | {LOGGING | NOLOGGING} ], ...) ] ]
CREATE INDEX^35^    [ PARALLEL parallel_clause ]
CREATE INDEX^36^ 
CREATE INDEX^37^ physical_attributes_clause
CREATE INDEX^38^   [ PCTFREE integer
CREATE INDEX^39^   | PCTUSED integer
CREATE INDEX^40^   | INITRANS integer
CREATE INDEX^41^   | MAXTRANS integer
CREATE INDEX^42^   | STORAGE storage_clause ]
CREATE INDEX^43^ 
CREATE INDEX^44^ For detailed information on this command, see the Oracle8 Server SQL
CREATE INDEX^45^ Reference.
CREATE INDEX^46^ 
CREATE LIBRARY^1^ 
CREATE LIBRARY^2^ CREATE LIBRARY
CREATE LIBRARY^3^ --------------
CREATE LIBRARY^4^ 
CREATE LIBRARY^5^ Use CREATE LIBRARY to create a schema object (library), which
CREATE LIBRARY^6^ represents an operating-system shared library, from which SQL and
CREATE LIBRARY^7^ PL/SQL can call external 3GL functions and procedures.
CREATE LIBRARY^8^ 
CREATE LIBRARY^9^ CREATE [OR REPLACE] LIBRARY [schema.]libname {IS|AS} 'filespec'
CREATE LIBRARY^10^ 
CREATE LIBRARY^11^ For detailed information on this command, see the Oracle8 Server SQL
CREATE LIBRARY^12^ Reference.
CREATE LIBRARY^13^ 
CREATE PACKAGE^1^ 
CREATE PACKAGE^2^ CREATE PACKAGE
CREATE PACKAGE^3^ --------------
CREATE PACKAGE^4^ 
CREATE PACKAGE^5^ Use this command to create the specification for a stored package. A
CREATE PACKAGE^6^ package is an encapsulated collection of related procedures,
CREATE PACKAGE^7^ functions, and other program objects stored together in the
CREATE PACKAGE^8^ database. The specification declares these objects.
CREATE PACKAGE^9^ 
CREATE PACKAGE^10^ CREATE [OR REPLACE] PACKAGE [schema.]package
CREATE PACKAGE^11^   {IS | AS} pl/sql_package_spec
CREATE PACKAGE^12^ 
CREATE PACKAGE^13^ For detailed information on this command, see the Oracle8 Server SQL
CREATE PACKAGE^14^ Reference.
CREATE PACKAGE^15^ 
CREATE PACKAGE BODY^1^ 
CREATE PACKAGE BODY^2^ CREATE PACKAGE BODY
CREATE PACKAGE BODY^3^ -------------------
CREATE PACKAGE BODY^4^ 
CREATE PACKAGE BODY^5^ Use this command to create the body of a stored package. A package
CREATE PACKAGE BODY^6^ is an encapsulated collection of related procedures, stored
CREATE PACKAGE BODY^7^ functions, and other program objects stored together in the
CREATE PACKAGE BODY^8^ database. 
CREATE PACKAGE BODY^9^
CREATE PACKAGE BODY^10^ The body defines these objects.
CREATE PACKAGE BODY^11^ 
CREATE PACKAGE BODY^12^ CREATE [OR REPLACE] PACKAGE BODY [schema.]package
CREATE PACKAGE BODY^13^   {IS | AS} pl_sql_package_body
CREATE PACKAGE BODY^14^ 
CREATE PACKAGE BODY^15^ For detailed information on this command, see the Oracle8 Server SQL
CREATE PACKAGE BODY^16^ Reference.
CREATE PACKAGE BODY^17^ 
CREATE PROCEDURE^1^ 
CREATE PROCEDURE^2^ CREATE PROCEDURE
CREATE PROCEDURE^3^ ----------------
CREATE PROCEDURE^4^ 
CREATE PROCEDURE^5^ Use this command to create a stand-alone stored procedure or to
CREATE PROCEDURE^6^ register an external procedure. A procedure is a group of PL/SQL
CREATE PROCEDURE^7^ statements that you can call by name.
CREATE PROCEDURE^8^ 
CREATE PROCEDURE^9^ An external procedure is a third generation language (3GL) routine
CREATE PROCEDURE^10^ stored in a shared library which can be called from SQL or PL/SQL.
CREATE PROCEDURE^11^ To call an external procedure, you must provide information in your
CREATE PROCEDURE^12^ PL/SQL function about where to find the external procedure, how to
CREATE PROCEDURE^13^ call it, and what to pass to it.
CREATE PROCEDURE^14^ 
CREATE PROCEDURE^15^ CREATE [OR REPLACE] PROCEDURE [schema.]procedure
CREATE PROCEDURE^16^        [ (argument [IN | OUT | IN OUT] datatype
CREATE PROCEDURE^17^        [, argument [IN | OUT | IN OUT] datatype] ...) ]
CREATE PROCEDURE^18^        {IS|AS} {pl/sql_subprogram_body | external_body}
CREATE PROCEDURE^19^ 
CREATE PROCEDURE^20^ external_body
CREATE PROCEDURE^21^   EXTERNAL LIBRARY [schema.]library_name
CREATE PROCEDURE^22^   [NAME external_proc_name]
CREATE PROCEDURE^23^   [LANGUAGE language_name]
CREATE PROCEDURE^24^   [CALLING STANDARD [C | PASCAL] ]
CREATE PROCEDURE^25^   PARAMETERS (external_parameter_list) [WITH CONTEXT]
CREATE PROCEDURE^26^ 
CREATE PROCEDURE^27^ external_parameter_list
CREATE PROCEDURE^28^   { { parameter_name [property]
CREATE PROCEDURE^29^     | RETURN property }
CREATE PROCEDURE^30^     [ BY REF]
CREATE PROCEDURE^31^     [ external_datatype]
CREATE PROCEDURE^32^     | CONTEXT }
CREATE PROCEDURE^33^   [,{ parameter_name [property]
CREATE PROCEDURE^34^     | RETURN property }
CREATE PROCEDURE^35^     [BY REF]
CREATE PROCEDURE^36^     [external_datatype] ] ...
CREATE PROCEDURE^37^ 
CREATE PROCEDURE^38^ property
CREATE PROCEDURE^39^   INDICATOR | LENGTH | MAXLEN | CHARSETID | CHARSETFORM
CREATE PROCEDURE^40^ 
CREATE PROCEDURE^41^ For detailed information on this command, see the Oracle8 Server SQL
CREATE PROCEDURE^42^ Reference.
CREATE PROCEDURE^43^ 
CREATE PROFILE^1^ 
CREATE PROFILE^2^ CREATE PROFILE
CREATE PROFILE^3^ --------------
CREATE PROFILE^4^ 
CREATE PROFILE^5^ Use this command to create a profile. A profile is a set of limits
CREATE PROFILE^6^ on database resources. If you assign the profile to a user, that
CREATE PROFILE^7^ user cannot exceed these limits.
CREATE PROFILE^8^ 
CREATE PROFILE^9^ CREATE PROFILE profile LIMIT
CREATE PROFILE^10^   { { SESSION_PER_USER
CREATE PROFILE^11^     | CPU_PER_SESSION
CREATE PROFILE^12^     | CPU_PER_CALL
CREATE PROFILE^13^     | CONNECT_TIME
CREATE PROFILE^14^     | IDLE_TIME
CREATE PROFILE^15^     | LOGICAL_READS_PER_SESSION
CREATE PROFILE^16^     | LOGICAL_READS_PER_CALL
CREATE PROFILE^17^     | COMPOSITE_LIMIT}
CREATE PROFILE^18^   { integer | UNLIMITED | DEFAULT}
CREATE PROFILE^19^   | { PRIVATE_SGA { integer [K | M] | UNLIMITED | DEFAULT} }
CREATE PROFILE^20^   | FAILED_LOGIN_ATTEMPTS
CREATE PROFILE^21^   | PASSWORD_LIFETIME
CREATE PROFILE^22^   | {PASSWORD_REUSE_TIME | PASSWORD_REUSE_MAX}
CREATE PROFILE^23^   | ACCOUNT_LOCK_TIME
CREATE PROFILE^24^   | PASSWORD_GRACE_TIME
CREATE PROFILE^25^   { integer | UNLIMITED | DEFAULT}
CREATE PROFILE^26^   | PASSWORD_VERIFY_FUNCTION
CREATE PROFILE^27^   { function | NULL | DEFAULT} }...
CREATE PROFILE^28^ 
CREATE PROFILE^29^ For detailed information on this command, see the Oracle8 Server SQL
CREATE PROFILE^30^ Reference.
CREATE PROFILE^31^ 
CREATE ROLE^1^ 
CREATE ROLE^2^ CREATE ROLE
CREATE ROLE^3^ -----------
CREATE ROLE^4^ 
CREATE ROLE^5^ Use this command to create a role. A role is a set of privileges
CREATE ROLE^6^ that can be granted to users or to other roles.
CREATE ROLE^7^ 
CREATE ROLE^8^ CREATE ROLE role [NOT IDENTIFIED | IDENTIFIED {BY password | 
CREATE ROLE^9^   EXTERNALLY | GLOBALLY} ]
CREATE ROLE^10^ 
CREATE ROLE^11^ For detailed information on this command, see the Oracle8 Server SQL
CREATE ROLE^12^ Reference.
CREATE ROLE^13^ 
CREATE ROLLBACK SEGMENT^1^ 
CREATE ROLLBACK SEGMENT^2^ CREATE ROLLBACK SEGMENT
CREATE ROLLBACK SEGMENT^3^ -----------------------
CREATE ROLLBACK SEGMENT^4^ 
CREATE ROLLBACK SEGMENT^5^ Use this command to create a rollback segment. A rollback segment is
CREATE ROLLBACK SEGMENT^6^ an object that Oracle uses to store data necessary to reverse, or
CREATE ROLLBACK SEGMENT^7^ undo, changes made by transactions.
CREATE ROLLBACK SEGMENT^8^ 
CREATE ROLLBACK SEGMENT^9^ CREATE [PUBLIC] ROLLBACK SEGMENT rollback_segment
CREATE ROLLBACK SEGMENT^10^   [ TABLESPACE tablespace
CREATE ROLLBACK SEGMENT^11^   | STORAGE storage_clause
CREATE ROLLBACK SEGMENT^12^   | OPTIMAL [ TO integer [K | M]
CREATE ROLLBACK SEGMENT^13^             | NULL] ] ...
CREATE ROLLBACK SEGMENT^14^ 
CREATE ROLLBACK SEGMENT^15^ For detailed information on this command, see the Oracle8 Server SQL
CREATE ROLLBACK SEGMENT^16^ Reference.
CREATE ROLLBACK SEGMENT^17^ 
CREATE SCHEMA^1^ 
CREATE SCHEMA^2^ CREATE SCHEMA
CREATE SCHEMA^3^ -------------
CREATE SCHEMA^4^ 
CREATE SCHEMA^5^ Use this command to create multiple tables and views and perform
CREATE SCHEMA^6^ multiple grants in a single transaction.
CREATE SCHEMA^7^ 
CREATE SCHEMA^8^ CREATE SCHEMA AUTHORIZATION schema
CREATE SCHEMA^9^   { CREATE TABLE command
CREATE SCHEMA^10^   | CREATE VIEW command
CREATE SCHEMA^11^   | GRANT command} ...
CREATE SCHEMA^12^ 
CREATE SCHEMA^13^ For detailed information on this command, see the Oracle8 Server SQL
CREATE SCHEMA^14^ Reference.
CREATE SCHEMA^15^ 
CREATE SEQUENCE^1^ 
CREATE SEQUENCE^2^ CREATE SEQUENCE
CREATE SEQUENCE^3^ ---------------
CREATE SEQUENCE^4^ 
CREATE SEQUENCE^5^ Use this command to create a sequence. A sequence is a database
CREATE SEQUENCE^6^ object from which multiple users may generate unique integers. You
CREATE SEQUENCE^7^ can use sequences to automatically generate primary key values.
CREATE SEQUENCE^8^ 
CREATE SEQUENCE^9^ CREATE SEQUENCE [schema.]sequence
CREATE SEQUENCE^10^   [ INCREMENT BY integer
CREATE SEQUENCE^11^   | START WITH integer
CREATE SEQUENCE^12^   | {MAXVALUE integer | NOMAXVALUE}
CREATE SEQUENCE^13^   | {MINVALUE integer | NOMINVALUE}
CREATE SEQUENCE^14^   | {CYCLE | NOCYCLE}
CREATE SEQUENCE^15^   | {CACHE integer | NOCACHE}
CREATE SEQUENCE^16^   | {ORDER | NOORDER} ] ...
CREATE SEQUENCE^17^ 
CREATE SEQUENCE^18^ For detailed information on this command, see the Oracle8 Server SQL
CREATE SEQUENCE^19^ Reference.
CREATE SEQUENCE^20^ 
CREATE SNAPSHOT^1^ 
CREATE SNAPSHOT^2^ CREATE SNAPSHOT
CREATE SNAPSHOT^3^ ---------------
CREATE SNAPSHOT^4^ 
CREATE SNAPSHOT^5^ Use this command to create a snapshot. A snapshot is a table that
CREATE SNAPSHOT^6^ contains the results of a query of one or more tables or views,
CREATE SNAPSHOT^7^ often located on a remote database.
CREATE SNAPSHOT^8^ 
CREATE SNAPSHOT^9^ CREATE SNAPSHOT [schema.]snapshot
CREATE SNAPSHOT^10^   { { PCTFREE integer
CREATE SNAPSHOT^11^     | PCTUSED integer
CREATE SNAPSHOT^12^     | INITRANS integer
CREATE SNAPSHOT^13^     | MAXTRANS integer
CREATE SNAPSHOT^14^     | TABLESPACE tablespace
CREATE SNAPSHOT^15^     | STORAGE storage_clause}
CREATE SNAPSHOT^16^   | CLUSTER cluster (column [, column] ...) } ...
CREATE SNAPSHOT^17^   [ USING  {INDEX [ PCTFREE integer
CREATE SNAPSHOT^18^                   | PCTUSED integer
CREATE SNAPSHOT^19^                   | INITRANS integer
CREATE SNAPSHOT^20^                   | MAXTRANS integer ]
CREATE SNAPSHOT^21^                   | [DEFAULT] [MASTER | LOCAL] ROLLBACK SEGMENT
CREATE SNAPSHOT^22^                     [rollback_segment] } ]
CREATE SNAPSHOT^23^   [ REFRESH [FAST | COMPLETE | FORCE]
CREATE SNAPSHOT^24^     [ START WITH date]
CREATE SNAPSHOT^25^     [ NEXT date]
CREATE SNAPSHOT^26^     [ WITH {PRIMARY KEY | ROWID}] ]
CREATE SNAPSHOT^27^   [ FOR UPDATE] AS subquery
CREATE SNAPSHOT^28^ 
CREATE SNAPSHOT^29^ For detailed information on this command, see the Oracle8 Server SQL
CREATE SNAPSHOT^30^ Reference.
CREATE SNAPSHOT^31^ 
CREATE SNAPSHOT LOG^1^ 
CREATE SNAPSHOT LOG^2^ CREATE SNAPSHOT LOG
CREATE SNAPSHOT LOG^3^ -------------------
CREATE SNAPSHOT LOG^4^ 
CREATE SNAPSHOT LOG^5^ Use this command to create a snapshot log. A snapshot log is a table
CREATE SNAPSHOT LOG^6^ associated with the master table of a snapshot. Oracle stores
CREATE SNAPSHOT LOG^7^ changes to the master table's data in the snapshot log and then
CREATE SNAPSHOT LOG^8^ uses the snapshot log to refresh the master table's snapshots.
CREATE SNAPSHOT LOG^9^ 
CREATE SNAPSHOT LOG^10^ CREATE SNAPSHOT LOG ON [schema.]table
CREATE SNAPSHOT LOG^11^   [ WITH { [PRIMARY KEY]
CREATE SNAPSHOT LOG^12^            [,ROWID]
CREATE SNAPSHOT LOG^13^            [,(filter column)
CREATE SNAPSHOT LOG^14^            | ,(filter column) ...] }
CREATE SNAPSHOT LOG^15^   [ PCTFREE integer
CREATE SNAPSHOT LOG^16^   | PCTUSED integer
CREATE SNAPSHOT LOG^17^   | INITRANS integer
CREATE SNAPSHOT LOG^18^   | MAXTRANS integer
CREATE SNAPSHOT LOG^19^   | TABLESPACE tablespace
CREATE SNAPSHOT LOG^20^   | STORAGE storage_clause] ...
CREATE SNAPSHOT LOG^21^ 
CREATE SNAPSHOT LOG^22^ For detailed information on this command, see the Oracle8 Server SQL
CREATE SNAPSHOT LOG^23^ Reference.
CREATE SNAPSHOT LOG^24^ 
CREATE SYNONYM^1^ 
CREATE SYNONYM^2^ CREATE SYNONYM
CREATE SYNONYM^3^ --------------
CREATE SYNONYM^4^ 
CREATE SYNONYM^5^ Use this command to create a synonym. A synonym is an alternative
CREATE SYNONYM^6^ name for a table, view, sequence, procedure, stored function,
CREATE SYNONYM^7^ package, snapshot, or another synonym.
CREATE SYNONYM^8^ 
CREATE SYNONYM^9^ CREATE [PUBLIC] SYNONYM [schema.]synonym
CREATE SYNONYM^10^   FOR [schema.]object [@dblink]
CREATE SYNONYM^11^ 
CREATE SYNONYM^12^ For detailed information on this command, see the Oracle8 Server SQL
CREATE SYNONYM^13^ Reference.
CREATE SYNONYM^14^ 
CREATE TABLE^1^ 
CREATE TABLE^2^ CREATE TABLE
CREATE TABLE^3^ ------------
CREATE TABLE^4^ 
CREATE TABLE^5^ Use this command to create a table, the basic structure to hold user
CREATE TABLE^6^ data, specifying the following information:
CREATE TABLE^7^ 
CREATE TABLE^8^   *  column definitions
CREATE TABLE^9^   *  table organization definition
CREATE TABLE^10^   *  column definitions using objects
CREATE TABLE^11^   *  integrity constraints
CREATE TABLE^12^   *  the table's tablespace
CREATE TABLE^13^   *  storage characteristics
CREATE TABLE^14^   *  an optional cluster
CREATE TABLE^15^   *  data from an arbitrary query
CREATE TABLE^16^   *  degree of parallelism used to create the table and the default
CREATE TABLE^17^      degree of parallelism for queries on the table
CREATE TABLE^18^   *  partitioning definitions
CREATE TABLE^19^ 
CREATE TABLE^20^ Use CREATE TABLE to create an object table or a table that uses an
CREATE TABLE^21^ object type for a column definition. An object table is a table
CREATE TABLE^22^ explicitly defined to hold object instances of a particular type.
CREATE TABLE^23^ 
CREATE TABLE^24^ You can also create an object type and then use it in a column when
CREATE TABLE^25^ creating a relational table.
CREATE TABLE^26^ 
CREATE TABLE^27^ Relational table definition
CREATE TABLE^28^   CREATE TABLE [schema.]table
CREATE TABLE^29^     [ ( { column datatype [DEFAULT expr] [WITH ROWID]
CREATE TABLE^30^           [SCOPE IS [schema.]scope_table_name]
CREATE TABLE^31^           [column_constraint] ...
CREATE TABLE^32^         | table_constraint | REF (ref_column_name) WITH ROWID
CREATE TABLE^33^         | SCOPE FOR (ref_column_name) IS [schema.]scope_table_name }
CREATE TABLE^34^      [, { column datatype [DEFAULT expr] [WITH ROWID]
CREATE TABLE^35^           [SCOPE IS [schema.]scope_table_name]
CREATE TABLE^36^           [column_constraint] ...
CREATE TABLE^37^         | table_constraint | REF (ref_column_name) WITH ROWID
CREATE TABLE^38^         | SCOPE FOR (ref_column_name) IS
CREATE TABLE^39^           [schema.]scope_table_name} ] ...) ]
CREATE TABLE^40^     [ { [ ORGANIZATION {HEAP | INDEX}
CREATE TABLE^41^           | PCTTHRESHOLD [INCLUDING column_name]
CREATE TABLE^42^           [ OVERFLOW [physical_attributes_clause |
CREATE TABLE^43^             TABLESPACE tablespace] ...]
CREATE TABLE^44^         | physical_attributes_clause
CREATE TABLE^45^         | TABLESPACE tablespace
CREATE TABLE^46^           | LOB (lob_item [, lob_item ...] ) STORE AS
CREATE TABLE^47^             [lob_segname]
CREATE TABLE^48^           [ ( TABLESPACE tablespace
CREATE TABLE^49^             | STORAGE storage_clause
CREATE TABLE^50^             | CHUNK integer
CREATE TABLE^51^             | PCTVERSION integer
CREATE TABLE^52^             | CACHE
CREATE TABLE^53^             | NOCACHE LOGGING | NOCACHE NOLOGGING
CREATE TABLE^54^             | INDEX [lob_index_name]
CREATE TABLE^55^             [ ( TABLESPACE tablespace
CREATE TABLE^56^               |  STORAGE storage_clause
CREATE TABLE^57^               |  INITRANS integer
CREATE TABLE^58^               |  MAXTRANS integer ) ...] ) ]
CREATE TABLE^59^           | NESTED TABLE nested_item STORE AS storage_table
CREATE TABLE^60^           | {LOGGING | NOLOGGING} ] ...
CREATE TABLE^61^         | CLUSTER cluster (column [, column] ...) } ]
CREATE TABLE^62^       [ PARALLEL parallel_clause]
CREATE TABLE^63^       [ PARTITION BY RANGE (column_list)
CREATE TABLE^64^         ( PARTITION [partition_name] VALUES LESS THAN (value_list)
CREATE TABLE^65^           [ physical_attributes_clause
CREATE TABLE^66^           | TABLESPACE tablespace
CREATE TABLE^67^           | {LOGGING | NOLOGGING} ] ) ...]
CREATE TABLE^68^       [ ENABLE enable_clause | DISABLE disable_clause] ...
CREATE TABLE^69^         [AS subquery]
CREATE TABLE^70^         [CACHE | NOCACHE]
CREATE TABLE^71^ 
CREATE TABLE^72^ physical_attributes_clause
CREATE TABLE^73^   [ PCTFREE integer
CREATE TABLE^74^   | PCTUSED integer
CREATE TABLE^75^   | INITRANS integer
CREATE TABLE^76^   | MAXTRANS integer
CREATE TABLE^77^   | STORAGE storage_clause ]
CREATE TABLE^78^ 
CREATE TABLE^79^ Object table definition
CREATE TABLE^80^   CREATE TABLE [schema.]table OF [schema.]object_type
CREATE TABLE^81^     [ ( [ column | attribute [DEFAULT expr] [WITH ROWID]
CREATE TABLE^82^         [ SCOPE IS [schema.]scope_table_name]
CREATE TABLE^83^         [column_constraint] ...]
CREATE TABLE^84^       | table_constraint | REF (ref_column_name) WITH ROWID
CREATE TABLE^85^       | SCOPE FOR (ref_column_name) IS [schema.]scope_table_name
CREATE TABLE^86^       [, { column | attribute [DEFAULT expr] [WITH ROWID]
CREATE TABLE^87^          [ SCOPE IS [schema.]scope_table_name]
CREATE TABLE^88^          [column_constraint] ...
CREATE TABLE^89^          | table_constraint | REF (ref_column_name) WITH ROWID
CREATE TABLE^90^          | SCOPE FOR (ref_column_name) IS
CREATE TABLE^91^            [schema.]scope_table_name} ] ...) ]
CREATE TABLE^92^     [ OIDINDEX [index] [( physical_attributes_clause |
CREATE TABLE^93^            TABLESPACE tablespace) ...]
CREATE TABLE^94^       [ { [ physical_attributes_clause
CREATE TABLE^95^           | TABLESPACE tablespace
CREATE TABLE^96^           | LOB (lob_item [, lob_item ...]) STORE AS
CREATE TABLE^97^             [ lob_segname]
CREATE TABLE^98^             [ ( TABLESPACE tablespace
CREATE TABLE^99^               | STORAGE storage_clause
CREATE TABLE^100^               | CHUNK integer
CREATE TABLE^101^               | PCTVERSION integer
CREATE TABLE^102^               | CACHE
CREATE TABLE^103^               | NOCACHE LOGGING | NOCACHE NOLOGGING
CREATE TABLE^104^               | INDEX [lob_index_name]
CREATE TABLE^105^                 [ ( TABLESPACE tablespace
CREATE TABLE^106^                   |  STORAGE storage_clause
CREATE TABLE^107^                   |  INITRANS integer
CREATE TABLE^108^                   |  MAXTRANS integer ) ] ) ]
CREATE TABLE^109^           | NESTED TABLE nested_item STORE AS storage_table
CREATE TABLE^110^           | {LOGGING | NOLOGGING} ] ...
CREATE TABLE^111^         | CLUSTER cluster (column [, column] ...) } ]
CREATE TABLE^112^     [ PARALLEL parallel_clause]
CREATE TABLE^113^     [ ENABLE enable_clause | DISABLE disable_clause] ...
CREATE TABLE^114^     [ AS subquery]
CREATE TABLE^115^     [ CACHE | NOCACHE]
CREATE TABLE^116^ 
CREATE TABLE^117^ For detailed information on this command, see the Oracle8 Server SQL
CREATE TABLE^118^ Reference.
CREATE TABLE^119^ 
CREATE TABLESPACE^1^ 
CREATE TABLESPACE^2^ CREATE TABLESPACE
CREATE TABLESPACE^3^ -----------------
CREATE TABLESPACE^4^ 
CREATE TABLESPACE^5^ Use this command to create a tablespace. A tablespace is an
CREATE TABLESPACE^6^ allocation of space in the database that can contain schema objects.
CREATE TABLESPACE^7^ 
CREATE TABLESPACE^8^ CREATE TABLESPACE tablespace
CREATE TABLESPACE^9^ DATAFILE filespec
CREATE TABLESPACE^10^   [ AUTOEXTEND
CREATE TABLESPACE^11^     { OFF | ON
CREATE TABLESPACE^12^       [ NEXT integer [K | M] ]
CREATE TABLESPACE^13^       [ MAXSIZE
CREATE TABLESPACE^14^         { UNLIMITED | integer [K | M] } ] } ]
CREATE TABLESPACE^15^   [ LOGGING | NOLOGGING]
CREATE TABLESPACE^16^   [, filespec
CREATE TABLESPACE^17^     [ AUTOEXTEND
CREATE TABLESPACE^18^       { OFF | ON
CREATE TABLESPACE^19^         [ NEXT integer [K | M] ]
CREATE TABLESPACE^20^         [ MAXSIZE
CREATE TABLESPACE^21^           { UNLIMITED | integer [K | M] } ] } ] ]
CREATE TABLESPACE^22^   [LOGGING | NOLOGGING] ...
CREATE TABLESPACE^23^   [ MINIMUM EXTENT integer [K | M] ]
CREATE TABLESPACE^24^   [ DEFAULT STORAGE storage_clause
CREATE TABLESPACE^25^     | {ONLINE | OFFLINE}
CREATE TABLESPACE^26^     | {PERMANENT | TEMPORARY} ] ...
CREATE TABLESPACE^27^ 
CREATE TABLESPACE^28^ For detailed information on this command, see the Oracle8 Server SQL
CREATE TABLESPACE^29^ Reference.
CREATE TABLESPACE^30^ 
CREATE TRIGGER^1^ 
CREATE TRIGGER^2^ CREATE TRIGGER
CREATE TRIGGER^3^ --------------
CREATE TRIGGER^4^ 
CREATE TRIGGER^5^ Use this command to create and enable a database trigger. A database
CREATE TRIGGER^6^ trigger is a stored PL/SQL block that is associated with a table.
CREATE TRIGGER^7^ Oracle automatically executes a trigger when a specified SQL
CREATE TRIGGER^8^ statement is issued against the table.
CREATE TRIGGER^9^ 
CREATE TRIGGER^10^ CREATE [OR REPLACE] TRIGGER [schema.]trigger
CREATE TRIGGER^11^   {BEFORE | AFTER | INSTEAD OF}
CREATE TRIGGER^12^   { DELETE
CREATE TRIGGER^13^   | INSERT
CREATE TRIGGER^14^   | UPDATE [OF column [, column] ...] }
CREATE TRIGGER^15^   [ OR { DELETE
CREATE TRIGGER^16^        | INSERT
CREATE TRIGGER^17^        | UPDATE [OF column [, column] ... ] } ] ...
CREATE TRIGGER^18^   ON [schema.]{table | view}
CREATE TRIGGER^19^   [ [ REFERENCING { OLD [AS] old | NEW [AS] new} ...]
CREATE TRIGGER^20^     FOR EACH {ROW | STATMENT} [WHEN (condition) ] ] pl/sql_block
CREATE TRIGGER^21^ 
CREATE TRIGGER^22^ For detailed information on this command, see the Oracle8 Server SQL
CREATE TRIGGER^23^ Reference.
CREATE TRIGGER^24^ 
CREATE TYPE^1^ 
CREATE TYPE^2^ CREATE TYPE
CREATE TYPE^3^ -----------
CREATE TYPE^4^ 
CREATE TYPE^5^ Use the CREATE TYPE command to create an object type, named varying
CREATE TYPE^6^ array (VARRAY), nested table type, or an incomplete object type.
CREATE TYPE^7^ 
CREATE TYPE^8^ An incomplete object type is an object type created by a forward
CREATE TYPE^9^ type definition. It is called "incomplete" because it has a name but
CREATE TYPE^10^ no attributes or methods. However, it can be referenced by 
CREATE TYPE^11^ other object types, and so can be used to define object types that
CREATE TYPE^12^ refer to each other.
CREATE TYPE^13^ 
CREATE TYPE^14^ create_incomplete_object_type
CREATE TYPE^15^   CREATE [OR REPLACE] TYPE [schema.]type_name AS OBJECT;
CREATE TYPE^16^ 
CREATE TYPE^17^ create_varray_type
CREATE TYPE^18^   CREATE TYPE type_name AS {VARRAY | VARYING ARRAY} (limit) OF datatype;
CREATE TYPE^19^ 
CREATE TYPE^20^ create_nested_table_type
CREATE TYPE^21^   CREATE TYPE type_name AS TABLE OF datatype;
CREATE TYPE^22^ 
CREATE TYPE^23^ create_object_type_spec
CREATE TYPE^24^   CREATE [OR REPLACE] TYPE [schema.]type_name AS OBJECT
CREATE TYPE^25^  (
CREATE TYPE^26^     attribute_name  datatype[, attribute_name  datatype]...
CREATE TYPE^27^   | [ { MAP | ORDER} MEMBER function_specification]
CREATE TYPE^28^   | [ MEMBER {procedure_specification | function_specification}
CREATE TYPE^29^     [, MEMBER {procedure_specification |
CREATE TYPE^30^      function_specification}]... ]
CREATE TYPE^31^   | [ PRAGMA RESTRICT_REFERENCES (method_name, constraints)
CREATE TYPE^32^     [, PRAGMA RESTRICT_REFERENCES (method_name,
CREATE TYPE^33^        constraints)]... ]  );
CREATE TYPE^34^ 
CREATE TYPE^35^ constraints
CREATE TYPE^36^   {RNDS | WNDS | RNPS | WNPS} [, {RNDS | WNDS | RNPS | WNPS}]...
CREATE TYPE^37^ Note: any order, but no duplicates
CREATE TYPE^38^ 
CREATE TYPE^39^ datatype
CREATE TYPE^40^   { [REF] [schema.]object_type_name
CREATE TYPE^41^   | [schema.]type_name
CREATE TYPE^42^   | VARCHAR2(size)
CREATE TYPE^43^   | NUMBER [(precision[, scale])]
CREATE TYPE^44^   | DATE
CREATE TYPE^45^   | RAW(size)
CREATE TYPE^46^   | CHAR(size)
CREATE TYPE^47^   | CHARACTER(size)
CREATE TYPE^48^   | CHAR(size)
CREATE TYPE^49^   | CHARACTER VARYING(size)
CREATE TYPE^50^   | CHAR VARYING(size)
CREATE TYPE^51^   | VARCHAR(size)
CREATE TYPE^52^   | NUMERIC[(precision[, scale])]
CREATE TYPE^53^   | DECIMAL[(precision[, scale])]
CREATE TYPE^54^   | DEC[(precision[, scale])]
CREATE TYPE^55^   | INTEGER
CREATE TYPE^56^   | INT
CREATE TYPE^57^   | SMALLINT
CREATE TYPE^58^   | FLOAT[(size)]
CREATE TYPE^59^   | DOUBLE PRECISION
CREATE TYPE^60^   | REAL
CREATE TYPE^61^   | BLOB
CREATE TYPE^62^   | CLOB
CREATE TYPE^63^   | BFILE }
CREATE TYPE^64^ 
CREATE TYPE^65^ For detailed information on this command, see the Oracle8 Server SQL
CREATE TYPE^66^ Reference.
CREATE TYPE^67^ 
CREATE TYPE BODY^1^ 
CREATE TYPE BODY^2^ CREATE TYPE BODY
CREATE TYPE BODY^3^ ----------------
CREATE TYPE BODY^4^ 
CREATE TYPE BODY^5^ Use the CREATE TYPE BODY command to define or implement the member
CREATE TYPE BODY^6^ methods defined in the object type specification.
CREATE TYPE BODY^7^ 
CREATE TYPE BODY^8^ CREATE [OR REPLACE] TYPE BODY [schema.]type_name
CREATE TYPE BODY^9^   IS
CREATE TYPE BODY^10^     MEMBER {procedure_declaration | function_declaration};
CREATE TYPE BODY^11^     [ MEMBER {procedure_declaration | function_declaration}; ] ...
CREATE TYPE BODY^12^     [{MAP | ORDER} MEMBER function_declaration;]
CREATE TYPE BODY^13^   END;
CREATE TYPE BODY^14^ 
CREATE TYPE BODY^15^ For detailed information on this command, see the Oracle8 Server SQL
CREATE TYPE BODY^16^ Reference.
CREATE TYPE BODY^17^ 
CREATE USER^1^ 
CREATE USER^2^ CREATE USER
CREATE USER^3^ -----------
CREATE USER^4^ 
CREATE USER^5^ Use CREATE USER to create a database user, or an account through
CREATE USER^6^ which you can log in to the database, and establish the means by
CREATE USER^7^ which Oracle permits access by the user. You can optionally
CREATE USER^8^ assign the following properties to the user:
CREATE USER^9^ 
CREATE USER^10^   *  default tablespace
CREATE USER^11^   *  temporary tablespace
CREATE USER^12^   *  quotas for allocating space in tablespaces
CREATE USER^13^   *  profile containing resource limits
CREATE USER^14^ 
CREATE USER^15^ CREATE USER user IDENTIFIED {BY password | EXTERNALLY | GLOBALLY AS 'CN=user'}
CREATE USER^16^   [ DEFAULT TABLESPACE tablespace
CREATE USER^17^   | TEMPORARY TABLESPACE tablespace
CREATE USER^18^   | QUOTA { integer [K | M] | UNLIMITED } ON tablespace
CREATE USER^19^     [ QUOTA { integer [K | M] | UNLIMITED } ON tablespace ] ...
CREATE USER^20^   | PROFILE profile
CREATE USER^21^   | PASSWORD EXPIRE
CREATE USER^22^   | ACCOUNT { LOCK | UNLOCK } ... ]
CREATE USER^23^ 
CREATE USER^24^ For detailed information on this command, see the Oracle8 Server SQL
CREATE USER^25^ Reference.
CREATE USER^26^ 
CREATE VIEW^1^ 
CREATE VIEW^2^ CREATE VIEW
CREATE VIEW^3^ -----------
CREATE VIEW^4^ 
CREATE VIEW^5^ Use this command to define a view, a logical table based on one or
CREATE VIEW^6^ more tables or views.
CREATE VIEW^7^ 
CREATE VIEW^8^ Use CREATE VIEW to create an object view or a relational view that
CREATE VIEW^9^ supports LOB and object datatypes (object types, REFs, nested table,
CREATE VIEW^10^ or VARRAY types) on top of the existing view mechanism. An object
CREATE VIEW^11^ view is a view with an object identifier that is explicitly defined
CREATE VIEW^12^ to hold object instances of a particular type.
CREATE VIEW^13^ 
CREATE VIEW^14^ CREATE [OR REPLACE] VIEW [FORCE | NO FORCE] VIEW [schema.]view
CREATE VIEW^15^   [ [(alias [alias] ...)]
CREATE VIEW^16^   | OF [schema.]type_name WITH OBJECT OID [DEFAULT | 
CREATE VIEW^17^   (attribute [, attribute] ...) ] ]
CREATE VIEW^18^ AS subquery
CREATE VIEW^19^   [WITH [ READ ONLY | CHECK OPTION [CONSTRAINT constraint] ] ]
CREATE VIEW^20^ 
CREATE VIEW^21^ For detailed information on this command, see the Oracle8 Server SQL
CREATE VIEW^22^ Reference.
CREATE VIEW^23^ 
DEALLOCATE clause^1^ 
DEALLOCATE clause^2^ DEALLOCATE clause
DEALLOCATE clause^3^ -----------------
DEALLOCATE clause^4^ 
DEALLOCATE clause^5^ Use this command to specify the amount of unused space to deallocate
DEALLOCATE clause^6^ from extents.
DEALLOCATE clause^7^ 
DEALLOCATE clause^8^ DEALLOCATE UNUSED [KEEP integer [K | M] ]
DEALLOCATE clause^9^ 
DEALLOCATE clause^10^ For detailed information on this command, see the Oracle8 Server SQL
DEALLOCATE clause^11^ Reference.
DEALLOCATE clause^12^ 
DECLARE CURSOR (Embedded SQL)^1^ 
DECLARE CURSOR (Embedded SQL)^2^ DECLARE CURSOR (Embedded SQL)
DECLARE CURSOR (Embedded SQL)^3^ -----------------------------
DECLARE CURSOR (Embedded SQL)^4^ 
DECLARE CURSOR (Embedded SQL)^5^ Use this command to declare a cursor, giving it a name and
DECLARE CURSOR (Embedded SQL)^6^ associating it with a SQL statement or a PL/SQL block.
DECLARE CURSOR (Embedded SQL)^7^ 
DECLARE CURSOR (Embedded SQL)^8^ EXEC SQL [ AT {db_name | :host_variable} ]
DECLARE CURSOR (Embedded SQL)^9^ DECLARE cursor CURSOR FOR { SELECT command
DECLARE CURSOR (Embedded SQL)^10^                           | statement_name
DECLARE CURSOR (Embedded SQL)^11^                           | blockname }
DECLARE CURSOR (Embedded SQL)^12^ 
DECLARE CURSOR (Embedded SQL)^13^ For detailed information on this command, see the Oracle8 Server SQL
DECLARE CURSOR (Embedded SQL)^14^ Reference.
DECLARE CURSOR (Embedded SQL)^15^ 
DECLARE DATABASE (Embedded SQL)^1^ 
DECLARE DATABASE (Embedded SQL)^2^ DECLARE DATABASE (Embedded SQL)
DECLARE DATABASE (Embedded SQL)^3^ -------------------------------
DECLARE DATABASE (Embedded SQL)^4^ 
DECLARE DATABASE (Embedded SQL)^5^ Use this command to declare an identifier for a non-default database
DECLARE DATABASE (Embedded SQL)^6^ to be accessed in subsequent embedded SQL statements.
DECLARE DATABASE (Embedded SQL)^7^ 
DECLARE DATABASE (Embedded SQL)^8^ EXEC SQL DECLARE db_name DATABASE
DECLARE DATABASE (Embedded SQL)^9^ 
DECLARE DATABASE (Embedded SQL)^10^ For detailed information on this command, see the Oracle8 Server SQL
DECLARE DATABASE (Embedded SQL)^11^ Reference.
DECLARE DATABASE (Embedded SQL)^12^ 
DECLARE STATEMENT (Embedded SQL)^1^ 
DECLARE STATEMENT (Embedded SQL)^2^ DECLARE STATEMENT (Embedded SQL)
DECLARE STATEMENT (Embedded SQL)^3^ --------------------------------
DECLARE STATEMENT (Embedded SQL)^4^ 
DECLARE STATEMENT (Embedded SQL)^5^ Use this command to declare an identifier for a SQL statement or
DECLARE STATEMENT (Embedded SQL)^6^ PL/SQL block to be used in other embedded SQL statements.
DECLARE STATEMENT (Embedded SQL)^7^ 
DECLARE STATEMENT (Embedded SQL)^8^ EXEC SQL [ AT {db_name | :host_variable} ]
DECLARE STATEMENT (Embedded SQL)^9^ DECLARE STATEMENT { statement_name
DECLARE STATEMENT (Embedded SQL)^10^                   | block_name} STATEMENT
DECLARE STATEMENT (Embedded SQL)^11^ 
DECLARE STATEMENT (Embedded SQL)^12^ For detailed information on this command, see the Oracle8 Server SQL
DECLARE STATEMENT (Embedded SQL)^13^ Reference.
DECLARE STATEMENT (Embedded SQL)^14^ 
DECLARE TABLE (Embedded SQL)^1^ 
DECLARE TABLE (Embedded SQL)^2^ DECLARE TABLE (Embedded SQL)
DECLARE TABLE (Embedded SQL)^3^ ----------------------------
DECLARE TABLE (Embedded SQL)^4^ 
DECLARE TABLE (Embedded SQL)^5^ Use this command to define the structure of a table or view,
DECLARE TABLE (Embedded SQL)^6^ including each column's datatype, default value, and NULL or NOT
DECLARE TABLE (Embedded SQL)^7^ NULL specification for semantic checking by the Oracle Precompilers.
DECLARE TABLE (Embedded SQL)^8^ 
DECLARE TABLE (Embedded SQL)^9^ EXEC SQL DECLARE table TABLE
DECLARE TABLE (Embedded SQL)^10^   ( column datatype [ DEFAULT expr [NULL | NOT NULL]
DECLARE TABLE (Embedded SQL)^11^                     | NOT NULL [WITH DEFAULT] ]
DECLARE TABLE (Embedded SQL)^12^   [, column datatype [ DEFAULT expr [NULL | NOT NULL]
DECLARE TABLE (Embedded SQL)^13^                      | NOT NULL [WITH DEFAULT] ] ] ...)
DECLARE TABLE (Embedded SQL)^14^ 
DECLARE TABLE (Embedded SQL)^15^ For detailed information on this command, see the Oracle8 Server SQL
DECLARE TABLE (Embedded SQL)^16^ Reference.
DECLARE TABLE (Embedded SQL)^17^ 
DELETE^1^ 
DELETE^2^ DELETE
DELETE^3^ ------
DELETE^4^ 
DELETE^5^ Use this command to remove rows from a table, a partitioned table, a
DELETE^6^ view's base table, or from a view's partitioned base table.
DELETE^7^ 
DELETE^8^ DELETE [FROM]
DELETE^9^   { [schema.]{table [PARTITION (partition_name) | @dblink]
DELETE^10^               | view [@dblink] }
DELETE^11^   | [THE] ( subquery ) }
DELETE^12^   [alias]
DELETE^13^   [WHERE condition]
DELETE^14^ 
DELETE^15^ For detailed information on this command, see the Oracle8 Server SQL
DELETE^16^ Reference.
DELETE^17^ 
DELETE (Embedded SQL)^1^ 
DELETE (Embedded SQL)^2^ DELETE (Embedded SQL)
DELETE (Embedded SQL)^3^ ---------------------
DELETE (Embedded SQL)^4^ 
DELETE (Embedded SQL)^5^ Use this command to remove rows from a table, and index-only table,
DELETE (Embedded SQL)^6^ or from a view's base table.
DELETE (Embedded SQL)^7^ 
DELETE (Embedded SQL)^8^ EXEC SQL [ AT {db_name | :host_variable} ] [FOR :host_integer]
DELETE (Embedded SQL)^9^  DELETE [FROM]
DELETE (Embedded SQL)^10^    { [schema.]{table [PARTITION (partition_name)]
DELETE (Embedded SQL)^11^                | view [@dblink]}
DELETE (Embedded SQL)^12^    | ( subquery )}
DELETE (Embedded SQL)^13^    [alias]
DELETE (Embedded SQL)^14^    [WHERE {condition | CURRENT OF cursor} ]
DELETE (Embedded SQL)^15^ 
DELETE (Embedded SQL)^16^ For detailed information on this command, see the Oracle8 Server SQL
DELETE (Embedded SQL)^17^ Reference.
DELETE (Embedded SQL)^18^ 
DESCRIBE (Embedded SQL)^1^ 
DESCRIBE (Embedded SQL)^2^ DESCRIBE (Embedded SQL)
DESCRIBE (Embedded SQL)^3^ -----------------------
DESCRIBE (Embedded SQL)^4^ 
DESCRIBE (Embedded SQL)^5^ Use this command to initialize a descriptor to hold descriptions of
DESCRIBE (Embedded SQL)^6^ host variables for a dynamic SQL statement or PL/SQL block.
DESCRIBE (Embedded SQL)^7^ 
DESCRIBE (Embedded SQL)^8^ EXEC SQL DESCRIBE [BIND VARIABLES FOR | SELECT LIST FOR]
DESCRIBE (Embedded SQL)^9^   {statement_name | block_name} INTO descriptor
DESCRIBE (Embedded SQL)^10^ 
DESCRIBE (Embedded SQL)^11^ For detailed information on this command, see the Oracle8 Server SQL
DESCRIBE (Embedded SQL)^12^ Reference.
DESCRIBE (Embedded SQL)^13^ 
DISABLE clause^1^ 
DISABLE clause^2^ DISABLE clause
DISABLE clause^3^ --------------
DISABLE clause^4^ 
DISABLE clause^5^ Use this command to disable an integrity constraint or all triggers
DISABLE clause^6^ associated with a table:
DISABLE clause^7^ 
DISABLE clause^8^   *  If you disable an integrity constraint, Oracle does not enforce
DISABLE clause^9^      it. However, disabled integrity constraints appear in the data
DISABLE clause^10^      dictionary along with enabled integrity constraints.
DISABLE clause^11^   *  If you disable a trigger, Oracle does not fire it if its
DISABLE clause^12^      triggering condition is satisfied.
DISABLE clause^13^ 
DISABLE clause^14^ DISABLE
DISABLE clause^15^   { { UNIQUE (column [, column] ...)
DISABLE clause^16^     | PRIMARY KEY
DISABLE clause^17^     | CONSTRAINT constraint }
DISABLE clause^18^   [ CASCADE ]
DISABLE clause^19^   | ALL TRIGGERS }
DISABLE clause^20^ 
DISABLE clause^21^ For detailed information on this command, see the Oracle8 Server SQL
DISABLE clause^22^ Reference.
DISABLE clause^23^ 
DROP clause^1^ 
DROP clause^2^ DROP clause
DROP clause^3^ -----------
DROP clause^4^ 
DROP clause^5^ Use this command to remove an integrity constraint from the
DROP clause^6^ database.
DROP clause^7^ 
DROP clause^8^ DROP
DROP clause^9^   { { PRIMARY
DROP clause^10^     | UNIQUE (column [, column] ...)}
DROP clause^11^   [ CASCADE ]
DROP clause^12^   | CONSTRAINT constraint }
DROP clause^13^ 
DROP clause^14^ For detailed information on this command, see the Oracle8 Server SQL
DROP clause^15^ Reference.
DROP clause^16^ 
DROP CLUSTER^1^ 
DROP CLUSTER^2^ DROP CLUSTER
DROP CLUSTER^3^ ------------
DROP CLUSTER^4^ 
DROP CLUSTER^5^ Use this command to remove a cluster from the database.
DROP CLUSTER^6^ 
DROP CLUSTER^7^ DROP CLUSTER [schema.]cluster
DROP CLUSTER^8^   [INCLUDING TABLES [CASCADE CONSTRAINTS] ]
DROP CLUSTER^9^ 
DROP CLUSTER^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP CLUSTER^11^ Reference.
DROP CLUSTER^12^ 
DROP DATABASE LINK^1^ 
DROP DATABASE LINK^2^ DROP DATABASE LINK
DROP DATABASE LINK^3^ ------------------
DROP DATABASE LINK^4^ 
DROP DATABASE LINK^5^ Use this command to remove a database link from the database.
DROP DATABASE LINK^6^ 
DROP DATABASE LINK^7^ DROP [PUBLIC] DATABASE LINK dblink
DROP DATABASE LINK^8^ 
DROP DATABASE LINK^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP DATABASE LINK^10^ Reference.
DROP DATABASE LINK^11^ 
DROP DIRECTORY^1^ 
DROP DIRECTORY^2^ DROP DIRECTORY
DROP DIRECTORY^3^ --------------
DROP DIRECTORY^4^ 
DROP DIRECTORY^5^ Use DROP DIRECTORY to remove a directory schema object from the
DROP DIRECTORY^6^ database.
DROP DIRECTORY^7^ 
DROP DIRECTORY^8^ DROP DIRECTORY directory_name
DROP DIRECTORY^9^ 
DROP DIRECTORY^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP DIRECTORY^11^ Reference.
DROP DIRECTORY^12^ 
DROP FUNCTION^1^ 
DROP FUNCTION^2^ DROP FUNCTION
DROP FUNCTION^3^ -------------
DROP FUNCTION^4^ 
DROP FUNCTION^5^ Use this command to remove a stand-alone stored function from the
DROP FUNCTION^6^ database.
DROP FUNCTION^7^ 
DROP FUNCTION^8^ DROP FUNCTION [schema.]function
DROP FUNCTION^9^ 
DROP FUNCTION^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP FUNCTION^11^ Reference.
DROP FUNCTION^12^ 
DROP INDEX^1^ 
DROP INDEX^2^ DROP INDEX
DROP INDEX^3^ ----------
DROP INDEX^4^ 
DROP INDEX^5^ Use this command to remove an index from the database.
DROP INDEX^6^ 
DROP INDEX^7^ DROP INDEX [schema.]index
DROP INDEX^8^ 
DROP INDEX^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP INDEX^10^ Reference.
DROP INDEX^11^ 
DROP LIBRARY^1^ 
DROP LIBRARY^2^ DROP LIBRARY
DROP LIBRARY^3^ ------------
DROP LIBRARY^4^ 
DROP LIBRARY^5^ Use the DROP LIBRARY command to remove an external procedure library
DROP LIBRARY^6^ from the database.
DROP LIBRARY^7^ 
DROP LIBRARY^8^ DROP LIBRARY libname
DROP LIBRARY^9^ 
DROP LIBRARY^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP LIBRARY^11^ Reference.
DROP LIBRARY^12^ 
DROP PACKAGE^1^ 
DROP PACKAGE^2^ DROP PACKAGE
DROP PACKAGE^3^ ------------
DROP PACKAGE^4^ 
DROP PACKAGE^5^ Use this command to remove a stored package from the database.
DROP PACKAGE^6^ 
DROP PACKAGE^7^ DROP PACKAGE [BODY] [schema.]package
DROP PACKAGE^8^ 
DROP PACKAGE^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP PACKAGE^10^ Reference.
DROP PACKAGE^11^ 
DROP PROCEDURE^1^ 
DROP PROCEDURE^2^ DROP PROCEDURE
DROP PROCEDURE^3^ --------------
DROP PROCEDURE^4^ 
DROP PROCEDURE^5^ Use this command to remove a stand-alone stored procedure from the
DROP PROCEDURE^6^ database.
DROP PROCEDURE^7^ 
DROP PROCEDURE^8^ DROP PROCEDURE [schema.]procedure
DROP PROCEDURE^9^ 
DROP PROCEDURE^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP PROCEDURE^11^ Reference.
DROP PROCEDURE^12^ 
DROP PROFILE^1^ 
DROP PROFILE^2^ DROP PROFILE
DROP PROFILE^3^ ------------
DROP PROFILE^4^ 
DROP PROFILE^5^ Use this command to remove a profile from the database.
DROP PROFILE^6^ 
DROP PROFILE^7^ DROP PROFILE profile [CASCADE]
DROP PROFILE^8^ 
DROP PROFILE^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP PROFILE^10^ Reference.
DROP PROFILE^11^ 
DROP ROLE^1^ 
DROP ROLE^2^ DROP ROLE
DROP ROLE^3^ ---------
DROP ROLE^4^ 
DROP ROLE^5^ Use this command to remove a role from the database.
DROP ROLE^6^ 
DROP ROLE^7^ DROP ROLE role
DROP ROLE^8^ 
DROP ROLE^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP ROLE^10^ Reference.
DROP ROLE^11^ 
DROP ROLLBACK SEGMENT^1^ 
DROP ROLLBACK SEGMENT^2^ DROP ROLLBACK SEGMENT
DROP ROLLBACK SEGMENT^3^ ---------------------
DROP ROLLBACK SEGMENT^4^ 
DROP ROLLBACK SEGMENT^5^ Use this command to remove a rollback segment from the database.
DROP ROLLBACK SEGMENT^6^ 
DROP ROLLBACK SEGMENT^7^ DROP ROLLBACK SEGMENT rollback_segment
DROP ROLLBACK SEGMENT^8^ 
DROP ROLLBACK SEGMENT^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP ROLLBACK SEGMENT^10^ Reference.
DROP ROLLBACK SEGMENT^11^ 
DROP SEQUENCE^1^ 
DROP SEQUENCE^2^ DROP SEQUENCE
DROP SEQUENCE^3^ -------------
DROP SEQUENCE^4^ 
DROP SEQUENCE^5^ Use this command to remove a sequence from the database.
DROP SEQUENCE^6^ 
DROP SEQUENCE^7^ DROP SEQUENCE [schema.]sequence
DROP SEQUENCE^8^ 
DROP SEQUENCE^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP SEQUENCE^10^ Reference.
DROP SEQUENCE^11^ 
DROP SNAPSHOT^1^ 
DROP SNAPSHOT^2^ DROP SNAPSHOT
DROP SNAPSHOT^3^ -------------
DROP SNAPSHOT^4^ 
DROP SNAPSHOT^5^ Use this command to remove a snapshot from the database.
DROP SNAPSHOT^6^ 
DROP SNAPSHOT^7^ DROP SNAPSHOT [schema.]snapshot
DROP SNAPSHOT^8^ 
DROP SNAPSHOT^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP SNAPSHOT^10^ Reference.
DROP SNAPSHOT^11^ 
DROP SNAPSHOT LOG^1^ 
DROP SNAPSHOT LOG^2^ DROP SNAPSHOT LOG
DROP SNAPSHOT LOG^3^ -----------------
DROP SNAPSHOT LOG^4^ 
DROP SNAPSHOT LOG^5^ Use this command to remove a snapshot log from the database.
DROP SNAPSHOT LOG^6^ 
DROP SNAPSHOT LOG^7^ DROP SNAPSHOT LOG ON [schema.]table
DROP SNAPSHOT LOG^8^ 
DROP SNAPSHOT LOG^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP SNAPSHOT LOG^10^ Reference.
DROP SNAPSHOT LOG^11^ 
DROP SYNONYM^1^ 
DROP SYNONYM^2^ DROP SYNONYM
DROP SYNONYM^3^ ------------
DROP SYNONYM^4^ 
DROP SYNONYM^5^ Use this command to remove a synonym from the database.
DROP SYNONYM^6^ 
DROP SYNONYM^7^ DROP [PUBLIC] SYNONYM [schema.]synonym
DROP SYNONYM^8^ 
DROP SYNONYM^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP SYNONYM^10^ Reference.
DROP SYNONYM^11^ 
DROP TABLE^1^ 
DROP TABLE^2^ DROP TABLE
DROP TABLE^3^ ----------
DROP TABLE^4^ 
DROP TABLE^5^ Use this command to remove a table or an object table and all its
DROP TABLE^6^ data from the database.
DROP TABLE^7^ 
DROP TABLE^8^ DROP TABLE [schema.]table [CASCADE CONSTRAINTS]
DROP TABLE^9^ 
DROP TABLE^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP TABLE^11^ Reference.
DROP TABLE^12^ 
DROP TABLESPACE^1^ 
DROP TABLESPACE^2^ DROP TABLESPACE
DROP TABLESPACE^3^ ---------------
DROP TABLESPACE^4^ 
DROP TABLESPACE^5^ Use this command to remove a tablespace from the database.
DROP TABLESPACE^6^ 
DROP TABLESPACE^7^ DROP TABLESPACE tablespace
DROP TABLESPACE^8^   [INCLUDING CONTENTS [CASCADE CONSTRAINTS] ]
DROP TABLESPACE^9^ 
DROP TABLESPACE^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP TABLESPACE^11^ Reference.
DROP TABLESPACE^12^ 
DROP TRIGGER^1^ 
DROP TRIGGER^2^ DROP TRIGGER
DROP TRIGGER^3^ ------------
DROP TRIGGER^4^ 
DROP TRIGGER^5^ Use this command to remove a database trigger from the database.
DROP TRIGGER^6^ 
DROP TRIGGER^7^ DROP TRIGGER [schema.]trigger
DROP TRIGGER^8^ 
DROP TRIGGER^9^ For detailed information on this command, see the Oracle8 Server SQL
DROP TRIGGER^10^ Reference.
DROP TRIGGER^11^ 
DROP TYPE^1^ 
DROP TYPE^2^ DROP TYPE
DROP TYPE^3^ ---------
DROP TYPE^4^ 
DROP TYPE^5^ Use the DROP TYPE command to drop the specification and body of an
DROP TYPE^6^ object, a VARRAY, or nested table type. To drop just the body of an
DROP TYPE^7^ object, use the DROP TYPE BODY command.
DROP TYPE^8^ 
DROP TYPE^9^ DROP TYPE [schema.]type_name [FORCE]
DROP TYPE^10^ 
DROP TYPE^11^ For detailed information on this command, see the Oracle8 Server SQL
DROP TYPE^12^ Reference.
DROP TYPE^13^ 
DROP TYPE BODY^1^ 
DROP TYPE BODY^2^ DROP TYPE BODY
DROP TYPE BODY^3^ --------------
DROP TYPE BODY^4^ 
DROP TYPE BODY^5^ Use the DROP TYPE BODY command to drop the body of an object, a
DROP TYPE BODY^6^ VARRAY, or nested table type. To drop the specification of an
DROP TYPE BODY^7^ object, use the DROP TYPE command.
DROP TYPE BODY^8^ 
DROP TYPE BODY^9^ DROP TYPE BODY[schema.]type_name
DROP TYPE BODY^10^ 
DROP TYPE BODY^11^ For detailed information on this command, see the Oracle8 Server SQL
DROP TYPE BODY^12^ Reference.
DROP TYPE BODY^13^ 
DROP USER^1^ 
DROP USER^2^ DROP USER
DROP USER^3^ ---------
DROP USER^4^ 
DROP USER^5^ Use this command to remove a database user and optionally remove the
DROP USER^6^ user's objects.
DROP USER^7^ 
DROP USER^8^ DROP USER user [CASCADE]
DROP USER^9^ 
DROP USER^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP USER^11^ Reference.
DROP USER^12^ 
DROP VIEW^1^ 
DROP VIEW^2^ DROP VIEW
DROP VIEW^3^ ---------
DROP VIEW^4^ 
DROP VIEW^5^ Use this command to remove a view or an object view from the
DROP VIEW^6^ database.
DROP VIEW^7^ 
DROP VIEW^8^ DROP VIEW [schema.]view
DROP VIEW^9^ 
DROP VIEW^10^ For detailed information on this command, see the Oracle8 Server SQL
DROP VIEW^11^ Reference.
DROP VIEW^12^ 
ENABLE clause^1^ 
ENABLE clause^2^ ENABLE clause
ENABLE clause^3^ -------------
ENABLE clause^4^ 
ENABLE clause^5^ Use this command to enable an integrity constraint or all triggers
ENABLE clause^6^ associated with a table:
ENABLE clause^7^ 
ENABLE clause^8^   *  If you enable a constraint, Oracle enforces it by applying it
ENABLE clause^9^      to all data in the table. All table data must satisfy an
ENABLE clause^10^      enabled constraint.
ENABLE clause^11^   *  If you enable a trigger, Oracle fires the trigger whenever its
ENABLE clause^12^      triggering condition is satisfied.
ENABLE clause^13^ 
ENABLE clause^14^ ENABLE
ENABLE clause^15^   { { UNIQUE (column [, column] ...)
ENABLE clause^16^     | PRIMARY KEY
ENABLE clause^17^     | CONSTRAINT constraint}
ENABLE clause^18^   [ USING INDEX [ INITRANS integer
ENABLE clause^19^                 | MAXTRANS integer
ENABLE clause^20^                 | TABLESPACE tablespace
ENABLE clause^21^                 | STORAGE storage_clause
ENABLE clause^22^                 | PCTFREE integer ] ...]
ENABLE clause^23^   [ EXCEPTIONS INTO [schema.]table ]
ENABLE clause^24^   | ALL TRIGGERS }
ENABLE clause^25^ 
ENABLE clause^26^ For detailed information on this command, see the Oracle8 Server SQL
ENABLE clause^27^ Reference.
ENABLE clause^28^ 
EXECUTE (Embedded SQL)^1^ 
EXECUTE (Embedded SQL)^2^ EXECUTE (Prepared SQL Statements and PL/SQL Blocks) (Embedded SQL)
EXECUTE (Embedded SQL)^3^ ------------------------------------------------------------------
EXECUTE (Embedded SQL)^4^ 
EXECUTE (Embedded SQL)^5^ Use this command to execute a DELETE, INSERT, or UPDATE statement or
EXECUTE (Embedded SQL)^6^ a PL/SQL block that has been previously prepared with an embedded
EXECUTE (Embedded SQL)^7^ SQL PREPARE statement.
EXECUTE (Embedded SQL)^8^ 
EXECUTE (Embedded SQL)^9^ EXEC SQL [FOR :host_integer] EXECUTE { statement_name
EXECUTE (Embedded SQL)^10^                                      | block_name }
EXECUTE (Embedded SQL)^11^   [ USING {:host_variable [ [INDICATOR] :indicator_variable]
EXECUTE (Embedded SQL)^12^           [, :host_variable [ [INDICATOR] :indicator_variable] ] ...
EXECUTE (Embedded SQL)^13^           | DESCRIPTOR descriptor} ]
EXECUTE (Embedded SQL)^14^ 
EXECUTE (Embedded SQL)^15^
EXECUTE (Embedded SQL)^16^ EXECUTE (Anonymous PL/SQL Blocks) (Embedded SQL)
EXECUTE (Embedded SQL)^17^ ------------------------------------------------
EXECUTE (Embedded SQL)^18^ 
EXECUTE (Embedded SQL)^19^ Use this command to embed an anonymous PL/SQL block into an Oracle
EXECUTE (Embedded SQL)^20^ Precompiler program.
EXECUTE (Embedded SQL)^21^ 
EXECUTE (Embedded SQL)^22^ EXEC SQL [AT {db_name | :host_variable} ]
EXECUTE (Embedded SQL)^23^   EXECUTE pl/sql_block END-EXEC
EXECUTE (Embedded SQL)^24^ 
EXECUTE (Embedded SQL)^25^
EXECUTE (Embedded SQL)^26^ EXECUTE IMMEDIATE (Embedded SQL)
EXECUTE (Embedded SQL)^27^ --------------------------------
EXECUTE (Embedded SQL)^28^ 
EXECUTE (Embedded SQL)^29^ Use this command to prepare and execute a DELETE, INSERT, or UPDATE
EXECUTE (Embedded SQL)^30^ statement or a PL/SQL block containing no host variables.
EXECUTE (Embedded SQL)^31^ 
EXECUTE (Embedded SQL)^32^ EXEC SQL [AT {db_name | :host_variable} ]
EXECUTE (Embedded SQL)^33^   EXECUTE IMMEDIATE {:host_string | 'text'}
EXECUTE (Embedded SQL)^34^ 
EXECUTE (Embedded SQL)^35^ For detailed information on this command, see the Oracle8 Server SQL
EXECUTE (Embedded SQL)^36^ Reference.
EXECUTE (Embedded SQL)^37^ 
EXPLAIN PLAN^1^ 
EXPLAIN PLAN^2^ EXPLAIN PLAN
EXPLAIN PLAN^3^ ------------
EXPLAIN PLAN^4^ 
EXPLAIN PLAN^5^ Use this command to determine the execution plan Oracle follows to
EXPLAIN PLAN^6^ execute a specified SQL statement. This command inserts a row
EXPLAIN PLAN^7^ describing each step of the execution plan into a specified table.
EXPLAIN PLAN^8^ If you are using cost-based optimization, this command also
EXPLAIN PLAN^9^ determines the cost of executing the statement.
EXPLAIN PLAN^10^ 
EXPLAIN PLAN^11^ EXPLAIN PLAN [ SET STATEMENT_ID = 'text' ]
EXPLAIN PLAN^12^   [ INTO [schema.]table [@dblink] ] FOR statement
EXPLAIN PLAN^13^ 
EXPLAIN PLAN^14^ For detailed information on this command, see the Oracle8 Server SQL
EXPLAIN PLAN^15^ Reference.
EXPLAIN PLAN^16^ 
FETCH (Embedded SQL)^1^ 
FETCH (Embedded SQL)^2^ FETCH (Embedded SQL)
FETCH (Embedded SQL)^3^ --------------------
FETCH (Embedded SQL)^4^ 
FETCH (Embedded SQL)^5^ Use this command to retrieve one or more rows returned by a query,
FETCH (Embedded SQL)^6^ assigning the select list values to host variables.
FETCH (Embedded SQL)^7^ 
FETCH (Embedded SQL)^8^ EXEC SQL [FOR :host_integer] FETCH cursor
FETCH (Embedded SQL)^9^   { INTO :host_variable [ [INDICATOR] :indicator_variable]
FETCH (Embedded SQL)^10^       [, :host_variable [ [INDICATOR] :indicator_variable] ] ...
FETCH (Embedded SQL)^11^   | USING DESCRIPTOR descriptor}
FETCH (Embedded SQL)^12^ 
FETCH (Embedded SQL)^13^ For detailed information on this command, see the Oracle8 Server SQL
FETCH (Embedded SQL)^14^ Reference.
FETCH (Embedded SQL)^15^ 
Filespec^1^ 
Filespec^2^ Filespec
Filespec^3^ --------
Filespec^4^ 
Filespec^5^ Use this command to either specify a file as a data file or specify
Filespec^6^ a group of one or more files as a redo log file group.
Filespec^7^ 
Filespec^8^ filespec (Data Files)
Filespec^9^   'filename' [SIZE integer [K | M]] [REUSE]
Filespec^10^ 
Filespec^11^ filespec (Redo Log File Groups)
Filespec^12^   { 'filename'
Filespec^13^   | (filename [, filename] ...)}
Filespec^14^   [SIZE integer [K | M]] [REUSE]
Filespec^15^ 
Filespec^16^ For detailed information on this command, see the Oracle8 Server SQL
Filespec^17^ Reference.
Filespec^18^ 
GRANT (System Privileges and Roles)^1^ 
GRANT (System Privileges and Roles)^2^ GRANT (System Privileges and Roles)
GRANT (System Privileges and Roles)^3^ -----------------------------------
GRANT (System Privileges and Roles)^4^ 
GRANT (System Privileges and Roles)^5^ Use this command to grant system privileges and roles to users and
GRANT (System Privileges and Roles)^6^ roles. To grant object privileges, use the GRANT command (Object
GRANT (System Privileges and Roles)^7^ Privileges).
GRANT (System Privileges and Roles)^8^ 
GRANT (System Privileges and Roles)^9^ GRANT
GRANT (System Privileges and Roles)^10^   { system_priv | role}
GRANT (System Privileges and Roles)^11^   [, { system_priv | role} ] ...
GRANT (System Privileges and Roles)^12^ TO
GRANT (System Privileges and Roles)^13^   { user | role | PUBLIC}
GRANT (System Privileges and Roles)^14^   [, { user | role | PUBLIC} ] ...
GRANT (System Privileges and Roles)^15^   [ WITH ADMIN OPTION]
GRANT (System Privileges and Roles)^16^ 
GRANT (System Privileges and Roles)^17^ For detailed information on this command, see the Oracle8 Server SQL
GRANT (System Privileges and Roles)^18^ Reference.
GRANT (System Privileges and Roles)^19^ 
GRANT (Object Privileges)^1^ 
GRANT (Object Privileges)^2^ GRANT (Object Privileges)
GRANT (Object Privileges)^3^ -------------------------
GRANT (Object Privileges)^4^ 
GRANT (Object Privileges)^5^ Use this command to grant privileges for a particular object to
GRANT (Object Privileges)^6^ users and roles. To grant system privileges and roles, use the GRANT
GRANT (Object Privileges)^7^ command (System Privileges and Roles).
GRANT (Object Privileges)^8^ 
GRANT (Object Privileges)^9^ GRANT
GRANT (Object Privileges)^10^   { object_priv | ALL [PRIVILEGES] }
GRANT (Object Privileges)^11^   [ ( column [, column] ...) ]
GRANT (Object Privileges)^12^   [, { object_priv | ALL [PRIVILEGES] }
GRANT (Object Privileges)^13^      [ ( column [, column] ...) ] ] ...
GRANT (Object Privileges)^14^ ON [ schema.| DIRECTORY] object
GRANT (Object Privileges)^15^ TO { user | role | PUBLIC} ...
GRANT (Object Privileges)^16^    [ WITH GRANT OPTION]
GRANT (Object Privileges)^17^ 
GRANT (Object Privileges)^18^ For detailed information on this command, see the Oracle8 Server SQL
GRANT (Object Privileges)^19^ Reference.
GRANT (Object Privileges)^20^ 
INSERT^1^ 
INSERT^2^ INSERT
INSERT^3^ ------
INSERT^4^ 
INSERT^5^ Use INSERT to add rows to:
INSERT^6^ 
INSERT^7^   *  a table
INSERT^8^   *  a view's base table
INSERT^9^   *  a partition of a partitioned table
INSERT^10^   *  an object table
INSERT^11^   *  an object view's base table
INSERT^12^ 
INSERT^13^ INSERT INTO
INSERT^14^   { [ schema.]{ table [PARTITION (partition_name) | @dblink]
INSERT^15^                | view}
INSERT^16^                [ @dblink]
INSERT^17^                | [THE] (subquery_1) }
INSERT^18^   [ ( column [, column] ...)]
INSERT^19^   { VALUES (expr [expr] ...)
INSERT^20^   | subquery_2 }
INSERT^21^   [ REF INTO data_item]
INSERT^22^ 
INSERT^23^ For detailed information on this command, see the Oracle8 Server SQL
INSERT^24^ Reference.
INSERT^25^ 
INSERT (Embedded SQL)^1^ 
INSERT (Embedded SQL)^2^ INSERT (Embedded SQL)
INSERT (Embedded SQL)^3^ ---------------------
INSERT (Embedded SQL)^4^ 
INSERT (Embedded SQL)^5^ Use this command to add rows to a table or to a view's base table.
INSERT (Embedded SQL)^6^ 
INSERT (Embedded SQL)^7^ EXEC SQL
INSERT (Embedded SQL)^8^   [ AT { db_name | :host_variable } ]
INSERT (Embedded SQL)^9^   [ FOR :host_integer ]
INSERT (Embedded SQL)^10^ INSERT INTO
INSERT (Embedded SQL)^11^   { [schema.]
INSERT (Embedded SQL)^12^     { table | view }
INSERT (Embedded SQL)^13^     [ @dblink ]
INSERT (Embedded SQL)^14^     | ( subquery_1 ) }
INSERT (Embedded SQL)^15^   [ ( column [, column] ...)]
INSERT (Embedded SQL)^16^   { VALUES (expr [expr] ...)
INSERT (Embedded SQL)^17^   | subquery_2 }
INSERT (Embedded SQL)^18^ 
INSERT (Embedded SQL)^19^ For detailed information on this command, see the Oracle8 Server SQL
INSERT (Embedded SQL)^20^ Reference.
INSERT (Embedded SQL)^21^ 
LOCK TABLE^1^ 
LOCK TABLE^2^ LOCK TABLE
LOCK TABLE^3^ ----------
LOCK TABLE^4^ 
LOCK TABLE^5^ Use this command to lock one or more tables in a specified mode.
LOCK TABLE^6^ This lock manually overrides automatic locking and permits or denies
LOCK TABLE^7^ access to a table or view by other users for the duration of your
LOCK TABLE^8^ operation.
LOCK TABLE^9^ 
LOCK TABLE^10^ LOCK TABLE
LOCK TABLE^11^   [ schema.]{table | view} [@dblink]
LOCK TABLE^12^   [, [schema.]{table | view} [@dblink] ] ...
LOCK TABLE^13^ IN lockmode MODE
LOCK TABLE^14^   [ NOWAIT]
LOCK TABLE^15^ 
LOCK TABLE^16^ For detailed information on this command, see the Oracle8 Server SQL
LOCK TABLE^17^ Reference.
LOCK TABLE^18^ 
NOAUDIT (SQL Statements)^1^ 
NOAUDIT (SQL Statements)^2^ NOAUDIT (SQL Statements)
NOAUDIT (SQL Statements)^3^ ------------------------
NOAUDIT (SQL Statements)^4^ 
NOAUDIT (SQL Statements)^5^ Use this command to stop auditing chosen by the AUDIT command (SQL
NOAUDIT (SQL Statements)^6^ Statements). To stop auditing chosen by the AUDIT command (Schema
NOAUDIT (SQL Statements)^7^ Objects), use the NOAUDIT command (Schema Objects).
NOAUDIT (SQL Statements)^8^ 
NOAUDIT (SQL Statements)^9^ NOAUDIT
NOAUDIT (SQL Statements)^10^   { statement_opt | system_priv}
NOAUDIT (SQL Statements)^11^   [, {statement_opt | system_priv} ] ...
NOAUDIT (SQL Statements)^12^   [ BY user [, user] ...]
NOAUDIT (SQL Statements)^13^   [ WITH GRANT OPTION [NOT] SUCCESSFUL]
NOAUDIT (SQL Statements)^14^ 
NOAUDIT (SQL Statements)^15^ For detailed information on this command, see the Oracle8 Server SQL
NOAUDIT (SQL Statements)^16^ Reference.
NOAUDIT (SQL Statements)^17^ 
NOAUDIT (Schema Objects)^1^ 
NOAUDIT (Schema Objects)^2^ NOAUDIT (Schema Objects)
NOAUDIT (Schema Objects)^3^ ------------------------
NOAUDIT (Schema Objects)^4^ 
NOAUDIT (Schema Objects)^5^ Use this command to stop auditing chosen by the AUDIT command
NOAUDIT (Schema Objects)^6^ (Schema Objects). To stop auditing chosen by the AUDIT command (SQL
NOAUDIT (Schema Objects)^7^ Statements), use the NOAUDIT command (SQL Statements).
NOAUDIT (Schema Objects)^8^ 
NOAUDIT (Schema Objects)^9^ NOAUDIT object_opt [, object_opt] ...
NOAUDIT (Schema Objects)^10^   ON [schema.]object [WHENEVER [NOT] SUCCESSFUL]
NOAUDIT (Schema Objects)^11^ 
NOAUDIT (Schema Objects)^12^ For detailed information on this command, see the Oracle8 Server SQL
NOAUDIT (Schema Objects)^13^ Reference.
NOAUDIT (Schema Objects)^14^ 
OPEN (Embedded SQL)^1^ 
OPEN (Embedded SQL)^2^ OPEN (Embedded SQL)
OPEN (Embedded SQL)^3^ -------------------
OPEN (Embedded SQL)^4^ 
OPEN (Embedded SQL)^5^ Use this command to open a cursor, evaluating the associated query
OPEN (Embedded SQL)^6^ and substituting the host variable names supplied by the USING
OPEN (Embedded SQL)^7^ clause into the WHERE clause of the query.
OPEN (Embedded SQL)^8^ 
OPEN (Embedded SQL)^9^ EXEC SQL OPEN cursor
OPEN (Embedded SQL)^10^   [ USING
OPEN (Embedded SQL)^11^     { :host_variable [ [INDICATOR] :indicator_variable] }
OPEN (Embedded SQL)^12^     [, { :host_variable [ [INDICATOR] :indicator_variable] } ] ...
OPEN (Embedded SQL)^13^     | DESCRIPTOR descriptor} ]
OPEN (Embedded SQL)^14^ 
OPEN (Embedded SQL)^15^ For detailed information on this command, see the Oracle8 Server SQL
OPEN (Embedded SQL)^16^ Reference.
OPEN (Embedded SQL)^17^ 
PARALLEL clause^1^ 
PARALLEL clause^2^ PARALLEL clause
PARALLEL clause^3^ ---------------
PARALLEL clause^4^ 
PARALLEL clause^5^ This clause can only be used in the following commands:
PARALLEL clause^6^ 
PARALLEL clause^7^   *  ALTER CLUSTER
PARALLEL clause^8^   *  ALTER DATABASE ... RECOVER
PARALLEL clause^9^   *  ALTER INDEX ... REBUILD
PARALLEL clause^10^   *  ALTER TABLE
PARALLEL clause^11^   *  CREATE CLUSTER
PARALLEL clause^12^   *  CREATE INDEX
PARALLEL clause^13^   *  CREATE TABLE
PARALLEL clause^14^ 
PARALLEL clause^15^ { NOPARALLEL | PARALLEL
PARALLEL clause^16^   ( { DEGREE {integer | DEFAULT}
PARALLEL clause^17^     | INSTANCES {integer | DEFAULT} } ...) }
PARALLEL clause^18^ 
PARALLEL clause^19^ For detailed information on this command, see the Oracle8 Server SQL
PARALLEL clause^20^ Reference.
PARALLEL clause^21^ 
PREPARE (Embedded SQL)^1^ 
PREPARE (Embedded SQL)^2^ PREPARE (Embedded SQL)
PREPARE (Embedded SQL)^3^ ----------------------
PREPARE (Embedded SQL)^4^ 
PREPARE (Embedded SQL)^5^ Use this command to parse a SQL statement or PL/SQL block specified
PREPARE (Embedded SQL)^6^ by a host variable and associate it with an identifier.
PREPARE (Embedded SQL)^7^ 
PREPARE (Embedded SQL)^8^ EXEC SQL PREPARE {statement_name | block_name}
PREPARE (Embedded SQL)^9^ FROM {:host_string | 'text'}
PREPARE (Embedded SQL)^10^ 
PREPARE (Embedded SQL)^11^ For detailed information on this command, see the Oracle8 Server SQL
PREPARE (Embedded SQL)^12^ Reference.
PREPARE (Embedded SQL)^13^ 
RECOVER clause^1^ 
RECOVER clause^2^ RECOVER clause
RECOVER clause^3^ --------------
RECOVER clause^4^ 
RECOVER clause^5^ Use this command to perform media recovery.
RECOVER clause^6^ 
RECOVER clause^7^ RECOVER [ AUTOMATIC] [FROM 'location']
RECOVER clause^8^   [ { [ [ STANDBY] DATABASE]
RECOVER clause^9^       [ UNTIL CANCEL
RECOVER clause^10^       | UNTIL TIME date
RECOVER clause^11^       | UNTIL CHANGE integer
RECOVER clause^12^       | USING BACKUP CONTROLFILE ] ...
RECOVER clause^13^     | TABLESPACE tablespace [, tablespace] ...
RECOVER clause^14^     | DATABASE 'filename' [, 'filename'] ...
RECOVER clause^15^     | LOGFILE 'filename'
RECOVER clause^16^     | CONTINUE [DEFAULT]
RECOVER clause^17^     | CANCEL } ]
RECOVER clause^18^   [ PARALLEL parallel_clause]
RECOVER clause^19^ 
RECOVER clause^20^ For detailed information on this command, see the Oracle8 Server SQL
RECOVER clause^21^ Reference.
RECOVER clause^22^ 
RENAME^1^ 
RENAME^2^ RENAME
RENAME^3^ ------
RENAME^4^ 
RENAME^5^ Use this command to rename a table, view, sequence, or private
RENAME^6^ synonym.
RENAME^7^ 
RENAME^8^ RENAME old TO new
RENAME^9^ 
RENAME^10^ For detailed information on this command, see the Oracle8 Server SQL
RENAME^11^ Reference.
RENAME^12^ 
REVOKE (System Privileges and Roles)^1^ 
REVOKE (System Privileges and Roles)^2^ REVOKE (System Privileges and Roles)
REVOKE (System Privileges and Roles)^3^ ------------------------------------
REVOKE (System Privileges and Roles)^4^ 
REVOKE (System Privileges and Roles)^5^ Use this command to revoke system privileges and roles from users
REVOKE (System Privileges and Roles)^6^ and roles. To revoke object privileges from users and roles, use the
REVOKE (System Privileges and Roles)^7^ REVOKE command (Object Privileges).
REVOKE (System Privileges and Roles)^8^ 
REVOKE (System Privileges and Roles)^9^ REVOKE
REVOKE (System Privileges and Roles)^10^   { system_priv | role}
REVOKE (System Privileges and Roles)^11^   [, { system_priv | role} ] ...
REVOKE (System Privileges and Roles)^12^ FROM
REVOKE (System Privileges and Roles)^13^   { user | role | PUBLIC}
REVOKE (System Privileges and Roles)^14^   [, {user | role | PUBLIC} ] ...
REVOKE (System Privileges and Roles)^15^ 
REVOKE (System Privileges and Roles)^16^ For detailed information on this command, see the Oracle8 Server SQL
REVOKE (System Privileges and Roles)^17^ Reference.
REVOKE (System Privileges and Roles)^18^ 
REVOKE (Schema Object Privileges)^1^ 
REVOKE (Schema Object Privileges)^2^ REVOKE (Schema Object Privileges)
REVOKE (Schema Object Privileges)^3^ ---------------------------------
REVOKE (Schema Object Privileges)^4^ 
REVOKE (Schema Object Privileges)^5^ Use this command to revoke object privileges for a particular object
REVOKE (Schema Object Privileges)^6^ from users and roles. To revoke system privileges or roles, use the
REVOKE (Schema Object Privileges)^7^ REVOKE command (System Privileges and Roles).
REVOKE (Schema Object Privileges)^8^ 
REVOKE (Schema Object Privileges)^9^ REVOKE
REVOKE (Schema Object Privileges)^10^   { object_priv | ALL [PRIVILEGES] }
REVOKE (Schema Object Privileges)^11^   [, {object_priv | ALL [PRIVILEGES] } ] ...
REVOKE (Schema Object Privileges)^12^ ON
REVOKE (Schema Object Privileges)^13^   [ schema.| DIRECTORY] object
REVOKE (Schema Object Privileges)^14^ FROM
REVOKE (Schema Object Privileges)^15^   { user | role | PUBLIC}
REVOKE (Schema Object Privileges)^16^   [, {user | role | PUBLIC} ] ...
REVOKE (Schema Object Privileges)^17^   [ CASCADE CONSTRAINTS]
REVOKE (Schema Object Privileges)^18^ 
REVOKE (Schema Object Privileges)^19^ For detailed information on this command, see the Oracle8 Server SQL
REVOKE (Schema Object Privileges)^20^ Reference.
REVOKE (Schema Object Privileges)^21^ 
ROLLBACK^1^ 
ROLLBACK^2^ ROLLBACK
ROLLBACK^3^ --------
ROLLBACK^4^ 
ROLLBACK^5^ Use this command to undo work done in the current transaction.
ROLLBACK^6^ 
ROLLBACK^7^ You can also use this command to manually undo the work done by an
ROLLBACK^8^ in-doubt distributed transaction.
ROLLBACK^9^ 
ROLLBACK^10^ ROLLBACK [WORK] [TO [SAVEPOINT] savepoint | FORCE 'text']
ROLLBACK^11^ 
ROLLBACK^12^ For detailed information on this command, see the Oracle8 Server SQL
ROLLBACK^13^ Reference.
ROLLBACK^14^ 
ROLLBACK (Embedded SQL)^1^ 
ROLLBACK (Embedded SQL)^2^ ROLLBACK (Embedded SQL)
ROLLBACK (Embedded SQL)^3^ -----------------------
ROLLBACK (Embedded SQL)^4^ 
ROLLBACK (Embedded SQL)^5^ Use this command to end the current transaction, discard all changes
ROLLBACK (Embedded SQL)^6^ in the current transaction, and release all locks and optionally
ROLLBACK (Embedded SQL)^7^ release resources and disconnect from the database.
ROLLBACK (Embedded SQL)^8^ 
ROLLBACK (Embedded SQL)^9^ EXEC SQL
ROLLBACK (Embedded SQL)^10^   [ AT {db_name | :host_variable} ]
ROLLBACK (Embedded SQL)^11^   ROLLBACK [WORK]
ROLLBACK (Embedded SQL)^12^   [ { TO [SAVEPOINT] savepoint [RELEASE] | PUBLIC } ]
ROLLBACK (Embedded SQL)^13^ 
ROLLBACK (Embedded SQL)^14^ For detailed information on this command, see the Oracle8 Server SQL
ROLLBACK (Embedded SQL)^15^ Reference.
ROLLBACK (Embedded SQL)^16^ 
SAVEPOINT^1^ 
SAVEPOINT^2^ SAVEPOINT
SAVEPOINT^3^ ---------
SAVEPOINT^4^ 
SAVEPOINT^5^ Use this command to identify a point in a transaction to which you
SAVEPOINT^6^ can later roll back.
SAVEPOINT^7^ 
SAVEPOINT^8^ SAVEPOINT savepoint
SAVEPOINT^9^ 
SAVEPOINT^10^ For detailed information on this command, see the Oracle8 Server SQL
SAVEPOINT^11^ Reference.
SAVEPOINT^12^ 
SAVEPOINT (Embedded SQL)^1^ 
SAVEPOINT (Embedded SQL)^2^ SAVEPOINT (Embedded SQL)
SAVEPOINT (Embedded SQL)^3^ ------------------------
SAVEPOINT (Embedded SQL)^4^ 
SAVEPOINT (Embedded SQL)^5^ Use this command to identify a point in a transaction to which you
SAVEPOINT (Embedded SQL)^6^ can later roll back.
SAVEPOINT (Embedded SQL)^7^ 
SAVEPOINT (Embedded SQL)^8^ EXEC SQL [ AT { db_name | :host_variable } ]
SAVEPOINT (Embedded SQL)^9^ SAVEPOINT savepoint
SAVEPOINT (Embedded SQL)^10^ 
SAVEPOINT (Embedded SQL)^11^ For detailed information on this command, see the Oracle8 Server SQL
SAVEPOINT (Embedded SQL)^12^ Reference.
SAVEPOINT (Embedded SQL)^13^ 
SELECT^1^ 
SELECT^2^ SELECT
SELECT^3^ ------
SELECT^4^ 
SELECT^5^ Use this command to retrieve data from one or more tables, object
SELECT^6^ tables, views, object views, or snapshots.
SELECT^7^ 
SELECT^8^ SELECT
SELECT^9^   [ DISTINCT | ALL ]
SELECT^10^   { *
SELECT^11^   | { [ schema. ]{ table | view | snapshot } .*
SELECT^12^     | expr [ [ AS ] c_alias ] }
SELECT^13^   [, { [ schema. ]{ table | view | snapshot } .*
SELECT^14^      | expr [ [ AS ] c_alias ] } ] ...
SELECT^15^ FROM
SELECT^16^   { [ schema. ]
SELECT^17^     { table [ PARTITION ( partition_name ) | @dblink ]
SELECT^18^     | [ view | snapshot ] [ @dblink ] }
SELECT^19^   [ t_alias ]
SELECT^20^   | [ THE ] ( subquery )
SELECT^21^   [ t_alias ]
SELECT^22^   | TABLE ( nested_table_column )
SELECT^23^   [ t_alias ] }
SELECT^24^   [, { [ schema. ]
SELECT^25^        { table [ PARTITION ( partition_name ) | @dblink ]
SELECT^26^        | [ view | snapshot ] [ @dblink ] }
SELECT^27^      [ t_alias ]
SELECT^28^      | [ THE ] ( subquery )
SELECT^29^      [ t_alias ]
SELECT^30^      | TABLE ( nested_table_column ) } ] ... 
SELECT^31^   [ WHERE condition ]
SELECT^32^   [ [ START WITH condition ] CONNECT BY condition
SELECT^33^     | GROUP BY expr [, expr] ...
SELECT^34^     [ HAVING CONDITION ] ] ...
SELECT^35^   [ { UNION
SELECT^36^     | UNION ALL
SELECT^37^     | INTERSECT
SELECT^38^     | MINUS } SELECT command ]
SELECT^39^   [ ORDER BY { expr | position | c_alias } [ ASC | DESC ]
SELECT^40^   [, { expr | position | c_alias } [ ASC | DESC ] ] ...
SELECT^41^   | FOR UPDATE
SELECT^42^     [ OF [ [ schema. ]{ table. | view. } ] column
SELECT^43^          [, [ [schema.]{table. | view.} ] column] ...] [NOWAIT]
SELECT^44^ 
SELECT^45^ For detailed information on this command, see the Oracle8 Server SQL
SELECT^46^ Reference.
SELECT^47^ 
SELECT (Embedded SQL)^1^ 
SELECT (Embedded SQL)^2^ SELECT (Embedded SQL)
SELECT (Embedded SQL)^3^ ---------------------
SELECT (Embedded SQL)^4^ 
SELECT (Embedded SQL)^5^ Use this command to retrieve data from one or more tables, views, or
SELECT (Embedded SQL)^6^ snapshots, assigning the selected values to host variables.
SELECT (Embedded SQL)^7^ 
SELECT (Embedded SQL)^8^ EXEC SQL
SELECT (Embedded SQL)^9^   [ AT { dbname | :host_variable } ]
SELECT (Embedded SQL)^10^   SELECT select_list
SELECT (Embedded SQL)^11^ INTO
SELECT (Embedded SQL)^12^   :host_variable [ [ INDICATOR ] :indicator_variable ]
SELECT (Embedded SQL)^13^   [, :host_variable [ [ INDICATOR ] :indicator_variable ] ] ...
SELECT (Embedded SQL)^14^ FROM table _list
SELECT (Embedded SQL)^15^ [ WHERE condition ]
SELECT (Embedded SQL)^16^ [ [ START WITH condition ] CONNECT BY condition
SELECT (Embedded SQL)^17^   | GROUP BY expr [, expr ] ... [ HAVING condition ] ] ...
SELECT (Embedded SQL)^18^ [ { UNION
SELECT (Embedded SQL)^19^   | UNION ALL
SELECT (Embedded SQL)^20^   | INTERSECT
SELECT (Embedded SQL)^21^   | MINUS } SELECT command ]
SELECT (Embedded SQL)^22^ [ ORDER BY
SELECT (Embedded SQL)^23^   { expr | position } [ ASC | DESC ]
SELECT (Embedded SQL)^24^   [, { expr | position } [ ASC | DESC ] ] ...
SELECT (Embedded SQL)^25^   | FOR UPDATE
SELECT (Embedded SQL)^26^     [ OF [ [ schema. ]{ table. | view. } ] column ]
SELECT (Embedded SQL)^27^     [, OF [ [ schema. ]{ table. | view. } ] column ] ...
SELECT (Embedded SQL)^28^     [ NOWAIT ]  ... ]
SELECT (Embedded SQL)^29^ 
SELECT (Embedded SQL)^30^ For detailed information on this command, see the Oracle8 Server SQL
SELECT (Embedded SQL)^31^ Reference.
SELECT (Embedded SQL)^32^ 
SET CONSTRAINT(S)^1^ 
SET CONSTRAINT(S)^2^ SET CONSTRAINT(S)
SET CONSTRAINT(S)^3^ -----------------
SET CONSTRAINT(S)^4^ 
SET CONSTRAINT(S)^5^ Use SET CONSTRAINT(S) to set, per transaction, whether a deferrable
SET CONSTRAINT(S)^6^ constraint is checked following each DML statement (IMMEDIATE) or
SET CONSTRAINT(S)^7^ when the transaction is committed (DEFERRED).
SET CONSTRAINT(S)^8^ 
SET CONSTRAINT(S)^9^ SET CONSTRAINT[S]
SET CONSTRAINT(S)^10^   { constraint [, constraint ] ... | ALL }
SET CONSTRAINT(S)^11^   { IMMEDIATE | DEFERRED }
SET CONSTRAINT(S)^12^ 
SET CONSTRAINT(S)^13^ For detailed information on this command, see the Oracle8 Server SQL
SET CONSTRAINT(S)^14^ Reference.
SET CONSTRAINT(S)^15^ 
SET ROLE^1^ 
SET ROLE^2^ SET ROLE
SET ROLE^3^ --------
SET ROLE^4^ 
SET ROLE^5^ Use this command to enable and disable roles for your current
SET ROLE^6^ session.
SET ROLE^7^ 
SET ROLE^8^ SET ROLE
SET ROLE^9^   { role
SET ROLE^10^     [ IDENTIFIED BY password ]
SET ROLE^11^     [, role [ IDENTIFIED BY password ] ] ...
SET ROLE^12^     | ALL [ EXCEPT role [, role ] ... ]
SET ROLE^13^     | NONE }
SET ROLE^14^ 
SET ROLE^15^ For detailed information on this command, see the Oracle8 Server SQL
SET ROLE^16^ Reference.
SET ROLE^17^ 
SET TRANSACTION^1^ 
SET TRANSACTION^2^ SET TRANSACTION
SET TRANSACTION^3^ ---------------
SET TRANSACTION^4^ 
SET TRANSACTION^5^ For the current transaction:
SET TRANSACTION^6^ 
SET TRANSACTION^7^   *  establish as a read-only or read-write transaction
SET TRANSACTION^8^   *  establish the isolation level
SET TRANSACTION^9^   *  assign the transaction to a specified rollback segment
SET TRANSACTION^10^ 
SET TRANSACTION^11^ SET TRANSACTION
SET TRANSACTION^12^   { READ ONLY
SET TRANSACTION^13^   | READ WRITE
SET TRANSACTION^14^   | ISOLATION LEVEL { SERIALIZABLE | READ COMMITTED }
SET TRANSACTION^15^   | USE ROLLBACK SEGMENT rollback_segment }
SET TRANSACTION^16^ 
SET TRANSACTION^17^ For detailed information on this command, see the Oracle8 Server SQL
SET TRANSACTION^18^ Reference.
SET TRANSACTION^19^ 
STORAGE clause^1^ 
STORAGE clause^2^ STORAGE clause
STORAGE clause^3^ --------------
STORAGE clause^4^ 
STORAGE clause^5^ Use this command to specify storage characteristics for tables,
STORAGE clause^6^ indexes, clusters, and rollback segments, and the default storage
STORAGE clause^7^ characteristics for tablespaces.
STORAGE clause^8^ 
STORAGE clause^9^ STORAGE
STORAGE clause^10^   ( { INITIAL integer [ K | M ]
STORAGE clause^11^     | NEXT integer [ K | M ]
STORAGE clause^12^     | MINEXTENTS integer
STORAGE clause^13^     | MAXEXTENTS { integer | UNLIMITED }
STORAGE clause^14^     | PCTINCREASE integer
STORAGE clause^15^     | FREELISTS integer
STORAGE clause^16^     | FREELIST GROUPS integer
STORAGE clause^17^     | OPTIMAL [ integer [ K | M ] | NULL ] } ... )
STORAGE clause^18^ 
STORAGE clause^19^ For detailed information on this command, see the Oracle8 Server SQL
STORAGE clause^20^ Reference.
STORAGE clause^21^ 
TRUNCATE^1^ 
TRUNCATE^2^ TRUNCATE
TRUNCATE^3^ --------
TRUNCATE^4^ 
TRUNCATE^5^ Use this command to remove all rows from a table or cluster and
TRUNCATE^6^ reset the STORAGE parameters to the values when the table or cluster
TRUNCATE^7^ was created.
TRUNCATE^8^ 
TRUNCATE^9^ TRUNCATE
TRUNCATE^10^   { TABLE [ schema. ]table
TRUNCATE^11^     [ [ PRESERVE | PURGE ] SNAPSHOT LOG ]
TRUNCATE^12^     | CLUSTER [ schema. ]cluster }
TRUNCATE^13^   [ { DROP | REUSE } STORAGE ]
TRUNCATE^14^ 
TRUNCATE^15^ For detailed information on this command, see the Oracle8 Server SQL
TRUNCATE^16^ Reference.
TRUNCATE^17^ 
TYPE (Embedded SQL)^1^ 
TYPE (Embedded SQL)^2^ TYPE (Embedded SQL)
TYPE (Embedded SQL)^3^ -------------------
TYPE (Embedded SQL)^4^ 
TYPE (Embedded SQL)^5^ Use this command to perform user-defined type equivalencing, or to
TYPE (Embedded SQL)^6^ assign an Oracle external datatype to a whole class of host
TYPE (Embedded SQL)^7^ variables by equivalencing the external datatype to a user-
TYPE (Embedded SQL)^8^ defined datatype.
TYPE (Embedded SQL)^9^ 
TYPE (Embedded SQL)^10^ EXEC SQL TYPE type IS datatype
TYPE (Embedded SQL)^11^ 
TYPE (Embedded SQL)^12^ For detailed information on this command, see the Oracle8 Server SQL
TYPE (Embedded SQL)^13^ Reference.
TYPE (Embedded SQL)^14^ 
UPDATE^1^ 
UPDATE^2^ UPDATE
UPDATE^3^ ------
UPDATE^4^ 
UPDATE^5^ Use this command to change existing values in a table or in a view's
UPDATE^6^ base table.
UPDATE^7^ 
UPDATE^8^ UPDATE
UPDATE^9^   { [ schema. ]
UPDATE^10^     { table
UPDATE^11^       [ PARTITION ( partition_name )
UPDATE^12^       | @dblink ]
UPDATE^13^     | [ view | snapshot ] }
UPDATE^14^   [ @dblink ]
UPDATE^15^   | [ THE ] ( subquery_1 )
UPDATE^16^   [ t_alias ] }
UPDATE^17^ SET
UPDATE^18^   { ( column [, column ] ... ) = ( subquery_2 )
UPDATE^19^   | column = { expr | ( subquery_3 ) } }
UPDATE^20^   [, { ( column [, column ] ... ) = ( subquery_2 )
UPDATE^21^      | column = { expr | ( subquery_3 ) } } ] ...
UPDATE^22^   [ WHERE condition ]
UPDATE^23^ 
UPDATE^24^ For detailed information on this command, see the Oracle8 Server SQL
UPDATE^25^ Reference.
UPDATE^26^ 
UPDATE (Embedded SQL)^1^ 
UPDATE (Embedded SQL)^2^ UPDATE (Embedded SQL)
UPDATE (Embedded SQL)^3^ ---------------------
UPDATE (Embedded SQL)^4^ 
UPDATE (Embedded SQL)^5^ Use this command to change existing values in a table or in a view's
UPDATE (Embedded SQL)^6^ base table.
UPDATE (Embedded SQL)^7^ 
UPDATE (Embedded SQL)^8^ EXEC SQL
UPDATE (Embedded SQL)^9^   [ AT { dbname | :host_variable } ]
UPDATE (Embedded SQL)^10^   [ FOR :host_integer ]
UPDATE (Embedded SQL)^11^ UPDATE
UPDATE (Embedded SQL)^12^   { [ schema. ]
UPDATE (Embedded SQL)^13^     { table | view | snapshot }
UPDATE (Embedded SQL)^14^     [ @dblink ]
UPDATE (Embedded SQL)^15^     | ( subquery_1 ) }
UPDATE (Embedded SQL)^16^   [ t_alias ]
UPDATE (Embedded SQL)^17^ SET
UPDATE (Embedded SQL)^18^   { ( column [, column ] ... ) = ( subquery_2 )
UPDATE (Embedded SQL)^19^   | column = { expr | ( subquery_3 ) } }
UPDATE (Embedded SQL)^20^   [, { ( column [, column ] ... ) = ( subquery_2 )
UPDATE (Embedded SQL)^21^      | column = { expr | ( subquery_3 ) } } ] ...
UPDATE (Embedded SQL)^22^   [ WHERE condition ]
UPDATE (Embedded SQL)^23^ 
UPDATE (Embedded SQL)^24^ For detailed information on this command, see the Oracle8 Server SQL
UPDATE (Embedded SQL)^25^ Reference.
UPDATE (Embedded SQL)^26^ 
VAR (Embedded SQL)^1^ 
VAR (Embedded SQL)^2^ VAR (Embedded SQL)
VAR (Embedded SQL)^3^ ------------------
VAR (Embedded SQL)^4^ 
VAR (Embedded SQL)^5^ Use this command to perform host variable equivalencing, or to
VAR (Embedded SQL)^6^ assign a specific Oracle external datatype to an individual host
VAR (Embedded SQL)^7^ variable, overriding the default datatype assignment.
VAR (Embedded SQL)^8^ 
VAR (Embedded SQL)^9^ EXEC SQL VAR host_variable IS datatype
VAR (Embedded SQL)^10^ 
VAR (Embedded SQL)^11^ For detailed information on this command, see the Oracle8 Server SQL
VAR (Embedded SQL)^12^ Reference.
VAR (Embedded SQL)^13^ 
WHENEVER (Embedded SQL)^1^ 
WHENEVER (Embedded SQL)^2^ WHENEVER (Embedded SQL)
WHENEVER (Embedded SQL)^3^ -----------------------
WHENEVER (Embedded SQL)^4^ 
WHENEVER (Embedded SQL)^5^ Use this command to specify the action to be taken when if error an
WHENEVER (Embedded SQL)^6^ warning results from executing an embedded SQL program.
WHENEVER (Embedded SQL)^7^ 
WHENEVER (Embedded SQL)^8^ EXEC SQL WHENEVER
WHENEVER (Embedded SQL)^9^   { NOT FOUND
WHENEVER (Embedded SQL)^10^   | SQLERROR
WHENEVER (Embedded SQL)^11^   | SQLWARNING }
WHENEVER (Embedded SQL)^12^   { CONTINUE 
WHENEVER (Embedded SQL)^13^   | GOTO label_name
WHENEVER (Embedded SQL)^14^   | STOP
WHENEVER (Embedded SQL)^15^   | DO routine_call }
WHENEVER (Embedded SQL)^16^ 
WHENEVER (Embedded SQL)^17^ For detailed information on this command, see the Oracle8 Server SQL
WHENEVER (Embedded SQL)^18^ Reference.
WHENEVER (Embedded SQL)^19^ 
