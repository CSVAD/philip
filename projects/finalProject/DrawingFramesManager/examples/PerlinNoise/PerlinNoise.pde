import drawing.library.*;
import processing.pdf.*;

DrawingFramesManager drawingFramesManager;
ArrayList<DShape> shapes = new ArrayList<DShape>();
int lineCount = 100;
float xoff = 0.0;
boolean doPerlin = false;
void setup() {
  size(1056,816,P3D);
  background(255);
  smooth();
  drawingFramesManager = new DrawingFramesManager(this);
 }

void draw() {
  if(mousePressed){
   drawingFramesManager.stroke(0,0,0);
   xoff = xoff + 0.1;
  float n = map(noise(xoff),0.0,1.0,-5.0,5.0);
  float r = random(-5.0,5.0);
   for(int i=0;i<shapes.size();i++){
    DShape  shape = shapes.get(i);
   float x = (mouseX-pmouseX);
   float y;
   if(doPerlin){
     y = n;
   }
   else{
     y = r;
   }
   shape.addDelta(x, y);
   }

  }
    

}

void keyPressed() {
  if(key == ' '){
    drawingFramesManager.savePDF();
  }
   if(key == 'c'){
    drawingFramesManager.clear();
  }
  if(key == 't'){
       doPerlin = !doPerlin;

  }
}


void mousePressed(){
 drawingFramesManager.stroke(0,0,0);
  shapes.clear();
  for(int i=0;i<lineCount;i++){
  DShape  shape = drawingFramesManager.addShape();
   shapes.add(shape);
   
   shape.addVertex(mouseX,0+10*i);

  }

}