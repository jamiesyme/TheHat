
//
// Loads and stores images.
//

class ImageManager {
	
	HashMap<String, PImage> images;
	
	ImageManager()
	{
		this.images = new HashMap<String, PImage>();
	}
	
	void load(String name, String location)
	{
		images.put(name, loadImage(location));
	}
	
	PImage get(String name)
	{
		return images.get(name);
	}
	
}
