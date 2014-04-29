class MovingImage extends Displayable {
  PImage img;
  PVector location;
  PVector velocity;
  
  MovingImage(PImage img_, PVector location_, PVector velocity_) {
    img = img_;
    location = location_;
    velocity = velocity_;
  }
  
  void update() {
    location.add(velocity);
    
    if (location.x < -img.width / 2) {
      location.x = width + img.width / 2;
    }

    if (location.y < -img.height / 2) {
      location.y = height + img.height / 2;
    }

    if (location.x > width + img.width / 2) {
      location.x = -img.width / 2;
    }

    if (location.y > height + img.height / 2) {
      location.y = -img.height / 2;
    }
  }
  
  void display() {
    imageMode(CENTER);
    image(img, location.x, location.y);
    imageMode(CORNER);
  }
}
