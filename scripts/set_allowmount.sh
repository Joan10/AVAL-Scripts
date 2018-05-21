#!/bin/bash

if [ -z "$1" ]; then
   exit -1
fi 
if [ "$1" == "NO" ]; then
   A="NO"
   B="YES"
elif [ "$1" == "YES" ]; then
   A="YES"
   B="NO"
else
   exit -1
fi

needed=$(cat /home/prepare/prepare.conf | grep "ALLOW_MOUNT_EXTERNAL=$B" )
if [ ! -z $needed ]; then
   sed -i -e "s/ALLOW_MOUNT_EXTERNAL=$B/ALLOW_MOUNT_EXTERNAL=$A/g" /home/prepare/prepare.conf
   /home/prepare/prepare.sh
fi

