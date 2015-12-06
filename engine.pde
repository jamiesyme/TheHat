
//
// The base class where everything happens. Entry point of the game.
// 
// Needs docs.
//

class Engine {
	
	int wWidth;
	int wHeight;
	int lastTime;
	SceneManager sceneMgr;
	MouseManager mouseMgr;
	KeyboardManager keyboardMgr;
	ImageManager imageMgr;
	
	Engine(int width, int height)
	{
		this.wWidth = width;
		this.wHeight = height;
		this.sceneMgr = new SceneManager(this);
		this.mouseMgr = new MouseManager();
		this.keyboardMgr = new KeyboardManager();
		this.imageMgr = new ImageManager();
	}
	
	void init()
	{
		this.addScene(new SplashScreen());
		this.addScene(new MainMenu());
		this.addScene(new Gameplay());
		this.setScene("splash screen");
	}
	
	void draw()
	{
		// Draw the current scene
		Scene s = this.sceneMgr.get();
		if (s != null) {
			s.draw();
		}
	}
	
	void tick()
	{
		// Calculate the delta time
		int curTime = millis();
		int deltaTime = curTime - lastTime;
		lastTime = curTime;
		
		// Max out the delta time at 0.2 seconds
		if (deltaTime > 200) {
			deltaTime = 200;
		}
		
		
		// Tick the scene
		Scene s = this.sceneMgr.get();
		if (s != null) {
			s.tick((float)deltaTime / 1000.0f);
		}
		
		
		// Reset the active mouse data
		this.mouseMgr.tick();
	}
	
	void addScene(Scene s)
	{
		this.sceneMgr.add(s);
	}
	
	void setScene(String sceneName)
	{
		this.sceneMgr.set(sceneName);
	}
	
	PImage getImage(String imageName)
	{
		return this.imageMgr.get(imageName);
	}
	
	void onKeyDown(int key)
	{
		this.keyboardMgr.onKeyDown(key);
	}
	
	void onKeyUp(int key)
	{
		this.keyboardMgr.onKeyUp(key);
	}
	
	boolean isKeyDown(int key)
	{
		
		return this.keyboardMgr.isKeyDown(key);
	}
	
	void onButtonDown(int button)
	{
		this.mouseMgr.onButtonDown(button);
	}
	
	void onButtonUp(int button)
	{
		this.mouseMgr.onButtonUp(button);
	}
	
	void onMouseMove(int x, int y)
	{
		this.mouseMgr.onMouseMove(x, y);
	}
	
	boolean isButtonDown(int button)
	{
		return this.mouseMgr.isButtonDown(button);
	}
	
	boolean isButtonPressed(int button)
	{
		return this.mouseMgr.isButtonPressed(button);
	}
	
	boolean isButtonReleased(int button)
	{
		return this.mouseMgr.isButtonReleased(button);
	}
	
	int[] getMouseCoords()
	{
		return this.mouseMgr.getCoords();
	}
	
	int[] getOldMouseCoords()
	{
		return this.mouseMgr.getOldCoords();
	}
	
	int[] getMouseDeltas()
	{
		return this.mouseMgr.getDeltas();
	}
}
