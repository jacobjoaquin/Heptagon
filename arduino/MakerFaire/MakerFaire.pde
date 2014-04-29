import moonpaper.*;
import moonpaper.opcodes.*;

MyOPC opc;
Moonpaper mp;
StackPGraphics stackpg;
int w = 250 * 5;
PGraphics img;

class MyOPC extends OPC {
  MyOPC(PApplet parent, String host, int port)
  {
    super(parent, host, port);
  }

  void myGrid() {
    int nLEDs = 35;
    int space = 5;
    int L = space * nLEDs;
    int yOffset = height / (16 * 4);
    int xOffset = width / 2;
    float rot = 0;

//    ledStrip(64 * 15, 35, xOffset, yOffset * 0, space, rot, false);
//    ledStrip(64 * 14, 35, xOffset, yOffset * 1, space, rot, false);
//    ledStrip(64 * 13, 35, xOffset, yOffset * 2, space, rot, false);
    ledStrip(64 * 12, 35, xOffset, yOffset * 3, space, rot, false);
    ledStrip(64 * 11, 35, xOffset, yOffset * 4, space, rot, false);
    ledStrip(64 * 10, 35, xOffset, yOffset * 5, space, rot, false);
    ledStrip(64 * 9, 35, xOffset, yOffset * 6, space, rot, false);
    ledStrip(64 * 8, 35, xOffset, yOffset * 7, space, rot, false);

    ledStrip(64 * 7, 35, xOffset, yOffset * 8, space, rot, false);
    ledStrip(64 * 6, 35, xOffset, yOffset * 9, space, rot, false);
    ledStrip(64 * 5, 35, xOffset, yOffset * 10, space, rot, false);
    ledStrip(64 * 4, 35, xOffset, yOffset * 11, space, rot, false);
    ledStrip(64 * 3, 35, xOffset, yOffset * 12, space, rot, false);
    ledStrip(64 * 2, 35, xOffset, yOffset * 13, space, rot, false);
    ledStrip(64 * 1, 35, xOffset, yOffset * 14, space, rot, false);
    ledStrip(64 * 0, 35, xOffset, yOffset * 15, space, rot, false);
    
    ledStrip(64 * 23, 35, xOffset, yOffset * 16, space, rot, false);
    ledStrip(64 * 22, 35, xOffset, yOffset * 17, space, rot, false);
    ledStrip(64 * 21, 35, xOffset, yOffset * 18, space, rot, false);
    ledStrip(64 * 20, 35, xOffset, yOffset * 19, space, rot, false);
    ledStrip(64 * 19, 35, xOffset, yOffset * 20, space, rot, false);
    ledStrip(64 * 18, 35, xOffset, yOffset * 21, space, rot, false);
    ledStrip(64 * 17, 35, xOffset, yOffset * 22, space, rot, false);
    ledStrip(64 * 16, 35, xOffset, yOffset * 23, space, rot, false);


  }
}

void setup() {
  size(200, 200, P2D);
  opc = new MyOPC(this, "127.0.0.1", 7890);
  opc.myGrid();
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

void draw() {
  background(0);
  mp.update();
  mp.display();
  
  fill(255);
  ellipseMode(CENTER);
  ellipse(mouseX, mouseY, 10, 10);

  
//  pushStyle();
//  String s = "FRESNO IDEAWORKS ARDUINO FOCUS GROUP";
//  textSize(84);  
//  colorMode(HSB);
//  fill(textColor, 255, 255);
//  int yOffset = 70;
//  text(s, textX, yOffset);
//  text(s, textX + 1, yOffset);
//  text(s, textX + 2, yOffset);
//
//  textColor += 0.5;
//  if (textColor >= 255) {
//    textColor = 0;
//  }
//  textX -= 1;
//  if (textX < -1600) {
//    textX = width;
//  }  
//  popStyle();
}

