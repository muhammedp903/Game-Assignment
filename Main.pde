private Renderer renderer;
private Player player;
private ArrayList<Enemy> enemies = new ArrayList<>();

private int lives = 10;
private int startTime;
public int time;

enum GameMode {
  START, PLAY, GAMEOVER
}
private GameMode gameMode = GameMode.START;

void setup() {
  size(1400, 800);

  renderer = new Renderer();
  player = new Player();

  // Add 8 regular and 4 killer pucks to the ArrayList
  for (int i=0; i<8; i++) {
    enemies.add(new RegularPuck());
  }
  for (int j=0; j<4; j++) {
    enemies.add(new KillerPuck());
  }
}

void draw() {
  if (lives<=0) {
    gameMode = GameMode.GAMEOVER;
    
    // Read the times from file, add new time, and write back to file
    String[] lines = loadStrings("scores.txt");
    String[] times = new String[1];
    times[0] = nf(time)+"    "+day()+"/"+month()+"/"+year();
    saveStrings("scores.txt", concat(times,lines));
    
    lives = 10;
  }

  switch (gameMode) {
    case PLAY:
      play();
      break;
    case START:
    case GAMEOVER:
      renderer.renderSplashScreen(gameMode);
      break;
  }
}

private void play() {
  time = (millis() - startTime)/1000;
  
  background(255);
  
  fill(0);
  textSize(45);
  text("Lives: "+lives, width-150, 70);
  text("Time: "+time, width-150, 125);

  renderer.renderGoal();
  player.update();

  for (Enemy puck : enemies) {
    // All Enemy objects check for collisions with player
    if (puck.collision()) {
      puck.reset();
      if (puck instanceof KillerPuck) {
        lives-=1;
        player.explode();
      }
    }
    // Only RegularPuck checks for goal
    if (puck instanceof RegularPuck) {
      // goal() can only be called on instances of RegularPuck
      // Cast puck to a RegularPuck and call goal() on it
      if(((RegularPuck) puck).goal()){
        puck.reset();
        lives-=1;
      }
    }
    puck.update();
  }
}

void mousePressed() {
  if (gameMode == GameMode.PLAY) {
    player.setTargetXY(mouseX, mouseY);
  } else {
    // Reset enemies, player, gameMode and times to restart the game
    for (Enemy puck : enemies) {
      puck.reset();
    }
    player.reset();
    gameMode = GameMode.PLAY;
    startTime = millis();
    time = 0;
  }
}
