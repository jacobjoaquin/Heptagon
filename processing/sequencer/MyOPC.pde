class MyOPC extends OPC {
  MyOPC(PApplet parent, String host, int port)
  {
    super(parent, host, port);
  }

  void myGrid() {
    int nLEDs = 35;
    int space = 1;
    int L = space * nLEDs;
    int yOffset = height / 2;
    int xOffset = 5;
    float rot = HALF_PI;


    ledStrip(64 * 0, 35, xOffset, yOffset, space, rot, false);
    ledStrip(64 * 8, 35, xOffset + 1, yOffset, space, rot, false);
    ledStrip(64 * 16, 35, xOffset + 2, yOffset, space, rot, false);


//    ledStrip(64 * 15, 35, xOffset, yOffset * 0, space, rot, false);
//    ledStrip(64 * 14, 35, xOffset, yOffset * 1, space, rot, false);
//    ledStrip(64 * 13, 35, xOffset, yOffset * 2, space, rot, false);
    // ledStrip(64 * 12, 35, xOffset, yOffset * 3, space, rot, false);
    // ledStrip(64 * 11, 35, xOffset, yOffset * 4, space, rot, false);
    // ledStrip(64 * 10, 35, xOffset, yOffset * 5, space, rot, false);
    // ledStrip(64 * 9, 35, xOffset, yOffset * 6, space, rot, false);
    // ledStrip(64 * 8, 35, xOffset, yOffset * 7, space, rot, false);

    // ledStrip(64 * 7, 35, xOffset, yOffset * 8, space, rot, false);
    // ledStrip(64 * 6, 35, xOffset, yOffset * 9, space, rot, false);
    // ledStrip(64 * 5, 35, xOffset, yOffset * 10, space, rot, false);
    // ledStrip(64 * 4, 35, xOffset, yOffset * 11, space, rot, false);
    // ledStrip(64 * 3, 35, xOffset, yOffset * 12, space, rot, false);
    // ledStrip(64 * 2, 35, xOffset, yOffset * 13, space, rot, false);
    // ledStrip(64 * 1, 35, xOffset, yOffset * 14, space, rot, false);
    // ledStrip(64 * 0, 35, xOffset, yOffset * 15, space, rot, false);

    // ledStrip(64 * 23, 35, xOffset, yOffset * 16, space, rot, false);
    // ledStrip(64 * 22, 35, xOffset, yOffset * 17, space, rot, false);
    // ledStrip(64 * 21, 35, xOffset, yOffset * 18, space, rot, false);
    // ledStrip(64 * 20, 35, xOffset, yOffset * 19, space, rot, false);
    // ledStrip(64 * 19, 35, xOffset, yOffset * 20, space, rot, false);
    // ledStrip(64 * 18, 35, xOffset, yOffset * 21, space, rot, false);
    // ledStrip(64 * 17, 35, xOffset, yOffset * 22, space, rot, false);
    // ledStrip(64 * 16, 35, xOffset, yOffset * 23, space, rot, false);
  }
}
