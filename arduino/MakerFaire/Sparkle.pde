class Sparkle extends Filter {
  int nDots = 1000;
  float threshold = 1.0;

  void display() {
    PGraphics pgBackground = stackPG.get();    
    PGraphics pg = stackPG.push(width, height);
    pgBackground.loadPixels();
    loadPixels();
    for (int i = 0; i < nDots; i++) {
      int r = (int) random(width * height);
      if (threshold < brightness(pgBackground.pixels[r])) {
        pixels[r] = color(255);
      } 
    }
    updatePixels();
    stackPG.pop(BLEND);
  }
}

