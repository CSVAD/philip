// M_1_4_01.pde
// TileSaver.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * creates a terrain like mesh based on noise values.
 * 
 * MOUSE
 * position x/y + left drag   : specify noise input range
 * position x/y + right drag  : camera controls
 * 
 * KEYS
 * l                          : toogle displaly strokes on/off
 * arrow up                   : noise falloff +
 * arrow down                 : noise falloff -
 * arrow left                 : noise octaves -
 * arrow right                : noise octaves +
 * space                      : new noise seed
 * +                          : zoom in
 * -                          : zoom out
 * s                          : save png
 * p                          : high resolution export (please update to processing 1.0.8 or 
 *                              later. otherwise this will not work properly)
 */

import processing.opengl.*;
import java.util.Calendar;
import controlP5.*;
ControlP5 cp5;

Controller zNoiseModSlider;
Controller noiseXRangeSlider;
Controller noiseYRangeSlider;
Controller maxLayersSlider;
Controller layerDensitySlider;
Controller tileCountSlider;
Controller cubeUnitsSlider;
Controller cubeSizeSlider;

// ------ mesh ------
int cubeUnits = 10;
int cubeSize = 28;
int tileCount = 50;
int zScale = 250;
int maxLayers = 50;
int layerDensity = 10;

// ------ noise ------
float zNoiseMod = 0.025;
float noiseXRange = 0.5;
float noiseYRange = 0.5;
int octaves = 4;
float falloff = 0.5;

// ------ mesh coloring ------
color midColor, topColor, bottomColor;
color strokeColor;
float threshold = 0.30;

// ------ mouse interaction ------
int offsetX = 0, offsetY = 0, clickX = 0, clickY = 0, zoom = -600;
float rotationX = 0, rotationZ = PI/4.0, targetRotationX = -PI/3, targetRotationZ = PI/4.0, clickRotationX, clickRotationZ; 

// ------ image output ------
int qualityFactor = 4;
TileSaver tiler;  
boolean showStroke = false;


void setup() {
  fullScreen(P3D);
  //size(800, 800, P3D);
  colorMode(HSB, 360, 100, 100);
  cp5 = new ControlP5(this);
  tiler = new TileSaver(this);
  cursor(CROSS);

  // colors
  topColor = color(6, 55, 55); //color(0, 0, 100); // dark blue
  midColor = color(6, 35, 75); //color(191, 99, 63); 
  bottomColor = color(6, 35, 75); //color(0, 0, 0); // black

  strokeColor = color(0, 0, 0);
  smooth();
  

  noiseXRangeSlider =  cp5.addSlider("noiseXRange")
    .setPosition(25, 1*25)
    .setRange(0.0, 4.0)
    .setColorLabel(0)
    ;
  noiseYRangeSlider =  cp5.addSlider("noiseYRange")
    .setPosition(25, 2*25)
    .setRange(0.0, 4.0)
    .setColorLabel(0)
    ;
  zNoiseModSlider =  cp5.addSlider("zNoiseMod")
    .setPosition(25, 3*25)
    .setRange(0.0, 0.15)
    .setColorLabel(0)
    ;
  maxLayersSlider =  cp5.addSlider("maxLayers")
    .setPosition(25, 4*25)
    .setRange(5, 100)
    .setColorLabel(0)
    ;
  layerDensitySlider =  cp5.addSlider("layerDensity")
    .setPosition(25, 5*25)
    .setRange(1, 100)
    .setColorLabel(0)
    ;
  tileCountSlider =  cp5.addSlider("tileCount")
    .setPosition(25, 6*25)
    .setRange(9, 100)
    .setColorLabel(0)
    ;
  cubeUnitsSlider =  cp5.addSlider("cubeUnits")
    .setPosition(25, 7*25)
    .setRange(5, 100)
    .setColorLabel(0)
    ;
  cubeSizeSlider =  cp5.addSlider("cubeSize")
    .setPosition(25, 8*25)
    .setRange(5, 100)
    .setColorLabel(0)
    ;
}

void draw() {
  if (tiler==null) return; 
  tiler.pre();

  if (showStroke) stroke(strokeColor);
  else noStroke();

  background(0, 10, 100);
  lights();


  // ------ set view ------
  pushMatrix();
  translate(width*0.5, height*0.5, zoom);

  if (mousePressed && mouseButton==RIGHT) {
    offsetX = mouseX-clickX;
    offsetY = mouseY-clickY;
    targetRotationX = min(max(clickRotationX + offsetY/float(width) * TWO_PI, -HALF_PI), HALF_PI);
    targetRotationZ = clickRotationZ + offsetX/float(height) * TWO_PI;
  }      
  rotationX += (targetRotationX-rotationX)*0.25; 
  rotationZ += (targetRotationZ-rotationZ)*0.25;  
  rotateX(-rotationX);
  rotateZ(-rotationZ); 


  // ------ mesh noise ------
  //if (mousePressed && mouseButton==LEFT) {
  //  noiseXRange = mouseX/200.0;
  //  noiseYRange = mouseY/200.0;
  //}

  noiseDetail(octaves, falloff);
  
  //for(int i=0; i<maxLayers; i++) {
  //  float baseHeight = i*layerDensity - (maxLayers * layerDensity)/2;
  //  drawSheet(baseHeight, i * zNoiseMod);
  //}
  
  drawCube(cubeUnits, cubeSize);

  popMatrix();

  tiler.post();
}

