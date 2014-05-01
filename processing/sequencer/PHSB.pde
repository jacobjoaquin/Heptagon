class PHSB {
  public Palette palette;
  
  void setPalette(Palette palette_) {
    palette = palette_;
  }
  
  color get(float f) {
    color thisColor = palette.get(f);
    return thisColor;
  }
}
