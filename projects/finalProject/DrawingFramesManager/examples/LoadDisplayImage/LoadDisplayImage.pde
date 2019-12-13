import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;
PImage img;  // Declare variable "a" of type PImage

void setup() {
  size(1056,816,P3D);
  background(255);
  frameRate(20);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);
    img = loadImage("moonwalk.jpg");  // Load the image into the program  

 }

void draw() {
  if(mousePressed){
    //push into the transformation matrix
    drawingFramesManager.pushMatrix();
    //translate to mouseX, mouseY;
    drawingFramesManager.translate(mouseX,mouseY);
    //calculate angle of mouse vector using a PVector heading function
    PVector p = new PVector(mouseX-pmouseX,mouseY-pmouseY);
    float theta = p.heading();
    //rotate by this angle
    drawingFramesManager.rotate(theta);
    //scale down to 
    drawingFramesManager.scale(0.5,0.5);
    //Draw the image. Setting the x and y values of the image call to
    //-img.width/2 and -img.height/2 will place the center of the image
    // where the mouse cursor is.
    drawingFramesManager.image(img,-img.width/2,-img.height/2,img.width,img.height);
    //pop out of the transformation matrix.
    drawingFramesManager.popMatrix();
  }
}

void keyPressed() {
  if(key == ' '){
    drawingFramesManager.savePDF();
  }
   if(key == 'c'){
    drawingFramesManager.clear();
  }
}

void mousePressed(){
 
}
  