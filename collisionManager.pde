

class CollisionManager {
	
	ArrayList<CollisionEntity> entities;
	
	CollisionManager()
	{
		this.entities = new ArrayList<CollisionEntity>();
	}
	
	void add(CollisionEntity e)
	{
		this.entities.add(e);
	}
	
	void remove(CollisionEntity e)
	{
		for (int i = 0; i < this.entities.size(); i++) {
			if (this.entities.get(i) == e) {
				this.entities.remove(i);
				break;
			}
		}
	}
	
	CollisionEntity findCollision(Rect rect, String type)
	{
		for (CollisionEntity e : this.entities) {
			
			if (!e.type.equals(type))
				continue;
			
			if (!isCollision(rect, e.rect))
				continue;
			
			return e;
		}
		
		return null;
	}
	
	CollisionEntity[] findCollisions(Rect rect, String type)
	{
		ArrayList<CollisionEntity> hits = new ArrayList<CollisionEntity>();
		
		for (CollisionEntity e : this.entities) {
			
			if (!e.type.equals(type))
				continue;
			
			if (!isCollision(rect, e.rect))
				continue;
			
			hits.add(e);
		}
		
		return hits.toArray( new CollisionEntity[hits.size()] );
	}
	
	boolean isCollision(Rect r1, Rect r2)
	{
		if (r1.x + r1.w < r2.x) return false;
		if (r1.y + r1.h < r2.y) return false;
		if (r1.x > r2.x + r2.w) return false;
		if (r1.y > r2.y + r2.h) return false;
		return true;
	}
	
	// Assumes isCollision() has been called and is true
	float[] getCollisionNormal(Rect r1, Rect r2)
	{
		float[] normal = { 0, 0 };
		if (r1.x + r1.w / 2 < r2.x + r2.w / 2) {		// If r1x < r2x
			if (r1.y + r1.h / 2 < r2.y + r2.h / 2) {	// If r1y < r2y
				float xd = (r1.x + r1.w) - r2.x;
				float yd = (r1.y + r1.h) - r2.y;
				if (xd < yd) normal[0] = -1;
				else         normal[1] = -1;
			} else {									// If r1y > r2y
				float xd = (r1.x + r1.w) - r2.x;
				float yd = (r2.y + r2.h) - r1.y;
				if (xd < yd) normal[0] = -1;
				else         normal[1] =  1;
			}
		} else {										// If r1x > r2x
			if (r1.y + r1.h / 2 < r2.y + r2.h / 2) {	// If r1y < r2y
				float xd = (r2.x + r2.w) - r1.x;
				float yd = (r1.y + r1.h) - r2.y;
				if (xd < yd) normal[0] =  1;
				else         normal[1] = -1;
			} else {									// If r1y > r2y
				float xd = (r2.x + r2.w) - r1.x;
				float yd = (r2.y + r2.h) - r1.y;
				if (xd < yd) normal[0] =  1;
				else         normal[1] =  1;
			}
		}
		return normal;
	}
}
