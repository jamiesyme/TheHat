
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
		this.w = 0.7;
		this.h = 1.5;
		this.x = 1.0 + w / 2.0;
		this.y = h / 2.0;
	}
	
	void tick(float dt)
	{
		float mx = 0.0;
		if (this.engine.isKeyDown('A') || this.engine.isKeyDown(LEFT)) {
			mx -= 1.0;
		}
		if (this.engine.isKeyDown('D') || this.engine.isKeyDown(RIGHT)) {
			mx += 1.0;
		}
		
		this.x += mx * 8 * dt;
	}
	
	void draw(Gameplay gp)
	{
		gp.drawColor(0, 0, 0);
		gp.drawRect(this.x, this.y, this.w, this.h);
	}
	
}
