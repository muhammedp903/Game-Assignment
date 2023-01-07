abstract class Enemy extends Moveable {

  protected PImage[] animationImages;
  protected int frameCounter = 0;

  Enemy() {
    super();
    size = 40;
    animationImages = new PImage[10];
  }

  @Override
  protected void reset() {
    // Set/reset the position and speed of the puck using random values from a range
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
    // Determine which image to display (changing every 6 frames/ 10 times per sec.)
    int imageNo = floor(frameCounter/6);

    frameCounter++;
    
    if (frameCounter >= 60) {
        frameCounter = 0;
      }

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
      // Use trigonometry to calculate x and y coordinates
      // of points on the circumference of the circular enemy at 10 degree intervals
      int testX = round(x + ((size/2)*cos(i)));
      int testY = round(y + ((size/2)*sin(i)));

      // Check the colour of the pixel at this point
      color testColour = get(testX, testY);
      if (testColour == color(0, 255, 0)) {
        // A collision is happening if the point is green (colour of the player)
        return true;
      }
    }
    return false;
  }
  
}
