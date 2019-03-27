PImage bg, soil, life, groundhogIdle, soldier, robot, cabbage;
PImage title, startHovered, restartHovered, restartNormal, gameover;

final int GAME_START = 0, GAME_RUN = 1, GAME_LOSE = 2;
int gameState;

float soldierX, soldierY;
float groundhogX, groundhogY;
float cabbageX, cabbageY;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup() {
  size(640, 480, P2D);

  // Put in background, soil, life, groundhog
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  startHovered = loadImage("img/startHovered.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  gameover = loadImage("img/gameover.jpg");

  //Random Place Cabbage
  cabbageX = floor(random(0,9))*80;
  cabbageY = floor(random(2,6))*80;

  // Random Place Soldier
  soldierX = 0;
  soldierY = floor(random(2, 6));
  
  //Grounghog plase
  groundhogX = width/2;
  groundhogY = 80;
  
  gameState = GAME_START;
}

void draw() {
  // Put in background, soil, life
  image(bg, 0, 0);
  image(soil, 0, 160);
  image(life, 10, 10);
  image(life, 80, 10);

  // Grass
  noStroke();
  colorMode(RGB);
  fill(124, 204, 25);
  rect(0, 145, 640, 15);
  
  // Draw a Sun
  fill(255, 255, 0);
  ellipse(590, 50, 130, 130);
  fill(253, 184, 19);
  ellipse(590, 50, 120, 120);
  
  //Cabbage
  image(cabbage, cabbageX, cabbageY);

/*  
  //Groundhog move
  if(downPressed){
    groundhogY += 80;
  }
  if(leftPressed){
    groundhogX -= 80;
  }
  if(rightPressed){
    groundhogX += 80;
  }
*/
  if(groundhogX + 80 > width-80){
    groundhogX = width-80;
  }
  if(groundhogX < 0){
    groundhogX = 0;
  }
  if(groundhogY > height-80){
    groundhogY = height-80;
  }
  if(groundhogX+80 > soldierX && groundhogY+80 > soldierY){
    groundhogX = width/2;
    groundhogY = 80;
  }

  // Put in Groundhog
  image(groundhogIdle, groundhogX, groundhogY);

  
  // Walking Soldier
  image(soldier, soldierX-80, 80*soldierY);
  soldierX += 5;
  soldierX %= 720;
  noFill();
}

	// Switch Game State
		// Game Start

		// Game Run

		// Game Lose

void keyPressed(){
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case DOWN:
        groundhogY += 80;
        break;
      case LEFT:
        groundhogX -= 80;
        break;
      case RIGHT:
        groundhogX += 80;
        break;
    }
  }
}

void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
