import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;
DShape shape;
boolean playLoop = false;

void setup() {
  size(1056,816,P3D);
  background(255);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);
 }

void draw() {

  drawingFramesManager.clear();
  drawingFramesManager.renderCurrentFrame();
  
  //float time = millis();
  //float seconds = time/1000.0 % 4;
  //if(seconds > 1) {
  //  println("render : 1");
  //  drawingFramesManager.currentFrameIndex = 1;
  //  drawingFramesManager.clear();
  //  drawingFramesManager.renderFrame(1);
  //} else {
  //  //println("seconds : " + (int)seconds);
  //  println("render : 0");
  //  drawingFramesManager.currentFrameIndex = 0;
  //  drawingFramesManager.clear();
  //  drawingFramesManager.renderFrame(0);
  //}
}

void keyPressed() {
  if(key == ' '){
    drawingFramesManager.savePDF();
  }
   if(key == 'c'){
    drawingFramesManager.clear();
  }
  if(key == 'd'){
    //drawingFramesManager.currentFrameIndex -= 1;
    drawingFramesManager.previousFrame();
  }
  if(key == 'f'){
    drawingFramesManager.nextFrame();
  }

    if(key == 'g'){
    drawingFramesManager.newFrame();
  }
  if(key == 'p'){
    playLoop = !playLoop; 
  }
}

void mousePressed(){
   shape = drawingFramesManager.addShape(); 
 
}
  
void mouseDragged(){
   drawingFramesManager.stroke(0,0,0);
   shape.addVertex(mouseX,mouseY); 
}
