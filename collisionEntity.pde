
//
// An easy way to group the collision-related data for an entity.
//

class CollisionEntity {
	
	Rect   rect;
	String type;
	Object data;
	
	CollisionEntity()
	{
	}
	
	CollisionEntity(Rect rect, String type)
	{
		this.rect = rect;
		this.type = type;
	}
	
	CollisionEntity(Rect rect, String type, Object data)
	{
		this.rect = rect;
		this.type = type;
		this.data = data;
	}
};
