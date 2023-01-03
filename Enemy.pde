abstract class Enemy extends Moveable {

  protected PImage[] animationImages;
  protected int frameCounter = 0;

  Enemy() {
    super();
    size = 40;
    animationImages = new PImage[4];
  }

  @Override
  protected void reset() {
    // Set/reset the position and speed of the puck using random values
    x = width + (int) random(30, 100);
    y = (int) random(50, height-50);
    dx = (int) random(-4, -2);
    dy = (int) random(-3, 3);
  }

  @Override
  public void update() {
    checkCanvasEdge();
    super.update();
  }

  @Override
  protected void render() {
    int imageNo = 0;

    if (frameCounter<8) {
      imageNo = 0;
    } else if (frameCounter<16) {
      imageNo = 1;
    } else if (frameCounter<23) {
      imageNo = 2;
    } else {
      imageNo = 3;
      if (frameCounter >= 30) {
        frameCounter = 0;
      }
    }
    frameCounter++;

    imageMode(CENTER);
    image(animationImages[imageNo], x, y, size, size);
  }

  protected void checkCanvasEdge() {
    // Bounce from the top and bottom of the screen
    if (y >=height-size/2 || y <= size/2) {
      dy = -dy;
    }
  }

  public boolean collision() {
    // Test for collision with player
    for (int i=0; i<=360; i+=10) {
      // Use trigonometry to calculate points on the circumference of the circle at 10 degree intervals
      int testX = round(x + ((size/2)*cos(i)));
      int testY = round(y + ((size/2)*sin(i)));

      // Check the colour of the pixel at this point
      color testColour = get(testX, testY);
      if (testColour == color(0, 255, 0)) {
        return true;
      }
    }
    return false;
  }
  
}
