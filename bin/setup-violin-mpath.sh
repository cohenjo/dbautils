#!/bin/bash
# setup-violin-mpath.sh - script for configuring the multipath.conf file with Violin devices
# Author: flashdba (http://flashdba.com)
# The output can be cut and pasted into the "multipaths {}" section of /etc/multipath.conf
#
# For educational purposes only - no warranty is provided
# Test thoroughly - use at your own risk
 
# TODO: Currently only written for use with Red Hat 6 / Oracle Linux 6
 
# Setup variables and arrays
VERBOSE=0
MULTIPATH_DEVICES=()
 
# Setup print functions
echoerr() { echo "Error: $@" 1&gt;&amp;2; }
echovrb() { [[ "$VERBOSE" = 1 ]] &amp;&amp; echo "Info : ${@}" 1&gt;&amp;2; }
echoout() { echo "$@"; }
 
# Function for printing usage information
usage() {
    echo "" 1&gt;&amp;2
    if [ "$#" -gt 0 ]; then
        echo "Error: $@" 1&gt;&amp;2
        echo "" 1&gt;&amp;2
    fi
    echo "Usage: $0 [-v ]" 1&gt;&amp;2
    echo "" 1&gt;&amp;2
    echo "  Script for configuring the /etc/multipath.conf file" 1&gt;&amp;2
    echo "  Creates entries for the \"multipath \{\}\" section" 1&gt;&amp;2
    echo "  Requires the sg3_utils package to be present" 1&gt;&amp;2
    echo "  Errors and info are printed to stderr" 1&gt;&amp;2
    echo "" 1&gt;&amp;2
    echo "  Options:" 1&gt;&amp;2
    echo "    -h   Help     (print help and version information)" 1&gt;&amp;2
    echo "    -v   Verbose  (show processing details)" 1&gt;&amp;2
    echo "" 1&gt;&amp;2
    exit 1
}
 
if [ "$1" == "-h" ]; then
    usage
elif [ "$1" == "-v" ]; then
    VERBOSE=1
    echovrb "Running in verbose mode"
elif [ "$#" -gt 0 ]; then
    usage "Unknown argument $1"
fi
 
# Check that the s3_utils package has been installed and is in the path
if hash sg_inq 2&gt; /dev/null; then
    echovrb "Using sg_inq `sg_inq -V 2&gt;&amp;1`"
else
    echoerr "sg3_utils package not installed - exiting..."
    exit 1
fi
 
# Build a list of multipath devices to scan
MULTIPATH_FILELIST=$( ls -1 /dev/dm-* )
 
# Iterate through the list
for MPDEVICE in $MULTIPATH_FILELIST; do
 
    echovrb "Issuing inquiry to device $MPDEVICE"
 
    # Issue sg3 inquiry to device
    SG3_OUTPUT=`sg_inq -i $MPDEVICE 2&gt; /dev/null`
    SG3_RETVAL=$?
 
    # If inquiry returned error code then skip
    if [ "$SG3_RETVAL" -ne 0 ]; then
        echovrb "Skipping device $MPDEVICE"
        continue
    fi
 
    # Scan output to find vendor id
    SG3_VENDORID=`echo "$SG3_OUTPUT" | grep "vendor id:" | cut -d':' -f2- | sed 's/^ *//g' | sed 's/ *$//g' ` 2&gt; /dev/null
 
    # Check the vendor is VIOLIN otherwise skip
    if [ "$SG3_VENDORID" != "VIOLIN" ]; then
        echovrb "Ignoring device on $MPDEVICE with vendor id = $SG3_VENDORID"
        continue
    fi
 
    # Get the sysfs device location (required for udevinfo)
    MPATH_DEVBASE=`basename $MPDEVICE`
    MPATH_SYSFS="/block/$MPATH_DEVBASE"
 
    # Process device specific details
    LUN_CONTAINER=`echo "$SG3_OUTPUT" | grep "vendor specific:" | cut -d':' -f2 | sed 's/^ *//g'`
    LUN_NAME=`echo "$SG3_OUTPUT" | grep "vendor specific:" | cut -d':' -f3`
    LUN_SERIAL=`echo "$SG3_OUTPUT" | grep "vendor specific:" | cut -d':' -f4`
    LUN_UUID=`udevadm info --query=property --path=$MPATH_SYSFS 2&gt; /dev/null | grep "DM_UUID=" | sed 's/^DM_UUID=mpath-*//g'`
    echovrb "Found Violin device on $MPDEVICE: Container = $LUN_CONTAINER LUN Name = $LUN_NAME Serial = $LUN_SERIAL UUID = $LUN_UUID"
 
    # Add details to an array variable of Violin devices
    MULTIPATH_DEVICES+=(`echo "$LUN_NAME:$LUN_UUID:$LUN_CONTAINER:$LUN_SERIAL"`)
done
 
# Sort the array into alphabetical order based on LUN name
echovrb "Sorting discovered devices into alphabetical order..."
MULTIPATH_DEVICES=($(for MPDEVICE in ${MULTIPATH_DEVICES[@]}; do
    echo $MPDEVICE
done | sort))
echovrb "Sort complete"
 
echovrb "Printing multipath.conf configuration details..."
echovrb ""
 
# Now print the multipath.conf output for each device, converting the LUN name to lowercase
for MPDEVICE in ${MULTIPATH_DEVICES[@]}; do
    MP_WWID=`echo $MPDEVICE | cut -d':' -f2`
    MP_ALIAS=`echo $MPDEVICE | cut -d':' -f1 | tr '[:upper:]' '[:lower:]'`
    MP_COMMENT="Container `echo $MPDEVICE | cut -d':' -f3`"
    echoout "    multipath {"
    echoout "        # $MP_COMMENT"
    echoout "        wwid $MP_WWID"
    echoout "        alias $MP_ALIAS"
    echoout "    }"
done
 
echovrb "Successful completion"
exit 0