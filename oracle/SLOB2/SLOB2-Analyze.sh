#!/bin/bash
# SLOB2 Analyze - script for analyzing AWR reports from SLOB2 Harness to track latency and IOPS stats
# Author: flashdba (http://flashdba.com)
# The output is a CSV file which can be used in spreadsheet software to create graphs
#
# For educational purposes only - no warranty is provided
# Test thoroughly - use at your own risk
 
# Counters
ERRCNT=0    # Number of errors experienced
FILECNT=0   # Number of files found
PROCCNT=0   # number of files processes
 
# Define search items from AWR text
AWR_READ_IOPS="physical read total IO requests"
AWR_WRITE_IOPS="physical write total IO requests"
AWR_REDO_IOPS="redo writes"
AWR_DBF_SEQREAD="db file sequential read"
AWR_DBF_PXWRITE="db file parallel write"
AWR_LOG_PXWRITE="log file parallel write"
 
# Some additional columns which, for now, have to be manually populated later on
INFO_VOLMANAGER="ASM"       # ASM or Filesystem?
INFO_ASMLIB="Unknown"       # Is ASMLib in use?
INFO_ASM_SECTOR_SIZE="Unknown"  # The sector size of the ASM diskgroup
INFO_REDO_BLOCKSIZE="Unknown"   # The blocksize of the database redo logs
INFO_STORAGE="Unknown"      # Name of storage product
INFO_CONNECTIVITY="8GFC"    # Fibre channel, Infiniband, iSCSI etc
INFO_STORAGE_PBA="4096"     # Storage Physical Blocksize
INFO_STORAGE_LBA="Unknown"  # Storage Logical Blocksize
 
echoerr() { echo "Error: $@" 1>&2; let ERRCNT++; }
echoinf() { echo "Info : $@" 1>&2; }
echocsv() { echo "$@"; }
 
usage() {
    echo ""
    echo "Usage: $0 <awr-filename.txt> (wildcards are accepted)"
    echo ""
    echo "  Redirect stdout to a CSV file to import into a spreadheet"
    echo "  Errors and info are printed to stderr"
    echo ""
    echo "  Example usage:"
    echo "    $0 awr*.txt > awr.csv"
    echo ""
    echo "  For use with AWR reports generated using the SLOB2 Harness"
    echo "  Expects filenames to be in form awr.<update_pct>.<workers>.txt"
    echo ""
    exit 1
}
 
