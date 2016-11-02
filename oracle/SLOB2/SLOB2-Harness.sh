#!/bin/bash
# SLOB2 Harness - script for driving the Silly Little Oracle Benchmark v2 (SLOB2)
# Author: flashdba (http://flashdba.com)
# For information on SLOB go to: http://lmgtfy.com/?q=oracle+slob
#
# For educational purposes only - no warranty is provided
# Test thoroughly - use at your own risk
 
# SLOB2 Harness should be installed and run from the SLOB home
# i.e. the location in which you unpacked the SLOB tarball
 
# Define variables and defaults
DEFAULT_METADATA_FILE="slob2-harness.inf"
 
# Define counters and flags
ERRORCNT=0  # Count number of errors occurred
SLOBCNT=0   # Count number of SLOB executions
SLOBTOT=0   # Total number of required SLOB runs
SILENT=0    # 0 = No, 1 = Yes
VERBOSE=0   # 0 = No, 1 = Yes
DEBUG=0     # 0 = No, 1 = Yes
 
# Define constants
EXIT_SUCCESS=0      # Things went well
EXIT_FAILURE=1      # Things didn't go so well
EXIT_INTERRUPT=2    # User interrupted with CRTL-C
 
# Define functions for printing messages
echoerr() { echo "`date +%Y%m%d-%H%M%S` Error: $@" 1>&2; let ERRORCNT++; }
echoinf() { [[ "$SILENT" = 1 ]] || echo "`date +%Y%m%d-%H%M%S` Info : ${@}" 1>&2; }
echovrb() { [[ "$VERBOSE" = 1 ]] && echo "`date +%Y%m%d-%H%M%S` Info : ${@}" 1>&2; }
echodbg() { [[ "$DEBUG" = 1 ]] && echo "`date +%Y%m%d-%H%M%S` Debug: ${@}" 1>&2; }
 
# Function for handling a user interrupt (CTRL-C)
trap_user_interrupt() {
    echodbg "Entering trap_user_interrupt() with ERRORCNT=$ERRORCNT"
    echoerr "Received User Interrupt... exiting SLOB Harness"
    echoinf "Warning - SLOB processes may still be running, check with ps -f"
    exit_harness $EXIT_INTERRUPT
}
 
# Trap SIGINT i.e. user interrupting via CTRL-C
trap trap_user_interrupt INT
 
