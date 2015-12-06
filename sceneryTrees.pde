

class SceneryTrees extends SceneEntity {
	
	int spacing;
	
	SceneryTrees()
	{
	}
	
	void init()
	{
		this.spacing = 5;	
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
			r.w = 1.5;
			r.h = 4.0;
			
			gp.drawTint(255, 255, 255);
			gp.drawRect(r, this.engine.imageMgr.get("tree town 2"), 0.0);
			//gp.drawColor(230, 230, 230);
			//gp.drawRect(r);
		}
	}	
}
