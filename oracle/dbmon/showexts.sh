#! /usr/bin/sh -f
######################################################################
# Name    : vsexts.sh
#
# Created : Yair Ron & Mohan Naik  - Dec 07 2000
#
# Purpose : Check the Objects for Available Space for Next 10 Extents 
#           / Lack of space 
#
# Inout   : vsexts.sh 
#
# Output  : Boolean ( number of least extents that an object can extent
#           in worst case)
#
#          ITO	   Number of       
#	   Error   Extents   Severity	Description
#         -----------------------------------------------------------------
# Range   : 0-3	   6 to 9    MINOR 	This Object can extent for another 
#					6 to 9 extents.
#         : 4-7    2 to 5    MAJOR      Needs attention and planning .
#         : 8&9    0 and 2   CRITICAL   JUMP START 
#
#######################################################################
SORT='/usr/bin/sort'
NumNextExt=5
Sids=''
SID=''
OK=0
Stat=0
Err0=0
Err1=1
Err2=2
Err3=3
Err4=4
Err5=5
Err6=6
Err7=7
Err8=8
Err9=9

ExitErr ()

{
exit
}

GetSids ()
{
if test $# -eq 0
  then if test -s /etc/oratab
         then Sids=`awk -F: '($3=="Y") {print $1}' /etc/oratab | $SORT -r`
         else return $...
       fi
  else
  Sids=`echo $@ | tr "[:lower:]" "[:upper:]"`
fi
return $OK
}

SetSid ()
{
ORACLE_SID=` grep $SID /etc/oratab | awk -F: '{ if ( $3 == "Y" ) { print $1 } else { print "" } }'`
if test "$ORACLE_SID" = "$SID"
        then export ORACLE_SID
             unset TWO_TASK
        else ORACLE_SID=$SID
             TWO_TASK=$SID
             export ORACLE_SID
             export TWO_TASK
fi
return $OK
}

SetHome ()
{
if test "$ORACLE_SID" = "$TWO_TASK"
        then ORACLE_HOME=` grep -v '^#' /etc/oratab | grep -v '^$' | head -1 | cut -d: -f2`
        else ORACLE_HOME=` grep $SID /etc/oratab | awk -F: '{ if ( $3 == "Y" ) { print $2 } else { print '' } }'`
fi
export ORACLE_HOME
SqlPlus=$ORACLE_HOME/bin/sqlplus
export SqlPlus
return $OK
}

ChkUp ()
{
Cnt=` echo 'show user' | $SqlPlus -s $USHOW/$PSHOW | wc -l `
if test $Cnt -ne 1
  then return $Err1
  else return $OK
fi
return $Err9
}

CreateTable ()
{
$SqlPlus -s $USHOW/$PSHOW <<*EOQ* >> /dev/null
drop table dba_exts
/
create table dba_exts
as
select seg.owner, seg.segment_name, seg.segment_type, seg.tablespace_name
     , 'next_extent [MB]    ' desc_1
     , seg.next_extent/power(1024,2) value_1
     , '                    ' desc_2
     , (seg.bytes*0) value_2
     , 'Number of Next Extent    ' error_desc
     , (seg.bytes*0) error_value
from sys.dba_segments seg
where seg.segment_type         in ( 'TABLE','INDEX','ROLLBACK','CLUSTER' )
/
update dba_exts
set ( error_value )
  = ( select sum(trunc(((free.bytes/power(1024,2))/dba_exts.value_1),0))
                   from dba_free_space free
                   where free.tablespace_name = dba_exts.tablespace_name )
/
commit
/
insert into dba_exts ( owner,segment_name,segment_type,tablespace_name
                      ,desc_1,value_1
                      ,desc_2,value_2
                      ,error_desc,error_value )
select t.owner,t.table_name,'Table',t.tablespace_name
      ,'max_extents',t.max_extents
      ,'number of extents',s.number_of_extents
      ,'Max Extents Exceeded'
      ,( t.max_extents - s.number_of_extents )
from dba_tables t, ( select owner,segment_name,tablespace_name,sum(extents) number_of_extents
                     from dba_segments
                     group by owner,segment_name,tablespace_name ) s
where t.owner = s.owner
  and t.table_name = s.segment_name
  and t.tablespace_name = s.tablespace_name
/
commit
/
insert into dba_exts ( owner,segment_name,segment_type,tablespace_name
                      ,desc_1,value_1
                      ,desc_2,value_2
                      ,error_desc,error_value )
select t.owner,t.index_name,'Index',t.tablespace_name
      ,'max_extents',t.max_extents
      ,'number of extents',s.number_of_extents
      ,'Max Extents Exceeded'
      ,( t.max_extents - s.number_of_extents )
from dba_indexes t, ( select owner,segment_name,tablespace_name,sum(extents) number_of_extents
                     from dba_segments
                     group by owner,segment_name,tablespace_name ) s
where t.owner = s.owner
  and t.index_name = s.segment_name
  and t.tablespace_name = s.tablespace_name
/
commit
/
insert into dba_exts ( owner,segment_name,segment_type,tablespace_name
                      ,desc_1,value_1
                      ,desc_2,value_2
                      ,error_desc,error_value )
select t.owner,t.cluster_name,'Cluster',t.tablespace_name
      ,'max_extents',t.max_extents
      ,'number of extents',s.number_of_extents
      ,'Max Extents Exceeded'
      ,( t.max_extents - s.number_of_extents )
from dba_clusters t, ( select owner,segment_name,tablespace_name,sum(extents) number_of_extents
                     from dba_segments
                     group by owner,segment_name,tablespace_name ) s
where t.owner = s.owner
  and t.cluster_name = s.segment_name
  and t.tablespace_name = s.tablespace_name
/
commit
/
*EOQ*
}

RunReport ()
{
$SqlPlus -s $USHOW/$PSHOW <<*EOQ*
set feed off
set pagesize 127
set linesize 255
ttitle 'Critical Conditions on $ORACLE_SID|Object with less then 10 more Extents to allocate'

col     tablespace_name format  a15     head    'TbaleSpace Name'
col     owner           format  a12     head    'Owner'
col     segment_name    format  a25     head    'Object Name'
col     segment_type    format  a11     head    'Object Type'
col	desc_1		format	a20	head	'Parameter'
col	value_1		format	999,999	head	'Value'
col     error_value	format  999     head    'Error Value'
col	error_desc	format	a25	head	'Error Descrioption'

select tablespace_name, owner, segment_name, segment_type
     , desc_1, value_1
     , error_desc, error_value
from dba_exts
where error_value <= $NumNextExt
order by error_value
/
*EOQ*
}

RunSql ()
{
CreateTable
RunReport
}


#############################################################
#
#   M A I N

GetSids $*
Stat=$?
if test Stat -ne OK
  then ExitErr
fi

for SID in $Sids
do

SetSid
Stat=$?
if test Stat -ne OK
  then ExitErr
fi

SetHome
Stat=$?
if test Stat -ne OK
  then ExitErr
fi

ChkUp
Stat=$?
if test Stat -ne OK
  then ExitErr
fi

RunSql
Stat=$?
if test Stat -ne OK
  then ExitErr
fi

done

ExitErr
