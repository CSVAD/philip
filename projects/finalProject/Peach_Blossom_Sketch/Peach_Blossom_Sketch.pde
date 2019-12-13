import drawing.library.*;
import processing.pdf.*;

import controlP5.*;

ControlP5 cp5;

CheckBox quickModeCheck;
Textlabel quickModeLabel;
Textlabel boomerangModeLabel;

DrawingFramesManager drawingFramesManager;
DShape shape;
boolean playLoop = false;
boolean boomerangMode = false;
boolean quickMode = false;
boolean quickModeLoopMode = false;
boolean playForward = true;
boolean validDrawingStrokeActive = false;
boolean validScrubActive = false;
boolean addFrameVisible = true;
int[] addButtonBounds = {0, 0, 0, 0};
int frameStart;
int frameEnd;

color pampNavyColor = color(126,214,216);
color offWhiteColor = color(255,250,221);
color backgroundColor = color(255,243,233);
color pampPinkColor = color(247,111,115);
color pampOrangeColor = color(255,204,152);
color pampBlueColor = color(126,214,216);
color aquaGreenColor = color(139,206,133);
color softRedColor = color(255,146,127);

void setup() {
  //size(1440, 900 ,P3D);
  fullScreen(P3D);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);
  frameRate(100);
  strokeWeight(3);
  
  cp5 = new ControlP5(this);
  //cp5.setAutoDraw(false);
  
  quickModeCheck = cp5.addCheckBox("quickModeCheckBox")
              .setPosition(25, 25)
              .setSize(100, 100)
              .setItemsPerRow(1)
              .setSpacingRow(25)
              .setColorBackground(pampOrangeColor)
              .setColorForeground(pampPinkColor)
              .setColorActive(aquaGreenColor)
              .addItem("a", 0)
              .addItem("b", 1)
              ;

  quickModeLabel = cp5.addTextlabel("quickLabel")
                    .setText("Quick Mode")
                    .setPosition(140,65)
                    .setColorValue(aquaGreenColor)
                    .setFont(createFont("Georgia",20))
                    ;
                    
  boomerangModeLabel = cp5.addTextlabel("boomerangLabel")
                    .setText("Boomerang Mode")
                    .setPosition(140,190)
                    .setColorValue(aquaGreenColor)
                    .setFont(createFont("Georgia",20))
                    ;
                    
  cp5.addButton("removeFrame")
     .setLabel("Remove Frame")
     .setValue(1)
     .setPosition(1072,25)
     .setSize(150,75)
     .setColorBackground(pampPinkColor)
     .setColorForeground(pampPinkColor)
     .setColorActive(pampPinkColor)
     .getCaptionLabel().setSize(15);
     ;    
    
  cp5.addButton("removeLastStroke")
     .setLabel("Remove Last Stroke")
     .setValue(1)
     .setPosition(1072,257)
     .setSize(150,75)
      .setColorLabel(color(0, 0, 0))
     .setColorBackground(pampOrangeColor)
     .setColorForeground(pampOrangeColor)
     .setColorActive(pampOrangeColor)
     .getCaptionLabel().setSize(15);
     ;                  
  
  // and add another 2 buttons
  cp5.addButton("copyFrame")
     .setLabel("Copy Frame")
     .setValue(1)
     .setPosition(1072,262+75) // y 337
     .setSize(150,75)
     .setColorLabel(color(0, 0, 0))
     .setColorBackground(aquaGreenColor)
     .setColorForeground(aquaGreenColor)
     .setColorActive(aquaGreenColor)
     .getCaptionLabel().setSize(15);
     ;
     
  cp5.addButton("pasteFrame")
     .setLabel("Paste Frame")
     .setValue(1)
     .setPosition(1072,262+75+80) // y 417
     .setSize(150,75) // y bottom: 492
     .setColorLabel(color(0, 0, 0))
     .setColorBackground(pampBlueColor)
     .setColorForeground(pampBlueColor)
     .setColorActive(pampBlueColor)
     .getCaptionLabel().setSize(15);
     ;
     
  cp5.addButton("exportToPDF")
     .setLabel("Export PDF")
     .setValue(1)
     .setPosition(25, 350)
     .setSize(150,75)
     .setColorLabel(color(0, 0, 0))
     .setColorBackground(pampBlueColor)
     .setColorForeground(pampBlueColor)
     .setColorActive(pampBlueColor)
     .getCaptionLabel().setSize(15);
     ;
     
  cp5.addButton("reset")
     .setLabel("Reset Sketchpad")
     .setValue(1)
     .setPosition(25, 450)
     .setSize(150,75)
     .setColorBackground(pampPinkColor)
     .setColorForeground(pampPinkColor)
     .setColorActive(pampPinkColor)
     .getCaptionLabel().setSize(15);
     ;
 }
  
