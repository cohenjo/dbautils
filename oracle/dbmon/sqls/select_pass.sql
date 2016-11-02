-- This script is used by password. 
-- It gets encoded password of the selected user.

set feed off
set pagesize 0
set verify off

select password from dba_users
where username='&1'
/

exit
