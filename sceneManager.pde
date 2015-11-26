
//
// Needs docs.
//

class SceneManager {
	
	Engine engine;
	Scene currentScene;
	ArrayList<Scene> allScenes;
	
	SceneManager(Engine engine)
	{
		this.engine = engine;
		this.allScenes = new ArrayList<Scene>();
		this.currentScene = null;
	}
	
	void add(Scene scene)
	{
		if (scene != null) {
			scene.engine = this.engine;
			this.allScenes.add(scene);
		}
	}
	
	void set(String sceneName)
	{
		// Deinit the current scene
		if (this.currentScene != null) {
			this.currentScene.deinit();
		}
		
		// Select the new scene
		this.currentScene = this.get(sceneName);
		
		// Init the new scene
		if (this.currentScene != null) {
			this.currentScene.init();
		}
	}
	
	Scene get(String sceneName)
	{
		for (Scene scene : this.allScenes) {
			if (scene.name.equals(sceneName)) {
				return scene;
			}
		}
		return null;
	}
	
	Scene get()
	{
		return this.currentScene;
	}
	
}
