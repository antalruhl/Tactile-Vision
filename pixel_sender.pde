import processing.serial.*;
import processing.video.*;

int cols = 3;
int rows = 3;
int colSize, rowSize;
Capture video;
int zwart =0;
Serial myPort;
int pixelColors[] = new int[cols*rows];
int pinStates[] = new int[cols*rows];
int solStatus;
int threshold = 110;
void setup() {
  size(480, 480);
  colSize = width / cols;
  rowSize = height / rows;
  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  String[] cameras = Capture.list();
   if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + " " + cameras[i]);
    }
      // The camera can be initialized directly using an 
    // element from the array returned by list():
     
  }      
  video = new Capture(this, width, height,Capture.list()[0], 30);

  video.start();  

  background(0);
}


void draw() { 
  if (video.available()) {
    video.read();
    video.loadPixels();


    // Begin loop for columns
    for (int i = 0; i < cols; i++) {
      // Begin loop for rows
      for (int j = 0; j < rows; j++) {

        // Where are we, pixel-wise?
        int x = i * colSize;
        int y = j * rowSize;
        
        //int loc = (video.width-x-1) + y*video.width; // Reversing x to mirror the image
        color c = video.pixels[video.width * y + x];
        
        //println(brightness(c));
        if (brightness(c)<threshold) {
          zwart = 0;
          solStatus = 1;
        } else {
          zwart = 255;
          solStatus = 0;
        }
        
          pixelColors[cols * j + i]=zwart;
          pinStates[cols * j + i]=solStatus;
          fill(pixelColors[cols * j + i]);
          noStroke();
          rect(x + (colSize/2), y+(rowSize/2), colSize, rowSize);
      }
    }
  }
  
  for(int i =0; i< pinStates.length; i++) {
    myPort.write(pinStates[i]);
  }
  
 // printArray(pinStates);
  
  
}