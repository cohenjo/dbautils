#!/bin/sh

connect()
{
        echo "set echo on time on timing on 
        prompt exec dbms_lock.sleep(5);
" | sqlplus -s / > /dev/null
}

##########################3
# Main 
##########################3

i=0
echo "Start at `date`"
while (( i < 100 ))
do
        connect $i &
        (( i = i + 1 ))
done
echo "Processes Submitted = $i"
wait
echo "End   at `date`"


