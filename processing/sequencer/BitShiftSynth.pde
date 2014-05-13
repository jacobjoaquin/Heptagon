class BitShiftSynth {
	CsoundSynth cs;
	int instr = 104;

	BitShiftSynth(CsoundSynth cs_) {
		cs = cs_;
	}

	void play(float dur, int division) {
		float amp = 0.1;
		turnoffInstr(instr);
		cs.event("i " + instr + " " + cs.frameDur + " " + dur + " " + amp + " " + division + "\n");
	}
}