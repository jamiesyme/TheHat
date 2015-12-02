
//
// Needs docs.
//

class SplashScreen extends Scene {
	
	SplashScreen()
	{
		super("splash screen");
	}
	
	void init()
	{
		HashMap<String, String> images = new HashMap<String, String>();
		
		images.put("gale", "gale.png");
		
		for (HashMap.Entry<String, String> img : images.entrySet()) {
			this.engine.imageMgr.load(img.getKey(), img.getValue());
		}
		
		this.engine.setScene("main menu");
	}
	
}
