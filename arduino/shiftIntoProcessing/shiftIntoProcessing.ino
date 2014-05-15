const int PULSE = 0;
// const int LATCH = 9;
// const int DATA = 12;
// const int CLOCK = 13;
const int DATA = 4;
const int CLOCK = 3;
const int LATCH = 2;
const long RATE = 38400;
const int NBYTES = 14;
const int NUINTS = 21;

byte bytes[NBYTES];


unsigned int uints[NUINTS];
unsigned int analogs[] = {A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12,
                          A13, A14, A15, A16, A17, A18, A19, A20};

// For debugging purposes
long counter = 0;
unsigned int value = 0;
void simulateAnalogInput() {
  if (counter <= millis()) {
    counter = millis() + 100;;
    uints[0] = random(0, 1024);
    byte v0 = 128;
    byte v1 = 64;
    byte temp[3] = {15, value >> 8, value & 0xFF};
    Serial.write(temp, 3);
    value = (value + 1) % 1024;
  }
}

void updateBytes() {
  digitalWrite(CLOCK, HIGH);
  digitalWrite(LATCH, LOW);
  delayMicroseconds(PULSE);
  digitalWrite(LATCH, HIGH);

  for(int i = NBYTES - 1; i >= 0; i--) {
    byte thisByte = shiftIn(DATA, CLOCK, MSBFIRST);

    if (thisByte != bytes[i]) {
      byte temp[3] = {i, thisByte, 0};
      Serial.write(temp, 3);
      bytes[i] = thisByte;
    }
  }
}

unsigned long pause = 0;
void updateAnalog() {
  if (pause <= millis()) {
    pause = millis() + 16;
    for (int i = 0; i < NUINTS; i++) {
      if (!(i == 12 || i == 19 || i == 20)) {
        int offset = i + NBYTES;

        unsigned int value = analogRead(analogs[i]);

        if (uints[0] != value) {
          byte temp[3] = {offset, (value >> 8) & 0xFF, value & 0xFF};
          Serial.write(temp, 3);
          uints[0] = value;
        }
      }
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
  for (unsigned int i = 0; i < NUINTS; i++) {
    uints[i] = 0;
  }
}

void loop() {
  updateBytes();
  updateAnalog();
  // simulateAnalogInput();
}