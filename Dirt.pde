

public class Dirt extends MovingObject {
  
  public Dirt(int xLoc, int yLoc) {
    ICON_WIDTH = 10;
    ICON_HEIGHT = 5;
    xLocation = xLoc - ICON_WIDTH / 2;
    yLocation = yLoc - ICON_HEIGHT / 2;
    speed = 0;
  }
  
  public void drawOnce(List<MovingObject> allObjects) {
//    //LIGHT_GRAY
//    color inside = color(100, 100, 100);
    // BLACK
    color outside = color(0, 0, 0);
    //stroke(outside);
    fill(outside);
    rect(xLocation, yLocation, ICON_WIDTH, ICON_HEIGHT);
  }
}
