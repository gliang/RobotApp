
public abstract class MovingObject {
  
 int RADIUS = 10;
 int SQUARE_OF_RADIUS = RADIUS * RADIUS;
 Integer ICON_WIDTH;
 Integer ICON_HEIGHT;
 int TURN_UNIT = 15;
 int CW = -1;
 int CCW = 1;
 
 int speed;
 int xLocation;
 int yLocation;
 int direction;
 int desiredDirection;
 
 float COLLISION_COST = 0.0025f; 
 float FORWARD_COST = 0.0005f; 
 float TURN_COST = 0.00005f;
 float CHARGE_AMOUNT = 0.005f;
 

 
 void turn(int degrees) { 
    direction = direction + degrees; 
    if (direction > 180) direction -= 360;
    if (direction <= -180) direction += 360;
    
  }
  
  public void turnTowards(int desiredDirection) {
    int turnDirection=0;
    
    if (desiredDirection == direction) return;
    
    // Adjust direction to ensure within range -180 to 180 degrees
    if (desiredDirection > 180)
      desiredDirection -= 360;
    if (desiredDirection <= -180)
      desiredDirection += 360;

    // Now decide which way to turn
    if ((desiredDirection>=0) && (direction>=0))
      if (desiredDirection < direction)
        turnDirection = CW;
      else 
        turnDirection = CCW;
    else if ((desiredDirection<0) && (direction<0))
        if (desiredDirection < direction)
          turnDirection = CW;
        else 
          turnDirection = CCW;
    else if ((desiredDirection<0) && (direction>=0))
        if (direction - desiredDirection < 180)
          turnDirection = CW;
        else 
          turnDirection = CCW;
    else if ((desiredDirection>=0) && (direction<0))
        if (desiredDirection - direction < 180)
          turnDirection = CCW;
        else 
          turnDirection = CW;
          
    // Now make the turn
    turn(TURN_UNIT*turnDirection);
  }
  
  // Compute a direction in which to head
  int computeDesiredDirection() {
    if ((abs(direction-desiredDirection) < TURN_UNIT) || 
          (abs(direction+desiredDirection) < TURN_UNIT)) 
           return computeRandomDirectionChange(); 
       else 
      return desiredDirection; 

  }
  
  int computeRandomDirectionChange() {
    int amount;
    if (random(0, 1) > 0.67) {      //the probabilities of 1/3
      amount = (int)((Math.random() * 10) % (90 / TURN_UNIT));
      if (random(0, 1) > 0.5)
        desiredDirection = direction - TURN_UNIT * amount;
      else
        desiredDirection = direction + TURN_UNIT * amount;
        
      if (desiredDirection > 180) desiredDirection -= 360; 
      if (desiredDirection <= -180) desiredDirection += 360;
      return desiredDirection;
    }
    else 
      return desiredDirection;
  }
  
  // Make a Move 
  void makeMoveIn(List<MovingObject> allObjects) {
    // Turn the robot in an appropriate direction
    //Point target = findTarget(world);
    turnTowards(computeDesiredDirection());
    
    int newX = (int)(xLocation + speed * (cos(direction * 3.14 / 180.0)));
    int newY = (int)(yLocation - speed * (sin(direction * 3.14 / 180.0)));
    
    if (checkForCollision(newX, newY, allObjects)) {
      desiredDirection = direction - 90;
      //reduceBatteryLifeBy(COLLISION_COST); //collision
    } else {
      xLocation = newX;
      yLocation = newY;
      //reduceBatteryLifeBy(FORWARD_COST);  //move forward
    }

  }
  
  boolean checkForCollision(int x, int y, List<MovingObject> allObjects) {
    int iconWidth = RADIUS;
    int iconHeight = RADIUS;
    int r = RADIUS;
    if ( ICON_WIDTH != null && ICON_HEIGHT != null ) {
        iconWidth = ICON_WIDTH;
        iconHeight = ICON_HEIGHT;
        r = 0;
    }
    if ( (x + iconWidth) > 600 || (x - r) < 0 ||
        (y + iconHeight) > 600 || (y - r) < 0 ) {
           return true;
        } 
    else {
      for (MovingObject object: allObjects) {
         if ( object != this ) {
            if ( ICON_WIDTH == null && object.ICON_WIDTH == null ) {
              // this is circle, object is circle
              if ( dist(x, y, object.xLocation, object.yLocation) <= (RADIUS + object.RADIUS)) {
                 return true; 
              }
            } else if (ICON_WIDTH != null && object.ICON_WIDTH != null) {
              // this is square, object is square
              if ( x < (object.xLocation + object.ICON_WIDTH) &&
                   (x + ICON_WIDTH) > object.xLocation &&
                   y < (object.yLocation + object.ICON_HEIGHT) &&
                   (y + ICON_HEIGHT) > object.yLocation ) {
                     return true;
                   }
            } else if (ICON_WIDTH == null && object.ICON_WIDTH != null) {
              // this is circle(Robot), object is square(Dirt or Recharge Station)
              int xDist = abs((object.xLocation + object.ICON_WIDTH/2) - x);
              int yDist = abs((object.yLocation + object.ICON_HEIGHT/2) - y);
              if ( xDist <= (object.ICON_WIDTH/2 + RADIUS) && yDist <= (object.ICON_HEIGHT/2 + RADIUS)) {
                if ( object instanceof Dirt) {
                  // robot 'removes' the dirt
                  allObjects.remove(object);
                  return false;
                } else {
                  return true;
                }
              }
            } else if (ICON_WIDTH != null && object.ICON_WIDTH == null) {
              // this is square, object is cicle
              int xDist = abs((x + iconWidth/2) - object.xLocation);
              int yDist = abs((y + iconHeight/2) - object.yLocation);
              if ( xDist <= iconWidth/2 || yDist <= iconHeight/2) {
                return true;
              }
            }
         } 
      }
      return false;
        }
 }
 void drawOnce(List<MovingObject> allObjects) {
   // to be overrided 
 }
}


