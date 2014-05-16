import csnd6.*;
import java.lang.StringBuilder;

class CsoundSynthThread implements Runnable {
	public CsoundSynth cs;

	CsoundSynthThread() {
		cs = new CsoundSynth(true);
	}

	CsoundSynth getCsoundSynth() {
		return cs;
	}

	@Override
	public void run() {
		while(true) {

		}
	}
}

class CsoundSynth {
	Csound cs;
	CsoundPerformanceThread csPerf;
	StringBuilder eventBuffer;
	float frameDur;
	boolean isEnabled = true;

	CsoundSynth() {
		eventBuffer = new StringBuilder(4096);
		cs = new Csound();
		csPerf = new CsoundPerformanceThread(cs);
		cs.SetOption("-odac");
		loadOrc();
		cs.Start();
		csPerf.Play();
		frameDur = (float) cs.GetKsmps() / 44100.0;
		startRunningInstruments();
		isEnabled = true;
	}

	CsoundSynth(boolean isEnabled_) {
 		eventBuffer = new StringBuilder(4096);
		isEnabled = isEnabled_;
		if (isEnabled) {
			cs = new Csound();
			csPerf = new CsoundPerformanceThread(cs);
			cs.SetOption("-odac");
			loadOrc();
			cs.Start();
			csPerf.Play();
			frameDur = (float) cs.GetKsmps() / 44100.0;
			startRunningInstruments();
		}
		else {
			frameDur = 0;
		}
	}

	private void startRunningInstruments() {
		event("i 1 0 1\n");     // Setup
		event("i 2 0 -1\n");    // Clear Chn
		event("i 101 0 -1\n");  // Modem Noise
		event("i 103 0 -1\n");  // Modem Noise
		event("i 108 0 -1 0.2\n");  // Rumble
		event("i 500 0 -1\n");  // Reverb FX
		event("i 600 0 -1\n");  // Master Output
		update();
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
	synchronized void SetChannel(String s, float v) {
		if (isEnabled) {
			cs.SetChannel(s, v);
		}
	}

	synchronized void event(String s) {
		if (isEnabled) {
			eventBuffer.append(s);
		}
	}

	synchronized void update() {
		if (eventBuffer.length() > 0 && isEnabled) {
			cs.ReadScore(eventBuffer.toString());
			println(eventBuffer.toString());
			eventBuffer.delete(0, eventBuffer.length());
		}
	}
}