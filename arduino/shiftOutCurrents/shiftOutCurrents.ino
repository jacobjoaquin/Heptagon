/*
  Test output to TLC5916 chips
*/

const int PULSE = 5;
const int LATCH = 8;
const int DATA = 11;
const int CLOCK = 12;
const int OUTPUT_ENABLE = 9;
const long RATE = 9600;
const int NBYTES = 2;
byte bytes[NBYTES];

void updateBytes() {
  digitalWrite(LATCH, LOW);

  for(int i = NBYTES - 1; i >= 0; i--) {
    shiftOut(DATA, CLOCK, MSBFIRST, bytes[i]);
  }
  digitalWrite(LATCH, HIGH);
}

void setCurrent() {
  // 1
  digitalWrite(CLOCK, HIGH);  
  digitalWrite(OUTPUT_ENABLE, HIGH);
  digitalWrite(LATCH, LOW);  

  digitalWrite(CLOCK, LOW);  
  digitalWrite(OUTPUT_ENABLE, LOW);
  
  // 2
  digitalWrite(CLOCK, HIGH);  

  digitalWrite(CLOCK, LOW);  
  digitalWrite(OUTPUT_ENABLE, HIGH);

  // 3
  digitalWrite(CLOCK, HIGH);  

  digitalWrite(CLOCK, LOW);  
  digitalWrite(LATCH, HIGH);  

  // 4
  digitalWrite(CLOCK, HIGH);  
  digitalWrite(CLOCK, LOW);  
  digitalWrite(LATCH, LOW);  

  // 5
  digitalWrite(CLOCK, HIGH);
  digitalWrite(CLOCK, LOW);  
  
// 
//  byte b0 = 0B00000000;
//  byte b1 = 0B11110000;
//  for (int i = 0; i < 8; i++) {
//    shiftOut(DATA, CLOCK, LSBFIRST, b0);
//  }
//  
//  for (int i = 0; i < 8; i++) {
//    shiftOut(DATA, CLOCK, LSBFIRST, b1);
//  }

  
  // Resume
  digitalWrite(OUTPUT_ENABLE, LOW);
}

void setup() {
  Serial.begin(RATE);
  pinMode(LATCH, OUTPUT);
  pinMode(CLOCK, OUTPUT);
  pinMode(DATA, OUTPUT);
  pinMode(OUTPUT_ENABLE, OUTPUT);
  digitalWrite(OUTPUT_ENABLE, LOW);
  digitalWrite(CLOCK, LOW);
  digitalWrite(LATCH, HIGH);
  for (unsigned int i = 0; i < NBYTES; i++) {
    bytes[i] = 255;
  }

  setCurrent();  
  updateBytes();
}

void loop() {
  updateBytes();

  for (int i = 0; i < NBYTES; i++) {
    bytes[i]++;
  }
 
  delay(50);
}
