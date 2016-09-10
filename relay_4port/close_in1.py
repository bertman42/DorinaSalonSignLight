#!/usr/bin/python
import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

# init list with pin numbers
GPIO.setup(17, GPIO.OUT) 


#pinList = [2]

# loop through pins and set mode and state to 'high'

#for i in pinList: 
#    GPIO.setup(i, GPIO.OUT) 
#    GPIO.output(i, GPIO.HIGH)

# time to sleep between operations in the main loop

SleepTimeS = 0.2
SleepTimeL = 0.5

# main loop

try:
  GPIO.output(17, GPIO.HIGH)
  print "OFF"



# End program cleanly with keyboard
except KeyboardInterrupt:
  print "  Quit"

  # Reset GPIO settings
  GPIO.cleanup()