[[ $# -eq 0 ]] && usage
 
echocsv "Filename,Update Pct,Workers,Read IOPS,Write IOPS,Redo IOPS,Total IOPS,Read Num Waits,Read Wait Time (s),Read Latency (us),Write Num Waits,Write Wait Time (s),Write Latency (us),Redo Num Waits,Redo Wait Time (s),Redo Latency (us),CPUs,CPU Cores,CPU Sockets,Linux Version,Kernel Version,Processor Type,SLOB Run Time,SLOB Work Loop,SLOB Scale,SLOB Work Unit,SLOB Redo Stress,SLOB Shared Data Modulus,Volume Manager,ASMLib?,ASM Sector Size,DB Redo Blocksize,Storage,Connectivity,Storage Physical Blocksize,Storage Logical Blocksize"
 
while (( "$#" )); do
    let FILECNT++
    if [ -r "$1" ]; then
        FILE=$1
        echoinf "Analyzing file $FILE"
        CHECK_HTML=$(sed -n -e '1,5 p' $FILE | grep "<HTML>" | wc -l)
        CHECK_AWR=$(sed -n -e '1,5 p' $FILE | grep WORKLOAD | wc -l)
        if [ $CHECK_HTML -gt "0" ]; then
            echoerr "$1 is in HTML format - ignoring..."
        elif [ $CHECK_AWR -gt "0" ]; then
            # Strip any path from filename
            FILENAME=`basename $FILE`
 
            # Attempt to deduce UPDATE_PCT and WORKERS values from filename
            TMPVAL=`echo $FILENAME | cut -d. -f2`
            case $TMPVAL in
                *[!0-9]*)   echoinf "Cannot deduce UPDATE_PCT from filename $FILENAME, found $TMPVAL"
                        SLOB_UPDATE_PCT="Unknown"
                        ;;
                "")     echoinf "Cannot deduce UPDATE_PCT from filename $FILENAME"
                        SLOB_UPDATE_PCT="Unknown"
                        ;;
                *)      SLOB_UPDATE_PCT=$TMPVAL
                        ;;
            esac
            TMPVAL=`echo $FILENAME | cut -d. -f3`
            case $TMPVAL in
                *[!0-9]*)   echoinf "Cannot deduce SLOB_WORKERS from filename $FILENAME, found $TMPVAL"
                        SLOB_WORKERS="Unknown"
                        ;;
                "")     echoinf "Cannot deduce SLOB_WORKERS from filename $FILENAME"
                        SLOB_WORKERS="Unknown"
                        ;;
                *)      SLOB_WORKERS=$TMPVAL
                        ;;
            esac
 
            # Grab IOPS values and calculate total IOPS
            READ_IOPS=$(sed -n -e '/Instance Activity Stats/,/Tablespace/p' $FILE | grep "$AWR_READ_IOPS"| cut -c53-66|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            WRITE_IOPS=$(sed -n -e '/Instance Activity Stats/,/Tablespace/p' $FILE | grep "$AWR_WRITE_IOPS"| cut -c53-66|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            REDO_IOPS=$(sed -n -e '/Instance Activity Stats/,/Tablespace/p' $FILE | grep "$AWR_REDO_IOPS"| cut -c53-66|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            TOTAL_IOPS=`echo "$READ_IOPS + $WRITE_IOPS + $REDO_IOPS" | bc -l`
 
            # Work out average latency from DB FILE SEQUENTIAL READ wait events and convert to microseconds (us)
            READ_NUM_WAITS=$(sed -n -e '/Foreground Wait Events/,/Background Wait Events/p' $FILE |grep "$AWR_DBF_SEQREAD" |cut -c29-39|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            READ_WAIT_TIME=$(sed -n -e '/Foreground Wait Events/,/Background Wait Events/p' $FILE |grep "$AWR_DBF_SEQREAD" |cut -c47-56|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            if [ -z "$READ_NUM_WAITS" ]; then
                READ_NUM_WAITS=0
                READ_LATENCY_u=""
            elif [ "$READ_NUM_WAITS" -gt 0 ]; then
                READ_LATENCY_u=`echo "scale=3; $READ_WAIT_TIME * 1000000 / $READ_NUM_WAITS" | bc -l`
            else
                READ_LATENCY_u=""
            fi
 
            # Work out average latency from DB FILE PARALLEL WRITE wait events and convert to microseconds (us)
            WRITE_NUM_WAITS=$(sed -n -e '/Background Wait Events/,/Wait Event Histogram/p' $FILE |grep "$AWR_DBF_PXWRITE" |cut -c29-39|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            WRITE_WAIT_TIME=$(sed -n -e '/Background Wait Events/,/Wait Event Histogram/p' $FILE |grep "$AWR_DBF_PXWRITE" |cut -c47-56|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            if [ -z "$WRITE_NUM_WAITS" ]; then
                WRITE_NUM_WAITS=0
                WRITE_LATENCY_u=""
            elif [ "$WRITE_NUM_WAITS" -gt 0 ]; then
                WRITE_LATENCY_u=`echo "scale=3; $WRITE_WAIT_TIME * 1000000 / $WRITE_NUM_WAITS" | bc -l`
            else
                WRITE_LATENCY_u=""
            fi
 
            # Work out average latency from LOG FILE PARALLEL WRITE wait events and convert to microseconds (us)
            REDO_NUM_WAITS=$(sed -n -e '/Background Wait Events/,/Wait Event Histogram/p' $FILE |grep "$AWR_LOG_PXWRITE" |cut -c29-39|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            REDO_WAIT_TIME=$(sed -n -e '/Background Wait Events/,/Wait Event Histogram/p' $FILE |grep "$AWR_LOG_PXWRITE" |cut -c47-56|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            if [ -z "$REDO_NUM_WAITS" ]; then
                REDO_NUM_WAITS=0
                REDO_LATENCY_u=""
            elif [ "$REDO_NUM_WAITS" -gt 0 ]; then
                REDO_LATENCY_u=`echo "scale=3; $REDO_WAIT_TIME * 1000000 / $REDO_NUM_WAITS" | bc -l`
            else
                REDO_LATENCY_u=""
            fi
 
            # Get CPU information from AWR report
            AWR_NUM_CPUS=$(sed -n -e '/^NUM_CPUS/p' $FILE |cut -c27-48|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            AWR_NUM_CPU_CORES=$(sed -n -e '/^NUM_CPU_CORES/p' $FILE |cut -c27-48|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
            AWR_NUM_CPU_SOCKETS=$(sed -n -e '/^NUM_CPU_SOCKETS/p' $FILE |cut -c27-48|sed -e 's/,//g'|sed -e 's/^[[:space:]]*//')
 
            # SLOB2 Harness has the option to print an infostamp to the end of each AWR file
            # Test for the existence of this infostamp and parse if found
            AWR_INFOSTAMP=$(sed -n -e '/======================================/,$p' $FILE)
            if [ `echo -n "$AWR_INFOSTAMP" | wc -l` -gt 0 ]; then
                # Infostamp exists
                INFO_LINUX=$(echo -n "$AWR_INFOSTAMP" | grep "^LINUX=" | cut -d= -f2)
                INFO_KERNEL=$(echo -n "$AWR_INFOSTAMP" | grep "^KERNEL=" | cut -d= -f2)
                INFO_PROCESSOR=$(echo -n "$AWR_INFOSTAMP" | grep "^PROCESSOR=" | cut -d= -f2)
                INFO_RUN_TIME=$(echo -n "$AWR_INFOSTAMP" | grep "^SLOB RUN_TIME=" | cut -d= -f2)
                INFO_WORK_LOOP=$(echo -n "$AWR_INFOSTAMP" | grep "^SLOB WORK_LOOP=" | cut -d= -f2)
                INFO_SCALE=$(echo -n "$AWR_INFOSTAMP" | grep "^SLOB SCALE=" | cut -d= -f2)
                INFO_WORK_UNIT=$(echo -n "$AWR_INFOSTAMP" | grep "^SLOB WORK_UNIT=" | cut -d= -f2)
                INFO_REDO_STRESS=$(echo -n "$AWR_INFOSTAMP" | grep "^SLOB REDO_STRESS=" | cut -d= -f2)
                INFO_SHARED_DATA_MODULUS=$(echo -n "$AWR_INFOSTAMP" | grep "^SLOB SHARED_DATA_MODULUS=" | cut -d= -f2)
            else
                INFO_LINUX="Unknown"
                INFO_KERNEL="Unknown"
                INFO_PROCESSOR="Unknown"
                INFO_RUN_TIME="Unknown"
                INFO_WORK_LOOP="Unknown"
                INFO_SCALE="Unknown"
                INFO_WORK_UNIT="Unknown"
                INFO_REDO_STRESS="Unknown"
                INFO_SHARED_DATA_MODULUS="Unknown"
            fi
 
            # Print harvested information to errinf function
            echoinf "            Filename = $FILENAME"
            echoinf "          Update Pct = $SLOB_UPDATE_PCT"
            echoinf "             Workers = $SLOB_WORKERS"
            echoinf "           Read IOPS = $READ_IOPS"
            echoinf "          Write IOPS = $WRITE_IOPS"
            echoinf "           Redo IOPS = $REDO_IOPS"
            echoinf "          Total IOPS = $TOTAL_IOPS"
            echoinf "      Read Num Waits = $READ_NUM_WAITS"
            echoinf "      Read Wait Time = $READ_WAIT_TIME"
            echoinf "     Read Latency us = $READ_LATENCY_u"
            echoinf "     Write Num Waits = $WRITE_NUM_WAITS"
            echoinf "     Write Wait Time = $WRITE_WAIT_TIME"
            echoinf "    Write Latency us = $WRITE_LATENCY_u"
            echoinf "      Redo Num Waits = $REDO_NUM_WAITS"
            echoinf "      Redo Wait Time = $REDO_WAIT_TIME"
            echoinf "     Redo Latency us = $REDO_LATENCY_u"
            echoinf "            Num CPUs = $AWR_NUM_CPUS"
            echoinf "       Num CPU Cores = $AWR_NUM_CPU_CORES"
            echoinf "     Num CPU Sockets = $AWR_NUM_CPU_SOCKETS"
            echoinf "       Linux Version = $INFO_LINUX"
            echoinf "      Kernel Version = $INFO_KERNEL"
            echoinf "      Processor Type = $INFO_PROCESSOR"
            echoinf "       SLOB Run Time = $INFO_RUN_TIME"
            echoinf "      SLOB Work Loop = $INFO_WORK_LOOP"
            echoinf "          SLOB Scale = $INFO_SCALE"
            echoinf "      SLOB Work Unit = $INFO_WORK_UNIT"
            echoinf "    SLOB Redo Stress = $INFO_REDO_STRESS"
            echoinf "SLOB Shared Data Mod = $INFO_SHARED_DATA_MODULUS"
 
            # Write values to CSV file
            echocsv "$FILENAME,$SLOB_UPDATE_PCT,$SLOB_WORKERS,$READ_IOPS,$WRITE_IOPS,$REDO_IOPS,$TOTAL_IOPS,$READ_NUM_WAITS,$READ_WAIT_TIME,$READ_LATENCY_u,$WRITE_NUM_WAITS,$WRITE_WAIT_TIME,$WRITE_LATENCY_u,$REDO_NUM_WAITS,$REDO_WAIT_TIME,$REDO_LATENCY_u,$AWR_NUM_CPUS,$AWR_NUM_CPU_CORES,$AWR_NUM_CPU_SOCKETS,$INFO_LINUX,$INFO_KERNEL,$INFO_PROCESSOR,$INFO_RUN_TIME,$INFO_WORK_LOOP,$INFO_SCALE,$INFO_WORK_UNIT,$INFO_REDO_STRESS,$INFO_SHARED_DATA_MODULUS,$INFO_VOLMANAGER,$INFO_ASMLIB,$INFO_ASM_SECTOR_SIZE,$INFO_REDO_BLOCKSIZE,$INFO_STORAGE,$INFO_CONNECTIVITY,$INFO_STORAGE_PBA,$INFO_STORAGE_LBA"
 
            let PROCCNT++
        else
            echoerr "$1 is not an AWR file"
        fi
    else
        echoerr "Cannot read file $1 - ignoring..."
    fi
shift
 
done
 
echoinf "No more files found"
echoinf "============================="
echoinf "  AWR Files Found     = $FILECNT"
echoinf "  AWR Files Processed = $PROCCNT"
echoinf "  Errors Experienced  = $ERRCNT"
echoinf "============================="
 
if [ $ERRCNT -gt 0 ]; then
    exit 1
else
    exit 0
fi
#EOF