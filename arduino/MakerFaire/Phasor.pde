class Phasor {
  float phase;
  float inc;
  
  Phasor(float inc_) {
    inc = inc_;
    phase = 0;
  }
  
  void update() {
    phase += inc;
    
    while (phase >= 1.0) {
      phase -= 1.0;
    }
    
    while (phase < 0) {
      phase += 1.0;
    }
  }
}
