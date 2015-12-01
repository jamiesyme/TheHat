
//
// Needs docs.
//

class MainMenu extends Scene {
	
	MainMenu()
	{
		super("main menu");
	}
	
	void init()
	{
		// Put any initialization code here.
		// So, things like storing button positions, colors, etc.
		
		// This next line skips the main menu, and goes right to the gameplay.
		// You probably want to call this after pressing the "play" button or 
		// something like that.
		this.engine.setScene("gameplay");
	}
	
	void deinit()
	{
		// Put any cleanup code here.
		// You most likely won't have any (I haven't needed it yet), but if you
		// do need it, it goes here!
	}
	
	void tick(float dt)
	{
		// This function gets called once a frame.
		// dt is going to be the delta time - or, the time since the last frame
		// in seconds.
		// This is useful for animations, so you can make them time-based (ie.
		// make the button hover up & down once per second, instead of once 
		// every 60 frames).
	}
	
	void draw()
	{
		// Draw code goes here sir!
	}
	
}
