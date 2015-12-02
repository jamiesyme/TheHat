
//
// Needs docs.
//

class Background extends SceneEntity {
	
	Rect rect;
	PImage texture;
	float scale;
	
	Background(Rect rect, PImage texture, float scale)
	{
		this.rect = rect;
		this.texture = texture;
		this.scale = scale;
	}
	
	void draw()
	{
		Gameplay gp = (Gameplay)this.scene;
		int x1 = int( floor((gp.ortho.x) * this.scale / this.rect.w) );
		int x2 = int( ceil((gp.ortho.x + gp.ortho.w) * this.scale / this.rect.w) );
		
		for (int i = x1; i <= x2; i++) {
			
			float x = gp.ortho.x * this.scale + float(i) * this.rect.w;
			
			gp.drawTint(255, 255, 255);
			gp.drawRect(
				new Rect(
					x,
					this.rect.y,
					this.rect.w,
					this.rect.h
				),
				this.texture, 0.0
			);
			
		}
	}
	
}
