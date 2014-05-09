import csnd6.*;

Csound cs;
CsoundPerformanceThread csPerf;

void setup() {
	cs = new Csound();
	csPerf = new CsoundPerformanceThread(cs);
	cs.SetOption("-odac");
	cs.CompileOrc("sr = 44100\nkr = 4410\nksmps = 10\nnchnls = 1\n0dbfs = 1.0");
	cs.CompileOrc("instr 1\nidur = p3\niamp = p4\nifreq = p5\nk1 line 1, idur, 0\na1 oscils iamp, ifreq, 1\nout a1 * k1\nendin");
	cs.Start();
	csPerf.Play();
}

void draw() {
	if (frameCount % 5 == 0) {
		// float value = 440.0 * pow(2.0, ((int) random(0, 12) / 12.0));
		float value = 440.0 * pow(2.0, (random(0, 12) / 12.0));
		cs.ReadScore("i 1 0 0.25 0.5 " + value);
		float value2 = value * pow(2.0, 3.0 / 12.0);
		cs.ReadScore("i 1 0 0.25 0.5 " + value2);
	}
}