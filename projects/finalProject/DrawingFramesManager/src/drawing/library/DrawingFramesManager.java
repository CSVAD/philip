package drawing.library;


import processing.core.*;
import processing.core.PImage;

import java.util.ArrayList;
import java.time.LocalDateTime;
/**
 * This is a template class and can be used to start a new processing Library.
 * Make sure you rename this class as well as the name of the example package 'template' 
 * to your own Library naming convention.
 * 
 * (the tag example followed by the name of an example included in folder 'examples' will
 * automatically include the example in the javadoc.)
 *
 * @example Hello 
 */

public class DrawingFramesManager {
	
	// myParent is a reference to the parent sketch
	PApplet myParent;
	public ArrayList<DFrame> frames;
	public DFrame clipboard = new DFrame();
	public int currentFrameIndex;
	public boolean isWrapping = false;
	DColor fillColor;
	DColor strokeColor;
	float strokeWeight;
	boolean noFill = true;
	boolean noStroke = false;
	
	public final static String VERSION = "1.0.0";
	

	/**
	 * constructor
	 *
	 */
	public DrawingFramesManager(PApplet theParent) {
		myParent = theParent;
		frames = new ArrayList<DFrame>();
		clear();
		strokeColor = new DColor(0,0,0);
		fillColor = new DColor(255,255,255);
		strokeWeight = 1;
	}
	
	
	public void fill(int r, int g, int b){
	      fillColor = new DColor(r,g,b);
	      noFill = false;
	    }
	
	public void fill(int r, int g, int b, int a){
	      fillColor = new DColor(r,g,b,a);
	      noFill = false;
	    }
	
	public void stroke(int r, int g, int b){
	      strokeColor = new DColor(r,g,b);
	      noStroke = false;
	    }
	public void stroke(int r, int g, int b, int a){
	      strokeColor = new DColor(r,g,b,a);
	      noStroke = false;
	    }
	
	public void noStroke(){
	     noStroke = true;
	    }
	
	public void strokeWeight(float weight){
	    this.strokeWeight = weight;
	    }
	
	
	public void noFill(){
	     noFill = true;
	    }
	
	
	
	public void line(float x1, float y1,float x2, float y2){
	      DLine l = new DLine(this.myParent, x1, y1,x2,  y2, fillColor,strokeColor,noFill,noStroke);
	      currentFrame().objects.add(l);
	   }
	
	public DShape addShape(){
		DShape dShape = new DShape(this.myParent,fillColor,strokeColor,strokeWeight,noFill,noStroke);
		currentFrame().objects.add(dShape);
		return dShape;
	}
	
	public void triangle(float x1, float y1,float x2, float y2,float x3, float y3){
	      DTriangle t = new DTriangle(this.myParent, x1, y1,x2,  y2,x3,y3, fillColor,strokeColor,noFill,noStroke);
	      currentFrame().objects.add(t);
	   }
	
	public void ellipse(float x, float y,float width, float height){
	      DEllipse e = new DEllipse(this.myParent, x, y, width, height, fillColor,strokeColor,noFill,noStroke);
	      currentFrame().objects.add(e);
	   }
	
	public void image(PImage name, float x, float y,float width, float height){
	      DImage i = new DImage(this.myParent,name, x, y, width, height);
	      currentFrame().objects.add(i);
	   }
	
	public void rect(float x, float y,float width, float height){
	     DRect r = new DRect(this.myParent, x, y, width, height, fillColor,strokeColor,noFill,noStroke);
	     currentFrame().objects.add(r);
	   }
	public void pushMatrix(){
		PushTransform p = new PushTransform(this.myParent);
		currentFrame().objects.add(p);
	}
	
	public void popMatrix(){
		PopTransform p = new PopTransform(this.myParent);
		currentFrame().objects.add(p);
	}
	
	public void rotate(float theta){
		Rotate r = new Rotate(this.myParent,theta);
		currentFrame().objects.add(r);
	}
	
	public void scale(float x, float y){
		Scale s = new Scale(this.myParent,x,y);
		currentFrame().objects.add(s);
	}
	
	public void translate(float x, float y){
		Translate t = new Translate(this.myParent,x,y);
		currentFrame().objects.add(t);
	}

	public void clear() {
		frames.clear();
		frames.add(new DFrame());
		clipboard.objects.clear();
		setCurrentFrameIndex(0);
	}
	
