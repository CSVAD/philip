import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;

//list of shapes
ArrayList<DShape> shapes = new ArrayList<DShape>();
void setup() {
  size(792,612,P3D);
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
  //set the stroke to black
   drawingFramesManager.stroke(0,0,0);
 
   //loop through each shape and add a vertex at the mouse x and y positions
   for(int i = 0; i<2;i++){
     DShape shape = shapes.get(i);
     shape.addVertex(mouseX,mouseY);
   }
 
}

void mousePressed(){
  //clear all existing shapes
  shapes.clear();

     //initialize a new DShape object
    DShape s1 = drawingFramesManager.addShape(); 
    //add it to the list of shapes
    shapes.add(s1);
    
     //initialize a second DShape object
    DShape s2 = drawingFramesManager.addShape(); 
    //add it to the list of shapes
    shapes.add(s2);
    //perform a matrix transformation to reflect the shape across the y axis
    s2.translate(width,0);
    s2.scale(-1,1);
  
}