
//
// Needs docs.
//

class Gameplay extends Scene {
	
	Rect ortho;
	CollisionManager collisionMgr;
	Player player;
	PlayerCamera playerCam;
	SceneryTrees trees;
	ArrayList<Walker> walkers;
	ArrayList<Car> cars;
	
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
		this.collisionMgr.add(new CollisionEntity(new Rect(-100, 0, 200, 1), "floor"));
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
		this.walkers = new ArrayList<Walker>();
		for (int i = 0; i < 100; i++) {
			Walker walker = new Walker(random(-20, 60));
			walker.engine = this.engine;
			walker.scene = this;
			walker.init();
			this.walkers.add(walker);
		}
		this.cars = new ArrayList<Car>();
		//for (int i = 0; i < 1; i++) {
			Car car = new Car(100);
			car.engine = this.engine;
			car.scene = this;
			car.init();
			this.cars.add(car);
		//}
	}
	
	void deinit()
	{
		for (Car car : this.cars)
			car.deinit();
		for (Walker walker : this.walkers)
			walker.deinit();
		this.playerCam.deinit();
		this.player.deinit();
		this.trees.deinit();
	}
	
	void tick(float dt)
	{
		this.trees.tick(dt);
		this.player.tick(dt);
		this.playerCam.tick(dt);
		for (Walker walker : this.walkers)
			walker.tick(dt);
		for (int i = 0; i < this.walkers.size(); i++) {
			if (!this.walkers.get(i).isActive) {
				this.walkers.remove(i--);
			}
		}
		for (Car car : this.cars)
			car.tick(dt);
	}
	
	void draw()
	{
		background(255);
		noStroke();
		
		drawColor(50, 50, 50);
		drawRect(-1000, 0, 10000, 1);
		
		this.trees.draw();
		for (Walker walker : this.walkers)
			walker.draw();
		for (Car car : this.cars)
			car.draw();
		this.player.draw();
	}
	
	void drawColor(int r, int g, int b)
	{
		fill(r, g, b);
	}
	
	void drawColor(int r, int g, int b, int a)
	{
		fill(r, g, b, a);
	}
	
	void drawColor(color col)
	{
		fill(col);
	}
	
	void drawColor(color col, int a)
	{
		fill(col, a);
	}
	
	int[] translateCoords(float x, float y)
	{
		int wWidth   = this.engine.wWidth;
		int wHeight  = this.engine.wHeight;
		float transX = float(wWidth)  / this.ortho.w;
		float transY = float(wHeight) / this.ortho.h;
		
		int px = int(round(x * transX)) - int(round(this.ortho.x * transX));
		int py = int(round(y * transY)) - int(round(this.ortho.y * transY));
		py = wHeight - 1 - py;
		
		int[] arr = { px, py };
		return arr;
	}
	
	int[] translateDimensions(float w, float h)
	{
		int wWidth   = this.engine.wWidth;
		int wHeight  = this.engine.wHeight;
		float transX = float(wWidth)  / this.ortho.w;
		float transY = float(wHeight) / this.ortho.h;
		
		int[] arr = { int(round(w * transX)), int(round(h * transY)) };
		return arr;
	}
	
	Rect translateRect(Rect rect)
	{
		int[] coords = translateCoords(rect.x, rect.y);
		int[] dims = translateDimensions(rect.w, rect.h);
		return new Rect(
			(float)coords[0], 
			(float)(coords[1] - dims[1]),
			(float)dims[0], 
			(float)dims[1]
		);
	}
	
	void drawRect(float x, float y, float w, float h)
	{
		drawRect(new Rect(x, y, w, h));
	}
	
	void drawRect(Rect rect)
	{
		rect = translateRect(rect);
		rect(rect.x, rect.y, rect.w, rect.h);
	}
	
	void drawRect(Rect rect, float rot)
	{
		rect = translateRect(rect);
		pushMatrix();
		translate(rect.x, rect.y);
		rotate( radians(rot) );
		rect(0, 0, rect.w, rect.h);
		popMatrix();
	}
}
