
//
// Needs docs.
//

class MainMenu extends Scene {
	
	PImage background;
	PImage hover;
	PImage nonhover;
	PImage play;
	PImage exit;
	PImage title;
	
	MainMenu()
	{
		super("main menu");
	}
	
	void init()
	{
		this.engine.setScene("gameplay"); // TEMPORARY TO SKIP MAIN MENU
		
		ImageManager imageMgr = this.engine.imageMgr;
		this.background = imageMgr.get("main menu bg");
		this.hover      = imageMgr.get("main menu button hover");
		this.nonhover   = imageMgr.get("main menu button");
		this.play       = imageMgr.get("main menu play");
		this.exit       = imageMgr.get("main menu exit");
		this.title      = imageMgr.get("main menu title");
	}
	
	void tick(float dt)
	{
		MouseManager mouseMgr = this.engine.mouseMgr;
		int mouseX = mouseMgr.getCoords()[0];
		int mouseY = mouseMgr.getCoords()[1];
		
		image(this.background, 0, 0);
		image(this.nonhover, 100, 300);
		image(this.nonhover, 100, 450);
		image(this.title, 400, 150);
		
		if (mouseX >= 100 && mouseY >= 300) {
			
			if (mouseX <= 300 && mouseY <= 400) {
				
				image(this.hover, 100, 300);
				
				if (mouseMgr.isButtonDown(LEFT)) {
					image(this.nonhover, 100, 300);
				}
				
				if (mouseMgr.isButtonReleased(LEFT)) {
					this.engine.setScene("gameplay");
				}
				
			}
			
		}
		
		if (mouseX >= 100 && mouseY >= 450) {
			
			if (mouseX <= 300 && mouseY <= 550) {
				
				image(hover,100,450);
				
				if (mouseMgr.isButtonDown(LEFT)) {
					image(this.nonhover, 100, 450);
				}
				
				if (mouseMgr.isButtonReleased(LEFT)) {
					exit();
				}
				
			}
			
		}
		
		image(this.play, 120, 307);
		image(this.exit, 120, 460);
	}
	
	void draw()
	{
		
	}
	
}
