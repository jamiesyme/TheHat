
//
// A camera to follow the player and adjust the ortho.
//

class PlayerCamera extends SceneEntity {
	
	Player player;
	float bufferX;
	float bufferY;
	
	PlayerCamera(Player player)
	{
		this.player = player;
	}
	
	void init()
	{
		this.bufferX = 1.0;
		this.bufferY = 0.1;
	}
	
	void tick(float dt)
	{
		Gameplay gp = (Gameplay)this.scene;
		Player p = this.player;
		
		if (p.rect.x < gp.ortho.x + this.bufferX) {
			gp.ortho.x = p.rect.x - this.bufferX;
		}
		if (p.rect.x + p.rect.w > gp.ortho.x + gp.ortho.w - this.bufferX) {
			gp.ortho.x = p.rect.x + p.rect.w + this.bufferX - gp.ortho.w;
		}
		
		if (p.rect.y < gp.ortho.y + this.bufferY) {
			gp.ortho.y = p.rect.y - this.bufferY;	
		}
		if (p.rect.y + p.rect.h > gp.ortho.y + gp.ortho.h - this.bufferY) {
			gp.ortho.y = p.rect.y + p.rect.h + this.bufferY - gp.ortho.h;
		}
	}
	
}
