#!/bin/bash

log_file="/home/pi/DSSL/DorinaSalonSignLight.log

#Eganville
lat="45.5333N"
lon="77.1000W"
sunrise_time=$(/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $1; }' )

#Wait for the sunrise, then turn the light off 1 hour after sunrise
echo "`date '+%m/%d/%y @ %H:%M:%S'`" " - Sunrise today: " $sunrise_time | cat - $log_file > temp && mv temp $log_file

/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait wait rise offset 1:0:00 $lat $lon

echo "`date '+%m/%d/%y @ %H:%M:%S'`" " - Relay One on " | cat - $log_file > temp && mv temp $log_file
sudo python /home/pi/DSSL/relay_4port/open_in1.py
echo "`date '+%m/%d/%y @ %H:%M:%S'`" " - Relay Two off " | cat - $log_file > temp && mv temp $log_file
sudo python /home/pi/DSSL/relay_4port/close_in2.py

echo "`date '+%m/%d/%y @ %H:%M:%S'`" " - Sign turned off " | cat - $log_file > temp && mv temp $log_file

mail -s "Dorina Salon Sign activity" bertman30@msn.com < $log_file

