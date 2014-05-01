class SineWave extends Displayable {
	Phasor phasor = new Phasor(0.01);
	int resolution = 16;
	float weight = 4;
	float nCycles = 1;

	void update() {
		phasor.update();
	}

	void display() {
		pushStyle();
		noFill();
		strokeWeight(weight);
		stroke(255);
		beginShape();
		for (int i = -resolution; i < width + resolution; i += resolution) {
			float v = sin((norm(i, 0, width) * nCycles + phasor.phase) * TWO_PI);
			vertex(i, map(v, -1, 1, height, 0));
		}
		endShape();
		popStyle();
	}
}