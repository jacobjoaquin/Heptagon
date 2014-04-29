const int PULSE = 5;
const int LATCH = 8;
const int DATA = 11;
const int CLOCK = 12;
const long RATE = 9600;
const int NBYTES = 14;
byte bytes[NBYTES];

void updateBytes() {
  delay(500);
  digitalWrite(CLOCK, HIGH);
  digitalWrite(LATCH, LOW);
  delayMicroseconds(PULSE);
  digitalWrite(LATCH, HIGH);

  for(int i = NBYTES - 1; i >= 0; i--) {
    byte thisByte = shiftIn(DATA, CLOCK, MSBFIRST);
    if (thisByte != bytes[i]) {
      for (int j = 7; j >= 0; j--) {
        byte newBit = (thisByte >> j) & 1;
        byte oldBit = (bytes[i] >> j) & 1;
        if (newBit != oldBit) {
          byte temp[2] = {i * 8 + j, newBit};
          Serial.write(temp, 2);
        }
      }
      
      bytes[i] = thisByte;
    }
  }
}

void setup() {
  Serial.begin(RATE);
  pinMode(LATCH, OUTPUT);
  pinMode(CLOCK, OUTPUT);
  pinMode(DATA, INPUT);
  digitalWrite(CLOCK, LOW);
  digitalWrite(LATCH, HIGH);    
  for (unsigned int i = 0; i < NBYTES; i++) {
    bytes[0] = 0;
  }
}

void loop() {
  updateBytes();
}
