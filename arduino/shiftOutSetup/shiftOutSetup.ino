/*
  Test output to TLC5916 chips
*/

const int PULSE = 5;
const int LATCH = 9;
const int CLOCK = 10;
const int OUTPUT_ENABLE = 11;
const int DATA = 12;
const long RATE = 9600;
const int NBYTES = 2;
byte bytes[NBYTES];

int t = 0;
int flip = 0;
bool booting = true;

int allFlip = 0;

void updateBytes() {
  digitalWrite(LATCH, LOW);
  for(int i = NBYTES - 1; i >= 0; i--) {
    shiftOut(DATA, CLOCK, MSBFIRST, bytes[i]);
  }
  digitalWrite(LATCH, HIGH);
}

void setup() {
  Serial.begin(RATE);
  pinMode(LATCH, OUTPUT);
  pinMode(CLOCK, OUTPUT);
  pinMode(DATA, OUTPUT);
  pinMode(OUTPUT_ENABLE, OUTPUT);
  pinMode(13, OUTPUT);
  digitalWrite(OUTPUT_ENABLE, LOW);
  digitalWrite(OUTPUT_ENABLE, HIGH);
  digitalWrite(OUTPUT_ENABLE, LOW);
  digitalWrite(CLOCK, LOW);
  digitalWrite(LATCH, HIGH);
  for (unsigned int i = 0; i < NBYTES; i++) {
    bytes[i] = 255;
  }
  updateBytes();
}

void loop() {

// digitalWrite(LATCH, LOW);
// digitalWrite(CLOCK, LOW);
// digitalWrite(DATA, LOW);
// digitalWrite(OUTPUT_ENABLE, LOW);

  // digitalWrite(LATCH, HIGH);
// digitalWrite(CLOCK, HIGH);
// digitalWrite(OUTPUT_ENABLE, HIGH);
// digitalWrite(DATA, HIGH);


  // while(true) {}

  if (booting) {
    booting = false;

    for (int i = 0; i < 20; i++) {
      digitalWrite(13, HIGH);
      delay(50);
      digitalWrite(13, LOW);
      delay(50);
    }
  }
  else {
    // for (int i = 0; i < NBYTES; i++) {
    //   bytes[i]++;
    // }
    onOff();

    delay(100);
    flip = 1 - flip;
    digitalWrite(13, flip);
    updateBytes();
  }
}


void onOff() {
  for (int i = 0; i < NBYTES; i++) {
    bytes[i] = 255 - bytes[i];
  }
}