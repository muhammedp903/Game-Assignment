class RegularPuck extends Enemy {

  RegularPuck() {
    super();
    for (int i=0; i<10; i++) {
      animationImages[i] = loadImage("regularPuck"+i+".png");
    }
  }
  
  // Only RegularPuck has the goal() method, as KillerPuck bounces off the goal
  public boolean goal() {
    // Check if the goal has been hit
    if (x <= 20 + size/2) {
      return true;
    }
    return false;
  }

}