# Function for printing usage information
usage() {
    echodbg "Entering usage() with parameters: $@"
    if [ $# -gt 0 ]; then
        echo "Error: $@" 1>&2
        echo "" 1>&2
    fi
    echo "Usage: $0 [ -p | -P ] [ -s | -v ] [ -f  ]" 1>&2
    echo "" 1>&2
    echo "  Harness for driving SLOBv2 (the Silly Little Oracle Benchmark)"
    echo "" 1>&2
    echo "  Should be run from the directory in which SLOB is installed" 1>&2
    echo "" 1>&2
    echo "  Uses a metadata file to iterate through SLOB runs while varying:" 1>&2
    echo "      - The number of SLOB worker processes" 1>&2
    echo "      - The percentage of transactions which are DML" 1>&2
    echo "" 1>&2
    echo "  Options:" 1>&2
    echo "    -h   Help            (print this help information)" 1>&2
    echo "    -m   Metadata File   (specify non-default metadata file)" 1>&2
    echo "    -i   Infostamp       (print additional system information at the tail of each AWR report)" 1>&2
    echo "    -I   noInfostamp     (do not print the additional system information)" 1>&2
    echo "    -s   Silent          (do not print SLOB processing information)" 1>&2
    echo "    -v   Verbose         (show extra SLOB processing details)" 1>&2
    echo "" 1>&2
    echo "  If not overridden with the -m flag, the default metadata file is $DEFAULT_METADATA_FILE" 1>&2
    echo "" 1>&2
    exit $EXIT_FAILURE
}
 
# Function for exiting the SLOB harness via an attempted cleanup
exit_harness() {
    echodbg "Entering exit_harness() with parameters: $@"
    restore_slob_conf
    echoinf "-----------------------------------"
    echoinf "  Total submitted SLOB jobs: $SLOBTOT"
    echoinf "  Total completed SLOB jobs: $SLOBCNT"
    echoinf "-----------------------------------"
    [[ "$1" -gt 0 ]] && echoinf "FAILURE of slob-harness"
    exit $1
}
 
# Function for checking Oracle and SLOB environment
check_slob_environment() {
    # Check the environment is correctly setup for both Oracle and SLOB
    echodbg "Entering check_slob_environment()"
    # Check location of SLOB executable
    if [ \! -x ./runit.sh ]; then
        echoerr "Cannot locate SLOB run script at ./runit.sh - exiting..."
        exit $EXIT_FAILURE
    elif [ -z "$ORACLE_SID" ]; then
        echoerr "Environment variable ORACLE_SID not set - exiting..."
        exit $EXIT_FAILURE
    fi
 
    # Check location of SLOB configuration file
    if [ \! -r ./slob.conf ]; then
        echoerr "Cannot locate SLOB configuration file at ./slob.conf - exiting..."
        exit $EXIT_FAILURE
    else
        SLOB_CONF=slob.conf
        source ./slob.conf
    fi
 
    # Check to see if non-default metadata file was specified
    if [ -z "$METADATA_FILE" ]; then
        echovrb "Using default metadata file $DEFAULT_METADATA_FILE"
        METADATA_FILE=$DEFAULT_METADATA_FILE
    else
        echoinf "Using user-specified metadata file $METADATA_FILE"
    fi
}
 
read_metadata_file() {
    # Read the SLOB Harness metadata file to get values for workers and update percentage
    echodbg "Entering read_metadata_file()"
    # Test existence of file
    if [ -r "$METADATA_FILE" ]; then
        echovrb "Found readable metadata file $METADATA_FILE"
    else
        echoerr "Unable to read metadata file $METADATA_FILE - exiting..."
        exit $EXIT_FAILURE
    fi
 
    # Parse metadata file for WORKERS and UPDATE_PCT values
    UPDPCT_LIST=`cat $METADATA_FILE | sed '/^\#/d' | sed -n -e '/UPDATE_PCT/,/\/UPDATE_PCT/p' | grep -v "UPDATE_PCT" | tr -d '\r\f'`
    WORKER_LIST=`cat $METADATA_FILE | sed '/^\#/d' | sed -n -e '/WORKERS/,/\/WORKERS/p' | grep -v "WORKERS"`
    echoinf "`echo Update Pct list  : $UPDPCT_LIST | tr -d '\r\f'`"
    echoinf "`echo SLOB Worker list : $WORKER_LIST | tr -d '\r\f'`"
 
    # Calculate the total number of SLOB runs required
    SLOBTOT=`expr $(echo $UPDPCT_LIST | wc -w) \* $(echo $WORKER_LIST | wc -w)`
    echoinf "$SLOBTOT runs of SLOB will be required"
}
 
backup_slob_conf() {
    # Backup the existing slob.conf file prior to performing any manipulation of parameters
    echodbg "Entering backup_slob_conf()"
    if [ -w "$SLOB_CONF" ]; then
        echovrb "Copying slob configuration file $SLOB_CONF to ${SLOB_CONF}.backup"
        echovrb "EXCUTING cp $SLOB_CONF ${SLOB_CONF}.backup"
        cp $SLOB_CONF ${SLOB_CONF}.backup
        if [ "$?" != 0 ]; then
            echoerr "Cannot backup slob configuration file $SLOB_CONF to $SLOB_BACKUP_CONF"
            exit $EXIT_FAILURE
        else
            # Set variable so that the restore_slob_conf function can restore the backup
            SLOB_BACKUP_CONF=${SLOB_CONF}.backup
        fi
    else
        echoerr "Cannot edit slob configuration file $SLOB_CONF"
        exit $EXIT_FAILURE
    fi
}
 
manipulate_slob_conf() {
    # Manipulate the slob configuration file to remove the UPDATE_PCT line
    echodbg "Entering manipulate_slob_conf()"
    # This function is called AFTER backup_slob_conf and so we know the conf files exist
    # We therefore do not need to include extra tests to ensure they exist and are modifiable
    echovrb "Manipulating slob configuration file to remove UPDATE_PCT"
    echovrb "EXECUTING cat $SLOB_BACKUP_CONF | grep -v ^UPDATE_PCT > $SLOB_CONF"
    cat $SLOB_BACKUP_CONF | grep -v ^UPDATE_PCT > $SLOB_CONF
    if [ "$?" != 0 ]; then
        echoerr "Cannot manipulate slob configuration file $SLOB_CONF -> $SLOB_BACKUP_CONF"
        exit_harness $EXIT_FAILURE
    fi
}
 
create_infostamp_text() {
    # Create system information to be written to the tail of AWR reports
    echodbg "Entering create_infostamp_text()"
    if [ -r /etc/oracle-release ]; then
        local INFOSTAMP_LINUX="LINUX=`cat /etc/oracle-release`"
    elif [ -r /etc/redhat-release ]; then
        local INFOSTAMP_LINUX="LINUX=`cat /etc/redhat-release`"
    elif [ -r /etc/SuSE-release ]; then
        local INFOSTAMP_LINUX="LINUX=`cat /etc/SuSE-release`"
    else
        local INFOSTAMP_LINUX="LINUX=Unknown"
    fi
    local INFOSTAMP_KERNEL="KERNEL=`uname -r`"
    local INFOSTAMP_PROCESSOR="PROCESSOR=`grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2-`"
    AWR_INFOSTAMP_TEXT="======================================\n${INFOSTAMP_LINUX}\n${INFOSTAMP_KERNEL}\n${INFOSTAMP_PROCESSOR}"
    echodbg "`echo -e "Gathered system information:\n${AWR_INFOSTAMP_TEXT}"`"
}
 
print_awr_infostamp() {
    # Function for printing a stamp of system details to the end of the SLOB-produced AWR report
    echodbg "Entering print_awr_infostamp()"
    if [ -w awr.txt ]; then
        echovrb "Writing additional system information to tail of awr.txt"
    else
        echoerr "Cannot find writable file awr.txt - exiting..."
        exit_harness $EXIT_FAILURE
    fi
 
    echo -e $AWR_INFOSTAMP_TEXT >> awr.txt
    echo "SLOB UPDATE_PCT=$UPDATE_PCT" >> awr.txt
    echo "SLOB RUN_TIME=$RUN_TIME" >> awr.txt
    echo "SLOB WORK_LOOP=$WORK_LOOP" >> awr.txt
    echo "SLOB SCALE=$SCALE" >> awr.txt
    echo "SLOB WORK_UNIT=$WORK_UNIT" >> awr.txt
    echo "SLOB REDO_STRESS=$REDO_STRESS" >> awr.txt
    echo "SLOB LOAD_PARALLEL_DEGREE=$LOAD_PARALLEL_DEGREE" >> awr.txt
    echo "SLOB SHARED_DATA_MODULUS=$SHARED_DATA_MODULUS" >> awr.txt
}
 
rename_slob_output() {
    # Rename SLOB output files and place in new directory
    echodbg "Entering rename_slob_output() with parameters: $@"
    if [ "$#" != 2 ]; then
        echoerr "Function rename_slob_output() incorrectly called with parameters: $@"
        exit_harness $EXIT_FAILURE
    fi
    if [ -f "$1" ]; then
        echovrb "EXECUTING mv $1 $2"
        mv $1 $2
        if [ "$?" != 0 ]; then
            echoerr "Cannot mv $1 to $2 - exiting..."
            exit_harness $EXIT_FAILURE
        fi
    else
        echovrb "File not found - $1"
    fi
}
 
restore_slob_conf() {
    # Restore the slob.conf file from its backup
    echodbg "Entering restore_slob_conf()"
    if [ -z "$SLOB_BACKUP_CONF" ]; then
        echoinf "No known backup slob configuration file - restore unnecessary"
    elif [ -r "$SLOB_BACKUP_CONF" ]; then
        echovrb "Copying $SLOB_CONF to ${SLOB_CONF}.backup"
        echovrb "EXECUTING mv $SLOB_BACKUP_CONF $SLOB_CONF"
        mv $SLOB_BACKUP_CONF $SLOB_CONF
        if [ "$?" != 0 ]; then
            echoerr "Cannot restore backup slob configuration file $SLOB_BACKUP_CONF to $SLOB_CONF"
        else
            # Unset variable so that no further attempts can be made to restore the backup configuration file
            unset SLOB_BACKUP_CONF
        fi
    else
        echoerr "Cannot find slob backup configuration file $SLOB_BACKUP_CONF - unable to restore"
    fi
}
 
# Start of main program
 
# Process calling parameters
while getopts ":iIhm:svX" opt; do
    case $opt in
        i)
            # Print additional system information to the tail end of AWR reports
            [[ "$AWR_INFOSTAMP" = 0 ]] && usage "Print and noPrint are conflicting options"
            AWR_INFOSTAMP=1
            ;;
        I)
            # Do not print additional system information to the tail end of AWR reports
            [[ "$AWR_INFOSTAMP" = 1 ]] && usage "Print and noPrint are conflicting options"
            AWR_INFOSTAMP=0
            ;;
        h)
            # Print usage information and then exit
            usage
            ;;
        m)
            # Location of the metadata file
            [[ -z "$OPTARG" ]] && usage "Metadata File (-m) switch requires a filename"
            METADATA_FILE="$OPTARG"
            ;;
        s)
            [[ "$VERBOSE" = 1 ]] && usage "Silent and Verbose are conflicting options"
            SILENT=1
            ;;
        v)
            [[ "$SILENT" = 1 ]] && usage "Silent and Verbose are conflicting options"
            VERBOSE=1
            echovrb "Running in verbose mode"
            ;;
        X)
            DEBUG=1
            VERBOSE=1
            echodbg "Running in debug mode - expect lots of output..."
            ;;
        \?)
            usage "Invalid option -$OPTARG"
            ;;
    esac
