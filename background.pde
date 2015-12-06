
//
// Needs docs.
//

class Background extends SceneEntity {
	
	Rect rect;
	PImage texture;
	float spacing;
	float scale;
	int tint;
	
	Background(Rect rect, PImage texture, float spacing, float scale, int tint)
	{
		this.rect = rect;
		this.texture = texture;
		this.spacing = spacing;
		this.scale = scale;
		this.tint = tint;
	}
	
	void draw()
	{
		Gameplay gp = (Gameplay)this.scene;
		float w = this.rect.w + this.spacing;
		float x1 = gp.ortho.x * this.scale / w;
		float x2 = x1 + gp.ortho.w / w;
		
		for (int i = int(floor(x1)); i <= int(floor(x2)); i++) {
			
			float x = gp.ortho.x * (1 - this.scale) + float(i) * w;
			
			gp.drawTint(gp.envTints[this.tint]);
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
