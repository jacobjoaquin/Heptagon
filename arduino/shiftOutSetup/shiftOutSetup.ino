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

  for (int i = 0; i < NBYTES; i++) {
    if (i % 2) {
      bytes[i]++;
    }
    else {
      bytes[i]--;
    }
  }  
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
    bytes[i] = 0;
  }
}

void loop() {
  updateBytes();
  delay(500);
}
