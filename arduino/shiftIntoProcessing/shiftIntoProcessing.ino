const int PULSE = 5;
const int LATCH = 8;
const int DATA = 11;
const int CLOCK = 13;
const long RATE = 38400;
const int NBYTES = 14;
byte bytes[NBYTES];

unsigned long LEDTimer = 0;
int LEDState = 1;

void updateBytes() {
  digitalWrite(CLOCK, HIGH);
  digitalWrite(LATCH, LOW);
  delayMicroseconds(PULSE);
  digitalWrite(LATCH, HIGH);

  for(int i = NBYTES - 1; i >= 0; i--) {
    byte thisByte = shiftIn(DATA, CLOCK, MSBFIRST);
    if (thisByte != bytes[i]) {
      byte temp[2] = {i, thisByte};
      Serial.write(temp, 2);
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
    bytes[i] = 0;
  }
}

void loop() {
  updateBytes();
}
