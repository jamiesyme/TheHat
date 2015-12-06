
//
// Self explanatory.
//

class TransitionTownToGraveyard extends SceneEntity {
	
	boolean hasStarted;
	boolean isDone;
	float transitionTime;
	float accumTime;
	color startEnvTint;
	color endEnvTint;
	
	TransitionTownToGraveyard()
	{
	}
	
	void init()
	{
		this.hasStarted = false;
		this.isDone = false;
		this.transitionTime = 4.0;
		this.accumTime = 0.0;
		this.endEnvTint = color(91, 66, 166);
	}
	
	void tick(float dt)
	{
		if (!this.hasStarted)
			return;
		if (this.isDone)
			return;
		
		this.accumTime += dt;
		if (this.accumTime > this.transitionTime)
			this.accumTime = this.transitionTime;
		
		float t = this.accumTime / this.transitionTime;
		((Gameplay)this.scene).envTint = lerpColor(
			this.startEnvTint,
			this.endEnvTint,
			t
		);
		
		if (this.accumTime >= this.transitionTime)
			this.isDone = true;
	}
	
	void start()
	{
		this.hasStarted = true;
		this.startEnvTint = ((Gameplay)this.scene).envTint;
		this.accumTime = 0.0;
	}
	
}