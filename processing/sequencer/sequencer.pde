import processing.serial.*;


MyOPC opc;
// Moonpaper mp;
// StackPGraphics stackpg;
PGraphics img;

// Generals
Phasor phasor = new Phasor(1 / 128.0);
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

CsoundSynthThread csoundSynthThread;
Thread t2;

void setupSynth() {

  // serialDataManager = new SerialDataManager();
  // serialDataManagerThread = new SerialDataManagerThread(serialDataManager);
  // t = new Thread(serialDataManagerThread);
  // t.start();

  csoundSynthThread = new CsoundSynthThread();
  t2 = new Thread(csoundSynthThread);
  t2.start();
  cs = csoundSynthThread.getCsoundSynth();
  // cs = new CsoundSynth(true);

  phoneSynth = new PhoneSynth(cs);
  sampler = new Sampler(cs);
  bitshiftSynth = new BitShiftSynth(cs);
}

void setup() {
  size(16, 70);
  frameRate(30);
  opc = new MyOPC(this, "127.0.0.1", 7890);
  opc.showLocations(false);
  opc.myGrid();
  setupSynth();
  setupSerial();
  // stackpg = new StackPGraphics(this);
  // phsb.setPalette(new Palette_foo());
  // phsb.setPalette(new Palette_BWGW());
  // phsb.setPalette(new Palette_singleRed());
  // phsb.setPalette(new Palette_singleGreen());
  // phsb.setPalette(new Palette_singleBlue());
  phsb.setPalette(new Palette_singleOrange());
  // phsb.setPalette(new Palette_HSB());
  sw = new SineWave();
}

void draw() {
  phsb.fillScreen();
  phsb.update();
  // sw.update();
  // sw.display();
  cs.update();
  serialDataManager.readBuffer();
  while(serialDataManager.isLocked) {}


  // Voice Counter
  if (frameCount % 120 == 0) {
    sampler.nextNumber();
  }
}


