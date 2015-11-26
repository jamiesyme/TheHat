
//
// Needs docs.
//

class KeyboardManager {
	
	boolean[] keysDown;
	
	KeyboardManager()
	{
		this.keysDown = new boolean[256];
	}
	
	void onKeyDown(char key)
	{
		this.keysDown[int(key)] = true;
	}
	
	void onKeyUp(char key)
	{
		this.keysDown[int(key)] = false;
	}
	
	boolean isKeyDown(char key)
	{
		return this.keysDown[int(key)];
	}
}
