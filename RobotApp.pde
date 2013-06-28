import java.util.List;
import java.util.ArrayList;

Cat cat;
RechargeStation rechargeStation;
Robot robot;

 Maxim maxim;
 AudioPlayer catPlayer;

List<MovingObject> allObjects;

void setup() {
  size(600, 600);
  maxim = new Maxim(this);
  catPlayer = maxim.loadFile("sound/cat.wav");
  
  cat = new Cat(catPlayer);
  rechargeStation = new RechargeStation(width/2,height/2);
  robot = new Robot(400, 500);
  background(255);
  allObjects = new ArrayList<MovingObject>();
  allObjects.add(cat);
  allObjects.add(rechargeStation);
  allObjects.add(robot);
  
  
}

void draw()
{
  // display the cat
  background(255);
  cat.drawOnce( allObjects );
  robot.drawOnce( allObjects );
//  println("Cat X position: " + cat.getXLoc());
//  println("Cat Y position: " + cat.getYLoc());
  
  rechargeStation.drawStation( );
}

void mouseReleased()
{
  /**
  float distance = dist(pmouseX, pmouseY, mouseX, mouseY);
  int speed = int(map(distance, 0, 10, 1, 5));
  robot.setSpeed(speed);
  */
}