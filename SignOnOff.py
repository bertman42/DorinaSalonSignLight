#!/usr/bin/python
import RPi.GPIO as GPIO
import time
import subprocess
import logging
import logging.handlers

import sys

#Setup GPIO pins
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
relay1 = [17]
GPIO.setup(11, GPIO.OUT)

#Setup logging
LOG_FILENAME="/home/pi/DSSL/DSSL.log"
my_logger = logging.getLogger('MyLogger')

handler = logging.handlers.RotatingFileHandler(
		LOG_FILENAME, maxBytes=80, backupCount=5)
my_logger.addHandler(handler)

formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")

my_logger.setLevel(logging.INFO)

#Setup LAT and LON for Kanata
lat = "45.5333N"
lon = "75.9000W"
#sunrise_time = "Test "
sunwait_time = subprocess.Popen(['/home/pi/DSSL/sunwait08/sunwait/0.8/sunwait', 'list' ,lat ,lon], stdout=subprocess.PIPE).stdout.read()
sunrise_time = sunwait_time.split(",")[0].strip()
sunset_time = sunwait_time.split(",")[1].strip()
print "Sunrise time:", sunrise_time
print "Sunset time:", sunset_time
my_logger.info("Sunset is set to", sunset_time)

current_time =  subprocess.Popen(['date'], stdout=subprocess.PIPE).stdout.read()
current_time = current_time.split(" ")[3].strip()
print "Current time:", current_time

if current_time < 12:
	print ("It is Morning, turn off the light")
	try:
		GPIO.output(relay1,GPIO.LOW)
		print "Relay 1 OFF"
	except:
		GPIO.cleanup()
else:
	print ("It is evening, time to turn light back on")

	try:
                GPIO.output(relay1,GPIO.HIGH)
                print "Relay 1 OFF"
        except:
                GPIO.cleanup()

