import RPi.GPIO as GPIO  # import GPIO module
import time # import time module
import OSC # import OSC module

send_address = '127.0.1.1' , 9000 # set address to localhost - this can also be a network address - you need to know the IP
c = OSC.OSCClient() # creat an OSC object as client
c.connect(send_address) # connect to the OSC server - here over localhost, as same machine

GPIO.setmode(GPIO.BCM)

TRIG = 23
ECHO = 24

print("Distance Measurement In Progress")

GPIO.setup(TRIG,GPIO.OUT) # set triger to pin 23
GPIO.setup(ECHO,GPIO.IN) # set echo to pin 24

while True:
  GPIO.output(TRIG, False)
  print("Waiting For Sensor To Settle")
  time.sleep(2)

  GPIO.output(TRIG, True)
  time.sleep(0.00001) # initiate ultrasonic module
  GPIO.output(TRIG, False)

  while GPIO.input(ECHO)==0:
    pulse_start = time.time()

  while GPIO.input(ECHO)==1:
    pulse_end = time.time()

  pulse_duration = pulse_end - pulse_start

  distance = pulse_duration * 17150

  distance = round(distance, 2)

  print("Distance:",distance,"cm")

  msg = OSC.OSCMessage() # create a OSC message object
  msg.setAddress("/distance") # define the address pattern to send OSC message to server
  msg.append(distance) # add the distance result to the object
  c.send(msg) # send the message to the server

GPIO.cleanup()
