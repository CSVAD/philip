import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;

void setup() {
  size(1056,816,P3D);
  background(255);

  drawingManager = new DrawingManager(this);
  
 }

void draw() {
}

void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
   if(key == 'c'){
    drawingManager.clear();
  }
}


void mouseDragged(){
  drawingManager.stroke(0,0,0);
  snakeLine(mouseX, mouseY, pmouseX, pmouseY);
}

void snakeLine(int x, int y, int px, int py) {
  float speed = abs(x-px) + abs(y-py);
  float speedColor = map(speed, 0.0, 100.0, 230, 0);
  
  drawingManager.stroke(int(speedColor), int(speedColor), int(speedColor));
  
  PVector current = new PVector(x, y); // mouse location
  PVector previous = new PVector(px, py); // prev mouse
  PVector delta = current.copy().sub(previous); // delta vector
  
  PVector flank1 = new PVector(-delta.y, delta.x);
  PVector flank2 = new PVector(delta.y, -delta.x);
  
  PVector flank1Line = current.copy().add(flank1.mult(random(0.4, 0.7)));
  PVector flank2Line = current.copy().add(flank2.mult(random(0.4, 0.7)));
  
  PVector feather = delta.copy().mult(random(2.5, 3.0)).add(current);
  PVector flank1Feather = delta.copy().mult(random(1.3, 1.7)).add(flank1Line);
  PVector flank2Feather = delta.copy().mult(random(1.3, 1.7)).add(flank2Line);

  drawingManager.line(x, y, feather.x, feather.y);
  drawingManager.line(flank1Line.x, flank1Line.y, flank1Feather.x, flank1Feather.y);
  drawingManager.line(flank2Line.x, flank2Line.y, flank2Feather.x, flank2Feather.y);
}
