 
class Robot extends MovingObject {
 
 float batteryLife;
 boolean recharging;
 boolean needFlash;
 boolean isRecharging;
 
 int flashCounter;
 
 boolean isPicked;
 
 
 Robot(int xLoc, int yLoc) {
  xLocation = xLoc + RADIUS;
  yLocation = yLoc + RADIUS;
  
  direction = 0;
  desiredDirection = 0;
  speed = 3f;
  batteryLife = 1.0f;
  recharging = false;
  needFlash = false;
  RADIUS = 13;
  TURN_UNIT = 20;
  flashCounter = 0;
  isPicked = false;
 }
 
 @Override
 public void turn(int degrees) {
   super.turn(degrees);
   reduceBatteryLifeBy(TURN_COST);
 } 
 
 void reduceBatteryLifeBy(float amount)
  {
    batteryLife -= amount;
    if (hasLowBattery())
    {
      speed = (speed * (batteryLife / 1.0f));
    }
  }
  
  float getBatteryLife() { return batteryLife; }
  boolean hasLowBattery() { return batteryLife < 0.3f; }
  boolean hasDeadBattery() { return batteryLife <= 0f; }
  
  public void pickUp() {isPicked = true;}
  public void putDown() {isPicked = false;}
  public boolean isPicked() {return isPicked;}
  
  void setRecharging(boolean isRecharging) {
    this.isRecharging = isRecharging;
  }
  
  boolean rechargeBattery()
  {
    batteryLife += CHARGE_AMOUNT;
    setRecharging(true);
    if (batteryLife >= 1.0f)
    {
      speed = 3f;
      setRecharging(false);
      return true;
    }
    else
      return false;
  }
  
  public void drawOnce( ) {
    
      //CYAN
      color insideCyan = color(0,255,255);
      //RED
      color insideRed = color(255,0,0);
      //GREEN
      color insideGreen = color(0, 255, 100);
      // BLACK
      color outside = color(0, 0, 0);
      stroke(outside);
    if ( hasDeadBattery() ) {
      fill(insideRed);
      
    } else if (isRecharging) {
       rechargeBattery();
       if ( flashCounter <= 1 ) {
          fill(insideGreen);
          flashCounter++;
       } else {
          flashCounter = 0;
          fill(insideCyan);
       }
    }
      else {
      if ( !isPicked && !isRecharging) {
        // robot is not picked, so can move
        makeMoveIn();
        reduceBatteryLifeBy(FORWARD_COST);
      }
      if ( hasLowBattery() && (flashCounter <= 1) ) {
        fill(insideRed);
        flashCounter++;
      } else {
        flashCounter=0;
        fill(insideCyan);
      }
    }
    ellipse(xLocation, yLocation, RADIUS*2, RADIUS*2);
    fill(outside);
    line(xLocation, yLocation, 
        (int)(xLocation + RADIUS * cos(direction * 3.14 / 180.0)),
        (int)(yLocation - RADIUS * sin(direction * 3.14 / 180.0)) );
  }
  
  public void setSpeed(int s) {
     speed = s;
  }
  
  public Boolean robotAt(int x, int y) {
     // distance of location (x,y) and robot current locatin(xLocation, yLocation)
     return sq(x - xLocation) + sq(y - yLocation) <= sq(RADIUS);
  }
  
  public void beingDrag(int x, int y) {
     xLocation = x;
     yLocation = y; 
  }
  
}
