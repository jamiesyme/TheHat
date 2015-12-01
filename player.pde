
//
// Needs docs.
//

class Player extends SceneEntity {
	
	Rect rect;
	float vx;
	float vy;
	float maxVx;
	float maxVy;
	float accelTimeVx;
	float accelVy;
	float accelVyGravity;
	float airVxDamp;
	float jumpVy;
	boolean isGrounded;
	
	void init()
	{
		this.rect = new Rect(1.0, 5.0, 0.7, 1.5);
		this.vx = 0.0;
		this.vy = 0.0;
		this.maxVx = 7.0;
		this.maxVy = 40.0;
		this.accelTimeVx = 0.1;
		this.accelVyGravity = -28.0;
		this.airVxDamp = 0.1;
		this.jumpVy = 14.0;
		this.isGrounded = false;
	}
	
	void tick(float dt)
	{
		Gameplay gp = (Gameplay)this.scene;
		
		// Generate the acceleration based on player input
		float ax = 0.0;
		if (this.engine.isKeyDown('A') || this.engine.isKeyDown(LEFT)) {
			ax -= 1.0;
		}
		if (this.engine.isKeyDown('D') || this.engine.isKeyDown(RIGHT)) {
			ax += 1.0;
		}
		
		// Adjust the acceleration based on acceleration time
		float accelConst = this.maxVx / this.accelTimeVx;
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
		
		// Reduce control in the air
		if (!this.isGrounded) {
			ax *= this.airVxDamp;
		}
		
		
		// Apply acceleration to velocity
		this.vx += ax * dt;
		this.vy += this.accelVyGravity * dt;
		
		// Cap the velocity
		if (abs(this.vx) > this.maxVx) {
			float vDir = (this.vx < 0.0 ? -1.0 : 1.0);
			this.vx = vDir * this.maxVx;
		}
		if (abs(this.vy) > this.maxVy) {
			float vDir = (this.vy < 0.0 ? -1.0 : 1.0);
			this.vy = vDir * this.maxVy;	
		}
		
		
		// Move the position
		this.rect.x += this.vx * dt;
		this.rect.y += this.vy * dt;
		
		
		// Check if we're grounded
		CollisionEntity ground = gp.collisionMgr.findCollision(this.rect, "floor");
		if (ground != null) {
			this.rect.y = ground.rect.y + ground.rect.h;
			if (this.vy < 0.0)
				this.vy = 0.0;
			
			if (this.engine.isKeyDown(' ') || this.engine.isKeyDown(UP)) {
				this.vy += this.jumpVy;
			}
			
			this.isGrounded = true;
		} else {
			this.isGrounded = false;	
		}
		
		
		// Check if we're stomping on a walker
		if (!this.isGrounded) {
			
			CollisionEntity walker = gp.collisionMgr.findCollision(this.rect, "walker");
			if (walker != null) {
				
				if ( gp.collisionMgr.isCollision(this.rect, walker.rect) ) {
					
					float[] norm = gp.collisionMgr.getCollisionNormal(this.rect, walker.rect);
					
					if (this.vy < 0.0 && norm[1] > 0) {
						
						this.rect.y = walker.rect.y + walker.rect.h;
						this.vy = this.jumpVy * 0.75;
						
						((Walker)walker.data).killDown( this.vx );
						
					}
					
				}
			}
			
		}
	}
	
	void draw()
	{
		Gameplay gp = (Gameplay)this.scene;
		gp.drawColor(0, 0, 0);
		gp.drawRect(this.rect);
	}
	
}
