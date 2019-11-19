
import processing.pdf.*;
import AULib.*;
import controlP5.*;

ControlP5 cp5;

Controller noiseModSlider;
Controller noiseXRangeSlider;
Controller noiseYRangeSlider;
Controller tdXSlider;
Controller tdYSlider;
Controller tileCountSlider;
Controller cubeUnitsSlider;
Controller cubeSizeSlider;



// ------ mesh ------
int cubeUnits = 30;
int cubeSize = 5;
int tileCount = 30;
int zScale = 100;
int maxLayers = 50;
int layerDensity = 10;

// ------ noise ------
float noiseMod = 300.0;
float noiseXRange = 0.93;
float noiseYRange = 0.88;
int octaves = 8;
float falloff = 0.5;

// ------ mesh coloring ------
color midColor = color(6, 35, 75);
color topColor = color(6, 55, 55);
color bottomColor = color(6, 35, 75);
color strokeColor = color(0);
float threshold = 0.50;

// ------ mouse interaction ------
int offsetX = 0, offsetY = 0, clickX = 0, clickY = 0, zoom = 400;
float rotationX = 0, rotationZ = PI, targetRotationX = -1.4366239, targetRotationZ = PI, clickRotationX, clickRotationZ; 

// ------ image output ------
int qualityFactor = 4;
boolean showStroke = true;

//
PVector opticalFlow;
int ofThreshold = 100;
int flowScale = 10;
float cubeMoveX = 0;
float cubeMoveY = 0;
int translateDrawX = 1609;
int translateDrawY = 65;

void setup() {

  size(792,612);
  //strokeJoin(ROUND);
  stroke(0);
  
  cp5 = new ControlP5(this);
  
  //noiseModSlider =  cp5.addSlider("noiseMod")
  //  .setPosition(25, 3*25)
  //  .setRange(0.0, 300.0)
  //  .setColorLabel(0)
  //  ;
  //cubeUnitsSlider =  cp5.addSlider("cubeUnits")
  //  .setPosition(25, 4*25)
  //  .setRange(5, 100)
  //  .setColorLabel(0)
  //  ;
  //cubeSizeSlider =  cp5.addSlider("cubeSize")
  //  .setPosition(25, 5*25)
  //  .setRange(5, 100)
  //  .setColorLabel(0)
  //  ;
    
}
void draw() {


beginRecord(PDF, "plot.pdf"); 

pushMatrix();
    translate(width*0.5, height*0.2);
    scale(3.2, 1.8);
    
    if (mousePressed && mouseButton==RIGHT) {
      offsetX = mouseX-clickX;
      offsetY = mouseY-clickY;
      targetRotationX = min(max(clickRotationX + offsetY/float(width) * TWO_PI, -HALF_PI), HALF_PI);
      targetRotationZ = clickRotationZ + offsetX/float(height) * TWO_PI;
      println(targetRotationX);
    }      
    rotationX += (targetRotationX-rotationX)*0.25; 
    rotationZ += (targetRotationZ-rotationZ)*0.25;  
    //rotateX(-rotationX);
    //rotateZ(-rotationZ); 
    
    noiseDetail(octaves, falloff);
    fill(255);//, 145);
    for(int y = 0;y<4;y++) { 
      drawCube(cubeUnits, cubeSize+0.4*y);
    }
  popMatrix(); 


//noFill();


endRecord();

}

void drawCube(int units, float size){
  pushMatrix();
    //// front and back
    //drawFacePair(units, size);
    //rotateX(HALF_PI);
    //// top and bottom
    //drawFacePair(units, size);
    //rotateY(HALF_PI);
    //// left and right
    drawFacePair(units, size);
  popMatrix();
}

void drawFacePair(int units, float size){
  pushMatrix();
    translate(0,0);
    drawSheet(units, units, size, size);
  popMatrix();
}

void drawSheet(int cols, int rows, float w, float h){  
  pushMatrix();
  translate(-cols*w/2,-rows*h/2);
  for (int meshY = 0; meshY < rows; meshY++) {
    beginShape(POINTS); 
    for (int meshX = 0; meshX <= cols; meshX++) {
      float noiseX = map(meshX, 0, cols, 0, noiseXRange);
      float noiseY = map(meshY, 0, rows, 0, noiseYRange);
      //float noiseZ
      float z1 = noise(noiseX, noiseY);//, noiseZ);      
      vertex(meshX*w, meshY*h + z1*noiseMod);//, + z1*zScale);
      vertex(meshX*w, meshY*h + z1*noiseMod);//, + z2*zScale); 
    }
    endShape();
  }
  popMatrix();
}