done
 
# Set things up ready for execution
check_slob_environment
read_metadata_file
backup_slob_conf
manipulate_slob_conf
 
# Check if we are going to be printing additional system information in the AWR reports
AWR_INFOSTAMP=${AWR_INFOSTAMP:=1}
[[ "$AWR_INFOSTAMP" = 1 ]] && create_infostamp_text
 
# Start of SLOB calling loop - the outer loop iterates through UPDATE_PCT values, the inner loop through WORKERS values
 
echoinf "Starting slob-harness..."
 
for updatepct_value in $UPDPCT_LIST; do
 
    echoinf "Starting loop for UPDATE_PCT=$updatepct_value"
 
    export UPDATE_PCT=$updatepct_value
 
    for slobworkers in $WORKER_LIST; do
 
        echoinf "Calling SLOB with $slobworkers workers"
 
        # Create a string which will be used in all filenames for this run
        SLOB_RUNNAME=${updatepct_value}.${slobworkers}
 
        if [ "$VERBOSE" = 1 ]; then
            echovrb "EXECUTING ./runit.sh $((10#$slobworkers)) | tee slob_runit.${SLOB_RUNNAME}.out 2>&1"
            ./runit.sh $((10#$slobworkers)) | tee slob_runit.${SLOB_RUNNAME}.out 2>&1
            SLOB_RETVAL=$?
        else
            ./runit.sh $((10#$slobworkers)) > slob_runit.${SLOB_RUNNAME}.out 2>&1
            SLOB_RETVAL=$?
        fi
 
        if [ "$SLOB_RETVAL" = 0 ]; then
            echoinf "Completed SLOB run for $slobworkers workers: `grep ^Tm slob_runit.${SLOB_RUNNAME}.out`"
            let SLOBCNT++
        else
            echoerr "SLOB returned error code $SLOB_RETVAL - exiting..."
            exit_harness $EXIT_FAILURE
        fi
 
        if [ "$AWR_INFOSTAMP" = 1 ]; then
            # Add system details to the end of the AWR report
            print_awr_infostamp
        fi
 
        # Create a directory in which the output files can reside
        if [ -d awr.${SLOB_RUNNAME} ]; then
            echovrb "Directory awr.${SLOB_RUNNAME} already exists..."
        else
            echovrb "EXECUTING mkdir awr.${SLOB_RUNNAME}"
            mkdir awr.${SLOB_RUNNAME}
            if [ "$?" != 0 ]; then
                echoerr "Cannot create directory awr.${SLOB_RUNNAME} - exiting..."
                exit_harness $EXIT_FAILURE
            fi
        fi
 
        # Move the various AWR reports into the new directory
        rename_slob_output awr.txt awr.${SLOB_RUNNAME}/awr.${SLOB_RUNNAME}.txt
        rename_slob_output awr.html.gz awr.${SLOB_RUNNAME}/awr.${SLOB_RUNNAME}.html.gz
        rename_slob_output awr_rac.html.gz awr.${SLOB_RUNNAME}/awr_rac.${SLOB_RUNNAME}.html.gz
        # Move the various out files into the new directory
        rename_slob_output iostat.out awr.${SLOB_RUNNAME}/iostat.${SLOB_RUNNAME}.out
        rename_slob_output mpstat.out awr.${SLOB_RUNNAME}/mpstat.${SLOB_RUNNAME}.out
        rename_slob_output vmstat.out awr.${SLOB_RUNNAME}/vmstat.${SLOB_RUNNAME}.out
        rename_slob_output db_stats.out awr.${SLOB_RUNNAME}/db_stats.${SLOB_RUNNAME}.out
        rename_slob_output slob_runit.${SLOB_RUNNAME}.out awr.${SLOB_RUNNAME}/slob_runit.${SLOB_RUNNAME}.out
 
        echoinf "   SLOB Harness is `expr $SLOBCNT \* 100 / $SLOBTOT`% complete"
    done
 
done
 
echoinf "Successfully completed slob-harness"
 
exit_harness $EXIT_SUCCESS
 
# EOF