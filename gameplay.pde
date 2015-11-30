
//
// Needs docs.
//

class Gameplay extends Scene {
	
	Rect ortho;
	CollisionManager collisionMgr;
	Player player;
	PlayerCamera playerCam;
	SceneryTrees trees;
	Walker walker;
	
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
		this.trees = new SceneryTrees();
		this.trees.engine = this.engine;
		this.trees.scene = this;
		this.trees.init();
		this.player = new Player();
		this.player.engine = this.engine;
		this.player.scene = this;
		this.player.init();
		this.playerCam = new PlayerCamera(this.player);
		this.playerCam.engine = this.engine;
		this.playerCam.scene = this;
		this.playerCam.init();
		this.walker = new Walker(8.0);
		this.walker.engine = this.engine;
		this.walker.scene = this;
		this.walker.init();
	}
	
	void deinit()
	{
		this.playerCam.deinit();
		this.player.deinit();
		this.trees.deinit();
	}
	
	void tick(float dt)
	{
		this.trees.tick(dt);
		this.player.tick(dt);
		this.playerCam.tick(dt);
		this.walker.tick(dt);
	}
	
	void draw()
	{
		background(255);
		noStroke();
		
		drawColor(50, 50, 50);
		drawRect(0, 0, 10000, 1);
		
		this.trees.draw();
		this.walker.draw();
		this.player.draw();
	}
	
	void drawColor(int r, int g, int b)
	{
		fill(r, g, b);
	}
	
	void drawColor(color col)
	{
		fill(col);
	}
	
	void drawRect(float x, float y, float w, float h)
	{
		int wWidth   = this.engine.wWidth;
		int wHeight  = this.engine.wHeight;
		float transX = float(wWidth)  / this.ortho.w;
		float transY = float(wHeight) / this.ortho.h;
		
		int pw = int(w * transX);
		int ph = int(h * transY);
		int px = int(x * transX) - int(this.ortho.x * transX);
		int py = int(y * transY) - int(this.ortho.y * transY);
		py = wHeight - 1 - (py + ph);
		
		rect(px, py, pw, ph);
	}
	
	void drawRect(Rect rect)
	{
		drawRect(rect.x, rect.y, rect.w, rect.h);
	}
}
