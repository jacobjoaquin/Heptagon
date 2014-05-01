PImage makeDot(float size, float blurAmount, color c) {
  int pgSize = (int) ceil(size) * 2;
  PGraphics pg = stackpg.push(pgSize, pgSize);
  PVector center = new PVector(width / 2, height / 2);
  float ratio = size / 100.0;
  float step = size / 3;
  blurAmount *= ratio;
  color c2 = color(255);
    
  background(0);
  for (float i = size; i >= 1; i -= step) {
    float n = pow(i / size, 2);
    color thisColor = lerpColor(c, c2, 1 - n);
    stackpg.push();
    smooth();
    noStroke();
    fill(thisColor);
    ellipse(center.x, center.y, i, i);
    stackpg.pop(BLEND);
    filter(BLUR, blurAmount);
  }

  // Get edge
  loadPixels();
  int y = (height / 2) * width;
  int l0 = 0;
  int l1 = width / 2;
  int l3 = 0;
  int counter = 100;
  int p = 255;
  
  while(l1 - l0 > 1 || p > 1) {
    l3 = (l1 - l0 ) / 2 + l0;    
    p = (int) brightness(pixels[l3 + y]);
    if (p <= 1) {
      l0 = l3;
    }
    else {
      l1 = l3;
    }
  }
  updatePixels();
  stackpg.pop();

  // Generate and return cropped image  
  int imgSize = (int) ((center.x - l3) * 2);
  PImage img = createImage(imgSize, imgSize, ARGB);
  img.copy(pg, l3, l3, imgSize, imgSize, 0, 0, imgSize, imgSize);
  return img;
}

