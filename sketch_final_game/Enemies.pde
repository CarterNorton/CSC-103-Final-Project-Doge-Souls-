
class Enemy{
  
  //declaring enemy vars
  int eX;
  int eY;
  int eW;//width
  int eH;//height
  color c;//color
  int enemySpeed;
  int topBound;//top boundary of enemy
  int bottomBound;//bottom boundary of enemy
  int leftBound;//left boundary of enemy
  int rightBound;//right boundary of enemy
  int enemyHealth; //max times an enemy can be hit before they die
  boolean isDead;//if true enemy is dead and is removed
  
  
  //Constructor//
  
  Enemy(int tempX, int tempY){
    eX=tempX;
    eY=tempY;
    eW=50;
    eH=75;
    c=color(int(random(0,255)),int(random(0,255)),int(random(0,255)));
    enemySpeed=2;
    topBound=eY;
    bottomBound=eY+eH;
    leftBound=eX;
    rightBound=eX+eW;
    enemyHealth = 1;
    isDead = false;
   
  }
  
  //Functions//
  
  //displays the enemy
  void renderEnemy(){
   fill(c);
   rect(eX,eY,eW,eH);
  }
  
  //makes the enemies move towards the player
  void moveEnemy(Player thePlayer){   
    if(thePlayer.pX<=eX){
     eX-=enemySpeed; 
    }
    if(thePlayer.pX>=(eX+eW/2)){
     eX+=enemySpeed; 
    }
    if(thePlayer.pY>=(eY+eH/2)){
     eY+=enemySpeed; 
    }
    if(thePlayer.pY<=(eY+eH/2)){
     eY-=enemySpeed; 
    }
  }
  
  //checks if bullets are hitting enemies
  void isHit(Projectile aProjectile){
    if(aProjectile.bottomBound>=topBound){
      if(aProjectile.topBound<=bottomBound){
       if(aProjectile.rightBound>=leftBound){
        if(aProjectile.leftBound<=rightBound){
         println("bullet hit enemy");
         isDead=true;
         aProjectile.isDestroyed=true;
         enemyHealth = enemyHealth - 1;
        }
       }
      }
    }
  }
  
   //checks if player touches enemies
  void isTouching(Player thePlayer){
    if(thePlayer.bottomBound>=topBound){
      if(thePlayer.topBound<=bottomBound){
       if(thePlayer.rightBound>=leftBound){
        if(thePlayer.leftBound<=rightBound){
          thePlayer.isPlayerDead=true;
          println("player touches enemy");
        }
       }
      }
    }
  }
  
  //updates enemy bounds
  void resetEnemyBounds(){
    topBound=eY;
    bottomBound=eY+eH;
    leftBound=eX;
    rightBound=eX+eW;
  }
  
   
}
