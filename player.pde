
//
// Needs docs.
//

class Player extends SceneEntity {
	
	float x;
	float y;
	float w;
	float h;
	float vx;
	float maxVel;
	float accelTime;
	
	void init()
	{
		this.w = 0.7;
		this.h = 1.5;
		this.x = 1.0 + w / 2.0;
		this.y = h / 2.0;
		this.vx = 0.0;
		this.maxVel = 7.0;
		this.accelTime = 0.1;
	}
	
	void tick(float dt)
	{
		// Generate the acceleration based on player input
		float ax = 0.0;
		if (this.engine.isKeyDown('A') || this.engine.isKeyDown(LEFT)) {
			ax -= 1.0;
		}
		if (this.engine.isKeyDown('D') || this.engine.isKeyDown(RIGHT)) {
			ax += 1.0;
		}
		
		// Adjust the acceleration based on acceleration time
		float accelConst = this.maxVel / this.accelTime;
		ax *= accelConst * 2.0;
		
		// Increase the acceleration if opposing the current velocity
		if (ax < 0.0 && this.vx > 0.0 ||
		    ax > 0.0 && this.vx < 0.0) {
	    	ax *= 1.5;
	    }
		
		// If the player released all controls, stop them
		if (ax == 0.0) {
			float vDir = (this.vx < 0.0 ? -1.0 : 1.0);
			ax = -vDir * accelConst;
			if (abs(ax * dt) > abs(this.vx))
				ax = -this.vx / dt;
		}
		
		// Adjust the velocity based on the acceleration, and cap it
		this.vx += ax * dt;
		if (abs(this.vx) > this.maxVel) {
			float vDir = (this.vx < 0.0 ? -1.0 : 1.0);
			this.vx = vDir * this.maxVel;
		}
		
		// Move the position
		this.x += this.vx * dt;
	}
	
	void draw(Gameplay gp)
	{
		gp.drawColor(0, 0, 0);
		gp.drawRect(this.x, this.y, this.w, this.h);
	}
	
}
