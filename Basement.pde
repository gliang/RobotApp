

public class Basement {
  
 Cat cat;
 RechargeStation rechargeStation;
 Robot robot;
 Dirt dirt;

 Maxim maxim;
 AudioPlayer catPlayer;
 AudioPlayer backgroundPlayer;
 
 List<MovingObject> allObjects;
 List<MovingObject> toRemoveObjects;
 List<MovingObject> toAddObjects;
 
 // TODO: Should implement an Interface, so that moving objects can be put in different place :)
 public Basement(Maxim m) {
   
   maxim = m;
   catPlayer = maxim.loadFile("sound/cat.wav");
   backgroundPlayer = maxim.loadFile("sound/FreedomDance.wav");
   backgroundPlayer.setLooping(true);
   backgroundPlayer.volume(0.8);
   backgroundPlayer.play();
  
   cat = new Cat(catPlayer);
   cat.putIn(this);
   rechargeStation = new RechargeStation(300,300);
   rechargeStation.putIn(this);
   robot = new Robot(400, 500);
   robot.putIn(this);
   dirt = new Dirt(200, 200);
   dirt.putIn(this);
   
   allObjects = new ArrayList<MovingObject>();
   toRemoveObjects = new ArrayList<MovingObject>();
   toAddObjects = new ArrayList<MovingObject>();
   
   allObjects.add(cat);
   allObjects.add(rechargeStation);
   allObjects.add(robot);
   allObjects.add(dirt);
  
   Dirt dirt2 = new Dirt(100, 200);
   dirt2.putIn(this);
   Dirt dirt3 = new Dirt(50, 100);
   dirt3.putIn(this);
   Dirt dirt4 = new Dirt(400, 300);
   dirt4.putIn(this);
   Dirt dirt5 = new Dirt(500, 400);
   dirt5.putIn(this);
  
   allObjects.add(dirt2);
   allObjects.add(dirt3);
   allObjects.add(dirt4);
   allObjects.add(dirt5);
 }
 
 public List<MovingObject> getAllObjects() {
   return allObjects; 
 }
 
 public void setAllObjects(List<MovingObject> objects) {
    allObjects = objects;
 }
 
 public List<MovingObject> getToRemoveObjects() {
   return toRemoveObjects; 
 }
 
 public List<MovingObject> getToAddObjects() {
   return toAddObjects;
 }
 
 public void toRemoveDirt() {
   if ( allObjects != null ) {
     allObjects.removeAll(toRemoveObjects);
     toRemoveObjects = new ArrayList<MovingObject>();
   }
 }
 
 public void toAddDirt() {
   if ( allObjects != null ) {
     // make sure new dirt cannot be added to existing moving objects
     for (MovingObject mo: toAddObjects) {
        if ( !mo.checkForCollision(mo.xLocation, mo.yLocation)) {
           allObjects.add(mo);
        } 
     }
     toAddObjects = new ArrayList<MovingObject>();
   }
 }
 
 public void pickupRobot(int x, int y) {
    if (robot.robotAt(x, y) && robot.hasDeadBattery() ) {
         robot.pickUp();
    } 
 }
 
 public void dragRobot(int x, int y) {
   if ( robot.isPicked() ) {
     robot.beingDrag(x,y);
   }
 }
 
 public void putDownRobot(int x, int y) {
   if (robot.isPicked() ) {
     robot.putDown();
      int xDist = abs((rechargeStation.xLocation + rechargeStation.ICON_WIDTH/2) - x);
      int yDist = abs((rechargeStation.yLocation + rechargeStation.ICON_HEIGHT/2) - y);
      if ( xDist <= (rechargeStation.ICON_WIDTH/2 + RADIUS) && yDist <= (rechargeStation.ICON_HEIGHT/2 + RADIUS)) {
        robot.setRecharging(true);
        robot.rechargeBattery();
      }
   }
 }
  
}
