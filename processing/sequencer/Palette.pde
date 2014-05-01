public abstract class Palette {
  protected ArrayList<Integer> colors;
  int nColors = 0;
  
  Palette() {
    colors = new ArrayList<Integer>();
  }

  color get(float h) {
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