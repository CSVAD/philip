/**
 * Recursion. 
 * 
 * A demonstration of recursion, which means functions call themselves. 
 * Notice how the drawCircle() function calls itself at the end of its block. 
 * It continues to do this until the variable "level" is equal to 1. 
 */
 
import drawing.library.*;
import processing.pdf.*;

ArrayList<DShape> shapes = new ArrayList<DShape>();
DrawingFramesManager drawingFramesManager;
//offset between each recursion
int offset = 10;

void setup() {
  size(792, 612, P3D);
  background(255);
  drawingFramesManager = new DrawingFramesManager(this);
  drawingFramesManager.stroke(0,0,0);
  print("setup");
}

void draw(){
  
}

void mouseDragged() {
  //set the stroke to black
  drawingFramesManager.stroke(0, 0, 0);

  //loop through each shape and add a vertex at the mouse x and y positions
  for (int i = 0; i<shapes.size(); i++) {
    DShape shape = shapes.get(i);
    
    shape.addDelta(mouseX-pmouseX,mouseY-pmouseY);
  }
}

void mousePressed() {
  shapes.clear();
  //call addLine function
  addLine(mouseX, mouseY, 1, 6);
}

void keyPressed() {
  if (key == ' ') {
    drawingFramesManager.savePDF();
  }
  if (key == 'c') {
    drawingFramesManager.clear();
    shapes.clear();
  }
}


void addLine(int x, int y, float scale, int level) {  
  DShape s1 = drawingFramesManager.addShape(); 
  s1.translate(x,y);
  s1.scale(scale,scale);
  shapes.add(s1);
  //as long as level is > than 1, recurse by calling addLine function;
  if(level > 1) {
    level = level - 1;
    scale = scale-0.3;
    addLine(x - offset, y, scale, level);
    addLine(x + offset, y, -scale, level);
  }
}