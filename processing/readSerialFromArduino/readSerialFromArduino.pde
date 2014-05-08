import processing.serial.*;

final int CHIPS_PER_BOARD = 7;
final int INPUTS_PER_BOARD = 8 * CHIPS_PER_BOARD;
final int N_BOARDS = 2;
final int N_INPUTS = N_BOARDS * INPUTS_PER_BOARD;
Serial port;
int serialRate = 38400;
ArrayList<Chip> chips = new ArrayList<Chip>();
ArrayList<Byte> bytes = new ArrayList<Byte>();
SerialDataManager serialDataManager;
SerialDataManagerThread serialDataManagerThread;
Thread t;
  
void debugInfo() {
  if (frameCount % 60 == 0) {
    for (Chip c : chips) {
      for (int i = 0; i < 8; i++) {
        print((c.pins >> i) & 0x01);
      }
      println();
    }
    println();
  }
}

void updateVirtualBoard() {
  for (Chip c : chips) {
    c.draw();
  }
}

void setup() {
  size(274, 550);
  frameRate(60);
  println(Serial.list());
  port = new Serial(this, "/dev/cu.usbmodem38791", serialRate);
  port.clear();

  serialDataManager = new SerialDataManager();
  serialDataManagerThread = new SerialDataManagerThread(serialDataManager);
  t = new Thread(serialDataManagerThread);
  t.start();

  for (int i = 0; i < 14; i++) {
    bytes.add((byte) 0);
  }
      
  int byteIndex = 0;
  for (int i = CHIPS_PER_BOARD - 1; i >= 0; i--) {
    chips.add(new Chip(200, (Chip.h + 6) * i + 24, true, bytes.get(byteIndex)));
    byteIndex++;
  }

  for (int i = 0; i < CHIPS_PER_BOARD; i++) {
    chips.add(new Chip(50, (Chip.h + 6) * i + 24, false, bytes.get(byteIndex)));
    byteIndex++;
  }
}

void draw() {
  background(#BFFF95);
  updateVirtualBoard();
  serialDataManager.readBuffer();
  // debugInfo();
}