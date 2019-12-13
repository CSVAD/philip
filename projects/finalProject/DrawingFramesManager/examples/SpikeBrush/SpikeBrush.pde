import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;

void setup() {
  size(1056,816,P3D);
  background(255);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);
  
 }

void draw() {
}

void keyPressed() {
  if(key == ' '){
    drawingFramesManager.savePDF();
  }
   if(key == 'c'){
    drawingFramesManager.clear();
  }
}


void mouseDragged(){
   drawingFramesManager.stroke(0,0,0);
   int xDist = mouseX-pmouseX;
   int yDist = mouseY-pmouseY;
   float theta = atan2(xDist,yDist);
   drawingFramesManager.fill(0,0,0);
   drawingFramesManager.pushMatrix();
   drawingFramesManager.translate(mouseX,mouseY);
   drawingFramesManager.rotate(TWO_PI-theta);
   drawingFramesManager.triangle(-10,0, 10, 0, 0,random(10,100));
   drawingFramesManager.popMatrix();
  

}