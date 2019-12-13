package drawing.library;

import java.util.ArrayList;

import processing.core.*;

public class DFrame {
	
	public ArrayList<DObj> objects; 
	 
	DFrame(){
		objects = new ArrayList<DObj>();
		
	}
	public void render() {
		for(int o=0; o<objects.size(); o++) {
			DObj obj = (DObj)objects.get(o);
			obj.render();
		}
	}
	
	public void drawIntoPDF(PGraphics pdf){
		for(int i =0;i< objects.size();i++){ 
			objects.get(i).drawIntoPDF(pdf);
	    }
	}
	
}
