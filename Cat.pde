

public class Cat extends MovingObject {
 PImage icon;
 PImage [] images;
 private final int CAT_STOP = 5;
 
 private float currentFrame;
 
 AudioPlayer player;
 
 float speedAdjust;
 
 int timeCounter;
 
 
 public Cat(AudioPlayer p) {
   xLocation = 100;
   yLocation = 100;
  
   direction = 0;
   desiredDirection = 0;
   speed = 5;
  
   icon = loadImage("images/cat/cat1.png");
   
   images = loadImages("images/cat/cat", ".png", 5);
   currentFrame = 0;
   speedAdjust=0.02;
   TURN_UNIT = 15;
   
   timeCounter = 0;
   ICON_WIDTH = 58;
   ICON_HEIGHT = 75;
   
   player = p;
   player.setLooping(false);
   player.volume(1.0);
 }
 
 void draw() {

   
 }
 
 public int getXLoc() {
    return xLocation; 
 }
 public int getYLoc() {
    return yLocation; 
 }
 
 public void drawOnce() {
   if ( timeCounter > 0 && timeCounter < 250) {
     image(images[(int)currentFrame], xLocation, yLocation);
     currentFrame = currentFrame+1*speedAdjust;
     if(currentFrame >= images.length)
     {
        currentFrame = 0;
     }
     ++timeCounter;
   } else {
     timeCounter = 0;
     int ranNum = int(map(random(10), 0, 10, 0, 1000));
     //println("ranNum: " + ranNum);
     // the cat will randomly stop
     if (ranNum >= CAT_STOP) {
       makeMoveIn();
       image(icon, xLocation, yLocation);
     } else {
       timeCounter = 1;
       player.play();
     }
   }
 }
}
