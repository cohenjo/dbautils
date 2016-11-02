set termout off echo off veri off termout on feed off heading off

-- change to sys.user$ to support 11G by AZ - 10/1/2011

define _username = '&1';
conn /

select 'User does NOT exist' from dual where upper('&_username') not in (select username from all_users);

prompt Connecting to user &_username

set feedback on heading on termout off

define _password = "EeLESY/E_e3=a_fQiM>+EIiUX"
column password new_value _password noprint

select password from sys.user$ where name = upper('&&_username');
alter user &&_username identified by temporary_dummy_password_;
connect &&_username/temporary_dummy_password_
alter user &&_username identified by values '&&_password';

column password clear
undefine _username
undefine _password
set termout on
show user
