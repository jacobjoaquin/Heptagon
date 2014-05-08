class Chip {
	PVector location;
	byte pins;
	boolean flip;
	static final int w = 24;
	static final int h = 64;

	Chip(float x, float y, boolean flip_, Byte pins_) {
		location = new PVector(x, y);
		flip = flip_;
		pins = pins_;
	}

	void draw() {
		int arcOffset = h;
		float arc1 = PI;
		float arc2 = TWO_PI;

		if (flip) {
			arcOffset = 0;
			arc1 = 0;
			arc2 = PI;
		}

		pushMatrix();

		// Chips
		translate(location.x, location.y);
		pushStyle();
		fill(64);
		stroke(48);
		rect(0, 0, w, h);
		fill(24);
		stroke(8);

		// Notch
		arc(w / 2, arcOffset, 8, 8, arc1, arc2);

		// Pins
		pushMatrix();
		fill(255);
		stroke(180);
		translate(0, 2);
		for (int i = 0; i < 8; i++) {
			rect(-8, i * 8, 8, 4);
			rect(w, i * 8, 8, 4);
		}

		// Activity
		translate(0, 16);
		fill(255, 0, 0);

		// Right Column
		if (flip) {
			for (int i = 0; i < 8; i++) {
				if ((0x01 & (pins >> i)) == 1)  {
					if (i < 4) {
						rect(w, (3 - i) * 8, 8, 4);
					}
					else {
						rect(-8, (i - 4) * 8, 8, 4);
					}
				}
			}
		}
		// Left Column
		else {
			for (int i = 0; i < 8; i++) {
				if ((0x01 & (pins >> i)) == 1)  {
					if (i < 4) {
						rect(-8, (3 - i) * 8, 8, 4);
					}
					else {
						rect(w, (7 - i) * 8, 8, 4);
					}
				}
			}
		}

		popMatrix();
		popStyle();
		popMatrix();
	}
}