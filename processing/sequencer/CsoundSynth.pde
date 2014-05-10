import csnd6.*;
import java.lang.StringBuffer;

class CsoundSynth {
	Csound cs;
	private CsoundPerformanceThread csPerf;

	CsoundSynth() {
		cs = new Csound();
		csPerf = new CsoundPerformanceThread(cs);
		cs.SetOption("-odac");
		loadOrc();
		cs.Start();
		csPerf.Play();
	}

	private void loadOrc() {
		String temp [] = loadStrings("data/synth.csd");
		StringBuffer sb = new StringBuffer();

		int size = temp.length;
		for (int i = 0; i < size; i++) {
			sb.append(temp[i]);
			sb.append("\n");
		}

		cs.CompileOrc(sb.toString());
	}

	void event(String s) {
		cs.ReadScore(s);
	}
}