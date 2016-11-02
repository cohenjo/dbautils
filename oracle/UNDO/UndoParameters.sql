set lines 120
set pages 999
clear col

set termout off
set trimout on
set trimspool on

connect / as sysdba
alter session set nls_date_format='dd-Mon-yyyy hh24:mi';

spool undoparameters.out

prompt
prompt  ############## RUNTIME ############## 
prompt

col rdate head "Run Time"

select sysdate rdate from dual;

col inst_id format 999 head "Instance #"
col Parameter format a35 wrap
col "Session Value" format a25 wrapped
col "Instance Value" format a25 wrapped

prompt
prompt  ############## PARAMETERS ############## 
prompt

select  a.inst_id, a.ksppinm  "Parameter",
             b.ksppstvl "Session Value",
             c.ksppstvl "Instance Value"
      from x$ksppi a, x$ksppcv b, x$ksppsv c
     where a.indx = b.indx and a.indx = c.indx
       and a.inst_id=b.inst_id and b.inst_id=c.inst_id
       and a.ksppinm in ('_undo_autotune', '_smu_debug_mode',
                         '_highthreshold_undoretention',
                'undo_tablespace','undo_retention','undo_management')
order by 2;

spool off
set termout on
set trimout off
set trimspool off
clear col