import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;
ArrayList<DShape> shapes = new ArrayList<DShape>();
ArrayList<Float> scaleVals = new ArrayList<Float>();
DShape referenceShape;
int lineCount = 20;

void setup() {
  size(1056, 816, P3D);
  background(255);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);
}

void draw() {
  if (mousePressed) {
    drawingFramesManager.stroke(0, 0, 0);

    for (int i=0; i<shapes.size(); i++) {
      DShape  shape = shapes.get(i);
      float scaleVal = scaleVals.get(i);
      float x = (mouseX-pmouseX)*scaleVal;
      float y = (mouseY-pmouseY)*scaleVal; 
      shape.addDelta(x, y);
    }
    referenceShape.addVertex(mouseX, mouseY);
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
  drawingFramesManager.stroke(0, 0, 0);
  shapes.clear();
  scaleVals.clear();
  for (int i=0; i<lineCount; i++) {
    DShape  shape = drawingFramesManager.addShape();
    shapes.add(shape);
    float xval = randomGaussian();
    float yval = randomGaussian();
    float sd = 100;                  // Define a standard deviation
    float mean = 0;           // Define a mean value (middle of the screen along the x-axis)
    float x = ( xval * sd ) + mean;  // Scale the gaussian random number by standard deviation and mean
    float y = ( yval * sd ) + mean;

    float sval = randomGaussian();
    sd = 1.5;                  // Define a standard deviation
    mean = 0.5;  
    float scale = abs(( sval * sd ) + mean);
    shape.addVertex(mouseX+x, mouseY+y);

    scaleVals.add(scale);
  }
  drawingFramesManager.stroke(255, 0, 0);

  referenceShape = drawingFramesManager.addShape();
  referenceShape.addVertex(mouseX, mouseY);
}