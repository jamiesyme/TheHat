

Engine _engine;


void setup()
{
    size(800, 600);
    _engine = new Engine(800, 600);
}


void draw()
{
    _engine.tick();
    _engine.draw();
}
