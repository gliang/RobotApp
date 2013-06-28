

public class RechargeStation extends MovingObject {
//  public static final int    WIDTH = 25;
//  public static final int    HEIGHT = 25;

  private Robot  chargingRobot;
  
  // Constructor
  public RechargeStation(int xLoc, int yLoc) {
    ICON_WIDTH = 30;
    ICON_HEIGHT = 30;
    xLocation = xLoc - ICON_WIDTH / 2;
    yLocation = yLoc - ICON_HEIGHT / 2;
    chargingRobot = null;
    speed = 0;
  }

  // Usual get methods
  public int getXLocation() { return xLocation; }
  public int getYLocation() { return yLocation; }
  public boolean isOccupied() { return chargingRobot != null; }
  public Robot getChargingRobot() { return chargingRobot; }

  // Set methods.
  public void setXLocation(int xLoc) { xLocation = xLoc; }
  public void setYLocation(int yLoc) { yLocation = yLoc; }
  public void setChargingRobot(Robot r) { chargingRobot = r; }
  
  // Draw the station
  public void draw( ) {
    
  }
  
  public void drawStation() {
    //LIGHT_GRAY
    color inside = color(100, 100, 100);
    // BLACK
    color outside = color(0, 0, 0);
    stroke(outside);
    fill(inside);
    rect(xLocation, yLocation, ICON_WIDTH, ICON_HEIGHT);
  }
  
  public void update() {
    if (chargingRobot != null)
      if (chargingRobot.rechargeBattery())
        chargingRobot = null;
  }
      
}
