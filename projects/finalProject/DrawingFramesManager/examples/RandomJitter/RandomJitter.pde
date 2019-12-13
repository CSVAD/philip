import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;
DShape shape;
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
   float x = mouseX-pmouseX+random(-10,10);
   float y = mouseY -pmouseY+random(-10,10); 
   shape.addDelta(x, y);
}

void mousePressed(){
  shape = drawingFramesManager.addShape();
  shape.translate(mouseX,mouseY);
}