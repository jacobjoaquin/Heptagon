import csnd6.*;
import java.lang.StringBuilder;

class CsoundSynth {
	Csound cs;
	CsoundPerformanceThread csPerf;
	StringBuilder eventBuffer;
	float frameDur;

	CsoundSynth() {
		eventBuffer = new StringBuilder(4096);
		cs = new Csound();
		csPerf = new CsoundPerformanceThread(cs);
		cs.SetOption("-odac");
		loadOrc();
		cs.Start();
		csPerf.Play();
		event("i 1 0 1\n");     // Setup
		event("i 2 0 -1\n");    // Clear Chn
		event("i 103 0 -1\n");  // Modem Noise
//		event("i 107 0 -1 0.5\n");  // Rumble
		event("i 108 0 -1 0.2\n");  // Rumble
		event("i 500 0 -1\n");  // Reverb FX
		event("i 600 0 -1\n");  // Master Output
		update();
		frameDur = (float) cs.GetKsmps() / 44100.0;
		// println(cs.KR);
	}

	private void loadOrc() {
		String temp [] = loadStrings("data/synth.orc");
		StringBuilder sb = new StringBuilder();

		int size = temp.length;
		for (int i = 0; i < size; i++) {
			sb.append(temp[i]);
			sb.append("\n");
		}

		cs.CompileOrc(sb.toString());
	}

	void event(String s) {
		eventBuffer.append(s);
	}

	void update() {
		if (eventBuffer.length() > 0) {
			cs.ReadScore(eventBuffer.toString());
			println(eventBuffer.toString());
			eventBuffer.delete(0, eventBuffer.length());
		}
	}
}