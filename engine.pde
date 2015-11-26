
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
	KeyboardManager keyboardMgr;
	
	Engine(int width, int height)
	{
		this.wWidth = width;
		this.wHeight = height;
		this.sceneMgr = new SceneManager(this);
		this.keyboardMgr = new KeyboardManager();
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
		
		// Max out the delta time at 0.5 seconds
		if (deltaTime > 500) {
			deltaTime = 500;
		}
			
		// Tick the scene
		Scene s = this.sceneMgr.get();
		if (s != null) {
			s.tick((float)deltaTime / 1000.0f);
		}
	}
	
	void addScene(Scene s)
	{
		this.sceneMgr.add(s);
	}
	
	void setScene(String sceneName)
	{
		this.sceneMgr.set(sceneName);
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
}
