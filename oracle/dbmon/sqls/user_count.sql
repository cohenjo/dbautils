set feed off
set head off

col users for 99999


select count(*) users
from dba_users;

prompt
exit
