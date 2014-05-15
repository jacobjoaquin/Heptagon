synchronized void doBit(int byteIndex, int bitIndex, int value) {
  if (false) {
    return;
  }
  int index = byteIndex * 8 + bitIndex;
  Integer storedBit = digitalBits.get(index);

  if (value == storedBit.intValue()) {
    return;
  }

  Long storedFrame = digitalBitsFrames.get(index);
  // println("frames() " + frameCount + " " + storedFrame.intValue() + " " + byteIndex + " " + index + " " + value + " " + storedBit.intValue());
  if (frameCount <= storedFrame.longValue() + minDelayBetweenFrames) {
    // println("frameCount returning");
    return;
  }
  // storedFrame = new Integer(frameCount);
  digitalBitsFrames.set(index, (long) frameCount);

  println("doBit() " + byteIndex + " " + index + " " + value + " " + storedBit.intValue());
  storedBit = new Integer(value);

  // Dialtones
  // Row 4: 40, 43, 42, 41
  switch(index) {
    case 40:
      if (value == 1) {
        phoneSynth.play("*".charAt(0));
      }
      break;
    case 41:
      if (value == 1) {
        phoneSynth.play("d".charAt(0));
      }
      break;
    case 42:
      if (value == 1) {
        phoneSynth.play("#".charAt(0));
      }
      break;
    case 43:
      if (value == 1) {
        phoneSynth.play(0);
      }
      break;


    // Row 0: 45, 47, 44, 46
    case 44:
      if (value == 1) {
        phoneSynth.play(2);
      }
      break;
    case 45:
      if (value == 1) {
        phoneSynth.play(0);
      }
      break;
    case 46:
      if (value == 1) {
        phoneSynth.play("a".charAt(0));
      }
      break;
    case 47:
      if (value == 1) {
        phoneSynth.play(1);
      }
      break;

    // Row 2: 50, 49. 51. 48
    case 48:
      if (value == 1) {
        phoneSynth.play("c".charAt(0));
      }
      break;
    case 49:
      if (value == 1) {
        phoneSynth.play(8);
      }
      break;
    case 50:
      if (value == 1) {
        phoneSynth.play(7);
      }
      break;
    case 51:
      if (value == 1) {
        phoneSynth.play(9);
      }
      break;

    // Row 1: 54, 55, 53, 52
    case 52:
      if (value == 1) {
        phoneSynth.play("b".charAt(0));
      }
      break;
    case 53:
      if (value == 1) {
        phoneSynth.play(6);
      }
      break;
    case 54:
      if (value == 1) {
        phoneSynth.play(4);
      }
      break;
    case 55:
      if (value == 1) {
        phoneSynth.play(5);
      }
      break;
    default:
  }
}