import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;

void setup() {
  size(1056,816,P3D);
  background(255);

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
    variableEllipse(mouseX, mouseY, pmouseX, pmouseY);
}

void variableEllipse(int x, int y, int px, int py) {
  float speed = abs(x-px) + abs(y-py);
  drawingFramesManager.ellipse(x,y,speed,speed); 
}