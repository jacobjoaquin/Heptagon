/* This is the Sequencer Version */

import processing.serial.*;

final int CHIPS_PER_BOARD = 7;
final int INPUTS_PER_BOARD = 8 * CHIPS_PER_BOARD;
final int N_BOARDS = 2;
final int N_INPUTS = N_BOARDS * INPUTS_PER_BOARD;
Serial port;
int serialRate = 9600;
ArrayList<Chip> chips = new ArrayList<Chip>();
ArrayList<Byte> bytes = new ArrayList<Byte>();
ArrayList<Pot> pots = new ArrayList<Pot>();
ArrayList<Integer> analogValues = new ArrayList<Integer>();

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
}