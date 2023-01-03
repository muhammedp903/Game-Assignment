abstract class Moveable {

  protected float x, y, dx, dy;
  protected int size;
  

  Moveable() {
    reset();
  }

  abstract protected void reset();
  
  abstract protected void render();

  public void update() {
    move();
    render();
  }

  protected void move() {
    x += dx;
    y += dy;
  }
}
