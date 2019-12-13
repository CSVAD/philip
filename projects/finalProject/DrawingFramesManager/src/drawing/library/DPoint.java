package drawing.library;

import processing.core.*;
import processing.core.PApplet;



public class DPoint implements DObj {

	 public float x;
	 public float y;
	 
	 public DPoint(float x, float y){
	   this.x = x;
	   this.y = y;
	 }
	 
	 public void renderTransformation(PApplet myParent){
		
	 }
	
	 public void drawIntoPDF(PGraphics pdf){
		 pdf.vertex(this.x,this.y);
	 }
	 public void render() {
		 System.out.println("empty render on DPoint");
	 }

	
}
