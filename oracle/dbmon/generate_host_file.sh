#!/bin/ksh
############################################
# generate host file for iGen
############################################

function run_ip
{
        export DNS_START=$2
        export DNS_END=$3
        export DNS=`echo $1 | cut -d. -f1-3`
        
        i=$DNS_START
        while (( i <= $DNS_END ))
        do
                IP="${DNS}.$i"
                host $IP | awk -Fpointer '{ print $2 }' | sed 's/.au./.au/' |grep -v "deleted" | grep -v "snat" | read NAME
                if [ ! -z "$NAME" ]
                then
                        SHORT=`echo $NAME|sed 's/.sensis.com.au//'`
                        printf "%-15s  %-40s  %-30s \n" $IP $NAME $SHORT
                fi

                (( i = i + 1 ))
        done
}

function run_ip_single
{
        export DNS_START=$2
        export DNS_END=$3
        export DNS=`echo $1 | cut -d. -f1-3`
        
        i=$DNS_START
        while (( i <= $DNS_END ))
        do
                IP="${DNS}.$i"
                host $IP | awk -Fpointer '{ print $2 }' | sed 's/.au./.au/' |grep -v "deleted" | grep -v "snat" | read NAME
                if [ ! -z "$NAME" ]
                then
                        printf "%-15s  %-40s \n" $IP $NAME 
                fi

                (( i = i + 1 ))
        done
}

function print_local
{
        printf "%-15s  %-40s  %-30s\n" $1 $2 $3
}

echo "##############################################################################"
echo "# Hosts file generated at `date`                       #"
echo "##############################################################################"
print_local 127.0.0.1 localhost loopback

echo ""
echo "##############################################################################"
echo "# special                                                                    # "
echo "##############################################################################"
print_local 161.117.22.240  dc-srv-fs3.sensis.com.au        dc-srv-fs3
print_local 161.117.200.200 su-net-01.sensis.com.au         su-net-01 
print_local 192.168.0.15    supr04priv.sensis.com.au        supr04priv
print_local 192.168.0.17    supr24priv.sensis.com.au        supr24priv
print_local 192.168.0.15    drcpr04priv.sensis.com.au       drcpr04priv
print_local 192.168.0.17    drcpr24priv.sensis.com.au       drcpr24priv
print_local 192.168.0.43    supf02priv.sensis.com.au        supf02priv
print_local 192.168.0.45    supf22priv.sensis.com.au        supf22priv

echo ""
echo "##############################################################################"
echo "# Prod Segment                                                               #"
echo "##############################################################################"
run_ip 10.100.1.0 1 254

echo ""
echo "##############################################################################"
echo "# Non Production Segment                                                     #"
echo "##############################################################################"
run_ip 10.100.2.0 1 170

echo ""
echo "##############################################################################"
echo "# Management Segments Switches only                                          #"
echo "##############################################################################"
print_local 10.101.17.36 drc-lb-prod1.sensis.com.au drc-lb-prod1
print_local 10.101.17.37 drc-lb-prod2.sensis.com.au drc-lb-prod2
run_ip 10.100.3.0 1 254 |egrep "su-swt|su-lb"

echo ""
echo "##############################################################################"
echo "# Remote Segment                                                             #"
echo "##############################################################################"
run_ip 203.35.145.0 33 40
print_local 203.35.145.41 syslnx02.sensis.com.au syslnx02                        
run_ip 203.35.145.0 42 59

echo ""
echo "##############################################################################"
echo "# Dev Segment                                                                #"
echo "##############################################################################"
run_ip 203.39.108.0 129 132
run_ip 203.39.108.0 162 162

echo ""
echo "##############################################################################"
echo "# DR Prod Segment                                                            #"
echo "##############################################################################"
run_ip 10.101.1.0 1 254

echo ""
echo "##############################################################################"
echo "# iGen URLS only for syslnx02 and syslnx03 for index page                    #"
echo "##############################################################################"
run_ip_single 10.100.8.0 1 255
run_ip_single 10.100.9.0 0 255
run_ip_single 10.100.10.0 0 255
run_ip_single 10.100.11.0 0 254

