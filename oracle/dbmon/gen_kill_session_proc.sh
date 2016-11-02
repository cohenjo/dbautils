#!/bin/ksh
########################################################
# Gen Kill Session - procedure to kill your own process
# 28/11/2011 - Adi Zohar
########################################################

echo "
set echo on pages 100 time on 
spool /oravl01/oracle/dba/LOGS/gen_kill_session_proc.log

prompt Creating Procedure SYS.KILL_SESSION
CREATE OR REPLACE procedure SYS.kill_session( p_sid in number)
is
    cursor_name     pls_integer default dbms_sql.open_cursor;
    p_serial#       number;
    ignore          pls_integer;
BEGIN
    --------------------------------------------------------
    -- kill procedure written by Adi Zohar - 28/11/2011
    --------------------------------------------------------
    select count(*) into ignore from v\$session where username = USER and sid = p_sid ;

    if ( ignore = 1 )
    then
        select serial# into p_serial# from v\$session where username = USER and sid = p_sid ;
        dbms_sql.parse(cursor_name, 'alter system kill session ''' ||p_sid||','||p_serial#||''''||' immediate', dbms_sql.native);
        ignore := dbms_sql.execute(cursor_name);
    else
        raise_application_error( -20001, 'You do not own session sid=' || p_sid  );
    end if;
END;
/
show error
prompt Grant Execute on SYS.KILL_SESSION to PUBLIC
grant execute on SYS.kill_session to public;

prompt Create Public Synonym
create or replace public synonym kill_session for SYS.kill_session;
spool off
" | sqlplus -s "/ as sysdba"
