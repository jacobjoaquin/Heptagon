import moonpaper.*;
import moonpaper.opcodes.*;

MyOPC opc;
Moonpaper mp;
StackPGraphics stackpg;
int w = 250 * 5;
PGraphics img;
Phasor phasor = new Phasor(1 / 255.0);
PHSB phsb = new PHSB();

CsoundSynth cs;

void createSequence() {
  mp = new Moonpaper(this);
  stackpg = new StackPGraphics(this);
  Cel cel0 = mp.createCel();
  Cel cel1 = mp.createCel();
  cel1.setActive(false);
  cel1.setTransparency(0.0);

  mp.seq(new ConsoleWrite("Start of Sequencer Loop"));  // Write message to console at beginning of sequencer loop using custom opcode
  mp.seq(new ClearCels());                              // Clear all cels off all layers
  mp.seq(new PushCel(cel0, new SetBackground()));       // Push black background to cel0
  mp.seq(new PushCel(cel1, new SetBackground()));       // Push black background to cel1


  mp.seq(new PushCel(cel0, new SineWave()));
  mp.seq(new Wait(w));                    // Wait for 250 frames


  mp.seq(new PushCel(cel0, new Scroller()));
  mp.seq(new Wait(w));                    // Wait for 250 frames
  Sparkle sparkle2 = new Sparkle();
  sparkle2.threshold = 128;
  sparkle2.nDots = 2000;
  mp.seq(new PushCel(cel0, sparkle2));
  mp.seq(new Wait(w));                    // Wait for 250 frames

  RainDots rainDots = new RainDots(10);
  rainDots.setBlendMode(SCREEN);
  mp.seq(new PushCel(cel0, rainDots));
  mp.seq(new Wait(w));

  // Pre-render 4 large dots and add them to cel0
  int nDots = 4;
  for (int i = 0; i < nDots; i += 2) {
    PImage dot = loadImage("dot6.tif");
    PVector startLocation = new PVector(width / 2, height / 2);
    PVector velocity = PVector.mult(PVector.fromAngle(map(i, 0, nDots, 0, TWO_PI) + QUARTER_PI), i + 1);
    MovingImage m = new MovingImage(dot, startLocation, velocity);
    m.setBlendMode(SCREEN);

    mp.seq(new PushCel(cel0, m));  // Add this dot as new layer to cel0
  }

  mp.seq(new Wait(w));                    // Wait for 250 frames
  mp.seq(new FadeOut(120, cel0));           // FadeOut cel0 over 120 frames
  mp.seq(new PushCel(cel0, new Mirror()));  // Push Mirror filter to cel0. Everything below Mirror will be mirrored.
  mp.seq(new FadeIn(120, cel0));            // Fade back in cel 0.
  mp.seq(new Wait(w));                    // Wait

  // Pre-render 8 small dots and add them to cel1
  nDots = 8;
  for (int i = 0; i < nDots; i++) {
    PImage dot = loadImage("dot" + i + ".tif");
    PVector startLocation = new PVector(map(i, 0, nDots - 1, 0, width), map(i, 0, nDots - 1, 0, height));
    PVector velocity = PVector.mult(PVector.fromAngle((i % 2) * PI + QUARTER_PI / 2), map(i, 0, nDots, 1, 4));
    MovingImage m = new MovingImage(dot, startLocation, velocity);
    m.setBlendMode(SCREEN);
    mp.seq(new PushCel(cel1, m));  // Add this dot as new layer to cel1
  }

  mp.seq(new CrossFade(120, cel0, cel1));
  mp.seq(new Wait(w));
  Sparkle sparkle = new Sparkle();
  sparkle.threshold = 128;
  mp.seq(new PushCel(cel1, sparkle));
  mp.seq(new Wait(w / 2));
  mp.seq(new PopCel(cel0));
  mp.seq(new CrossFade(120, cel1, cel0));
}

void setup() {
  size(200, 200, P2D);
//  opc = new MyOPC(this, "127.0.0.1", 7890);
//  opc.myGrid();
  cs = new CsoundSynth();
  // createSequence();
  // phsb.setPalette(new Palette_foo());
}

void draw() {
  background(0);
  // mp.update();
  // mp.display();
  if (frameCount % 5 == 0) {
    float value = 440.0 * pow(2.0, (random(0, 12) / 12.0));
    cs.event("i 1 0 0.25 0.5 " + value);
    float value2 = value * pow(2.0, 3.0 / 12.0);
    cs.event("i 1 0 0.25 0.5 " + value2);
  }
}


