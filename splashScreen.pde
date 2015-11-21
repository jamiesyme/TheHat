
//
//
//

class SplashScreen extends Scene {
    
    float accumTime;
    
    SplashScreen()
    {
        super("splash screen");
    }
    
    void init()
    {
        this.accumTime = 0.0f;
    }
    
    void tick(float dt)
    {
        this.accumTime += dt;
        if (this.accumTime > 3.0f)
            _engine.setScene("null");
    }
    
    void draw()
    {
        background(255, 0, 0);
    }
    
}
