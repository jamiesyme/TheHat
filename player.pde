
//
// Needs docs.
//

class Player extends SceneEntity {
	
	Rect rect;
	PImage texture;
	float vx;
	float vy;
	float targetVx;
	float maxVx;
	float maxVy;
	float accelTimeVx;
	float accelVy;
	float accelVyGravity;
	float airVxDamp;
	float jumpVy;
	float minPushVx;
	float minKillVx;
	float walkerPressure;
	float walkerRelief;
	float walkerDampVx;
	float carHitVx;
	float carHitVy;
	boolean isGrounded;
	
	void init()
	{
		this.rect = new Rect(1.0, 1.0, 0.7, 1.5);
		this.texture = this.engine.getImage("gale right");
		this.vx = 0.0;
		this.vy = 0.0;
		this.targetVx = 10.0;
		this.maxVx = 40.0;
		this.maxVy = 40.0;
		this.accelTimeVx = 0.1;
		this.accelVyGravity = -28.0;
		this.airVxDamp = 0.1;
		this.jumpVy = 14.0;
		this.minPushVx = this.targetVx * 0.05;
		this.minKillVx = this.targetVx * 0.6;
		this.walkerPressure = 0.0;
		this.walkerRelief = 0.1;
		this.walkerDampVx = 0.1;
		this.carHitVx = -10.0;
		this.carHitVy = 10.0;
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
		float accelConst = this.targetVx / this.accelTimeVx;
		ax *= accelConst * 2.0;
		
		// Increase the acceleration if opposing the current velocity
		if (ax < 0.0 && this.vx > 0.0 ||
		    ax > 0.0 && this.vx < 0.0) {
	    	ax *= 1.5;
	    }
	    
	    // Clamp the acceleration to the target speed
	    if (abs(this.vx + ax * dt) > abs(this.targetVx)) {
	    	float vxSign = (this.vx < 0.0 ? -1.0 : 1.0);
	    	float axSign = (ax      < 0.0 ? -1.0 : 1.0);
	    	if (vxSign == axSign) {
	    		ax = 0.0;
	    	} 
	    }
		
		
		// Update the texture direction
		PImage newTexture = null;
		if (ax > 0.0) newTexture = this.engine.getImage("gale right");
		if (ax < 0.0) newTexture = this.engine.getImage("gale left");
		if (newTexture != null)
			this.texture = newTexture;
		
		
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
		float walkerDamp = 1 + log(1 + this.walkerPressure);
		this.vx += ax * dt / walkerDamp;
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
		
		// Reduce the walker pressure
		this.walkerPressure *= (1.0 - this.walkerRelief);
		
		
		// Move the position
		this.rect.x += this.vx * dt;
		this.rect.y += this.vy * dt;
		
		
		// Check if we're grounded
		this.isGrounded = false;
		CollisionEntity[] floors = gp.collisionMgr.findCollisions(this.rect, "floor");
		for (CollisionEntity ground : floors) {
			if (this.rect.y > ground.rect.y + ground.rect.h)
				continue;
			
			this.isGrounded = true;
			this.rect.y = ground.rect.y + ground.rect.h;
			if (this.vy < 0.0) {
				this.vy = 0.0;
			}
		}
		
		
		// JUMP JUMP JUMP
		if (this.isGrounded) {
			
			if (this.engine.isKeyDown(' ') || this.engine.isKeyDown(UP)) {
				this.vy += this.jumpVy;
			}
			
		}
		

		// Check if we're stomping on a walker
		boolean stompedWalker = false;
		
		if (!this.isGrounded && this.vy < 0.0) {
			
			CollisionEntity[] walkers = gp.collisionMgr.findCollisions(this.rect, "walker");
			
			for (CollisionEntity walker : walkers) {
				
				float[] norm = gp.collisionMgr.getCollisionNormal(this.rect, walker.rect);
				
				if (norm[1] > 0) {
					
					this.rect.y = walker.rect.y + walker.rect.h;
					this.vy = this.jumpVy * 0.75;
					
					((Walker)walker.data).killDown( this.vx );
					
					stompedWalker = true;
					
				}
				
			}
			
		}
		
		
		// Check if we just ran into a walker
		
		float pushDist = this.vx * dt;
		
		CollisionEntity[] walkers = gp.collisionMgr.findCollisions(this.rect, "walker");
		
		for (CollisionEntity walker : walkers) {
			
			if (abs(this.vx) >= this.minPushVx) {
			
				// Make sure we're moving towards the walker
				if (this.vx > 0.0 && (this.rect.x - walker.rect.x) > 0.0)
					continue;
				if (this.vx < 0.0 && (this.rect.x - walker.rect.x) < 0.0)
					continue;
				
				float[] norm = gp.collisionMgr.getCollisionNormal(this.rect, walker.rect);
				
				if (norm[0] != 0) {
					
					// Are we pushing them or knocking them over
					if (abs(this.vx) >= this.minKillVx) {
						
						this.walkerPressure += 1;
						this.vx *= this.walkerDampVx;
						((Walker)walker.data).killHorizontal( this.vx );
						
					} else {
						
						walker.rect.x += pushDist;
						this.vx *= this.walkerDampVx;
						
					}
					
				}
				
			} else {
				
				// Let the walker push the player
				
				float[] norm = gp.collisionMgr.getCollisionNormal(this.rect, walker.rect);
				
				if (norm[0] != 0) {
					
					Walker w = (Walker)walker.data;
					
					if (w.vx > 0.0 && norm[0] > 0.0 ||
					    w.vx < 0.0 && norm[0] < 0.0) {
						
						this.rect.x += ((Walker)walker.data).vx * dt;
						
					}
					
				}
				
			}
			
		}
		
		
		// Check if hit by car
		CollisionEntity car = gp.collisionMgr.findCollision(this.rect, "car");
		if (car != null) {
			
			this.vx = this.carHitVx;
			this.vy = this.carHitVy;
			this.walkerPressure = 500;
			
		}
		
	}
	
	void draw()
	{
		Gameplay gp = (Gameplay)this.scene;
		gp.drawTint(255, 255, 255);
		gp.drawRect(this.rect, this.texture, 0.0);
	}
	
}
