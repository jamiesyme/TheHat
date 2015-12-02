
//
// Loads and stores images.
//

class ImageManager {
	
	HashMap<String, PImage> images;
	
	ImageManager()
	{
		this.images = new HashMap<String, PImage>();
	}
	
	PImage add(String name, String location)
	{
		PImage img = loadImage(location);
		this.images.put(name, img);
		return img;
	}
	
	PImage add(String name, PImage image)
	{
		this.images.put(name, image);
		return image;
	}
	
	PImage get(String name)
	{
		return this.images.get(name);
	}
	
}
