
//
// Needs docs.
//

class Player extends SceneEntity {
	
	float x;
	float y;
	float w;
	float h;
	
	void init()
	{
		this.w = 1.0;
		this.h = 2.0;
		this.x = 1.0 + w / 2.0;
		this.y = h / 2.0;
	}
	
	void tick(float dt)
	{
		
	}
	
	void draw(Gameplay gp)
	{
		gp.drawColor(0, 0, 0);
		gp.drawRect(this.x, this.y, this.w, this.h);
	}
	
}
