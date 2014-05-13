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
Sampler sampler;

void turnoffInstr(int i) {
  cs.event("i 10 0 1 " + i + "\n");
}

void setupSynth() {
  cs = new CsoundSynth();
  phoneSynth = new PhoneSynth(cs);
  sampler = new Sampler(cs);
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

  if (frameCount % 120 == 0) {
    phoneSynth.play((int) random(10));
    counter = (counter + 1) % 10;
  }

  cs.update();

  if (frameCount % 14 == 0) {
    cs.cs.SetChannel("masterTune", random(0.5, 2.0));
  }

  if (frameCount % 75 == 0) {
    // sampler.play((int) random(10));
    // sampler.play("a");
  }

  if (frameCount % 17 == 0) {
    cs.cs.SetChannel("reverbSize", random(0, 1));
  }
  if (frameCount % 88 == 0) {
    cs.cs.SetChannel("delayLeftAmount", random(0, 2000));
    cs.cs.SetChannel("delayRightAmount", random(0, 2000));
  }

  if (frameCount % 111 == 0) {
    cs.cs.SetChannel("delayFeedBack", random(0, 0.45));
  }

}
