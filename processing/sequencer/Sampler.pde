class Sampler {
	int instr = 106;
	int counter = 128;

	Sampler(CsoundSynth cs_) {
		cs = cs_;
	}

	void nextNumber() {
		float delay = 0.5;
		int d1 = counter & 0xF;
		int d2 = (counter & 0xF0) >> 4;
		char a;
		char b;
		if (d1 < 10) {
			a = String.valueOf(d1).charAt(0);
		}
		else {
			a = (char) (d1 + 87);
		}

		if (d2 < 10) {
			b = String.valueOf(d2).charAt(0);
		}
		else {
			b = (char) (d2 + 87);
		}

		turnoffInstr(instr);
		event(0, 1, "/Users/jacobjoaquin/Projects/Heptagon/processing/sequencer/data/audio/voice_" + b + ".wav", 1.0);
		event(delay, 1, "/Users/jacobjoaquin/Projects/Heptagon/processing/sequencer/data/audio/voice_" + a + ".wav", 1.0);
		counter = (counter + 1) % 255;
	}

	private void event(float start, float amp, String file, float pch) {
		cs.event("i " + instr + " " + cs.frameDur + " 1 " + amp + " \"" + file + "\" " + pch + "\n");
		cs.event("i " + instr + " " + start + " 1 " + amp + " \"" + file + "\" " + pch + "\n");
	}
}