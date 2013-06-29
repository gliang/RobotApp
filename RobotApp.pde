import java.util.List;
import java.util.ArrayList;


Maxim maxim;
Basement basement;

void setup() {
  size(600, 600);
  maxim = new Maxim(this);
  basement = new Basement(maxim);
  
}

void draw()
{
  // display the cat
  background(255);
  //cat.drawOnce( allObjects );
  //robot.drawOnce( allObjects );
  
  //rechargeStation.drawOnce( );
  basement.toRemoveDirt();
  basement.toAddDirt();
  for (MovingObject mo: basement.getAllObjects()) {
    mo.drawOnce();
  }
}

void mousePressed()
{
  /**
  float distance = dist(pmouseX, pmouseY, mouseX, mouseY);
  int speed = int(map(distance, 0, 10, 1, 5));
  robot.setSpeed(speed);
  */
  Dirt dirt = new Dirt(mouseX, mouseY);
  basement.getToAddObjects().add(dirt);
  
}
