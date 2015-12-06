
//
// Needs docs.
//

class Gameplay extends Scene {
	
	Rect ortho;
	CollisionManager collisionMgr;
	Player player;
	PlayerCamera playerCam;
	ArrayList<Walker> walkers;
	ArrayList<Car> cars;
	TownSpawner townSpawner;
	ArrayList<Background> backgrounds;
	color envTint;
	TransitionTownToGraveyard transition;
	
	Gameplay()
	{
		super("gameplay");
	}
	
	void init()
	{
		this.ortho = new Rect(
			0.0, 
			0.0,
			(float)this.engine.wWidth / 75.0,
			(float)this.engine.wHeight / 75.0
		);
		this.collisionMgr = new CollisionManager();
		this.player       = new Player();
		this.playerCam    = new PlayerCamera(this.player);
		this.walkers      = new ArrayList<Walker>();
		this.cars         = new ArrayList<Car>();
		this.townSpawner  = new TownSpawner();
		this.backgrounds  = new ArrayList<Background>();
		this.transition   = new TransitionTownToGraveyard();
		this.envTint = color(255, 255, 255);
		
		this.collisionMgr.add(new CollisionEntity(new Rect(-1000, 0, 10000, 1), "floor"));
		initSceneEntity(this.player);
		this.player.rect.x  = 100;
		initSceneEntity(this.playerCam);
		initSceneEntity(this.townSpawner);
		initSceneEntity(this.transition);
		addBackground(
			new Rect(0, 0, this.ortho.h * 2.5, this.ortho.h), 
			this.engine.imageMgr.get("mountain 2"), 
			0.0, 0.1
		);
		addBackground(
			new Rect(4, 0.8, 1.5, 4),
			this.engine.imageMgr.get("tree town 2"),
			5.0, 0.8
		);
		addBackground(
			new Rect(0, 0.9, 2, 2),
			this.engine.imageMgr.get("fence 1"),
			0.0, 0.85
		);
		addBackground(
			new Rect(0, 0, 6.3, 1.0), 
			this.engine.imageMgr.get("ground 1"), 
			0.0, 1.0
		);
	}
	
	void deinit()
	{
		for (Background bg : this.backgrounds)
			bg.deinit();
		this.townSpawner.deinit();
		for (Car car : this.cars)
			car.deinit();
		for (Walker walker : this.walkers)
			walker.deinit();
		this.playerCam.deinit();
		this.player.deinit();
	}
	
	void tick(float dt)
	{
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
		for (int i = 0; i < this.cars.size(); i++) {
			if (!this.cars.get(i).isActive) {
				this.cars.remove(i--);
			}
		}
		this.townSpawner.tick(dt);
		
		this.transition.tick(dt);
		if (!this.transition.hasStarted) {
			if (this.ortho.x >= this.townSpawner.getMaxX())
				this.transition.start();
		}
	}
	
	void draw()
	{
		background(this.envTint);
		noStroke();
		
		drawColor(50, 50, 50);
		drawRect(-1000, 0, 10000, 1);
		
		for (Background bg : this.backgrounds)
			bg.draw();
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
	
	
	void initSceneEntity(SceneEntity se)
	{
		se.engine = this.engine;
		se.scene = this;
		se.init();
	}
	
	
	Walker spawnWalker(float x)
	{
		Walker walker = new Walker(x);
		initSceneEntity(walker);
		this.walkers.add(walker);
		return walker;
	}
	
	Car spawnCar(float x)
	{
		Car car = new Car(x);
		initSceneEntity(car);
		this.cars.add(car);
		return car;
	}
	
	void addBackground(Rect r, PImage t, float spacing, float scale)
	{
		Background bg = new Background(r, t, spacing, scale);
		initSceneEntity(bg);
		this.backgrounds.add(bg);
	}
}