	public DFrame currentFrame() {
		return frames.get(currentFrameIndex);
	}
	public void nextFrame() {
		if(currentFrameIndex == frames.size()-1) {
			isWrapping = true;
		}
		setCurrentFrameIndex((currentFrameIndex + 1) % frames.size());
	}
	public void previousFrame() {
		int newIndex = currentFrameIndex - 1;
		
		if(newIndex < 0) {
			newIndex = frames.size() - 1;
		}
		
		setCurrentFrameIndex(newIndex);
	}
	public void newFrame() {
		frames.add(new DFrame());
		setCurrentFrameIndex(frames.size() - 1); // last frame
	}
	
	public void renderFrame(int frameIndex) {
		DFrame frame = frames.get(frameIndex);
		frame.render();
	}
	
	public void renderCurrentFrame() {
		DFrame frame = currentFrame();
		frame.render();
	}
	
	public int setCurrentFrameIndex(int index) {
		int max = frames.size() - 1;
		int newIndex = index > max ? max : index < 0 ? 0 : index;
		currentFrameIndex = newIndex;
		return newIndex;
	}
	
	public void copyFrameContents() {
		// clear the buffer
		clipboard.objects.clear();
		//copy in the contents of the current frame
		//clipboard.objects = currentFrame().objects;
		for(int i=0; i< currentFrame().objects.size(); i++) {
			clipboard.objects.add(currentFrame().objects.get(i));
		}
	}
	public void pasteFrameContents() {
		// copy the objects in clipboard frame.objects
		// into currentFrame.objects list (append)
		for(int i=0; i< clipboard.objects.size(); i++) {
			currentFrame().objects.add(clipboard.objects.get(i));
		}
	}
	
//	Switched strategies when implementing grid output
//  involved changing the interface drawIntoPDF argument type form PGraphicsPDF to PGraphics
//  I'm sure there is a way to unify these two strategies, but for now
// 	there is only one way to export PDFs and that is for scaled down grid
//  plotter output.
// 
//	public void savePDF(){
//		LocalDateTime today = LocalDateTime.now();
//		int year = today.getYear();
//		int month = today.getMonthValue();
//		int day = today.getDayOfMonth();
//		int hour = today.getHour();
//		int min = today.getMinute();
//		int sec = today.getSecond();
//		int milsec = today.getNano()/1000000;
//	    PGraphicsPDF pdf = (PGraphicsPDF)myParent.beginRaw(PGraphics.PDF, "saved_"+year+"-"+month+"-"+day+"-"+hour+"-"+min+"-"+sec+"-"+milsec+".pdf");
//	     
//	      for(int i =0;i< currentFrame().objects.size();i++){ 
//	    	  currentFrame().objects.get(i).drawIntoPDF(pdf);
//	      }
//	     myParent.endRaw();    
//	   }	
	public void savePDF(){
		savePDF("Export");
	}
	    
