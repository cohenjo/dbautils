#!/bin/ksh
. ~/.profile
for sid in `awk 'BEGIN {FS=":"} {if ($3=="Y" && $1!="*")  { print $1 }} ' /etc/oratab  `
do
export ORACLE_SID=$sid
echo "Checking $ORACLE_SID : \c"
sqlplus -s "/ as sysdba" <<*EOF*
set pages 0
set lines 80
set feed off
col alloc for 9,999.99
col db for a10
    select '   '||
        'Alloc: '||to_char(a.bytes+nvl(f.bytes,0)+l.bytes,'9,999.9')||'  '||
        'Free: '||to_char(fr.bytes,'9,999.9')||'    '||
        'Used: '||to_char(a.bytes+nvl(f.bytes,0)+l.bytes-fr.bytes,'9,999.9')
    from
    (select sum(bytes)/1024/1024/1024 bytes from dba_data_files) a,
    (select sum(bytes)/1024/1024/1024 bytes from dba_temp_files) f,
    (select sum(bytes)/1024/1024/1024 bytes from v\$log) l,
    (select sum(bytes)/1024/1024/1024 bytes from dba_free_space) fr;
*EOF*
done
