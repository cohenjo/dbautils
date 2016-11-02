REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show user info for a given name 
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off
set verify 	off

col bytes 			for 99,999,999,999 head "Bytes Used"
col quota			for a20 head Quota
col default_tablespace		for a20 head "Default Tablespace"
col temporary_tablespace	for a20 head "Temporary Tablespace"
col Resource_name  		for a40 head "Resource Name "
col limit              		for a20 head "Resource Limit"
col granted_role 		for a20 head Granted_role
col admin_option 		for a8 	head Admin 
col privilege 			for a20 head Privilege
col owner 			for a20 head Owner
col table_owner                 for a15 head "Table Owner"
col table_name 			for a25 head "Table Name"
col synonym_name		for a25 head "Synonym Name"
col Partitioned 		for a12 head Partitioned
col Nested     			for a12 head Nested
col IOT_TYPE   			for a17 head "IOT Type"
col Table_type  		for a12 head "Table Type"
col type_name 			for a25 head "Type Name"
col Methods   			for 9999 head "Methods "
col db_link 			for a12

set termout off
spool &2

SELECT default_tablespace, temporary_tablespace, created 
FROM dba_users 
WHERE username=upper('&1')
;
SELECT tablespace_name, bytes, 
       decode(sign(max_bytes),-1,'Unlimited',0,0,1,round(max_bytes/1024/1024,1)) quota
FROM dba_ts_quotas 
WHERE username=upper('&1')
;
SELECT Resource_name, limit
FROM dba_profiles profs, dba_users users
WHERE profs.profile=users.profile 
AND   username=upper('&1') 
AND   (Resource_name like 'PASSWORD%' or Resource_name ='FAILED_LOGIN_ATTEMPTS')
;
SELECT granted_role, admin_option  
FROM dba_role_privs 
WHERE grantee = upper('&1')
;
SELECT privilege, admin_option
FROM dba_sys_privs
WHERE grantee = upper('&1')
;
prompt
prompt user's privileges:
prompt ==================
break on table_name
SELECT table_name, privilege, owner  
FROM dba_tab_privs 
WHERE grantee = upper('&1')
ORDER BY owner
;
prompt
prompt user's tables:
prompt ==============
SELECT table_name ,partitioned, nested,IOT_TYPE 
FROM dba_tables
WHERE owner=upper('&1')
ORDER BY table_name
;
prompt
prompt user's object tables:
prompt =====================
SELECT table_name, table_type, nested,IOT_TYPE 
FROM dba_object_tables
WHERE owner=upper('&1')
ORDER BY table_name
;
prompt
prompt user's object:
prompt ==============
SELECT type_name, Methods 
FROM dba_types 
WHERE owner=upper ('&1')
;
prompt
prompt user's synonyms:
prompt ================
SELECT synonym_name, table_owner, table_name, db_link 
FROM dba_synonyms 
WHERE owner=upper('&1')
ORDER BY  synonym_name
;
prompt
prompt user's views:
prompt =============
SELECT view_name 
FROM dba_views 
WHERE owner=upper('&1')
;
prompt
spool off

exit

