class KillerPuck extends Enemy {

  KillerPuck() {
    super();
    for (int i=0; i<4; i++) {
      animationImages[i] = loadImage("killerPuck"+i+".png");
    }
  }
  
  @Override
  protected void checkCanvasEdge(){
    super.checkCanvasEdge();
    // KillerPuck also bounces from the left and right of the screen 
    // rather than resetting at goal like RegularPuck
    if (x >= width+100 || x <= 20+(size/2)) {
      dx = -dx;
    }
  }

}
