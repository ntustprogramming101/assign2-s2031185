PImage bg, soil, life, groundhogIdle, soldier, robot, cabbage;
PImage title, startNormal, startHovered, restartHovered, restartNormal, gameover;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState;

int lifeX;
int lifeV=2;
final int lifeY = 10;
final int lifeWidth = 50;

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
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  gameover = loadImage("img/gameover.jpg");

  //Random Place Cabbage
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;

  // Random Place Soldier
  soldierX = 0;
  soldierY = floor(random(2, 6))*80;
  
  //Grounghog plase
  groundhogX = width/2;
  groundhogY = 80;
  
  gameState = GAME_START;
}

void draw() {  
    switch(gameState){
      case GAME_START:
        image(title,0,0);
        image(startNormal,248,360);
        //MOUSE ACTION
        if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
          image(startHovered,248,360);
          //Click
          if(mousePressed){
            gameState = GAME_RUN;
          }
          break;
        }
      case GAME_RUN:
        // Put in background, soil, life
        image(bg, 0, 0);
        image(soil, 0, 160);
        for(int i=0;i<lifeV;i++){
          image(life, lifeX+(lifeWidth+20)*i, lifeY);
        }
        //image(life, lifeX+lifeWidth+20, 10);

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
        //Boundary Lock
        if(groundhogX + 80 > width-80){
          groundhogX = width-80;
        }
        if(groundhogX < 0){
          groundhogX = 0;
        }
        if(groundhogY > height-80){
          groundhogY = height-80;
        }
  
        //Eat cabbage
        if(groundhogX == cabbageX && groundhogY == cabbageY){
          cabbageX = floor(random(0,8))*80;
          cabbageY = floor(random(2,6))*80;
          lifeV++;
        }
/*
  if((((soldierX-groundhogX)>1 || (groundhogX-soldierX)>1) &&
    ((soldierY-groundhogY)>1 || (groundhogY-soldierY)>1))!=true){
    groundhogX = width/2;
    groundhogY = 80;
    lifeV--;
  }
 */ 
       //Crash with soldier
        if((soldierX-groundhogX)==0 && (groundhogY-soldierY)==0){
          groundhogX = width/2;
          groundhogY = 80;
          lifeV--;
        }
        if(lifeV<0){
          gameState = GAME_LOSE;
        }
  
        // Put in Groundhog
        image(groundhogIdle, groundhogX, groundhogY);

        // Walking Soldier
        image(soldier, soldierX-80, soldierY);
        soldierX += 5;
        soldierX %= 720;
        noFill();
        break;
        case GAME_LOSE:
          image(gameover,0,0);
          image(restartNormal,248 , 360);
          //click
          if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
            image(restartHovered,248,360);
            if(mousePressed){
              gameState = GAME_RUN;
            }
          }
        
  }
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
