#!/bin/bash

log_file="/home/pi/DSSL/check_door.log"

#Eganville
lat="45.5333N"
lon="75.9000W"
sunrise_time=$(/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $1; }' )
sunset_time=$(/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait list $lat $lon | awk 'BEGIN {FS=",";} { print $2; }' )
current_time=(date | awk '{ print $4; }' | awk 'BEGIN {FS=":";} { print $1; }')

if [current_time < 12]
  then


#if it is sunrise then do this
#Wait for the sunrise, then turn the light off after 30 minutes
echo $'\n'"`date`" " -- Waited for sunrise starting at " $sunrise_time | cat - $log_file > temp && mv temp $log_file
/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait wait rise offset 0:30:00 $lat $lon
sudo python /home/pi/DSSL/relay_4port/open_in1.py
echo "`date`" " -- Turned light off (30 mins after Sunrise)" | cat - $log_file > temp && mv temp $log_file
mail -s "Dorina Salon Sign Light has been turned off" bertman30@msn.com < $log_file

#if it is sunset then do this
#Wait for the sunset, then turn the light on
echo "`date`" " -- Begun waiting for sunset " $sunset_time | cat - $log_file > t
emp && mv temp $log_file
/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait wait down offset 0:01:00 $lat $lon
sudo python /home/pi/DSSL/relay_4port/close_in1.py
echo "`date`" " -- Turned light on (+1 minute after Sunset)" | cat - $log_file > temp && mv temp $log_file
mail -s "Dorina Salon Sign Light has been turned on" bertman30@msn.com < $log_file