void draw() {
  
  if(frameCount % 8 == 0) {
    // first, clear the screen
    background(backgroundColor);

    if(playLoop) {
      if(boomerangMode) {

          if(playForward && isLastFrame()) {
            playForward = false; // flip the bit
          }
          if(!playForward && drawingFramesManager.currentFrameIndex == 0) {
            playForward = true; // flip the bit
          }
          
          if(playForward) {
            drawingFramesManager.nextFrame();
          } else {
            drawingFramesManager.previousFrame();
          }
        
      } else {
        drawingFramesManager.nextFrame();
      }
    } else {
      // not playing, so render the onion skinning
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
      drawingFramesManager.renderCurrentFrame();
    
    renderFrameStrip();
    renderWireframes();
    renderClipboard();
    //cp5.draw();
  }

}

void renderFrameStrip() {
  frameStart = drawingFramesManager.currentFrameIndex <= 4 ? 0 : drawingFramesManager.currentFrameIndex-4;
  frameEnd = drawingFramesManager.frames.size();
  
  if(frameStart + 9 < drawingFramesManager.frames.size()) {
    frameEnd = frameStart + 9;
  }
  
  if(frameEnd-frameStart == 9) {
    // the visible frames on the frame strip take up the whole panel, don't render the "Add Frame" button
    addFrameVisible = false;
  } else {
    addFrameVisible = true;  
    // "Add Frame" button is visible, lets calculate its bounds for collision detection purposes
    //addButtonBounds[0] = (frameEnd-frameStart+1) * 125 + 25;
    //addButtonBounds[1] = addButtonBounds[0] + 100;
    //addButtonBounds[2] = 775;
    //addButtonBounds[3] = 875;
  }
    
  pushMatrix();
  
    translate(25, 775); // jump to the top-left of the frame strip!
    
    for(int i=frameStart; i < frameEnd; i++) {
      translate(125, 0); // translate draw matrix on each iteration

      if(i == drawingFramesManager.currentFrameIndex) {
        strokeWeight(1);
        if(drawingFramesManager.isWrapping) {
          fill(255, 255, 0, 200);
          drawingFramesManager.isWrapping = false;
        } else {
          noFill();
        }
        rect(0, 0, 100, 100);
      }
      
      strokeWeight(1);
      if(i > 0) {
        line(0, 0, 0, 100); // frame separator line
      }
      
      pushMatrix();
        fill(0);
        textSize(15);
        text(i+1, 48, 115); 
        scale(.14);
        translate(-370, -25);
        if(i == drawingFramesManager.currentFrameIndex) { strokeWeight(14); } else { strokeWeight(7); }

        drawingFramesManager.renderFrame(i); // render micro frame
  
      popMatrix();
    }
    
    // render the "add frame" button (if it is on-screen)
    if(addFrameVisible) {
      translate(125, 0);
      fill(aquaGreenColor);
      strokeWeight(1);
      noStroke();
      rect(0, 0, 100, 100);
      stroke(0);
      line(50, 25, 50, 75);
      line(25, 50, 75, 50);
      noFill();
    }
  
  popMatrix();
}

void renderClipboard() {
  pushMatrix();
  translate(1247, 364);
  strokeWeight(1);
  noFill();
  rect(0, 0, 100, 100);
    scale(.14);
    translate(-370, -25);
    strokeWeight(7);
    drawingFramesManager.clipboard.render();
  popMatrix();
}

void renderWireframes() {
  noFill();
  strokeWeight(1);
  stroke(0, 64);
  rect(370, 25, 700, 700); // canvas
  
  rect(0, 750, width, 150); // frame list
  strokeWeight(1);
  //rect(0, 25, 345, 700); // left panel
  //rect(playX, playY, playWidth, playHeight);
  
  
  
  
  //rect(1095, 25, 1440, 700); // right panel
  
  // play button
  fill(aquaGreenColor);
  int playX = 1095;
  int playY = 525;
  int playWidth = 320;
  int playHeight = 200;
  rect(playX, playY, playWidth, playHeight);
  stroke(0);
  if(playLoop) {
    rect(playX+playWidth/2-20, playY+playHeight/2-20, 10, 40);
    rect(playX+playWidth/2+20, playY+playHeight/2-20, 10, 40);
  } else {
    line(playX+playWidth/2-20, playY+playHeight/2-20, playX+playWidth/2-20, playY+playHeight/2+20);
    line(playX+playWidth/2-20, playY+playHeight/2-20, playX+playWidth/2+20, playY+playHeight/2);
    line(playX+playWidth/2-20, playY+playHeight/2+20, playX+playWidth/2+20, playY+playHeight/2);
    //stroke(0, 64);
  }
  
  noFill();
  fill(pampBlueColor);
  rect(25, 775, 100, 100); // prev button
  stroke(0);
  line(25+50+20, 775+50+20, 25+50-20, 775+50);
  line(25+50+20, 775+50-20, 25+50-20, 775+50);
  stroke(0, 64);
  
  rect(1315, 775, 100, 100); // next button
  stroke(0);
  line(1315+50-20, 775+50-20, 1315+50+20, 775+50);
  line(1315+50-20, 775+50+20, 1315+50+20, 775+50);
  stroke(0, 64);
  
  noFill();

  
}

void keyPressed() {
  if(key == 'e'){
    drawingFramesManager.savePDF();
  }

  if(key == 'c'){
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
  if(key == 'b'){
    boomerangMode = !boomerangMode;
  }
  if(key == 'q'){
    quickMode = !quickMode;
  }
}

void mousePressed(){
  // 370, 25, 700, 700
  if(mouseWithinCanvas()) {
    shape = drawingFramesManager.addShape();
    validDrawingStrokeActive = true;
  } else {
    checkCollisions();
  }
}

void mouseReleased() {
  if(quickMode && validDrawingStrokeActive) {
    if(quickModeLoopMode) {
      drawingFramesManager.nextFrame();
    } else {
      drawingFramesManager.newFrame();
    }
  }
  
  validDrawingStrokeActive = false;
  validScrubActive = false;
} 

void mouseDragged(){
  if(mouseWithinCanvas() && validDrawingStrokeActive) {
    drawingFramesManager.stroke(0,0,0);
    shape.addVertex(mouseX,mouseY); 
  }
  
  //if (validScrubActive) {
  //  float xDelta = (float)mouseX-(float)pmouseX;
  //  if(xDelta < -4.0) {
  //    println("dragged: prevFrame!");
  //    drawingFramesManager.previousFrame();
  //  }
  //  if(xDelta > 4.0) {
  //    println("dragged: nextFrame!");
  //    drawingFramesManager.nextFrame();
  //  }
  //}
}

void checkCollisions() {
  if(mouseWithinPlayButton()) { playLoop = !playLoop; }
  if(mouseWithinNextButton()) { drawingFramesManager.nextFrame(); }
  if(mouseWithinPrevButton()) { drawingFramesManager.previousFrame(); }
  
  if(mouseWithinStrip()) {
    validScrubActive = true;
    int index = stripIndex();
    //println("i: " + index);
    //println("frameEnd-frameStart: " + (frameEnd-frameStart));

    if(index <= frameEnd-1-frameStart) { //off-by-one compensation...
       //println("index is less than or equal to: " + (frameEnd-1-frameStart));
       //println("setting currentFrameIndex to frameStart:" + frameStart + "+index:"+index);
       drawingFramesManager.setCurrentFrameIndex(frameStart+index);
    } else {
      //OR
      //println("add frame button");
      if(drawingFramesManager.frames.get(drawingFramesManager.frames.size()-1).objects.size() > 0) {
        // don't create a new frame if the last frame is still empty. it is rare that a user would want to do this.
        drawingFramesManager.newFrame();
      } else {
        // zoom to the last frame so user can draw on it!
        drawingFramesManager.setCurrentFrameIndex(drawingFramesManager.frames.size()-1);
      }
    }
  }
}

void quickModeCheckBox(float[] a) {
  quickMode = (a[0] == 1.0);
  
  if(a[0] == 1.0) { // quick mode turning on!
    if(!isLastFrame()) {
      // we're not on the last frame!
      quickModeLoopMode = true;    
    }
  } else { // quick mode turning off!
    quickModeLoopMode = false;
  }
  
  boomerangMode = (a[1] == 1.0);
}

public boolean isLastFrame() {
  return drawingFramesManager.currentFrameIndex == drawingFramesManager.frames.size() - 1;
}

public void removeFrame() {
  int toBeRemoved = drawingFramesManager.currentFrameIndex;

  if(drawingFramesManager.frames.size() > 1) {
    if(toBeRemoved > 0) { // if we can, bump to previous frame. if we're at index zero, the deletion will bump us to the next frame
      drawingFramesManager.previousFrame();
    }
    drawingFramesManager.frames.remove(toBeRemoved);
  } else {
    drawingFramesManager.currentFrame().objects.clear();
  }
  
}

public void copyFrame() {
  drawingFramesManager.copyFrameContents();
}

public void pasteFrame() {
  drawingFramesManager.pasteFrameContents();
}

public void removeLastStroke() {
  if(drawingFramesManager.currentFrame().objects.size() > 0){
    drawingFramesManager.currentFrame().objects.remove(drawingFramesManager.currentFrame().objects.size()-1);
  }
}

public void exportToPDF() {
  drawingFramesManager.savePDF();
}

public void reset() {
  drawingFramesManager.clear();
}
  
boolean mouseWithinPlayButton() {
  return mouseX > 1095 && mouseX < 1095+320 && mouseY > 525 && mouseY < 525+200;
}
boolean mouseWithinNextButton() {
  return mouseX > 1315 && mouseX < 1415 && mouseY > 775 && mouseY < 875;
}
boolean mouseWithinPrevButton() {
  return mouseX > 25 && mouseX < 125 && mouseY > 775 && mouseY < 875;
}
boolean mouseWithinCanvas() {
  return mouseX > 370 && mouseX < 1070 && mouseY > 25 && mouseY < 725;
}
boolean mouseWithinAddButton() {
  return mouseX > addButtonBounds[0] && mouseX < addButtonBounds[1] && mouseY > addButtonBounds[2] && mouseY < addButtonBounds[3];
}
boolean mouseWithinStrip() {
  int upperRange;
  if(frameEnd - frameStart == 9) {
    upperRange = 150+(frameEnd-1-frameStart)*125+112;
  } else {
    upperRange = 150+(frameEnd-frameStart)*125+112;
  }
  return mouseX > 150 && mouseX < upperRange && mouseY > 775 && mouseY < 875;
  // frameEnd is one longer than it should be, so this bool encompasses the "add frame" button
}
int stripIndex() {
  int returnValue = -1;
  for(int i=0; i < 9; i++) {
    if (mouseX < 150+i*125+112) {
      returnValue = i;
      break;
    }
  }
  return returnValue;
}
