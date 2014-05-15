/* This is the Sequencer Version */

final int CHIPS_PER_BOARD = 7;
final int INPUTS_PER_BOARD = 8 * CHIPS_PER_BOARD;
final int N_BOARDS = 2;
final int N_INPUTS = N_BOARDS * INPUTS_PER_BOARD;
Serial port;
int serialRate = 9600;
SerialDataManager serialDataManager;
SerialDataManagerThread serialDataManagerThread;
Thread t;

void setupSerial() {
  println("Available Serial Devices:");
  println(Serial.list());
  port = new Serial(this, "/dev/cu.usbmodem38791", serialRate);
  port.clear();

  serialDataManager = new SerialDataManager();
  serialDataManagerThread = new SerialDataManagerThread(serialDataManager);
  t = new Thread(serialDataManagerThread);
  t.start();

  createBytes();
  createBits();
}

void createBytes() {
  for (int i = 0; i < nBytes; i++) {
    digitalValues.add((byte) 0);
  }
}

void createBits() {
  for (int i = 0; i < 8 * nBytes; i++) {
    digitalBits.add(new Integer(0));
  }
}