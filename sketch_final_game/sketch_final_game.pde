//NOTE//
//You can totally just cheese the boss by holding down the shoot keys
//but it's honestly way more fun if you don't

//wasd to move
//Shift+wasd to shoot in different directions
//you cannot move while holding shift
//hold space to dodge 
//enemies spawn on the top half of the screen

//Making the game harder//

//you can also make the game harder if you want to: 
//go to the boss and enemy tabs and increase their health and/or speed
//go to the press 'b' key section (way down near the bottom of this tab) and change
//the boss and enemy health to match what you changed it to
//you could also increase the amount of enemies and fireballs that spawn
//(those are near the beginning of the draw function)


//importing sound library
import processing.sound.*;

//declaring sound vars
SoundFile titleScreenSong;
SoundFile fire;
SoundFile bossSong;
SoundFile spawn;
SoundFile playerShooting;
SoundFile playerRolling;
SoundFile bossAttack;
SoundFile enemiesHit;
SoundFile loseSound;
SoundFile winSound;

boolean shouldPlayDeath;
boolean shouldPlayWin;

//creating new font
PFont font;

//creating background images
PImage titleScreenImage;
PImage winScreenImage;
PImage loseScreenImage;

//making animation objects
Animation bonfire;
Animation playerRun;
Animation playerRoll;
Animation playerShoot;
Animation enemiesMove;
Animation bossShoot;
Animation bossMove;
Animation arrow;

//making array lists for images
PImage[] bonfireImages = new PImage[6];
PImage[] playerRunImages = new PImage[5];
PImage[] playerRollImages = new PImage[5];
PImage[] playerShootImages = new PImage[6];
PImage[] enemiesMoveImages = new PImage[6];
PImage[] bossFireballs = new PImage[6];
PImage[] bossMoveImages = new PImage[8];
PImage[] arrowImages = new PImage[1];

 // setting up finite state machine
  int state; 
 
 //declaring player vars
  Player p1;
  
  //declaring boss vars
  Boss b1;
  
  //declaring array list of bullets
  ArrayList<Projectile> projectileList;
  
  //boss projectiles
  ArrayList<BossProjectile> bossList;
  
  //declaring array list of enemies
  ArrayList<Enemy> enemyList;
  
  //enemy spawn timer vars
  int eStartTime;
  int eEndTime;
  int eInterval;  
  
  //boss shooting timer vars
  int bStartTime;
  int bEndTime;
  int bInterval;
  
  //roll timer vars
  int rStartTime;
  int rEndTime;
  int rInterval;

