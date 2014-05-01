class Mirror extends Displayable {
  void display() {
    int halfWidth = width / 2;
    int wMinus1 = height - 1;
    
    loadPixels();
    for (int i = 0; i < halfWidth; i++) {
      for (int j = 0; j < height; j++) {
        int offset = j * width;
        pixels[wMinus1 - i + offset] = pixels[i + offset];
      }
    }
    updatePixels();    
  }
}
