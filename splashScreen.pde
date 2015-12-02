
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
		add("main menu bg", "mainMenu_background.png");
		add("main menu button", "mainMenu_buttonNoHover.png");
		add("main menu button hover", "mainMenu_buttonHover.png");
		add("main menu play", "mainMenu_play.png");
		add("main menu exit", "mainMenu_exit.png");
		add("main menu title", "mainMenu_title.png");
		
		add("gale right", "gale.png");
		addFlipped("gale left", "gale.png");
		
		add("boy right", "boy.png");
		addFlipped("boy left", "boy.png");
		
		add("car 1", "car1.png");
		add("car 2", "car2.png");
		
		this.engine.setScene("main menu");
	}
	
	void add(String name, String location)
	{
		this.engine.imageMgr.add(name, location);
	}
	
	void addFlipped(String name, String location)
	{
		PImage img = loadImage(location);
		PImage img2 = createImage(img.width, img.height, ARGB);
		
		for (int x = 0; x < img2.width; x++) {
			for (int y = 0; y < img2.height; y++) {
				img2.set(x, y, img.get(img.width - 1 - x, y));
			}
		}
		
		this.engine.imageMgr.add(name, img2);
	}
	
}
