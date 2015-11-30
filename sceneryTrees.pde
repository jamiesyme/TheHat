

class SceneryTrees extends SceneEntity {
	
	int spacing;
	
	SceneryTrees()
	{
	}
	
	void init()
	{
		this.spacing = 4;	
	}
	
	void draw()
	{
		Gameplay gp = (Gameplay)this.scene;
		int lowerX = (int)floor(gp.ortho.x) / this.spacing;
		int upperX = (int)ceil(gp.ortho.x + gp.ortho.w) / this.spacing;
		
		for (int i = lowerX; i <= upperX; i++) {
			
			Rect r = new Rect();
			r.x = (float)(i * this.spacing);
			r.y = 1.0;
			r.w = 1.0;
			r.h = 4.0;
			
			gp.drawColor(230, 230, 230);
			gp.drawRect(r.x, r.y, r.w, r.h);
		}
	}	
}
