set termout off
set echo off
set veri off
set termout on

define _user = '&1';

set feedback off
set heading off

select 'User does NOT exist'
from dual
where upper('&_user') not in (select username from all_users);

prompt Connecting to user &_user

set feedback on
set heading on

set termout off

define _password = "EeLESY/E_e3=a_fQiM>+EIiUX"
column password new_value _password noprint

select password from dba_users where username = upper('&&_user');

alter user &&_user identified by temporary_dummy_password_;

connect &&_user/temporary_dummy_password_

alter user &&_user identified by values '&&_password';

column password clear
undefine _user
undefine _password
set termout on
show user
