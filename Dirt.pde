

public class Dirt extends MovingObject {
  
  public Dirt(int xLoc, int yLoc) {
    ICON_WIDTH = 10;
    ICON_HEIGHT = 5;
    xLocation = xLoc - ICON_WIDTH / 2;
    yLocation = yLoc - ICON_HEIGHT / 2;
    speed = 0;
  }
  
  public void drawOnce() {

    // BLACK
    color outside = color(0, 0, 0);
    fill(outside);
    rect(xLocation, yLocation, ICON_WIDTH, ICON_HEIGHT);
  }
}
