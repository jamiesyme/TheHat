
//
// The game is broken down into a series of scenes.
//
// Examples of scenes:
// + Splash screen
// + Main menu
// + Intro cinematic
//
// There will be direct cuts between scenes (likely masked with screen fading),
// so a scene is NOT the same as a level. We want the levels to flow together
// seemlessly.
//

class Scene {
	
	String name;
	
	Scene(String name)
	{
		this.name = name;
	}
	
	void init()
	{
	}
	
	void deinit()
	{
	}
	
	void tick(float dt)
	{
	}
	
	void draw()
	{
	}
	
}
