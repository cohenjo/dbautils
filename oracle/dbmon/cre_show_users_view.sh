#!/bin/ksh 
#***********************************************************************
#
# Script Name    : show_users_view.sh
#
# create the show_user_view and show_users_view at SYS
#
# By Adi Zohar - Feb 2003
#***********************************************************************
. ~/.profile

ORATAB=/etc/oratab
#***********************************************************************
for NEW_SID in `grep -v "^#" ${ORATAB} | awk 'BEGIN {FS=":"} {if ($3=="Y")  { print $1 }} '|grep -v "*"`
do
    export ORACLE_SID=${NEW_SID}

    echo "set echo off verify off pages 0
    select substr(version,0,3) version from v\$instance;
    " | sqlplus -s / | read DB_VERSION

    echo "Running on $NEW_SID - $DB_VERSION "
    echo "----------------------------------------------"
    if [ $DB_VERSION = "8.0" ]
    then
	echo "Create 8.0 view"
#----------------------------------------------
	echo "set echo off verify off pages 0
@$AUTO_CONN sys
create or replace view show_users_view as
select 	s.user# user_id, 
	sum(blocks) blocks
from sys.seg\$ s
group by s.user# ;
grant select on show_users_view to public;
create or replace view show_user_view as
select 	s.user# user_id, 
	s.ts# tablespace_id, 
	sum(blocks) blocks
from sys.seg\$ s
group by s.user# , s.ts#;
grant select on show_user_view to public;
" | sqlplus -s /
#----------------------------------------------
    else
	echo "Create 8.1 view"
#----------------------------------------------
echo "set echo off verify off pages 0
create or replace view show_users_view as
select /*+ ordered  use_nl (s,e, */ 
	s.user# user_id, 
	sum(decode(bitand(NVL(s.spare1, 0), 1), 1,e.ktfbueblks,s.blocks) )  blocks
from sys.seg\$ s, sys.x\$ktfbue e
where e.ktfbuesegfno (+) = s.file# 
  and e.ktfbuesegbno (+) = s.block# 
  and e.ktfbuesegtsn (+) = s.ts# 
group by s.user# ;
grant select on show_users_view to public;
create or replace view show_user_view as
select /*+ ordered  use_nl (s,e, */ 
	s.user# user_id, 
	s.ts# tablespace_id, 
	sum(decode(bitand(NVL(s.spare1, 0), 1), 1,e.ktfbueblks,s.blocks) )  blocks
from sys.seg\$ s, sys.x\$ktfbue e
where e.ktfbuesegfno (+) = s.file# 
  and e.ktfbuesegbno (+) = s.block# 
  and e.ktfbuesegtsn (+) = s.ts# 
group by s.user# , s.ts#;
grant select on show_user_view to public;
" | sqlplus -s "/ as sysdba"
#----------------------------------------------
    fi

done
exit 
    $ORACLE_HOME/bin/sqlplus -s /  << %EOI%   >> $log_file 2>> $log_file
conn /
@$AUTO_CONN sys
exit
%EOI%
done


