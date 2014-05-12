class PhoneSynth {
	CsoundSynth cs;
	int tone_col[] = {1209, 1336, 1477, 1633};
	int tone_row[] = {697, 770, 852, 941};
	int instr = 105;
	float kDelay = 0.0022675736961451248;  //100 / 44100;

	PhoneSynth(CsoundSynth cs_) {
		cs = cs_;
		// super(cs);
	}

	void play(int n) {
		ArrayList<Integer> tones = new ArrayList<Integer>();

		switch(n) {
			case 0:
				tones = getTones(1, 3);
				break;
			case 1:
				tones = getTones(0, 0);
				break;
			case 2:
				tones = getTones(1, 0);
				break;
			case 3:
				tones = getTones(2, 0);
				break;
			case 4:
				tones = getTones(0, 1);
				break;
			case 5:
				tones = getTones(1, 1);
				break;
			case 6:
				tones = getTones(2, 1);
				break;
			case 7:
				tones = getTones(0, 2);
				break;
			case 8:
				tones = getTones(1, 2);
				break;
			case 9:
				tones = getTones(2, 2);
				break;
			default:
				return;
		}

		event(tones.get(0), tones.get(1));
	}

	void play (char c) {
		ArrayList<Integer> tones = new ArrayList<Integer>();

		switch((int) Character.toUpperCase(c)) {
			// A
			case 65:
				tones = getTones(3, 0);
				break;
			// B
			case 66:
				tones = getTones(3, 1);
				break;
			// C
			case 67:
				tones = getTones(3, 2);
				break;
			// D
			case 68:
				tones = getTones(3, 3);
				break;
			// *
			case 42:
				tones = getTones(0, 3);
				break;
			// #
			case 35:
				tones = getTones(2, 3);
				break;
			default:
				return;
		}

		event(tones.get(0), tones.get(1));
	}

	void play (String s) {
		ArrayList<Integer> tones = new ArrayList<Integer>();

		if (s == "BUSY") {
			tones.add(480);
			tones.add(620);
		}
		else if (s == "RINGBACK") {
			tones.add(440);
			tones.add(480);
		}
		else if (s == "DIALTONE") {
			tones.add(440);
			tones.add(480);
		}
		else {
			return;
		}

		event(tones.get(0), tones.get(1));
	}


	private void event(int p4, int p5) {
		turnoffInstr(instr);
		cs.event("i " + instr + " " + kDelay + " 0.5 " + p4 + " " + p5 + "\n");
	}

	private ArrayList<Integer> getTones(int x, int y) {
		ArrayList<Integer> tones = new ArrayList<Integer>();
		tones.add(tone_col[x]);
		tones.add(tone_row[y]);
		return tones;
	}
}