	public void savePDF(String fileName){
		//
		// The problem: animation frames are collections of objects
		// those objects are collections of vertices.
		// The coordinates of those vertices reflect a drawing canvas
		// that is near the center of a window that is
		// 1440 px wide x 900 px tall
		// 
		// In order to output these frames into a grid for plotting
		// and cutting to fabricate flipbooks, I need to scale and
		// render each frame into a different location...
		//
		// rect(370, 25, 700, 700); <-- this is my drawing canvas 
		// so... all of our frames have coordinates that are
		// min x > 370 ... max x < 1070
		// min y > 25 .... max y < 725
		// 
		// so we'll want to scale these values to a square that is 204X204:
		// this is a scale down of 204/700... -> 0.2914 (29% of the canvas size)
		// so lets try this first, by calling scale on the PGraphics object.
		//
		// Wow... it worked! Ok, I just learned something about Processing renderers-- each renderer has its own
		// translation matrix that allows you to call scale/translate/rotate on it, and it tracks the changes on a stack
		// that most likely supports functions like #pushMatrix and #popMatrix.
		//
		// But back to the task. I know that I need to use #translate to move the frame so it lines up with my cut lines.
		// I know that I need to translate it "up" 25 pixels... and over to the "left" by 370 pixels.
		// But I don't want it in the center of the plotted frame-- I want it on the right side, so that the frames are visible
		// when flipping the book with the thumb. The left buffer will be where the staples or other fasteners go to bind
		// the book.
		//
		//
		// so.. if the height 700px is shrunk down to 204 px, then the width is also 204 pix.
		// oh, right, the width of the plotter frame is 264... so if I slide the micro frame to the center the buffer would be
		// (264-204) / 2 = 30... so I want the frame to be on the right side, with zero offset
		// so I want to translate it -370 (center) + (30 * (700/204)) = -267
		
		// Lets find out if it works?!?!??!?!
		// result: it somehow is still centered. Definitely because the aspect ratios do not match,
		// hypothesis: 900/1440 != 204/264 => correct. different aspect ratios.
		// so, I got lucky (?) by having the frame centered, but it wasn't what I was going for.
		// lets offset it by another round of 30*(700/204) => 103
		// I have a good feeling about this.... BINGO!
		
		// OK, next step:
		// I need to fill up each frame in the 3x3 grid then cut a new pdf.
		//
		// I'm happy with this approach. Lets see if it works!
		// Mostly successful! Couple of issues:
		// -- the cut lines were scaled down! lol.
		// -- other issue: for each pdf, I need to increment the starting frame by 9...
		//
		// OK, those issues were addressed, but not I'm seeing a problem with how I compue the y translate
		// the ternary works fine for indexes 0-8, but breaks above that.
		// It will work fine if I create fake indexes by "undoing" the paging that I just introduced.
		
		LocalDateTime today = LocalDateTime.now();
		int year = today.getYear();
		int month = today.getMonthValue();
		int day = today.getDayOfMonth();
		int hour = today.getHour();
		int min = today.getMinute();
		int sec = today.getSecond();
		PGraphics pdf;
		
		// one way is to batch the frames into groups of 9
		// 
		int fullGroups = (int)frames.size() / 9;
		if(frames.size() % 9 > 0) { fullGroups++; } // add one more page if number of frames does not divide evenly by 9
		
		for(int i =0; i < fullGroups; i++){ 
			//for each full page
		    pdf = myParent.createGraphics(792,612, PGraphics.PDF, fileName+"_"+year+"-"+month+"-"+day+"-"+hour+"-"+min+"-"+sec+"_"+i+".pdf");
	        pdf.beginDraw();

	        
	        // cut-lines
	        for(int j=1; j<3; j++) {
	            pdf.line(0, j*(pdf.height/3), pdf.width, j*(pdf.height/3));
	            pdf.line(j*(pdf.width/3), 0, j*(pdf.width/3), pdf.height);
	          }
	        
	        pdf.scale(0.2914f); // only needs to happen once per pdf! (but after cut lines)

	        
	        // render the frames
	        int startFrame = i * 9;
	        int endFrame = frames.size() > i * 9 + 9 ? i * 9 + 9 : frames.size();
	        // ternary means:
	        // if the number of frames is larger than the start frame + 9
	        //   then the end frame should be start frame plus 9
	        //   else the end frame should be the last frame in the animation (frames.size())
	        
	        for(int f= startFrame; f<endFrame; f++) {
		        pdf.pushMatrix();
		        pdf.translate(-370 + (2*103), -25); // this gets us to index 0
		        
		        int gridIndex = f - (i * 9); // essentially "undo" the paging
		        int xTranslate = (gridIndex % 3) * 264;
		        int yTranslate = gridIndex < 3 ? 0 : gridIndex < 6 ? 204 : 408;
		        float scaler = 700.0f/204.0f;
		        
		        pdf.translate(xTranslate * scaler, yTranslate * scaler);
		        
		        // now if index is 
		        
		        // 0: 0, 0
		        // 1: 264, 0
		        // 2: 528, 0
		        // 3: 0, 204
		        // 4: 264, 204
		        // 5: 528, 204
		        // 6: 0, 408
		        // 7: 264, 408
		        // 8: 528, 408
		        
		        // this pattern can be computed using modulo for the xTranslate,
		        // but what about yTranslate... 
		        
				frames.get(f).drawIntoPDF(pdf);
				
				pdf.popMatrix();
	        }
		    pdf.dispose();
			pdf.endDraw();
	    }
	       
	   }
	
	
	/**
	 * return the version of the Library.
	 * 
	 * @return String
	 */
	public static String version() {
		return VERSION;
	}

}

