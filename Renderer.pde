class Renderer {
  // Methods for rendering the goal and splash screens

  public void renderGoal() {
    stroke(225, 110, 25);
    fill(225, 110, 25);
    rect(0, 0, 20, height);
  }

  public void renderSplashScreen(GameMode mode) {
    fill(0);
    textAlign(CENTER);
    textSize(100);
    
    switch (mode) {
      case START:
        background(0, 255, 0);
        text("Welcome", width/4, (height/3)+50);
        textSize(50);
        text("Click to start", width/4, (height/3)+200);
        
        text("Recent times", (width/4)*3, height/3);
        textSize(30);
        
        String[] lines = loadStrings("scores.txt");
        for(int i=0; i<lines.length && i<5; i++){
          text(lines[i], (width/4)*3, (height/3)+55+(i*45));
        }
        break;
      case GAMEOVER:
        background(255, 0, 0);
        text("Game Over", width/2, height/2);
        textSize(50);
        text("Click to restart", width/2, (height/2)+100);
        break;
      default:
    }
  }
}
