class RainDots extends Displayable {
  ArrayList<RainDot> dots;
  
  RainDots(int nDots) {
    dots = new ArrayList<RainDot>();
    for (int i = 0; i < nDots; i++) {
      RainDot dot = new RainDot();
      dots.add(dot);
    }
  }
  
  void display() {
    for (RainDot dot : dots) {
      dot.display();
    }
  }
  
  void update() {
    for (RainDot dot : dots) {
      dot.update();
    }
  } 
}

class RainDot {
  PVector location = new PVector(random(width), random(-height, height));
  PVector velocity = new PVector(0, random(0.1));
  float g = 0.01;
  PVector gravity = new PVector(0, random(g, g * 2));
  PImage img;
  float size = 0.8;
  
  RainDot() {
//      img = loadImage("dot" + (int) random(8) + ".tif");
      img = loadImage("dot7.tif");
  }
  
  void update() {
    location.add(velocity);
    velocity.add(gravity);
    if (location.y >= img.height * 1.5) {
      location.x = random(width);
      location.y = -img.height;
      velocity.y = 0;
    }
  }
  
  void display() {
    imageMode(CENTER);
    image(img, location.x, location.y, img.width * 0.25, img.height * 0.25); 
  }
}
