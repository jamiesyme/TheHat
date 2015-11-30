
//
// Passer-by on the sidewalk that the player must avoid.
//

class Walker extends SceneEntity {
	
	Rect rect;
	color col;
	float rot;
	float vx;
	float vr;
	bool isDead;
	
	
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
		this.rot = 0.0;
		if (random(2) < 1)
			this.vx = -1.0 * 4;
		else
			this.vx = 1.0 * 4;
		this.vr = 0.0;
		this.isDead = false;
	}
	
	void tick(float dt)
	{
		this.rect.x += this.vx * dt;
	}
	
	void draw()
	{
		Gameplay gp = (Gameplay)this.scene;
		gp.drawColor(this.col);
		gp.drawRect(this.rect);
	}
	
}
