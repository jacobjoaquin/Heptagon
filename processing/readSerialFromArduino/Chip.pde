class Chip {
	PVector location;
	byte pins;
	boolean flip;

	Chip(float x, float y, boolean flip_) {
		location = new PVector(x, y);
		flip = flip_;
	}

	void update() {
		// pins = pins_;
	}

	void draw() {
		int w = 24;
		int h = 64;
		int arcOffset = h;
		float arc1 = PI;
		float arc2 = TWO_PI;

		if (flip) {
			arcOffset = 0;
			arc1 = 0;
			arc2 = PI;
		}

		pushMatrix();
		translate(location.x, location.y);
		pushStyle();
		fill(64);
		stroke(48);
		rect(0, 0, w, h);
		fill(24);
		stroke(8);
		arc(w / 2, arcOffset, 8, 8, arc1, arc2);


		pushMatrix();
		fill(255);
		stroke(180);
		translate(0, 2);
		for (int i = 0; i < 8; i++) {
			rect(-8, i * 8, 8, 4);
			rect(w, i * 8, 8, 4);
		}
		popMatrix();

		
		popStyle();
		popMatrix();
	}
}