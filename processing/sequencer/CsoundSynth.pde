import csnd6.*;
import java.lang.StringBuilder;

class CsoundSynth {
	Csound cs;
	CsoundPerformanceThread csPerf;
	StringBuilder eventBuffer;

	CsoundSynth() {
		eventBuffer = new StringBuilder(4096);
		cs = new Csound();
		csPerf = new CsoundPerformanceThread(cs);
		cs.SetOption("-odac");
		loadOrc();
		cs.Start();
		csPerf.Play();
		cs.ReadScore("i 1000 0 1000");
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
		// cs.ReadScore(s);
		eventBuffer.append(s);
		// eventBuffer.append("\n");
	}

	void update() {
		if (eventBuffer.length() > 0) {
			cs.ReadScore(eventBuffer.toString());
			println(eventBuffer.toString());
			eventBuffer.delete(0, eventBuffer.length());

		}
	}
}