
//
// Provides the fade at the end of the town level.
//

class ToBeContinued extends SceneEntity {
	
	boolean hasStarted;
	float waitTime;
	float fadeTime;
	float menuTime;
	float accumTime;
	
	void init()
	{
		this.hasStarted = false;
		this.waitTime = 5.0;
		this.fadeTime = 3.0;
		this.menuTime = 5.0;
		this.accumTime = 0.0;
	}
	
	void tick(float dt)
	{
		if (!this.hasStarted)
			return;
		
		this.accumTime += dt;
		if (this.accumTime >= this.waitTime + this.fadeTime + this.menuTime)
			this.engine.setScene("main menu");
	}
	
	void draw()
	{
		if (!this.hasStarted)
			return;
		if (this.accumTime < this.waitTime)
			return;
		
		Gameplay gp = (Gameplay)this.scene;
		float alpha = min(1, (this.accumTime - this.waitTime) / this.fadeTime) * 255;
		gp.drawColor(0, 0, 0, (int)alpha);
		gp.drawRect(gp.ortho);
		
		PImage i = this.engine.imageMgr.get("ending title");
		gp.drawTint(255, 255, 255, (int)alpha);
		image(i, this.engine.wWidth / 2 - i.width / 2, this.engine.wHeight / 2 - i.height / 2);
	}
	
	void start()
	{
		this.hasStarted = true;
		this.accumTime = 0.0;
	}
	
}
