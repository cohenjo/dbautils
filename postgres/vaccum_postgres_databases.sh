#!/bin/bash

currentDate=$(date +%F)
currentDayInWeek=$(date +%w)
currentMonth=$(date +%m)
monthOfNextSaturday=$(date -d "next Saturday" +%m)
SATURDAY="6"
script=/tmp/vaccumdb.bash
log=~/vaccum_runs.txt
> $script
chmod +x $script

if [ "$currentDayInWeek" == "$SATURDAY" ]
then
	if [ $currentMonth != $monthOfNextSaturday ]
	then
		psql -U postgres -c "select 'vacuumdb -zf -d ' || datname from pg_database where datistemplate=false;" | grep vacuumdb > /tmp/vaccumdb.bash
	else
		psql -U postgres -c "select 'vacuumdb -z -d ' || datname from pg_database where datistemplate=false;" | grep vacuumdb > /tmp/vaccumdb.bash
	fi
fi

psql -U postgres -c "select 'vacuumdb -d ' || datname || ' -t qrtz_triggers' from pg_database where datname like '%mng%';" | grep vacuumdb >> /tmp/vaccumdb.bash
psql -U postgres -c "select 'vacuumdb -d ' || datname || ' -t qrtz_fired_triggers' from pg_database where datname like '%mng%';" | grep vacuumdb >> /tmp/vaccumdb.bash
psql -U postgres -c "select 'vacuumdb -d ' || datname || ' -t qrtz_cron_triggers' from pg_database where datname like '%mng%';" | grep vacuumdb >> /tmp/vaccumdb.bash
	
echo "`date +%F' '%T`: Running $script" >> "$log"
$script
if [ $? -eq 0 ]
then
	echo "`date +%F' '%T`: $script exit code was 0" >> "$log"
	exit 0
else
	echo "`date +%F' '%T`: $script exit code was not 0" >> "$log"
	exit 1
fi

exit 0
