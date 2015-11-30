

class CollisionManager {
	
	ArrayList<Rect> rects;
	ArrayList<String> types;
	
	CollisionManager()
	{
		this.rects = new ArrayList<Rect>();
		this.types = new ArrayList<String>();
	}
	
	void add(Rect rect, String type)
	{
		this.rects.add(rect);
		this.types.add(type);
	}
	
	void remove(Rect rect)
	{
		for (int i = 0; i < this.rects.size(); i++) {
			if (this.rects.get(i) == rect) {
				this.rects.remove(i);
				this.types.remove(i);
				break;	
			}
		}
	}
	
	Rect findCollision(Rect rect, String type)
	{
		for (Rect rect2 : this.rects) {
			
			if (rect.x + rect.w < rect2.x) continue;
			if (rect.y + rect.h < rect2.y) continue;
			if (rect.x > rect2.x + rect2.w) continue;
			if (rect.y > rect2.y + rect2.h) continue;
			
			return rect2;
		}
		
		return null;
	}
		
}
