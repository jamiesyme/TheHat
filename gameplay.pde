
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
	TownSpawner townSpawner;
	Background bgMountains;
	
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
		this.collisionMgr.add(new CollisionEntity(new Rect(-1000, 0, 10000, 1), "floor"));
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
		this.cars = new ArrayList<Car>();
		this.townSpawner = new TownSpawner();
		this.townSpawner.engine = this.engine;
		this.townSpawner.scene = this;
		this.townSpawner.init();
		this.bgMountains = new Background(
			new Rect(0, 0, this.ortho.h * 2.5, this.ortho.h), 
			this.engine.imageMgr.get("mountain 2"), 0.5
		);
		this.bgMountains.engine = this.engine;
		this.bgMountains.scene = this;
		this.bgMountains.init();
	}
	
	void deinit()
	{
		this.townSpawner.deinit();
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
		this.townSpawner.tick(dt);
	}
	
	void draw()
	{
		background(255);
		noStroke();
		
		drawColor(50, 50, 50);
		drawRect(-1000, 0, 10000, 1);
		
		this.bgMountains.draw();
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
	
	void drawTint(int r, int g, int b)
	{
		tint(r, g, b);
	}
	
	void drawTint(int r, int g, int b, int a)
	{
		tint(r, g, b, a);
	}
	
	void drawTint(color col)
	{
		tint(col);
	}
	
	void drawTint(color col, int a)
	{
		tint(col, a);
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
		drawRect(rect, null, 0.0);
	}
	
	void drawRect(Rect rect, PImage img, float rot)
	{
		rect = translateRect(rect);
		pushMatrix();
		translate(rect.x, rect.y);
		rotate( radians(rot) );
		if (img != null)
			image(img, 0, 0, rect.w, rect.h);
		else
			rect(0, 0, rect.w, rect.h);
		popMatrix();
	}
	
	
	Walker spawnWalker(float x)
	{
		Walker walker = new Walker(x);
		walker.engine = this.engine;
		walker.scene = this;
		walker.init();
		this.walkers.add(walker);
		return walker;
	}
	
	Car spawnCar(float x)
	{
		Car car = new Car(x);
		car.engine = this.engine;
		car.scene = this;
		car.init();
		this.cars.add(car);
		return car;
	}
}
