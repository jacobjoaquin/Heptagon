import moonpaper.*;
import moonpaper.opcodes.*;

MyOPC opc;
Moonpaper mp;
StackPGraphics stackpg;
PGraphics img;
Phasor phasor = new Phasor(1 / 255.0);
PHSB phsb = new PHSB();

CsoundSynth cs;
PhoneSynth phoneSynth;
SineWave sw;

void turnoffInstr(int i) {
  cs.event("i 10 0 1 " + i + "\n");
}

void setupSynth() {
  cs = new CsoundSynth();
  phoneSynth = new PhoneSynth(cs);
}

void setup() {
  size(14, 70);
  frameRate(60);
  // opc = new MyOPC(this, "127.0.0.1", 7890);
  // opc.myGrid();
  setupSynth();
  stackpg = new StackPGraphics(this);
  // phsb.setPalette(new Palette_foo());
  sw = new SineWave();
}

int counter = 0;
void draw() {
  background(0);
  sw.update();
  sw.display();

  if (frameCount % 2 == 0) {
    phoneSynth.play(counter);
    counter = (counter + 1) % 10;
  }

  cs.update();
}
