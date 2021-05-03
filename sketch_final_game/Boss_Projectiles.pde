class BossProjectile{
  
  //declaring projectile vars
  int x;
  int y;
  int d; //diameter
  color c; //color
  int speedX;
  int speedY;
  int topBound;//top boundary of bullet
  int bottomBound;//bottom bound of bullet
  int leftBound;//left bound of bullet
  int rightBound;//right bound of bullet
  
  //Constructor//
  
  BossProjectile(int tempX, int tempY, int tempD){
    //intializing bullet vars
    x=tempX;
    y=tempY;
    d=tempD;
    c=color(255,0,0);
    speedX= int(random(-10,10));
    speedY=int(random(-10,10));
    topBound=y-d/2;
    bottomBound=y+d/2;
    leftBound=x-d/2;
    rightBound=x+d/2;
  }
  
  //Functions//
  
  //displays the bullet
  void renderBossProjectile(){
   fill(c);
   circle(x,y,d);
  }  
  
  //moves boss bullets
  void moveBossBullet(){
    x+=speedX;
    y+=speedY;
  }
  
  //resets boundaries for the bullet
  void resetBounds(){
    topBound=y-d/2;
    bottomBound=y+d/2;
    leftBound=x-d/2;
    rightBound=x+d/2;
  }
}
