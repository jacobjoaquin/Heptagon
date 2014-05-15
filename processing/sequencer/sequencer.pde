import moonpaper.*;
import moonpaper.opcodes.*;
import processing.serial.*;


MyOPC opc;
Moonpaper mp;
StackPGraphics stackpg;
PGraphics img;

// Generals
Phasor phasor = new Phasor(1 / 255.0);
PHSB phsb = new PHSB();

// Visuals
SineWave sw;

// Synth
CsoundSynth cs;
BitShiftSynth bitshiftSynth;
PhoneSynth phoneSynth;
Sampler sampler;
int counter = 0;


int nBytes = 14;
ArrayList<Byte> digitalValues = new ArrayList<Byte>();
ArrayList<Integer> digitalBits = new ArrayList<Integer>();
ArrayList<Long> digitalBitsFrames = new ArrayList<Long>();
ArrayList<Integer> analogValues = new ArrayList<Integer>();
final static int minDelayBetweenFrames = 5;


void turnoffInstr(int i) {
  cs.event("i 10 0 1 " + i + "\n");
}

void setupSynth() {
  cs = new CsoundSynth();
  phoneSynth = new PhoneSynth(cs);
  sampler = new Sampler(cs);
  bitshiftSynth = new BitShiftSynth(cs);
}

void setup() {
  size(14, 70);
  frameRate(60);
  // opc = new MyOPC(this, "127.0.0.1", 7890);
  // opc.myGrid();
  setupSynth();
  setupSerial();
  stackpg = new StackPGraphics(this);
  // phsb.setPalette(new Palette_foo());
  phsb.setPalette(new Palette_BWGW());
  // phsb.setPalette(new Palette_HSB());
  sw = new SineWave();
}

void draw() {
  // background(0);
  phsb.fillScreen();
  sw.update();
  sw.display();
  testSound();
  phsb.update();
  serialDataManager.readBuffer();
}


void testSound() {
  // if (frameCount % 99 == 0) {
  //   bitshiftSynth.play(0.25, (int) random(1, 32));
  // }



  if (frameCount % 100 == 0) {
    cs.cs.SetChannel("bitShiftFreq", random(11025, 44100));
  }
  if (frameCount % 121 == 0) {
    cs.cs.SetChannel("modemFreq", random(100, 5000));
  }
  if (frameCount % 123 == 0) {
    cs.cs.SetChannel("modemBPS", random(8, 300));
  }
  if (frameCount % 125 == 0) {
    cs.cs.SetChannel("modemMod", random(100, 1000));
  }
  if (frameCount % 124 == 0) {
    cs.cs.SetChannel("modemAmp", random(0.025, 0.1));
  }


  // if (frameCount % 50 == 0) {
  //   // phoneSynth.play((int) random(10));
  //   phoneSynth.play("a".charAt(0));
  //   counter = (counter + 1) % 10;
  // }
  // if (frameCount % 14 == 0) {
  //   cs.cs.SetChannel("masterTune", random(0.5, 2.0));
  // }
  // if (frameCount % 301 == 0) {
  //   cs.cs.SetChannel("samplerRingModFreq", random(4, 30));
  //   // sampler.play((int) random(10));
  //   sampler.play("a");
  // }


  if (frameCount % 17 == 0) {
    cs.cs.SetChannel("reverbSize", random(0, 1));
  }
  if (frameCount % 88 == 0) {
    cs.cs.SetChannel("delayLeftAmount", random(0, 500));
    cs.cs.SetChannel("delayRightAmount", random(0, 500));
  }
  if (frameCount % 111 == 0) {
    cs.cs.SetChannel("delayFeedBack", random(0, 0.45));
  }
  cs.update();
}

synchronized void updateByteInput(int index, byte value) {
  Byte storedByte = digitalValues.get(index);
  byte storedByteValue = storedByte.byteValue();

  if (storedByteValue != value) {
    // println("byte: " + index);
    for (int i = 0; i < 8; i++) {
      int bitValue = ((value >> i) & 1);
      doBit(index, i, bitValue);
    }

    storedByte = new Byte(value);
  }
}
