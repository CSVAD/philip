import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;
int angle = 0;
int rate = 1;
int freq = 10;
int scale = 30;
int stepDist = 2;

void setup() {
  size(1056,816,P3D);
  background(255);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);
  
 }

void draw() {
if(mousePressed){
  if (abs(mouseX-pmouseX)>stepDist ||abs(mouseY-pmouseY)>stepDist){
   drawingFramesManager.stroke(0,0,0);
   angle += rate;
   float offset = sin(radians(angle*freq))*scale;
   pulseEllipse(mouseX, mouseY,offset);
   pulseEllipse(mouseX, mouseY,offset*-1);
  }
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

void mouseDragged(){
 
}

void pulseEllipse(int x, int y, float offset) {
 float diameter = (abs(offset/2)-scale/2+1)*2;
  drawingFramesManager.ellipse(x,y-offset,diameter,diameter); 
}