import processing.io.*; //Import Libraries

import oscP5.*;
import netP5.*;

boolean current = false; //Declare Variables
boolean prev = false;

PImage main;
PImage b1;
PImage b2;
PImage b3;
PImage b4;
PImage b5;
PImage b6;
PImage b7;
PImage c1;
PImage c2;
PImage c3;
PImage c4;
PImage c5;
PImage sketch1;
PImage sketch2;
PImage sketch3;
PImage sketch4;
PImage world;

OscP5 oscP5;

int i = 0;
float d;
int knob = 0;

void setup() {
  main = loadImage("imgs/main.jpg");
  b1 = loadImage("imgs/b1.png");
  b2 = loadImage("imgs/b2.png");
  b3 = loadImage("imgs/b3.png");
  b4 = loadImage("imgs/b4.png");
  b5 = loadImage("imgs/b5.png");
  b6 = loadImage("imgs/b6.png");
  b7 = loadImage("imgs/b7.png");
  
  c1 = loadImage("imgs/c1.png");
  c2 = loadImage("imgs/c2.png");
  c3 = loadImage("imgs/c3.png");
  c4 = loadImage("imgs/c4.png");
  c5 = loadImage("imgs/c5.png");
  
  sketch1 = loadImage("imgs/sketch1.png");
  sketch2 = loadImage("imgs/sketch2.png");
  sketch3 = loadImage("imgs/sketch3.png");
  sketch4 = loadImage("imgs/sketch4.png");
  
  world = loadImage("imgs/world.png");
  
  
  size(700, 700);
  image(main,0,0,700,700);
  oscP5 = new OscP5(this,9000);
  GPIO.pinMode(21, GPIO.INPUT);
  while(GPIO.digitalRead(21) == GPIO.HIGH){
  }
  
}      

void draw() {
  
  fill(255,0,0);
  
  if(GPIO.digitalRead(21) == GPIO.HIGH){//Motion Detection
    for(int c=0;c<100;c++){

 if(d>5 && d<10){  //Change Sea Colour according to distance from Ultrasonic Sensor
    println("5-10");
    image(c1,0,0,700,700);
    }
  if(d>10 && d<15){
    println("10-15");
    image(c2,0,0,700,700);
    }
  if(d>15 && d<20){
    println("15-20");
    image(c3,0,0,700,700);
    }
  if(d>20 && d<25){
    println("20-25");
    image(c4,0,0,700,700);
    }
  if(d>25){
    println("25+");
    image(c5,0,0,700,700);
  }
 image(world,0,0,700,700); //Place blank image of world
 
 if(light() == GPIO.HIGH){ //Change background according to light intensity
    println("on");
 /* image(b7,0,0,700,700);delay(100); //Removed animation of the sky to try and make the software run faster
  image(b6,0,0,700,700);delay(100);
  image(b5,0,0,700,700);delay(100);
  image(b4,0,0,700,700);delay(100);
  image(b3,0,0,700,700);delay(100);
  image(b2,0,0,700,700);delay(100);*/
  image(b1,0,0,700,700);
    }else {
  /*image(b1,0,0,700,700);delay(100);
  image(b2,0,0,700,700);delay(100);
  image(b3,0,0,700,700);delay(100);
  image(b4,0,0,700,700);delay(100);
  image(b5,0,0,700,700);delay(100);
  image(b6,0,0,700,700);delay(100);*/
  println("off");
  image(b7,0,0,700,700);
  }
  
  if(button() == GPIO.LOW){ //Change world environment type with button presses
  
  //Button is a bit hard a requires pressing hard for it to register
  
     i++;
     if(i==4)i=0;
     println(i);
     }
     if(i==0)image(sketch1,0,0,700,700);
     else if(i==1)image(sketch2,0,0,700,700);
     else if(i==2)image(sketch3,0,0,700,700);
     else if(i==3)image(sketch4,0,0,700,700);
  }
  }
}

int button(){
  GPIO.pinMode(17, GPIO.INPUT); 
  return GPIO.digitalRead(17);
}


int light(){
  GPIO.pinMode(3, GPIO.OUTPUT);
  GPIO.digitalWrite(3,GPIO.LOW);
  delay(50);
  GPIO.pinMode(3, GPIO.INPUT); 
  return GPIO.digitalRead(3);
}


void oscEvent(OscMessage theOscMessage) {
  println("value: "+theOscMessage.get(0).floatValue());
  d = theOscMessage.get(0).floatValue();
}
