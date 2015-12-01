
//
// Wraps mouse functionality within processing.
//

class MouseManager {
	
	HashMap<Integer, Boolean> buttonsDown;
	HashMap<Integer, Boolean> buttonsActive;
	int[] mouseCoords;
	int[] oldMouseCoords;
	
	MouseManager()
	{
		this.buttonsDown    = new HashMap<Integer, Boolean>();
		this.buttonsActive  = new HashMap<Integer, Boolean>();
		this.mouseCoords    = new int[2];
		this.oldMouseCoords = new int[2];
		for (int i = 0; i < 2; i++) {
			this.mouseCoords[i] = -1;
			this.oldMouseCoords[i] = -1;
		}
	}
	
	
	//
	// Gets called once a frame (AT THE END!) to reset the active buttons.
	//
	
	void tick()
	{
		for (HashMap.Entry<Integer, Boolean> e : this.buttonsActive.entrySet()) {
			this.buttonsActive.put(e.getKey(), false);
		}
		
		this.oldMouseCoords[0] = this.mouseCoords[0];
		this.oldMouseCoords[1] = this.mouseCoords[1];
	}
	
	
	//
	// Gets called when a mouse button is pressed.
	//
	
	void onButtonDown(int button)
	{
		this.buttonsDown.put(button, true);
		this.buttonsActive.put(button, true);
	}
	
	
	//
	// Gets called when a mouse button is released.
	//
	
	void onButtonUp(int button)
	{
		this.buttonsDown.put(button, false);
		this.buttonsActive.put(button, true);
	}
	
	
	//
	// Returns true if mouse button is currently held down.
	//
	// Example Code:
	//
	// if ( mouseMgr.isButtonDown(LEFT) ) {
	//
	//     doSomethingWithLeftClick();
	//
	// }
	//
	
	boolean isButtonDown(int button)
	{
		if (!this.buttonsDown.containsKey(button))
			return false;
		return this.buttonsDown.get(button);
	}
	
	
	//
	// Returns true is mouse button was just clicked.
	//
	
	boolean isButtonPressed(int button)
	{
		if (!this.buttonsActive.containsKey(button))
			return false;
		if (!this.buttonsActive.get(button))
			return false;
		return this.buttonsDown.get(button);
	}
	
	
	//
	// Returns true is mouse button was just released.
	//
	
	boolean isButtonReleased(int button)
	{
		if (!this.buttonsActive.containsKey(button))
			return false;
		if (!this.buttonsActive.get(button))
			return false;
		return !this.buttonsDown.get(button);
	}
	
	
	//
	// Gets called when the mouse is moved.
	//
	
	void onMouseMove(int x, int y)
	{
		this.mouseCoords[0] = x;
		this.mouseCoords[1] = y;
		
		// Prevent a large delta when moving the mouse for the first time
		if (this.oldMouseCoords[0] < 0 || this.oldMouseCoords[1] < 0) {
			this.oldMouseCoords[0] = this.mouseCoords[0];
			this.oldMouseCoords[1] = this.mouseCoords[1];
		}
	}
	
	
	//
	// Get the current mouse coordinates.
	//
	// Example Code:
	//
	// int[] coords = mouseMgr.getCoords();
	// coords[0]; // X Coordinate
	// coords[1]; // Y Coordinate
	//
	
	int[] getCoords()
	{
		return this.mouseCoords;
	}
	
	
	//
	// Get the mouse coordinates from last frame.
	//
	
	int[] getOldCoords()
	{
		return this.oldMouseCoords;
	}
	
	
	//
	// Get the mouse deltas. This will tell you difference between the mouse
	// coords this frame and the mouse coords last frame.
	//
	
	int[] getDeltas()
	{
		int[] deltas = { 
			this.mouseCoords[0] - this.oldMouseCoords[0],
			this.mouseCoords[1] - this.oldMouseCoords[1]
		};
		return deltas;
	}
	
}
