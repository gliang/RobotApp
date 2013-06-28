 
class Robot extends MovingObject {
 
 float batteryLife;
 boolean recharging;
 boolean needFlash;
 boolean isRecharging;
 
 
 Robot(int xLoc, int yLoc) {
  xLocation = xLoc + RADIUS;
  yLocation = yLoc + RADIUS;
  
  direction = 0;
  desiredDirection = 0;
  speed = 3;
  batteryLife = 1.0f;
  recharging = false;
  needFlash = false;
  RADIUS = 13;
  TURN_UNIT = 10;
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
      speed = (int)(RADIUS * 4 * (batteryLife / 1.0f));
    }
  }
  
  float getBatteryLife() { return batteryLife; }
  boolean hasLowBattery() { return batteryLife < 0.25f; }
  boolean hasDeadBattery() { return batteryLife <= 0f; }
  
  void setRecharging(boolean isRecharging) {
    this.isRecharging = isRecharging;
  }
  
  boolean rechargeBattery()
  {
    batteryLife += CHARGE_AMOUNT;
    setRecharging(true);
    if (batteryLife >= 1.0f)
    {
      speed = RADIUS;
      setRecharging(false);
      return true;
    }
    else
      return false;
  }
  
  public void drawOnce( List<MovingObject> allObjects ) {
    makeMoveIn(allObjects);
    //CYAN
    color inside = color(0,255,255);
    // BLACK
    color outside = color(0, 0, 0);
    stroke(outside);
    fill(inside);
    ellipse(xLocation, yLocation, RADIUS*2, RADIUS*2);
    fill(outside);
    line(xLocation, yLocation, 
        (int)(xLocation + RADIUS * cos(direction * 3.14 / 180.0)),
        (int)(yLocation - RADIUS * sin(direction * 3.14 / 180.0)) );
  }
  
  public void setSpeed(int s) {
     speed = s;
  }
  
}
