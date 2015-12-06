
//
// Self explanatory.
//

class TransitionTownToGraveyard extends SceneEntity {
	
	boolean hasStarted;
	boolean isDone;
	float transitionTime;
	float accumTime;
	color[] startEnvTints;
	color[] endEnvTints;
	
	TransitionTownToGraveyard()
	{
	}
	
	void init()
	{
		this.hasStarted = false;
		this.isDone = false;
		this.transitionTime = 4.0;
		this.accumTime = 0.0;
		this.startEnvTints = new color[3];
		this.endEnvTints = new color[3];
		
		this.endEnvTints[0] = color(81, 56, 146);
		this.endEnvTints[1] = color(104, 76, 186);
		this.endEnvTints[2] = color(116, 86, 206);
	}
	
	void tick(float dt)
	{
		if (!this.hasStarted)
			return;
		if (this.isDone)
			return;
		
		Gameplay gp = (Gameplay)this.scene;
		
		this.accumTime += dt;
		if (this.accumTime > this.transitionTime)
			this.accumTime = this.transitionTime;
		
		float t = this.accumTime / this.transitionTime;
		for (int i = 0; i < 3; i++) {
			gp.envTints[i] = lerpColor(
				this.startEnvTints[i],
				this.endEnvTints[i],
				t
			);
		}
		
		if (this.accumTime >= this.transitionTime)
			this.isDone = true;
	}
	
	void start()
	{
		Gameplay gp = (Gameplay)this.scene;
		this.hasStarted = true;
		for (int i = 0; i < gp.envTints.length; i++)
			this.startEnvTints[i] = gp.envTints[i];
		this.accumTime = 0.0;
	}
	
}
