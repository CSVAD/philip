import drawing.library.*;
import processing.pdf.*;
import processing.sound.*;

DrawingFramesManager drawingFramesManager;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;


// Declare a scaling factor
float scale=500;
float offsetScale = 30;

// Declare a smooth factor
float smooth_factor=0.25;

// Used for smoothing
float sum;


void setup() {
  size(1056, 816, P3D);
  background(255);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);

  //Load and play a soundfile and loop it
  sample = new SoundFile(this, "beat.aiff");
  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(sample);
}

void draw() {
  if(mousePressed){
      drawingFramesManager.stroke(0, 0, 0);
      // smooth the rms data by smoothing factor
      sum += (rms.analyze() - sum) * smooth_factor;  

      // rms.analyze() return a value between 0 and 1. It's
      // scaled to height/2 and then multiplied by a scale factor
      float offset=sum*scale;
      
        drawingFramesManager.fill(255,255,255);
        
      pulseLine(mouseX, mouseY, offset);
    
  }

}


void keyPressed() {
  if (key == ' ') {
    drawingFramesManager.savePDF();
  }
  if (key == 'c') {
    drawingFramesManager.clear();
  }
}


void mousePressed() {
  sample.loop();
  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(sample);
}

void mouseReleased() {
   sample.stop();
}


void pulseLine(int x, int y, float offset) {
  drawingFramesManager.translate(x,y); 
  drawingFramesManager.ellipse(0, 0,offset, offset);
}