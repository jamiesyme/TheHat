
//
// Spawns level obstacles at certain player trigger locations.
//

class TownSpawner_Entry {
	float triggerLoc;
	float spawnLoc;
	float spawnRange;
	int walkers;
	int cars;
	
	boolean trigger(float x, Gameplay gp) {
		
		if (x < this.triggerLoc)
			return false;
		
		for (int i = 0; i < this.walkers; i++) {
			x = random(this.spawnLoc, this.spawnLoc + this.spawnRange);
			gp.spawnWalker(x);
		}
		
		for (int i = 0; i < this.cars; i++) {
			x = random(this.spawnLoc, this.spawnLoc + this.spawnRange);
			gp.spawnCar(x);
		}
		
		return true;
	}
	
	TownSpawner_Entry clone()
	{
		TownSpawner_Entry c = new TownSpawner_Entry();
		c.triggerLoc = this.triggerLoc;
		c.spawnLoc = this.spawnLoc;
		c.spawnRange = this.spawnRange;
		c.walkers = this.walkers;
		c.cars = this.cars;
		return c;
	}
}

class TownSpawner extends SceneEntity {
	
	ArrayList<TownSpawner_Entry> entries;
	int entryIndex;
	
	TownSpawner()
	{
	}
	
	void init()
	{
		float screenWidth = ((Gameplay)this.scene).ortho.w;
		
		this.entries = new ArrayList<TownSpawner_Entry>();
		this.entryIndex = 0;
		
		TownSpawner_Entry e = new TownSpawner_Entry();
		e.triggerLoc = 1;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 0;
		e.walkers = 1;
		e.cars = 0;
		this.entries.add(e.clone());
		
		e.triggerLoc += 6;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 3;
		e.walkers = 3;
		e.cars = 0;
		this.entries.add(e.clone());
		
		e.triggerLoc += 8;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 6;
		e.walkers = 4;
		e.cars = 0;
		this.entries.add(e.clone());
		
		e.triggerLoc += 10;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 15;
		e.walkers = 10;
		e.cars = 0;
		this.entries.add(e.clone());
		
		e.triggerLoc += 25;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 30;
		e.walkers = 50;
		e.cars = 0;
		this.entries.add(e.clone());
		
		e.triggerLoc += 20;
		e.spawnLoc = e.triggerLoc + screenWidth + 5;
		e.spawnRange = 0;
		e.walkers = 0;
		e.cars = 1;
		this.entries.add(e.clone());
		
		e.triggerLoc += 15;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 0;
		e.walkers = 0;
		e.cars = 1;
		this.entries.add(e.clone());
		
		e.triggerLoc += 10;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 20;
		e.walkers = 10;
		e.cars = 0;
		this.entries.add(e.clone());
		
		e.triggerLoc += 10;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 0;
		e.walkers = 0;
		e.cars = 1;
		this.entries.add(e.clone());
		
		e.triggerLoc += 20;
		e.spawnLoc = e.triggerLoc + screenWidth;
		e.spawnRange = 100;
		e.walkers = 0;
		e.cars = 15;
		this.entries.add(e.clone());
		
	}
	
	void tick(float dt)
	{
		Gameplay gp = (Gameplay)this.scene;
		float x = gp.ortho.x;
		
		while (this.entryIndex < this.entries.size()) {
			
			if (this.entries.get( this.entryIndex ).trigger( x, gp )) {
				
				this.entryIndex++;
				
			} else {
				
				break;
				
			}
		}
		
	}
	
	float getMaxX()
	{
		TownSpawner_Entry e = this.entries.get(this.entries.size() - 1);
		return e.spawnLoc;
	}
	
}
