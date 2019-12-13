/**
 * RowBrush
 * 
 * simple example of a repeating brush. Lines drawn by dragging the mouse or stylus are repeated along the y-axis
 * pressing space bar saves out a copy of the drawing.
 */


import drawing.library.*;
import processing.pdf.*;

//instance of DrawingFramesManager library
DrawingFramesManager drawingFramesManager;

//total number of lines to be drawn
int linecount = 100;
//total distance between each ine
float gapDistance = 5;

//list of shapes
ArrayList<DShape> shapes = new ArrayList<DShape>();
void setup() {
  size(792,612,P3D);
  background(255);
  smooth();
  //initialize DrawingFramesManager
  drawingFramesManager = new DrawingFramesManager(this);
  
 }

void draw() {
}

//save and clear functions
void keyPressed() {
  if(key == ' '){
    drawingFramesManager.savePDF();
  }
  if(key == 'c'){
  	drawingFramesManager.clear();
  }
}



void mouseReleased(){
}

void mouseDragged(){
  //set the stroke to black
   drawingFramesManager.stroke(0,0,0);
 
   //loop through each shape and add a vertex
   for(int i = 0; i<linecount;i++){
     DShape shape = shapes.get(i);
     float yPos = mouseY+gapDistance*i;
     shape.addVertex(mouseX,yPos);
   }
 
 }
 
 
 void mousePressed(){
  //clear all existing shapes
  shapes.clear();
  //use a loop to create a new set of shapes
  for(int i = 0; i<linecount;i++){
     //initialize a new DShape object
    DShape s = drawingFramesManager.addShape(); 
    //add it to the list of shapes
    shapes.add(s);
  }
}
   
 