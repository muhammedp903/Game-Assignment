class RegularPuck extends Enemy {

  RegularPuck() {
    super();
    for (int i=0; i<4; i++) {
      animationImages[i] = loadImage("regularPuck"+i+".png");
    }
  }
  
  public boolean goal() {
    // Check if the goal has been hit
    if (x <= 20 + size/2) {
      return true;
    }
    return false;
  }

}
