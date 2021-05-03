
//players projectiles
class Projectile{
  
  //declaring projectile vars
  int x;
  int y;
  int h; 
  int w;
  color c; //color
  int speed;
  boolean shootLeft;
  boolean shootRight;
  boolean shootUp;
  boolean shootDown;
  int topBound;//top boundary of bullet
  int bottomBound;//bottom bound of bullet
  int leftBound;//left bound of bullet
  int rightBound;//right bound of bullet
  boolean isDestroyed;//if true projectile disappears
  
  //Constructor//
  
  Projectile(int tempX, int tempY, int tempW, int tempH){
    //intializing bullet vars
    x=tempX;
    y=tempY;
    w=tempW;
    h=tempH;
    c=color(255,0,0);
    speed=10;
    topBound=y;
    bottomBound=y+h;
    leftBound=x;
    rightBound=x+w;
    shootRight=false;
    shootLeft=false;
    shootUp=false;
    shootDown=false;
    isDestroyed=false;
  }
  
  //Functions//
  
  //displays the bullet
  void renderProjectile(){
   fill(c);
   rect(x,y,w,h);
  }
  
  //moves the bullet right
  void moveProjectileRight(){
    if(shootRight==true){
      x+=speed; 
    }
  }
  
   //moves the bullet left
  void moveProjectileLeft(){
    if(shootLeft==true){
   x-=speed; 
    }
  }
  
  //moves the bullet up
  void moveProjectileUp(){
    if(shootUp==true){
   y-=speed; 
    }
  } 
  
  //moves the bullet up
  void moveProjectileDown(){
    if(shootDown==true){
   y+=speed; 
    }
  }
  
  //checks if bullets leaves screen
  void isGone(){
    if(x>=width){
   isDestroyed=true; 
    }
    
    if(x<=0){
   isDestroyed=true; 
    }
    
    if(y>=height){
   isDestroyed=true; 
    }
    
    if(y<=0){
   isDestroyed=true; 
    }
  }
  
    //resets boundaries for the bullet
  void resetBounds(){
    topBound=y;
    bottomBound=y+h;
    leftBound=x;
    rightBound=x+w;
  }
 }
