/*
  Test output to TLC5916 chips
*/

const int PULSE = 5;
const int LATCH = 1;
const int CLOCK = 2;
const int OUTPUT_ENABLE = 3;
const int DATA = 4;
const long RATE = 9600;
const int NBYTES = 1;
byte bytes[NBYTES];

int t = 0;
int flip = 0;
bool booting = true;

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

 // Resume
  digitalWrite(OUTPUT_ENABLE, LOW);
}

void setup() {
  Serial.begin(RATE);
  pinMode(LATCH, OUTPUT);
  pinMode(CLOCK, OUTPUT);
  pinMode(DATA, OUTPUT);
  pinMode(OUTPUT_ENABLE, OUTPUT);
  pinMode(13, OUTPUT);
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

  if (booting) {
    booting = false;

    for (int i = 0; i < 10; i++) {
      digitalWrite(13, HIGH);
      delay(50);
      digitalWrite(13, LOW);
      delay(50);
    }
  }
  else {
    for (int i = 0; i < NBYTES; i++) {
      bytes[i]++;
    }

    delay(100);
    flip = 1 - flip;
    digitalWrite(13, flip);
  }
}
