#!/bin/bash

# for ANY state transition.
# "notify" script is called AFTER the
# notify_* script(s) and is executed
# with 3 arguments provided by keepalived
# (ie don't include parameters in the notify line).
# arguments
# $1 = "GROUP"|"INSTANCE"
# $2 = name of group or instance
# $3 = target state of transition
#     ("MASTER"|"BACKUP"|"FAULT")

TYPE=$1
NAME=$2
STATE=$3

case $STATE in
    "MASTER") echo "[$1 - $2] I'm the MASTER! Whup whup." > /proc/1/fd/1
        exit 0
    ;;
    "BACKUP") echo "[$1 - $2] Ok, i'm just a backup, great." > /proc/1/fd/1
        exit 0
    ;;
    "FAULT")  echo "[$1 - $2] Fault, what ?" > /proc/1/fd/1
        exit 0
    ;;
    *)        echo "[$1 - $2] Unknown state" > /proc/1/fd/1
        exit 1
    ;;
esac

## TODO: use aws change eip script
# source https://blog.rapid7.com/2014/12/03/keepalived-and-haproxy-in-aws-an-exploratory-guide/

# EIP=9.8.7.6
# INSTANCE_ID=i-abcd1234

# /usr/local/bin/aws ec2 disassociate-address --public-ip $EIP
# /usr/local/bin/aws ec2 associate-address --public-ip $EIP --instance-id $INSTANCE_ID

