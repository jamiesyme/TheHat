
//
// Needs docs.
//

class Gameplay extends Scene {
	
	Rect ortho;
	CollisionManager collisionMgr;
	Player player;
	
	Gameplay()
	{
		super("gameplay");
	}
	
	void init()
	{
		this.ortho = new Rect();
		this.ortho.x = 0.0;
		this.ortho.y = 0.0;
		this.ortho.w = (float)this.engine.wWidth / 75.0;
		this.ortho.h = (float)this.engine.wHeight / 75.0;
		this.collisionMgr = new CollisionManager();
		this.collisionMgr.add(new Rect(-100, 0, 200, 1), "floor");
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
		
		this.player.draw();
	}
	
	void drawColor(int r, int g, int b)
	{
		fill(r, g, b);
	}
	
	void drawRect(float x, float y, float w, float h)
	{
		int wWidth   = this.engine.wWidth;
		int wHeight  = this.engine.wHeight;
		float transX = float(wWidth)  / this.ortho,w;
		float transY = float(wHeight) / this.ortho.h;
		
		int pw = int(w * transX);
		int ph = int(h * transY);
		int px = int(x * transX + this.ortho.x * transX);
		int py = wHeight - 1 - int(y * transY + this.ortho.y * transY);
		
		rectMode(CENTER);
		rect(px, py, pw, ph);
	}
}
