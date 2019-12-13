package drawing.library;

import processing.core.PApplet;
import processing.core.*;


public class Translate implements DObj {
	public float x;
	public float y;
	
	Translate(PApplet myParent, float x, float y){
		this.x = x;
		this.y = y;
		this.renderTransformation(myParent)	;	
	}
	
	Translate(PApplet myParent, float x, float y, boolean apply){
		this.x = x;
		this.y = y;
		if(apply){
			this.renderTransformation(myParent);
		}
		
	}
	public void renderTransformation(PApplet parent){
		parent.translate(this.x,this.y);

	}
	
	public void drawIntoPDF(PGraphics pdf){
	   pdf.translate(this.x,this.y);
	  }
	
	public void render() {
		System.out.println("empty render on Translate");
	}
}




