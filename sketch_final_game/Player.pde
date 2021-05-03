
class Player{
  
  //declaring player vars
  int pX;
  int pY;
  int pW;
  int pH;
  color c; //player color
  int runSpeed; //speed player runs
  int rollSpeed; //speed player dodges
  boolean movingLeft; //if true, player will move left
  boolean movingRight; //if true, player will move right
  boolean movingUp;//if true player will move up
  boolean movingDown;//if true player will move down
  int topBound; //top boundary of player
  int bottomBound; //bottom boundary of player
  int leftBound; //left bound of player
  int rightBound; //right bound of player
  boolean isPlayerDead;
  boolean isRolling;
  boolean canRoll;
  boolean isShooting;
  
  //Constructor//
  
  Player(){
    
    //initializing player vars
    pW = 25;
    pH = 60;
    pX=width/2-(pW/2);
    pY=height/2+200;
    c=color(0,255,255);
    runSpeed=5;
    rollSpeed=30;
    topBound=pY;
    bottomBound=pY+60;
    leftBound=pX;
    rightBound=pX+pW;
    movingLeft=false;
    movingRight=false;
    movingUp=false;
    movingDown=false;  
    isPlayerDead = false;
    isRolling = false;
    canRoll = true;
    isShooting = false;
  }

  //Functions//
  
  //this function displays the player
  void render(){
    fill(c);
    rect(pX,pY,pW,60);
  }
  
  //this function moves the player to the right
  void moveRight(){
    if(movingRight==true){
      pX+=runSpeed;
    }
  }
  
  //this function moves the player to the left
  void moveLeft(){
   if(movingLeft==true){
    pX-=runSpeed; 
   }
  }
  
  //moves player up
  void moveUp(){
    if(movingUp==true){
     pY-=runSpeed; 
    }
  }
  
  //moves player down
  void moveDown(){
    if(movingDown==true){
     pY+=runSpeed; 
    }
  }
  
  //checks if player is rolling
  void roll(){
   if(isRolling == true){
    runSpeed = rollSpeed; 
   } else{runSpeed = 5;
   }
 }
  
  //checks if player is not rolling
  void notRoll(){
   if(canRoll == false){
     isRolling = false;
   }
  } 
  
  //checks if player is shooting
  void isShooting(Projectile aProjectile){
   if(aProjectile.shootLeft||aProjectile.shootRight||aProjectile.shootUp||aProjectile.shootDown == true){
     isShooting = true;
   }
  }
  
  //checks if player hits sides of screen
  void wallDetect(){
    if(pX+pW>=width){
      movingRight=false;
    }
    
    if(pX<=0){
      movingLeft=false;
    }
    
    if(pY<=0){
      movingUp=false;
    }
    
    if(pY+60>=height){
      movingDown=false;
    }
  }
  
  //updates bound values after player moves
  void resetBoundaries(){
    topBound=pY;
    bottomBound=pY+60;
    leftBound=pX;
    rightBound=pX+pW;
  }
  
  //checks if player touches boss
  void isHitBoss(Boss theBoss){
    if(theBoss.bottomBound>=topBound){
      if(theBoss.topBound<=bottomBound){
       if(theBoss.rightBound>=leftBound){
        if(theBoss.leftBound<=rightBound){
          isPlayerDead=true;
          println("boss hit player");
        }
       }
      }
    }
  }
  
  //checks if player touches enemies
  void isHitEnemy(Enemy anEnemy){
     if(anEnemy.bottomBound>=topBound){
      if(anEnemy.topBound<=bottomBound){
       if(anEnemy.rightBound>=leftBound){
        if(anEnemy.leftBound<=rightBound){
          isPlayerDead=true;
          println("enemy hit player");
        }
       }
      }
    }
  }
  
  //checks if boss bullets are hitting player
  void isHitFireball(BossProjectile fireballs){
    if(fireballs.bottomBound>=topBound){
      if(fireballs.topBound<=bottomBound){
       if(fireballs.rightBound>=leftBound){
        if(fireballs.leftBound<=rightBound){
          isPlayerDead=true;
          println("bullet hit player");
        }
       }
      }
    }
  }
}
