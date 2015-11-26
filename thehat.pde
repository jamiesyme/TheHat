

Engine _engine;


void setup()
{
	size(800, 600);
	_engine = new Engine(800, 600);
	_engine.init();
}


void draw()
{
	_engine.tick();
	_engine.draw();
}


void keyPressed()
{
	_engine.onKeyDown(keyCode);
}


void keyReleased()
{
	_engine.onKeyUp(keyCode);
}
