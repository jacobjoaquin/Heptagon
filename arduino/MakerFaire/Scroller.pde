class Scroller extends Displayable {
  String s = "ARDUINO FOCUS GROUP @ FRESNO IDEAWORKS";
  int yOffset = 70;
  float textWidth = 2000;
  int textX = width;  
  color textColor = 0;

  void update() {
    textColor += 3;
    if (textColor >= 255) {
      textColor = 0;
    }
    textX -= 1;
    if (textX < -textWidth) {
      textX = width;
    }  
  }
  
  void display() {
    pushStyle();
    textSize(84);  
    colorMode(HSB);
    fill(textColor, 255, 255);
    text(s, textX, yOffset);
    text(s, textX + 1, yOffset);
    text(s, textX + 2, yOffset);  
    popStyle();
  }
}
