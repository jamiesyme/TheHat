
//
// Loads and stores images.
//

class ImageManager {
	
	HashMap<String, PImage> images;
	
	ImageManager()
	{
		this.images = new HashMap<String, PImage>();
	}
	
	void add(String name, String location)
	{
		this.images.put(name, loadImage(location));
	}
	
	void add(String name, PImage image)
	{
		this.images.put(name, image);
	}
	
	PImage get(String name)
	{
		return this.images.get(name);
	}
	
}
