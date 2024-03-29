class Player extends Moveable {

  private float speed = 10;

  private float targetX;
  private float targetY;
  
  private color colour;
  
  private color green  = color(0,255,0);
  private color red  = color(255,0,0);
  private color orange  = color(255,150,0);
  
  private int immobileFrames = 0;

  Player() {
    super();
    size = 40;
    colour = green;
  }

  @Override
  public void reset() {
    x = 0;
    y = 0;
    targetX = 200;
    targetY = 200;
    dx = 0;
    dy = 0;
    immobileFrames = 0;
    colour = green;
  }
  
  @Override
  public void update() {
    if(colour != green) {
      // After hitting a KillerPuck, the player will be immobile for 3 seconds (180 frames)
      // and flash red and orange
      if(immobileFrames<180) {
        immobileFrames += 1;
        if(immobileFrames%15 == 0){
          switchColour();
        }
      } else {
        colour = green;
        immobileFrames = 0;
      }
    }
    super.update();
  }
  
  private void switchColour(){
    if(colour == red){
      colour = orange;
    }else{
      colour = red;
    }
  }
  
  @Override
  protected void render() {
    fill(colour);
    stroke(colour);
    ellipse(x, y, size, size);
  }

  @Override
  protected void move() {
    // Calculate the (positive or negative) distance from target position in x and y
    float distX = targetX - x;
    float distY = targetY - y;

    // Calculate the total distance to the target in a straight line using pythagoras
    float distance = sqrt((sq(distY) + sq(distX)));

    // Calculate a divisor to achieve an overall constant velocity of 10 (float speed)
    float speedFactor = distance/speed;

    // Use the divisor to calculate the speed in x and y
    dx = distX/speedFactor;
    dy = distY/speedFactor;

    // Change x and y by dx and dy or the remaining distance if smaller than the speed
    if (abs(distX) >= abs(dx)) {
      x += dx;
    } else {
      x += distX;
    }
    if (abs(distY) >= abs(dy)) {
      y += dy;
    } else {
      y += distY;
    }
  }

  public void setTargetXY(int targetX, int targetY) {
    // If the player is not immobile, set the new target position
    if(colour == green){
      this.targetX = targetX;
      this.targetY = targetY;
    }
  }
  
  public void explode() {
    // Stop the player moving and change colour
    targetX = x;
    targetY = y;
    colour = red;
  }
  
}
