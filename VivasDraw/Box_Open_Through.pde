class Box_Open_Through {
  
  // Declaring 3D transform variables and constants
  private final float GLOBAL_X_ROTATE = radians(-15);       // The amount of degrees the graphic context is shifted, giving the appearance of looking down onto the 3D geometry
  private float globalYRotate = 0;                          // The rotation applied to the geometry every frame, used for auto rotate

  // Declaring Objects
  Shape_Side_Piece sidePieceOne;
  Shape_Side_Piece sidePieceTwo;
  Shape_End_Piece endPieceOne;
  Shape_End_Piece endPieceTwo;

  Box_Open_Through(PGraphics graphicContext) {
    sidePieceOne = new Shape_Side_Piece();
    sidePieceTwo = new Shape_Side_Piece();
    endPieceOne = new Shape_End_Piece();
    endPieceTwo = new Shape_End_Piece();
    setGraphicContext(graphicContext);
  }

  void draw() {
    pushMatrix();

    // Move the world view coordinates [0,0,0] to the centre of the display.
    // Moves the spawn point of the shape (world origin) to where you want it to be drawn.
    translate((width / 2), (height / 2), 400);

    // Rotate the graphics context so we view the shape from different angles making it appear to be tumbling.
    rotateX(GLOBAL_X_ROTATE);
    globalYRotate -= 0.008;
    rotateY(globalYRotate);

    // Moves the origin so the box rotates in the centre of the screen
    translate(-(boxLength / 2), 0, (boxWidth / 2));

    // Render side piece one
    sidePieceOne.draw();

    // Render side piece two
    pushMatrix();
    translate(0, 0, -(boxWidth + thickness)); // Moving the graphics context on the z axis 
    sidePieceTwo.draw();
    popMatrix();

    // Render end piece one
    pushMatrix();
    rotateY(radians(90));                     // Rotating the graphic context 90 degrees
    endPieceOne.draw();
    popMatrix();

    // Render end piece Two
    pushMatrix();
    rotateY(radians(90));                     // Rotating the graphic context 90 degrees
    translate(0, 0, (boxLength - thickness)); // Translating on the local z axis.
    endPieceTwo.draw();
    popMatrix();

    popMatrix();
  }

  void setGraphicContext(PGraphics graphicContext) {
    sidePieceOne.setGraphicContext(graphicContext);
    sidePieceTwo.setGraphicContext(graphicContext);
    endPieceOne.setGraphicContext(graphicContext);
    endPieceTwo.setGraphicContext(graphicContext);
  }
}
