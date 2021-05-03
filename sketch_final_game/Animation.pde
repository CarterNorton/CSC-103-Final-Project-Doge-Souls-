
class Animation{
  //intializing vars
  PImage[] images;
  float speed;
  float scale;
  float index;
  boolean isAnimating;
  
  //Constructor//
  
  Animation(PImage[] tempImages, float tempSpeed, float tempScale){
    images=tempImages;
    speed=tempSpeed;
    scale=tempScale;
    index=0;
    isAnimating=false;
    
  }
  
  //Functions
  
  //displays the current sprite in the animation
  void renderArt(int x, int y){
    //imageMode(CENTER);
    
    if(isAnimating==true){
      int imageIndex=int(index);
      PImage img = images[imageIndex];
      image(img, x, y, img.width*scale, img.height*scale);
      
      //increment the index of the images to display
      updateArt();
    }else{
      PImage img = images[0];
      image(img, x, y, img.width*scale, img.height*scale);
    }
  }
  
  //updates the index of the image that should be displayed
  void updateArt(){
    index+=speed;
    
    if(index>=images.length){
     index=0;
     isAnimating=false;
    }
  }
  
}
