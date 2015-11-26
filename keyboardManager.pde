
//
// Needs docs.
//

class KeyboardManager {
	
	HashMap<Integer, Boolean> keysDown;
	
	KeyboardManager()
	{
		this.keysDown = new HashMap<Integer, Boolean>();
	}
	
	void onKeyDown(int key)
	{
		this.keysDown.put(key, true);
	}
	
	void onKeyUp(int key)
	{
		this.keysDown.put(key, false);
	}
	
	boolean isKeyDown(int key)
	{
		if (!this.keysDown.containsKey(key))
			return false;
		return this.keysDown.get(key);
	}
}
