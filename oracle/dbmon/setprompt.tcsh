set SID=`echo $ORACLE_SID | tr 'a-z' 'A-Z'`
echo -n "]2;`hostname` _ `echo ${USER} | tr 'a-z' 'A-Z'` _ ${SID}   DIR=`pwd`"
echo -n "]1;$HOST"
set prompt = "${HOST}:${USER}%> "
