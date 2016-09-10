#!/bin/bash

log_file="/home/pi/DSSL/DorinaSalonSignLight.log"

#Kanata
lat="45.5333N"
lon="75.9000W"

sunset_time=$(/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $2; }' )

#Wait for the sunset, then turn the sign light on 
echo  "`date '+%m/%d/%y @ %H:%M:%S'`" " * Sunset tonight: " $sunset_time | cat - $log_file > temp && mv temp $log_file

/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait wait down offset 00:00:00 $lat $lon

echo "`date '+%m/%d/%y @ %H:%M:%S'`" " * Turning relay in1 on " | cat - $log_file > temp && mv temp $log_file
sudo python /home/pi/DSSL/relay_4port/open_in1.py

echo $'\n'"`date '+%m/%d/%y @ %H:%M:%S'`" " * Sign turned on for the evening " | cat - $log_file > temp && mv temp $log_file

mail -s "Dorina Salon Sign activity" bertman30@msn.com < $log_file

