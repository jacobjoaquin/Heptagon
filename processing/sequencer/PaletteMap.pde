class PaletteMap {
	ArrayList<Palette> map;

	PaletteMap() {

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

class Palette_BWGW extends Palette {
  Palette_BWGW() {
    super();
    add(color(0, 0, 255));
    add(color(0));
    add(color(0));
    add(color(255));
    add(color(0));
    add(color(0));
    add(color(0, 255, 0));
    add(color(0));
    add(color(0));
    add(color(255));
    add(color(0));
    add(color(0));
  }
}