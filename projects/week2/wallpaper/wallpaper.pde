//truchet tiling 1

float rW = 50;
float rH = 50;
float[] pattern = {1.0, 0.25, 0.75, 0.5};
//float[] pattern = {random(1.0)};


void setup(){
  size(1000,1000);
  background(255, 255, 0);
  noFill();
  
  stroke(255);
  
    for(int j=0;j<height/rH;j++){
      int t = 0;
      
     //check to see if row is even or odd
      if(j%3 !=0){
        t = pattern.length/2;
      
      }
      
     for(int i=0;i<width/rW;i++){
      float v = pattern[t];
      //float v = random(1.0); //pattern[t];
      float r = toQuadrant(v);
      println(v,degrees(r),i);
      drawSeed(i*rW,j*rH,r);
      
      //if(i % 7 == 0 && j % 7 == 0) {//random(1.0) > 0.93) {
      if(random(1.0) > 0.97) {

        int offset = 135;
        stroke(i*rW*0.15 + offset, j*rW*0.15 + offset, (40-i)*rW*0.15 + offset);
        
        fill(i*rW*0.15 + offset, j*rW*0.15 + offset, (40-i)*rW*0.15 + offset);
        if(random(1.0) > 0.50) {
          noFill();
        }
        drawCircle(Math.round(i*rW), Math.round(j*rH), random(100));
      }
      t++;
      if(t>pattern.length-1){
        t = 0;
      }

    }
  }
}

void draw(){
  
}

void drawCircle(int x, int y, float radius) {
  ellipse(x, y, radius, radius);
  if(radius > random(150)) {
    radius *= 0.751f;
    fill(255, 255, 0);
    if(random(1.0) > 0.5) {
      noFill();
    }
    drawCircle(x, y, radius);
  }
}

float toQuadrant(float v){
  if(v <=0.25){
    return 2*PI*0.25;
  }
  else if(v >0.25 && v<=0.5){
    return  2*PI*0.5;
  }
  else if(v >0.5 && v<=0.75){
    return  2*PI*0.75;
  }
  else{
     return 2*PI;
  }
}

void drawSeed(float x, float y,float r){
  pushMatrix();
   translate(x+rW/2,y+rH/2);
   rotate(r + random(0.0));
   noFill();
   rectMode(CENTER);
   //rect(0,0,rW,rH); 
   //fill(255);
   noFill();
   //line(-rW/2,-rH/2,rW/2,-rH/2);
   //stroke(random(255), random(255), random(255));
   int offset = 135;
   stroke(x*0.15 + offset, y*0.15 + offset, x*0.15 + offset);
   line(rW/2 + random(10),-rH/2 + random(10),-rW/2 + random(10),rH/2 + random(10));
   line(rW/2 - 2,-rH/2 - 2,-rW/2 - 2,rH/2 - 2);
   line(-rW/2 + random(5),-rH/2 + random(5),rW/2 + random(5),-rH/2 + random(5));

   //triangle(-rW/2,-rH/2,rW/2,-rH/2,-rW/2,rH/2);
 popMatrix();
  
}
