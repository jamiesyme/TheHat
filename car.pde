
//
// It's a car. The player can jump on/over it, but should avoid getting hit.
//

class Car extends SceneEntity {
	
	Rect frontRect;
	Rect midRect;
	Rect backRect;
	CollisionEntity frontBody;
	CollisionEntity midBody;
	CollisionEntity backBody;
	color col;
	float vx;
	
	Car(float x)
	{
		this.frontRect = new Rect();
		this.midRect   = new Rect();
		this.backRect  = new Rect();
		this.frontRect.x = x;
	}
	
	void init()
	{
		this.frontRect.y = 1.3;
		this.frontRect.w = 1.5;
		this.frontRect.h = 1.0;
		this.midRect.x = this.frontRect.x + this.frontRect.w;
		this.midRect.y = this.frontRect.y;
		this.midRect.w = 2.5;
		this.midRect.h = 1.5;
		this.backRect.x = this.midRect.x + this.midRect.w;
		this.backRect.y = this.midRect.y;
		this.backRect.w = 1.0;
		this.backRect.h = 1.0;
		this.col = color(random(40) + 110, random(40) + 110, random(40) + 110);
		this.vx = -20.0;
		
		this.frontBody = new CollisionEntity(this.frontRect, "car",   this);
		this.midBody   = new CollisionEntity(this.midRect,   "floor", this);
		this.backBody  = new CollisionEntity(this.backRect,  "floor", this);
		Gameplay gp = (Gameplay)this.scene;
		gp.collisionMgr.add(this.frontBody);
		gp.collisionMgr.add(this.midBody);
		gp.collisionMgr.add(this.backBody);
	}
	
	void deinit()
	{
		Gameplay gp = (Gameplay)this.scene;
		gp.collisionMgr.remove(this.frontBody);
		gp.collisionMgr.remove(this.midBody);
		gp.collisionMgr.remove(this.backBody);
	}
	
	void tick(float dt)
	{
		// Move the car
		float moveX = this.vx * dt;
		this.frontRect.x += moveX;
		this.midRect.x   += moveX;
		this.backRect.x  += moveX;
		
		// Check if hit a walker
		Gameplay gp = (Gameplay)this.scene;
		CollisionEntity[] walkers = gp.collisionMgr.findCollisions(this.frontRect, "walker");
		for (CollisionEntity walker : walkers) {
			
			((Walker)walker.data).killUp( -this.vx );
			
		}
	}
	
	void draw()
	{
		Gameplay gp = (Gameplay)this.scene;
		gp.drawColor(this.col);
		gp.drawRect(this.frontRect);
		gp.drawRect(this.midRect);
		gp.drawRect(this.backRect);
	}
	
}
