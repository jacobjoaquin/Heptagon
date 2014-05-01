class PHSB {
  public Palette palette;
  float h;          // Hue from palette
  float s;          // Saturation
  float b;          // Brightness
  float a;          // Alpha
  
  void setPalette(Palette palette_) {
    palette = palette_;
  }
  
  color get(float f) {
    color thisColor = palette.get(f);
    return thisColor;
  }
}

public abstract class Palette {
  protected ArrayList<Integer> colors;
  int nColors = 0;
  
  Palette() {
    colors = new ArrayList<Integer>();
  }

  color get(float h) {
    println(h);
    if (nColors >= 1) {
      
      if (h >= 1.0) {
        h = h - floor(h);
      }
      
      h *= nColors;
      
      int index0 = floor(h);
      int index1 = ceil(h) % nColors;
      color c0 = colors.get(index0);
      color c1 = colors.get(index1);
      return lerpColor(c0, c1, h - floor(h));
    }
    
    return (color(0));
  }  

  void add(color c) {
    colors.add(c);
    update();
  }
  
  void update() {
    nColors = colors.size();
  }
}

class Palette_HSB extends Palette {
  Palette_HSB() {
    super();
    add(color(255, 0, 0));
    add(color(255, 255, 0));
    add(color(0, 255, 0));
    add(color(0, 255, 255));
    add(color(0, 0, 255));
    add(color(255, 0, 255));
  }
}

class Palette_foo extends Palette {
  Palette_foo() {
    super();
    add(color(255, 128, 0));
    add(color(0, 0, 255));
  }
}
