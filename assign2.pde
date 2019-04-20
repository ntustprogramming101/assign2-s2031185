PImage bg, soil, life, soldier, cabbage;
PImage title, startNormal, startHovered, restartHovered, restartNormal, gameover;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState;

final int lifeX = 10;
final int lifeY = 10;
final int lifeWidth = 50;
int lifeV=2;

float soldierX, soldierY;
float groundhogX, groundhogY;
float cabbageX, cabbageY;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

float dstX,dstY;

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
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");

  //Random Place Cabbage
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;

  // Random Place Soldier
  soldierX = 0;
  soldierY = floor(random(2, 6))*80;
  
  //Grounghog plase
  groundhogX = width/2;
  groundhogY = 80;
  
  //goal?
  dstX=width/2;
  dstY=80;
  
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
      }
       break;
    case GAME_RUN:
      // Put in background, soil, life
      image(bg, 0, 0);
      image(soil, 0, 160);
      for(int lifePlus=0 ; lifePlus<lifeV ; lifePlus++){
        image(life , lifeX+(lifeWidth+20)*lifePlus , lifeY);
      }
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
  

      //Boundary Lock
      if(dstX + 80 > width){
        dstX = width-80;
      }
      if(dstX < 0){
        dstX = 0;
      }
      if(dstY > height-80){
        dstY = height-80;
      }
      
       if(dstY>groundhogY)
       {
         groundhogY+=80/16;    
         image(groundhogDown, groundhogX, groundhogY);
       }
       else  if(dstX>groundhogX)
       {
         groundhogX+=80/16;
         image(groundhogRight, groundhogX, groundhogY);  
       }
       else if(dstX<groundhogX)
       {        
         groundhogX-=80/16;
         image(groundhogLeft, groundhogX, groundhogY);          
     }
       else
       {
         image(groundhogIdle, groundhogX, groundhogY);     
       }


      //Boundary Lock
      if(groundhogX + 80 > width){
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
        cabbageX = -100;
        cabbageY = -100;
        lifeV++;
      }

     //Crash with soldier
      if((soldierX-groundhogX)==0 && (groundhogY-soldierY)==0){
        dstX=width/2;
        dstY=80;
        groundhogX = width/2;
        groundhogY = 80;
        lifeV--;
      }
      if(lifeV==0){
        gameState = GAME_LOSE;
        break;
      }

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
            lifeV=2;
            break;
          }
        }      
  }
}

void keyPressed(){
  if (key == CODED && dstY==groundhogY && dstX==groundhogX) { // detect special keys 
    switch (keyCode) {
      case DOWN:        
          dstY+=80;
        break;
      case LEFT:
          dstX-=80;
        break;
      case RIGHT:
          dstX+=80;
        break;
    }
  }
}
