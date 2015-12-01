
//
// Passer-by on the sidewalk that the player must avoid.
//

class Walker extends SceneEntity {
	
	Rect rect;
	color col;
	float colA;
	float dColA;
	float rot;
	float vx;
	float vy;
	float vr;
	boolean isDead;
	boolean isActive;
	CollisionEntity body;
	
	
	Walker(float x)
	{
		this.rect = new Rect();
		this.rect.x = x;
	}
	
	void init()
	{
		this.rect.y = 1.0;
		this.rect.w = 0.6;
		this.rect.h = 1.35;
		this.col = color(random(40) + 110, random(40) + 110, random(40) + 110);
		this.colA = 1.0;
		this.dColA = 0.0;
		this.rot = 0.0;
		if (random(2) < 1)
			this.vx = -1.0 * 1;
		else
			this.vx = 1.0 * 1;
		this.vy = 0.0;
		this.vr = 0.0;
		this.isDead = false;
		this.isActive = true;
		
		this.body = new CollisionEntity(this.rect, "walker", this);
		((Gameplay)this.scene).collisionMgr.add(this.body);
	}
	
	void tick(float dt)
	{
		this.rect.x += this.vx * dt;
		this.rect.y += this.vy * dt;
		this.rot += this.vr * dt;
		this.colA += this.dColA * dt;
		if (this.colA <= 0.0)
			this.isActive = false;
	}
	
	void draw()
	{
		Gameplay gp = (Gameplay)this.scene;
		gp.drawColor(this.col, int(this.colA * 255));
		gp.drawRect(this.rect, this.rot);
	}
	
	// Will rotate in dirX direction
	void killDown(float dirX)
	{
		this.isDead = true;
		if (dirX > 0) this.vr =  45;
		if (dirX < 0) this.vr = -45;
		this.vx = 0.0;
		this.vy = -this.rect.h * 2;
		this.dColA = -2.0;
		
		((Gameplay)this.scene).collisionMgr.remove(this.body);
	}
	
	// Will rotate in dirX direction
	void killUp(float dirX)
	{
		this.isDead = true;
		if (dirX > 0) this.vr =  45;
		if (dirX < 0) this.vr = -45;
		this.vx = 0.0;
		this.vy = this.rect.h * 3;
		this.dColA = -1.5;
		
		((Gameplay)this.scene).collisionMgr.remove(this.body);
	}
	
	// Will fall over in dirX direction
	void killHorizontal(float dirX)
	{
		this.isDead = true;
		if (dirX > 0) { this.vr =  45; this.vx =  1; }
		if (dirX < 0) { this.vr = -45; this.vx = -1; }
		this.vy = -this.rect.h / 2;
		this.dColA = -2.0;
		
		((Gameplay)this.scene).collisionMgr.remove(this.body);
	}
	
}
