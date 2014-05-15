class PHSB {
  public Palette palette;
  Phasor offset = new Phasor(-0.01);

  void setPalette(Palette palette_) {
    palette = palette_;
  }

  color get(float f) {
    color thisColor = palette.get(f);
    return thisColor;
  }

  void fillScreen() {
  	for (int i = 0; i < height; i++ ) {
		float thisOffset = norm(i, 0, height);
		thisOffset += offset.phase;
		thisOffset -= (int) thisOffset;

  		pushStyle();
  		stroke(get(thisOffset));
  		line(0, i, width, i);
  		popStyle();
  	}
  }

  void update() {
  	offset.update();
  }
}
