#!/bin/bash
FILE=/tmp/status.txt
HOST=`/bin/hostname`
SUBJECT="NewServerInfo:$HOST"
EMAILID="devops@xxxxx.com"

#for i  in 1 2 3
#do

if [ -f $FILE ]
then
 rm -f $FILE
else
 touch $FILE
fi


echo "HOSTNAME:`/bin/hostname`" >> $FILE
echo >> $FILE

echo  "CPU MODEL:`cat /proc/cpuinfo  | grep 'model name' | head -1 | awk '{print $5,$6,$7,$8,$9,$10}'`" >>$FILE
echo >> $FILE

echo "CPU:`cat /proc/cpuinfo  | grep processor | wc -l` Core Processor"  >>$FILE
echo >> $FILE

echo "DISK" >> $FILE
echo "`fdisk -l | grep Disk | grep '/dev/sd' | awk '{print $2,$3,$4}'` " >>$FILE
echo >> $FILE

echo "RAM: `cat /proc/meminfo   | grep MemTotal | awk '{print $2/1024/1024}'` GB" >> $FILE
echo >> $FILE

echo "ARCHITECTURE: `getconf LONG_BIT` bit version"  >> $FILE
echo >> $FILE

echo "OS Version: `cat /etc/redhat-release`" >> $FILE
echo >> $FILE

/usr/bin/yum  -y install ethtool
echo "NETWORK SPEED-Eth0: `ethtool eth0 | grep Speed | awk '{print}' | awk '{print $2}'`" >> $FILE
echo >> $FILE

echo "NETWORK SPEED-Eth1: `ethtool eth1 | grep Speed | awk '{print}' | awk '{print $2}'`" >> $FILE
echo >> $FILE



mail -s $SUBJECT $EMAILID < $FILE
#sleep 10
#done
