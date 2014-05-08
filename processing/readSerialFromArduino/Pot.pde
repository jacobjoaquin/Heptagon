class Pot {
	PVector location;
	Integer value;
	int index;
	static final int w = 24;
	static final int h = 52;

	Pot(float x, float y, int index_) {
		location = new PVector(x, y);
		index = index_;
		value = analogValues.get(index);
	}

	void display() {
		pushMatrix();
		pushStyle();
		translate(location.x, location.y);
		fill(0);
		stroke(128);
		rect(0, 0, w, h);

		fill(255, 0, 0);
		noStroke();
		rect(1, h, w, map(value, 0, 1024, 0, -h));

		textSize(10);
		textAlign(CENTER);
		fill(255);
		text("A" + index, w / 2, h / 2);
		popStyle();
		popMatrix();
	}
}