set echo off
set verify off
set feedback off
set head off
SELECT 'drop index',owner||'.'||object_name,';'
FROM USPACEIDX_&1 u
WHERE not exists 
(	select * from dba_constraints  
	where owner = u.owner and constraint_name = u.object_name);
exit;

