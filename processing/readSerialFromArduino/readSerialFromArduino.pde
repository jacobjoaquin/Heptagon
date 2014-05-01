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
int serialRate = 9600;
int[] inputs = new int[N_INPUTS];
Boolean debug = true;
ArrayList<Integer> theBytes = new ArrayList<Integer>();
ArrayList<Chip> chips = new ArrayList<Chip>();


void updateInputs() {
  while(port.available() > 0) {
    serial = port.readStringUntil(endOfLine);
  }
  
  if (serial != null) {
    String[] values = split(serial, ',');
    int L = values.length - 1;
    
    for (int i = 0; i < L; i += 2) {
      int index = Integer.parseInt(values[i]);
      if (index < N_INPUTS) {
        int value = Integer.parseInt(values[i + 1]);
        inputs[index] = value;
        print(index + ", " + value + "    " + frameCount + "\n");
      }
    }
    
    serial = null;
  }  
}

void updateBytes() {
  int available = port.available();

  
  
  if (available > 0) {
    serialBytes = port.readBytes();
    
    if (debug) {
      println("=== " + frameCount + " ===");
      println("avaialable bytes total: " + available);
      println("avaialable bytes:");
      println(serialBytes);
    }

    for (int i = 0; i < available; i++) {
      theBytes.add((int) serialBytes[i]);
      serialBytes[i] = 0;
    }
    
    println(theBytes);
    

    for (int i = 0; i < (int) (theBytes.size() / 2); i++) {
      int index = theBytes.remove(0);
      int value = theBytes.remove(0);

      inputs[index] = value;
      println(index + ", " + value);      
    }
//    java.util.Arrays.fill(serialBytes, 0)
//    clearInputs();
  }
}

  
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
  size(N_INPUTS * 4, 400);
  frameRate(60);
  println(Serial.list());
  port = new Serial(this, Serial.list()[2], serialRate);
  port.clear();
  serial = port.readStringUntil(endOfLine);
  serial = null;  
  clearInputs();

  chips.add(new Chip(50.0, 50.0, false));
  chips.add(new Chip(100.0, 50.0, true));
}

void draw() {
  background(#BFFF95);
  updateBytes();
  updateVirtualBoards();
  // for (int board = 0; board < 2; board++) {
  //   for (int i = 0; i < N_INPUTS / 2; i++) {
  //     color c = color(inputs[i] * 255);
  //     fill(c);
  //     noStroke();
  //     int offset = i * 4;
  //     rect(offset, 0, 4, height);
  //   }    
  // }
}
