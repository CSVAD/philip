package drawing.library;

import processing.core.PApplet;
import processing.core.*;

public class Rotate implements DObj {
	public float theta;
	
	Rotate(PApplet myParent, float theta){
		this.theta = theta;
		this.renderTransformation(myParent);
	}
	
	Rotate(PApplet myParent, float theta, boolean apply){
		
		this.theta = theta;
		if(apply){
			this.renderTransformation(myParent);
		}
	}
	
	public void renderTransformation(PApplet parent){
		parent.rotate(this.theta);

	}
	
	public void drawIntoPDF(PGraphics pdf){
	   pdf.rotate(this.theta);
	  }
	
	public void render() {
		System.out.println("empty render on Rotate");
	}
}




