class Phasor {
  float phase;
  float inc;
  
  Phasor(float inc_) {
    inc = inc_;
    phase = 0;
  }
  
  void update() {
    phase += inc;
    phase -= (int) phase;
    
    if (phase < 0) {
      phase += 1;
    }
  }
}