void setup(){
  //setting window size
  size(1200,800);
  
  //loading images
  titleScreenImage = loadImage("Title Screen.png");
  loseScreenImage = loadImage("Dead Screen.png");
  winScreenImage = loadImage("Win Screen.png"); 
    
  //for loops for images//
  
  //arrows
  for(int i=0; i<arrowImages.length;i++){
   arrowImages[i]=loadImage("arrow"+i+".png"); 
  }
  
  //bonfire
  for(int i=0; i<bonfireImages.length;i++){
   bonfireImages[i]=loadImage("bonfire"+i+".png"); 
  }
  
  //player running
  for(int i=0; i<playerRunImages.length;i++){
   playerRunImages[i]=loadImage("doge"+i+".png"); 
  }
  
  //player rolling
  for(int i=0; i<playerRollImages.length;i++){
   playerRollImages[i]=loadImage("rolling"+i+".png"); 
  }
  
  //player shooting
  for(int i=0; i<playerShootImages.length;i++){
   playerShootImages[i]=loadImage("shooting"+i+".png"); 
  }
  
  //enemies
  for(int i=0; i<enemiesMoveImages.length;i++){
   enemiesMoveImages[i]=loadImage("enemy"+i+".png"); 
  }
  
  //fireballs
  for(int i=0; i<bossFireballs.length;i++){
   bossFireballs[i]=loadImage("fireball"+i+".png"); 
  }
  
  //boss
  for(int i=0; i<bossMoveImages.length;i++){
   bossMoveImages[i]=loadImage("boss"+i+".png"); 
  }
  
  //animation images
  arrow = new Animation(arrowImages, 0.1, 2);
  bonfire = new Animation(bonfireImages, 0.4, 2.5);
  playerRun = new Animation(playerRunImages, 0.1, 2);
  playerRoll = new Animation(playerRollImages, 0.4, 2);
  playerShoot = new Animation(playerShootImages, 0.4, 2);
  enemiesMove = new Animation(enemiesMoveImages, 0.1, 2.5);
  bossShoot = new Animation(bossFireballs, 0.2, 1);
  bossMove = new Animation(bossMoveImages, 0.1, 3);
  
  //declaring sound vars
  titleScreenSong = new SoundFile(this, "title_screen_song.wav");
  fire = new SoundFile(this, "fire.wav");
  bossSong = new SoundFile(this, "boss_song.wav");
  spawn = new SoundFile(this, "enemies_spawn.wav");
  playerShooting = new SoundFile(this, "player_shooting.wav");
  playerRolling = new SoundFile(this, "player_rolling.mp3");
  bossAttack = new SoundFile(this, "boss_attack.wav");
  enemiesHit = new SoundFile(this, "enemies_hit.wav");
  loseSound = new SoundFile(this, "lose_sound.wav");
  winSound = new SoundFile(this, "win_sound.wav");
  
  shouldPlayWin = true;
  shouldPlayDeath = true;
  
  //adjusting some sounds
  bossSong.amp(.5);
  bossAttack.amp(.1);
  spawn.amp(1.0);
  playerRolling.amp(1.0);
  loseSound.amp(.3);
  winSound.amp(.4);
  playerShooting.amp(1.0);
  playerShooting.rate(1.5);
  
  //declaring finite state machine
  state = 0;
  
  //enemy timer vars
  eInterval = 15000;
  eStartTime = millis();
  
  //boss timer vars
  bInterval = 10000;
  bStartTime = millis();
  
  //roll timer
  rInterval = 1000;

  //creating object of player class
  p1 = new Player();
  
  //creating object of boss class
  b1 = new Boss();
  
  //initializing empty bullet list
  projectileList = new ArrayList<Projectile>();
  
  //intializing boss list
  bossList = new ArrayList<BossProjectile>();
  
  //intializing enemy list
  enemyList = new ArrayList<Enemy>();
  
  //declaring font
  font = loadFont("MingLiU-ExtB-48.vlw");
}

