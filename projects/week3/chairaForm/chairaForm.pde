import controlP5.*;
ControlP5 cp5;

float seatWidth = 100.0; // width of seat, also influences where the legs go
float chairHeight = 100.0; // legs and back height
float seatDepth = 100.0; // depth of seat, also influences where the legs go
float legSize = 10.0; // drives x & z dimensions of legs
float seatThickness = 10.0; // how thick the seat and back are

Controller seatWidthSlider;
Controller chairHeightSlider;
Controller seatDepthSlider;
Controller legSizeSlider;
Controller seatThicknessSlider;


void setup() {
  size(1024, 768, P3D);
  cp5 = new ControlP5(this);

  seatWidthSlider =  cp5.addSlider("seatWidth")
    .setPosition(25, 25)
    .setRange(33, 300)
    ;

  chairHeightSlider = cp5.addSlider("chairHeight")
    .setPosition(25, 25*2)
    .setRange(33, 300)
    ;

  seatDepthSlider =  cp5.addSlider("seatDepth")
    .setPosition(25, 25*3)
    .setRange(33, 300);
    ;
  legSizeSlider =  cp5.addSlider("legSize")
    .setPosition(25, 25*4)
    .setRange(8, 50);
    ; 
    
  seatThicknessSlider =  cp5.addSlider("seatThickness")
    .setPosition(25, 25*5)
    .setRange(8, 50);
    ; 
}


void draw() {
  float seatOffset = seatThickness/2;
  float legOffset = legSize/2;
  float seatWidthOffset = seatWidth/2 - legOffset;
  float seatDepthOffset = seatDepth/2 - legOffset;
  float legPositionY = chairHeight/2 + seatThickness/2;

  background(0);
  lights();
  
  pushMatrix();
    translate(width / 2, height / 2, 0);
    fill(250, 220, 0);
    stroke(250,250,250);
    strokeWeight(1);
    rotateY((float)(frameCount * Math.PI / 400));
    translate(0, (sin(frameCount*0.01) * 40), 0);
    
    // draw seat, center origin
    box(seatWidth, seatThickness, seatDepth);
    
    // draw seat back
    pushMatrix();
      translate(0, -chairHeight/2 - seatOffset, seatDepth/2 - seatOffset);
      box(seatWidth, chairHeight, seatThickness);
    popMatrix();
    
    // draw legs
    pushMatrix();
      translate(-seatWidthOffset, legPositionY, -seatDepthOffset);
      box(legSize, chairHeight, legSize);
    popMatrix();
    
    pushMatrix();
      translate(-seatWidthOffset, legPositionY, seatDepthOffset);
      box(legSize, chairHeight, legSize);
    popMatrix();
    
    pushMatrix();
      translate(seatWidthOffset, legPositionY, seatDepthOffset);
      box(legSize, chairHeight, legSize);
    popMatrix();
    
    pushMatrix();
      translate(seatWidthOffset, legPositionY, -seatDepthOffset);
      box(legSize, chairHeight, legSize);
    popMatrix();


  popMatrix();
}
