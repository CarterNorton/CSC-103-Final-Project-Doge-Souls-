
class Boss{
  
  //declaring vars
  int bX;
  int bY;
  int h;
  int w;
  color c;
  float moveSpeed;
  int topBound;//top boundary of enemy
  int bottomBound;//bottom boundary of enemy
  int leftBound;//left boundary of enemy
  int rightBound;//right boundary of enemy
  int bossHealth;
  
  //Constructor//
  
  Boss(){
    w=150;
    h=200;
    bX=width/2-w/2;
    bY=25;
    moveSpeed=1;
    c=color(255,0,0);
    topBound=bY;
    bottomBound=bY+h;
    leftBound=bX;
    rightBound=bX+w;
    bossHealth = 50;
  }
  
  //fucntions//
  
  //displays the boss
  void renderBoss(){
   fill(c);
   rect(bX,bY,w,h); 
  }
  
  void renderBossHealth(){
   fill(c);
   textSize(50);
   text(bossHealth,1100,775);
  }
  
  //makes boss move toward player
  void moveBoss(Player thePlayer){   
    if(thePlayer.pX<=bX){
     bX-=moveSpeed; 
    }
    if(thePlayer.pX>=(bX+w/2)){
     bX+=moveSpeed; 
    }
    if(thePlayer.pY>=(bY+h/2)){
     bY+=moveSpeed; 
    }
    if(thePlayer.pY<=(bY+h/2)){
     bY-=moveSpeed; 
    }
  }
  
  //checks if bullets are hitting boss
  void isHit(Projectile aProjectile){
    if(aProjectile.bottomBound>=topBound){
      if(aProjectile.topBound<=bottomBound){
       if(aProjectile.rightBound>=leftBound){
        if(aProjectile.leftBound<=rightBound){
          println("bullet hit boss");
          aProjectile.isDestroyed=true;
          bossHealth = bossHealth - 1;
        }
       }
      }
    }
  }
  
  //updates boss bounds
  void resetBossBounds(){
    topBound=bY;
    bottomBound=bY+h;
    leftBound=bX;
    rightBound=bX+w;
  }
}