void draw(){
  
  //switch statements
  switch(state){
    
    //start screen
    case 0:
    
    background(0);
    
image(titleScreenImage, (width/2-titleScreenImage.width*2/2), (height/2-titleScreenImage.height*2/2), titleScreenImage.width*2, titleScreenImage.height*2);
   fill(255);
    textFont(font, 25);
    text("press 'g' to start", 490, 600);
    
    //loop background music
  if(!titleScreenSong.isPlaying()){
    titleScreenSong.play();
  }
    
    break;
    
    //description screen
    case 1:
    
    background(0);
    bonfire.renderArt(width/4-175, height/4-50);
    bonfire.isAnimating = true;
    fill(255);
    textFont(font, 30);
    text("You must defeat the Lord of Cinder using your magic bow", 200, 60);
    text("and rekindle the First Flame.", 400, 100);
    text("Rest here until you are ready...", 390, 700);
    text("press 'b' to begin", 475, 740);
    textFont(font, 20);
    text("DIRECTIONS:", 20, height/2-70);
    text("-Use 'wasd' to move", 20, height/2-35);
    text("-Hold 'shift' and press 'wasd' to shoot arrows", 20, height/2);
    text("and control their direction in the air", 20, height/2+25); 
    text("-You cannot move while shooting", 20, height/2+60);
    text("-Press 'space' while moving to roll, ", 20, height/2+95);
    text("but be cautious, as it has a cooldown", 20, height/2+120);
    text("-Enemies spawn in the top half of the arena", 20, height/2+155);
    
    //loop fire sounds
    if(!fire.isPlaying()){
    fire.play();
  }
    
    break;
    
    //game screen
    case 2:
    
    titleScreenSong.stop();
    fire.stop();
    
    //setting background color
  background(0);
   
  //creating player
  //p1.render();
  if(p1.movingRight||p1.movingLeft||p1.movingUp||p1.movingDown|| p1.isRolling==true && p1.isShooting==false){
      playerRoll.renderArt(p1.pX-20, p1.pY);
  }
  else if(p1.isRolling==false&&p1.isShooting==true){
    playerShoot.renderArt(p1.pX-20, p1.pY);
  }else{playerRun.renderArt(p1.pX-20, p1.pY); playerRun.isAnimating = true;
  }
  p1.moveRight();
  p1.moveLeft();
  p1.moveUp();
  p1.moveDown();
  p1.roll();
  p1.wallDetect();
  p1.notRoll();
  p1.isHitBoss(b1);   //checks if player touches boss
  p1.resetBoundaries();
  
  //creating boss
  bossMove.renderArt(b1.bX-20, b1.bY);
  bossMove.isAnimating = true;
  b1.renderBossHealth();
  b1.moveBoss(p1);  //makes boss follow player
  b1.resetBossBounds();
  
  //enhanced for loop for bullet array
  for(Projectile projectile1 : projectileList){
   arrow.renderArt(projectile1.x-25, projectile1.y-25);
   projectile1.moveProjectileRight();
   projectile1.moveProjectileLeft();
   projectile1.moveProjectileUp();
   projectile1.moveProjectileDown();
   projectile1.isGone(); //removes projectiles that hit enemies or leave the screen
   projectile1.resetBounds();
   
   //checking if enemies are hit by bullets
   for(Enemy enemy1 : enemyList){
    enemy1.isHit(projectile1); 
   }
   
   //checking if boss is hit by bullets
   b1.isHit(projectile1); 
   
   //player shooting animation
   p1.isShooting(projectile1);
  }
  
  //enhanced for loop for boss array
  for(BossProjectile BossProjectile1 : bossList){
    bossShoot.renderArt(BossProjectile1.x-30, BossProjectile1.y-30);
    bossShoot.isAnimating = true;
    BossProjectile1.moveBossBullet();
    BossProjectile1.resetBounds();
    
    p1.isHitFireball(BossProjectile1);
  }
  
  //for loop for enemy array
  for(Enemy enemy1 : enemyList){
   enemiesMove.renderArt(enemy1.eX-15, enemy1.eY-3);
   enemiesMove.isAnimating = true;
   enemy1.moveEnemy(p1);
   enemy1.isTouching(p1); //checks if player touches enemy
   enemy1.resetEnemyBounds();
 }
  
  //removes enemies hit with bullets
  for(int i=enemyList.size()-1; i>=0; i--){
   if(enemyList.get(i).isDead==true){
    enemyList.remove(i); 
   }
  }
  
  //removes projectiles that leave the screen
  for(int i = projectileList.size()-1; i>=0; i--){
   if(projectileList.get(i).isDestroyed==true){
     projectileList.remove(i);
     
     enemiesHit.play();
   }
  }
  
  //enemy spawn timer vars
  eEndTime=millis();
  
  if(eEndTime-eStartTime>=eInterval){
    println("Reinforcements Incoming");
    
    eStartTime=millis();
    
    spawn.play();
   
   //spawn three enemies
   //YOU CAN ADD MORE ENEMIES HERE BY ADDING MORE LINES OF THIS CODE
    enemyList.add(new Enemy(int(random(0,width)),int(random(0,height/2))));
    enemyList.add(new Enemy(int(random(0,width)),int(random(0,height/2))));
    enemyList.add(new Enemy(int(random(0,width)),int(random(0,height/2))));
    enemyList.add(new Enemy(int(random(0,width)),int(random(0,height/2))));
    enemyList.add(new Enemy(int(random(0,width)),int(random(0,height/2))));
 }
 
 //boss timer vars
 bEndTime=millis();
 
 if(bEndTime-bStartTime>=bInterval){
   
   bossAttack.play();
   
   //spawn a lot of boss projectiles
   //YOU CAN ADD MORE PROJECTILES BY ADDING MORE LINES OF THIS CODE
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    bossList.add(new BossProjectile((b1.bX + b1.w/2), (b1.bY + b1.h/2), 25));
    println("boss shot");
    bStartTime=millis();
 }
 
 //roll timer vars
 rEndTime = millis();
 
 if(p1.canRoll == false){
  if(rEndTime-rStartTime>=rInterval){  
   p1.canRoll = true;
  }
 }
 
 if(!bossSong.isPlaying()){
    bossSong.play();
  }
 
 break;
 
 //win screen
 case 3:
 
 
 
 if(shouldPlayWin == true){
   winSound.play();
   
   shouldPlayWin = false;
 }
 
  bossSong.stop();
  spawn.stop();
  playerShooting.stop();
  playerRolling.stop();
  bossAttack.stop();
  enemiesHit.stop();
        
 background(0);
 
 image(winScreenImage, (width/2-winScreenImage.width*2/2), (height/2-winScreenImage.height*2/2), winScreenImage.width*2, winScreenImage.height*2);
 
 fill(255);
 textFont(font, 25);
 text("press 'b' to restart", 457, 600);
 text("press 'k' to exit", 475, 640);
    
 break;
 
 //lose screen
 case 4:
 
 if(shouldPlayDeath == true){
  loseSound.play(); 
  
  shouldPlayDeath = false;
 }
 
  bossSong.stop();
  spawn.stop();
  playerShooting.stop();
  playerRolling.stop();
  bossAttack.stop();
  enemiesHit.stop();
   
 background(0);
 
 image(loseScreenImage, (width/2-loseScreenImage.width*2/2), (height/2-loseScreenImage.height*2/2), loseScreenImage.width*2, loseScreenImage.height*2);
 
 fill(255);
 textFont(font, 25);
 text("press 'b' to restart", 457, 600);
 text("press 'k' to exit", 475, 640);
 
 break;
  }
  
  if(b1.bossHealth<=0){
    state = 3;
  } 
  
  if(p1.isPlayerDead == true){
   state = 4; 
  }
}

