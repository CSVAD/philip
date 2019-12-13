package drawing.library;

import processing.core.PApplet;
import processing.core.*;


public interface DObj {
	
	 public void drawIntoPDF(PGraphics pdf);
	  
	 public void renderTransformation(PApplet parent);
	 
	 public void render();
}