void drawCube(int units, float size){
  pushMatrix();
    //// front and back
    drawFacePair(units, size);
    rotateX(HALF_PI);
    //// top and bottom
    drawFacePair(units, size);
    rotateY(HALF_PI);
    //// left and right
    drawFacePair(units, size);
  popMatrix();
}

void drawFacePair(int units, float size){
  pushMatrix();
    translate(0,0,units*size/2);
    drawSheet(units, units, size, size);
    translate(0,0,-units*size);
    drawSheet(units, units, size, size);
  popMatrix();
}

void drawSheet(int cols, int rows, float w, float h){
  
  float noiseYMax = 0;
  float tileSizeY = (float)height/rows;
  float noiseStepY = (float)noiseYRange/rows;
  
  pushMatrix();
  translate(-cols*w/2,-rows*h/2);
  for (int meshY = 0; meshY < rows; meshY++) {
    beginShape(TRIANGLE_STRIP); 
    for (int meshX = 0; meshX <= cols; meshX++) {
      
      float x = map(meshX, 0, cols, -width/3, width/3);
      float y = map(meshY, 0, rows, -height/2, height/2);

      float noiseX = map(meshX, 0, cols, 0, noiseXRange);
      float noiseY = map(meshY, 0, rows, 0, noiseYRange);
      //float noiseZ
      float z1 = noise(noiseX, noiseY);//, noiseZ);
      float z2 = noise(noiseX, noiseY+noiseStepY);//, noiseZ);
      
      //vertex(meshX*w, meshY*h);//, + z1*zScale);
      //vertex(meshX*w, meshY*h + h);//, + z2*zScale); 
      
      vertex(x, y, + z1);
      vertex(x, y + tileSizeY, + z2); 
    }
    endShape();
  }
  popMatrix();
}

//public void drawSheet(float baseHeight, float noiseZ) {
//  float noiseYMax = 0;

//  float tileSizeY = (float)height/tileCount;
//  float noiseStepY = (float)noiseYRange/tileCount;
  
//  for (int meshY=0; meshY<=tileCount; meshY++) {
//    beginShape(TRIANGLE_STRIP);
//    for (int meshX=0; meshX<tileCount; meshX++) {

//      float x = map(meshX, 0, tileCount, -width/3, width/3);
//      float y = map(meshY, 0, tileCount, -height/2, height/2);

//      float noiseX = map(meshX, 0, tileCount, 0, noiseXRange);
//      float noiseY = map(meshY, 0, tileCount, 0, noiseYRange);
//      //float noiseZ
//      float z1 = noise(noiseX, noiseY, noiseZ);
//      float z2 = noise(noiseX, noiseY+noiseStepY, noiseZ);

//      noiseYMax = max(noiseYMax, z1);
//      color interColor;
//      colorMode(RGB);
//      if (z1 <= threshold) {
//        float amount = map(z1, 0, threshold, 0.15, 1);
//        interColor = lerpColor(bottomColor, midColor, amount);
//      } 
//      else {
//        float amount = map(z1, threshold, noiseYMax, 0, 1);
//        interColor = lerpColor(midColor, topColor, amount);
//      }
//      colorMode(HSB, 360, 100, 100);
//      fill(interColor);

//      vertex(x, y, baseHeight + z1*zScale);   
//      vertex(x, y+tileSizeY, baseHeight + z2*zScale);
//    }
//    endShape();
//  }
//}

void mousePressed() {
  clickX = mouseX;
  clickY = mouseY;
  clickRotationX = rotationX;
  clickRotationZ = rotationZ;
}

void keyPressed() {
  if (keyCode == UP) falloff += 0.05;
  if (keyCode == DOWN) falloff -= 0.05;
  if (falloff > 1.0) falloff = 1.0;
  if (falloff < 0.0) falloff = 0.0;

  if (keyCode == LEFT) octaves--;
  if (keyCode == RIGHT) octaves++;
  if (octaves < 0) octaves = 0;

  if (key == '+') zoom += 20;
  if (key == '-') zoom -= 20;
}

void keyReleased() {  
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_####.png");
  if (key == 'p' || key == 'P') tiler.init(timestamp()+".png", qualityFactor);
  if (key == 'l' || key == 'L') showStroke = !showStroke;
  if (key == ' ') noiseSeed((int) random(100000));
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}