void keyPressed(){
  if(key == 'a'){
   p1.movingLeft = true; 
   p1.wallDetect();
  }
  
   if(key == 'A'){
   projectileList.add(new Projectile((p1.pX+p1.pW/2), (p1.pY+p1.pH/2), 10, 10));
   for(Projectile projectile1 : projectileList){
   projectile1.shootDown = false;
   projectile1.shootRight = false;
   projectile1.shootLeft = true;
   projectile1.shootUp = false;
  }
  
  playerShoot.isAnimating = true;
  
  if(playerShooting.isPlaying()){
    playerShooting.stop(); 
   }
   //play sound file
   playerShooting.play();
 }
  
  if(key == 'd'){
   p1.movingRight = true; 
   p1.wallDetect();
  }
  
   if(key == 'D'){
   projectileList.add(new Projectile((p1.pX+p1.pW/2), (p1.pY+p1.pH/2), 10 , 10));
   for(Projectile projectile1 : projectileList){
   projectile1.shootDown = false;
   projectile1.shootRight = true;
   projectile1.shootLeft = false;
   projectile1.shootUp = false;
  }
  
  playerShoot.isAnimating = true;
  
  if(playerShooting.isPlaying()){
    playerShooting.stop(); 
   }
   //play sound file
   playerShooting.play();
 }
  
  if(key == 'w'){
   p1.movingUp = true;
   p1.wallDetect();
  }
  
   if(key == 'W'){
   projectileList.add(new Projectile((p1.pX+p1.pW/2), (p1.pY+p1.pH/2), 10, 10));
   for(Projectile projectile1 : projectileList){
   projectile1.shootDown = false;
   projectile1.shootRight = false;
   projectile1.shootLeft = false;
   projectile1.shootUp = true;
   }
   
   playerShoot.isAnimating = true;
   
   if(playerShooting.isPlaying()){
    playerShooting.stop(); 
   }
   //play sound file
   playerShooting.play();
  }
  
  if(key == 's'){
   p1.movingDown = true; 
   p1.wallDetect();
 }
  
  if(key == 'S'){
   projectileList.add(new Projectile((p1.pX+p1.pW/2), (p1.pY+p1.pH/2), 10, 10));
   for(Projectile projectile1 : projectileList){
   projectile1.shootDown = true;
   projectile1.shootRight = false;
   projectile1.shootLeft = false;
   projectile1.shootUp = false;
  }
  
  playerShoot.isAnimating = true;
  
  if(playerShooting.isPlaying()){
    playerShooting.stop(); 
   }
   //play sound file
   playerShooting.play();
 }
 
 if(key == 'k'){
  state = 0; 
  b1.bossHealth = 50;
  p1.isPlayerDead = false;
  bossSong.stop();
  spawn.stop();
  playerShooting.stop();
  playerRolling.stop();
  bossAttack.stop();
  enemiesHit.stop();
  fire.stop();
  
  if(loseSound.isPlaying()){
  loseSound.stop();
  }
  
  if(winSound.isPlaying()){
  winSound.stop();
  }
  
  
 }
 
 if(key == 'g'){
   state = 1;
 }
 
 if(key == 'b'){
  state = 2; 
  
  if(loseSound.isPlaying()){
   loseSound.stop();
  }
  
  if(winSound.isPlaying()){
   winSound.stop(); 
  }
  
  if(bossSong.isPlaying()){
   bossSong.stop();
  }
  
  shouldPlayDeath = true;
  shouldPlayWin = true;
  
  bossSong.play();
  
  eStartTime = millis();
  
  bStartTime = millis();
  
    b1.bX=width/2-b1.w/2;
    b1.bY=25;
    b1.topBound=b1.bY;
    b1.bottomBound=b1.bY+b1.h;
    b1.leftBound=b1.bX;
    b1.rightBound=b1.bX+b1.w;
    b1.bossHealth = 50;
        
    p1.pW=25;
    p1.pH = 25;
    p1.pX=width/2-(p1.pW/2);
    p1.pY=height/2+200;
    p1.c=color(0,255,255);
    p1.runSpeed=5;
    p1.rollSpeed=15;
    p1.topBound=p1.pY;
    p1.bottomBound=p1.pY+p1.pH;
    p1.leftBound=p1.pX;
    p1.rightBound=p1.pX+p1.pW;
    p1.movingLeft=false;
    p1.movingRight=false;
    p1.movingUp=false;
    p1.movingDown=false;  
    rInterval=1000;
    p1.isPlayerDead = false;
    p1.isShooting = false;

   for(int i=enemyList.size()-1; i>=0; i--){
    enemyList.remove(i); 
  }
  
  for(Enemy enemy1 : enemyList){
   enemy1.enemyHealth = 1;
 }
  
  for(int i = bossList.size()-1; i>=0; i--){
     bossList.remove(i);
  }
  
  for(int i = projectileList.size()-1; i>=0; i--){
     projectileList.remove(i);
  }
  
  if(!bossSong.isPlaying()){
    bossSong.play();
  }
  
 } 
 
 if(key == ' '){
   p1.isRolling = true;
   
   playerRolling.play();
   
   playerRoll.isAnimating = true;
 }
}

void keyReleased(){
  if(key == 'a'){
   p1.movingLeft = false; 
  }
  
  if(key == 'd'){
    p1.movingRight = false;
  }
  
  if(key == 'w'){
   p1.movingUp = false;
  }
  
  if(key=='s'){
   p1.movingDown=false; 
  }
  
  if(key == ' '){  
    
    p1.canRoll = false;
    
    rStartTime = millis();
    
    playerRoll.isAnimating = false;
  }
}
