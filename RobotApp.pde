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
  basement.toRemoveDirt();
  basement.toAddDirt();

  for (MovingObject mo: basement.getAllObjects()) {
    mo.drawOnce();
  }
}

void mousePressed()
{
  Dirt dirt = new Dirt(mouseX, mouseY);
  dirt.putIn(basement);
  basement.getToAddObjects().add(dirt);
  basement.pickupRobot(mouseX, mouseY);
}

void mouseDragged() {
  basement.dragRobot(mouseX, mouseY);
}

void mouseReleased() {
  basement.putDownRobot(mouseX, mouseY);
}
