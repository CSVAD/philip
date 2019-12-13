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
  if(key == 'v'){
    normalizeShape();
  }
}

void mousePressed(){
   shape = drawingFramesManager.addShape(); 
 
}
  
void mouseDragged(){
   drawingFramesManager.stroke(0,0,0);
   shape.addVertex(mouseX,mouseY); 
}

void normalizeShape(){
 ArrayList<DPoint> points = shape.getNormalizedVertices();
 DShape s2 = drawingFramesManager.addShape();
 for(int i=0;i<points.size();i++){
   s2.addVertex(points.get(i).x,points.get(i).y);
 }
}