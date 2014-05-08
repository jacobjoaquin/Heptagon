import processing.serial.*;

final int CHIPS_PER_BOARD = 7;
final int INPUTS_PER_BOARD = 8 * CHIPS_PER_BOARD;
final int N_BOARDS = 2;
final int N_INPUTS = N_BOARDS * INPUTS_PER_BOARD;

int endOfLine = 10;
String serial;
int nSerialBytes = 256;
byte[] serialBytes = new byte[nSerialBytes];
Serial port;
int serialRate = 38400;
int[] inputs = new int[N_INPUTS];
Boolean debug = false;
ArrayList<Byte> theBytes = new ArrayList<Byte>();
ArrayList<Chip> chips = new ArrayList<Chip>();
ArrayList<Byte> foo = new ArrayList<Byte>();


SerialDataManager serialDataManager;
SerialDataManagerThread serialDataManagerThread;
Thread t;
  
void clearInputs() {
  for (int i = 0; i < nSerialBytes; i++) {
    serialBytes[i] = 0;
  }
}

void updateVirtualBoards() {
  for (Chip c : chips) {
    c.update();
  }
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
  serial = port.readStringUntil(endOfLine);
  serial = null;  
  clearInputs();

  serialDataManager = new SerialDataManager();
  serialDataManagerThread = new SerialDataManagerThread(serialDataManager);
  t = new Thread(serialDataManagerThread);
  t.start();
  // serialDataManagerThread.start();

  for (int i = 0; i < 14; i++) {
    foo.add((byte) 0);
  }
      
  int byteIndex = 0;
  for (int i = CHIPS_PER_BOARD - 1; i >= 0; i--) {
    chips.add(new Chip(200, (Chip.h + 6) * i + 24, true, foo.get(byteIndex)));
    byteIndex++;
  }

  for (int i = 0; i < CHIPS_PER_BOARD; i++) {
    chips.add(new Chip(50, (Chip.h + 6) * i + 24, false, foo.get(byteIndex)));
    byteIndex++;
  }
}

void draw() {
  background(#BFFF95);
  updateVirtualBoards();

  if (debug) {
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

  serialDataManager.readBuffer();
}