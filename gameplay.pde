
//
// Needs docs.
//

class Gameplay extends Scene {
	
	float orthoW;
	float orthoH;
	Player player;
	
	Gameplay()
	{
		super("gameplay");
	}
	
	void init()
	{
		this.orthoW = (float)this.engine.wWidth / 75.0;
		this.orthoH = (float)this.engine.wHeight / 75.0;
		this.player = new Player();
		this.player.engine = this.engine;
		this.player.scene = this;
		this.player.init();
	}
	
	void deinit()
	{
		this.player.deinit();
	}
	
	void tick(float dt)
	{
		this.player.tick(dt);
	}
	
	void draw()
	{
		background(255);
		
		this.player.draw(this);
	}
	
	void drawColor(int r, int g, int b)
	{
		fill(r, g, b);
	}
	
	void drawRect(float x, float y, float w, float h)
	{
		int wWidth   = this.engine.wWidth;
		int wHeight  = this.engine.wHeight;
		float transX = float(wWidth)  / this.orthoW;
		float transY = float(wHeight) / this.orthoH;
		
		int pw = int(w * transX);
		int ph = int(h * transY);
		int px = int(x * transX);
		int py = wHeight - 1 - int(y * transY);
		
		rectMode(CENTER);
		rect(px, py, pw, ph);
	}
}
