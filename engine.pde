

class Engine {
    
    int wWidth;
    int wHeight;
    int lastTime;
    SceneManager sceneMgr;
    
    Engine(int width, int height)
    {
        this.wWidth = width;
        this.wHeight = height;
        this.sceneMgr = new SceneManager();
        
        this.addScreen(new SplashScreen());
        this.setScreen("splash screen");
    }
    
    void draw()
    {
        background(255);
        
        Scene s = this.sceneMgr.get();
        if (s != null) {
            s.draw();
        }
    }
    
    void tick()
    {
        int curTime = millis();
        int delTime = curTime - lastTime;
        lastTime = curTime;
        
        Scene s = this.sceneMgr.get();
        if (s != null) {
            s.tick((float)delTime / 1000.0f);
        }
    }
    
    void addSceen(Scene s)
    {
        this.sceneMgr.add(s);
    }
    
    void setScene(String sceneName)
    {
        this.sceneMgr.set(sceneName);
    }
}
