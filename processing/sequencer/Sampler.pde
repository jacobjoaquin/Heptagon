class Sampler {
	int instr = 106;

	Sampler(CsoundSynth cs_) {
		cs = cs_;
	}

	void play (int i) {
		if (i < 0 || i > 9) {
			return;
		}

		event(0.5, "/Users/jacobjoaquin/Projects/Heptagon/processing/sequencer/data/audio/voice_" + i + ".wav", 1.0);
	}

	void play (String s) {
		event(0.5, "/Users/jacobjoaquin/Projects/Heptagon/processing/sequencer/data/audio/voice_" + s.charAt(0) + ".wav", 1.0);
	}


	private void event(float amp, String file, float pch) {
		turnoffInstr(instr);
		cs.event("i " + instr + " " + cs.frameDur + " 1 " + amp + " \"" + file + "\" " + pch + "\n");
	}
}