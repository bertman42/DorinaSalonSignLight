#!/bin/bash

log_file="/home/pi/DSSL/check_door.log"

#Eganville
lat="45.5333N"
lon="77.1000W"

sunset_time=$(/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $2; }' )

#Wait for the sunset, then turn the sign light on 
echo  "`date '+%m/%d/%y @ %H:%M:%S'`" " * Sunset tonight: " $sunset_time | cat - $log_file > temp && mv temp $log_file

/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait wait down offset -0:01:00 $lat $lon

echo "`date '+%m/%d/%y @ %H:%M:%S'`" " * Relay One on " | cat - $log_file > temp && mv temp $log_file
sudo python /home/pi/DSSL/relay_4port/open_in1.py
echo "`date '+%m/%d/%y @ %H:%M:%S'`" " * Relay Two on " | cat - $log_file > temp && mv temp $log_file
sudo python /home/pi/DSSL/relay_4port/open_in2.py

echo $'\n'"`date '+%m/%d/%y @ %H:%M:%S'`" " * Door closed " | cat - $log_file > temp && mv temp $log_file

mail -s "Dorina Salon Sign activity" bertman30@msn.com < $log_file

