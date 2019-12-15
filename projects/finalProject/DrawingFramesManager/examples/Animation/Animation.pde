import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;
DShape shape;
boolean playLoop = false;

void setup() {
  size(700, 700 ,P3D);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);
  frameRate(12);
  strokeWeight(3);
 }
  
void draw() {
  // first, clear the screen
  background(255, 240, 230);

  if(playLoop) {
    // if playing, advance the frame
    drawingFramesManager.nextFrame();
  } else {
    // if not playing, so render the onion skinning
    int prevIndex = drawingFramesManager.currentFrameIndex - 1;
    if(prevIndex < 0) {
      prevIndex = drawingFramesManager.frames.size() - 1;
    }
    stroke(0, 32);
    strokeWeight(3);
    drawingFramesManager.renderFrame(prevIndex);
  }
    
    stroke(0);
    strokeWeight(3);
    // render current frame
    drawingFramesManager.renderCurrentFrame();
}

void keyPressed() {
  if(key == 'e'){
    drawingFramesManager.savePDF("My_Animation");
  }
  if(key == 'r'){
    drawingFramesManager.clear();
  }
  if(key == 'd'){
    drawingFramesManager.previousFrame();
  }
  if(key == 'f'){
    drawingFramesManager.nextFrame();
  }
  if(key == 'g'){
    drawingFramesManager.newFrame();
  }
  if(key == 'p' || key == ' '){
    playLoop = !playLoop;
  }
  if(key == 'c'){
    drawingFramesManager.copyFrameContents();
  }
  if(key == 'v'){
    drawingFramesManager.pasteFrameContents();
  }
  if(key == 'u') {
    removeLastStroke();
  }
}

void mousePressed(){
  shape = drawingFramesManager.addShape();
}

void mouseDragged(){
  drawingFramesManager.stroke(0,0,0);
  shape.addVertex(mouseX,mouseY); 
}

public void removeLastStroke() {
  if(drawingFramesManager.currentFrame().objects.size() > 0){
    drawingFramesManager.currentFrame().objects.remove(drawingFramesManager.currentFrame().objects.size()-1);
  }
}

public void reset() {
  drawingFramesManager.clear();
}
