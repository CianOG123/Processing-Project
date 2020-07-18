class Shape_End_Piece implements Shape_Base {

  // Objects
  PShape endPiece;                // Declaring the end piece shape

  // Booleans
  private boolean updateShape = false;     // When set to true, the vertices of the shape will be replotted.

  Shape_End_Piece() {
    // Side piece initialisation
    endPiece = createShape();
    endPiece.beginShape();
    endPiece.stroke(SHAPE_COLOR);
    endPiece.strokeWeight(STROKE_WEIGHT);
    endPiece.noFill();
    plotShape();
    endPiece.endShape(CLOSE);
  }

  void display() {
    endPiece.draw(getGraphics());
  }

  void update() {
    if (updateShape == true) {
      updateShape = false;
    }
  }

  void plotShape() {
    endPiece.vertex(0, 0, 0);      // Significant
    endPiece.vertex(0, 0, thickness);
    endPiece.vertex(boxWidth, 0, thickness);
    endPiece.vertex(0, 0, 0);


    endPiece.vertex(boxWidth, 0, 0);       // Significant
    endPiece.vertex(boxWidth, 0, thickness);
    endPiece.vertex(boxWidth, jointHeight, thickness);
    endPiece.vertex(boxWidth, 0, 0);

    endPiece.vertex(boxWidth, jointHeight, 0);      // Significant
    endPiece.vertex(boxWidth, jointHeight, thickness);
    endPiece.vertex((boxWidth + thickness), 20, thickness);
    endPiece.vertex(boxWidth, jointHeight, 0);

    endPiece.vertex((boxWidth + thickness), jointHeight, 0);      // Significant
    endPiece.vertex((boxWidth + thickness), jointHeight, thickness);
    endPiece.vertex((boxWidth + thickness), (jointHeight * 2), thickness);
    endPiece.vertex((boxWidth + thickness), jointHeight, 0);

    endPiece.vertex((boxWidth + thickness), (jointHeight * 2), 0);      // Significant
    endPiece.vertex((boxWidth + thickness), (jointHeight * 2), thickness); 
    endPiece.vertex(boxWidth, (jointHeight * 2), thickness); 
    endPiece.vertex((boxWidth + thickness), (jointHeight * 2), 0);

    endPiece.vertex(boxWidth, (jointHeight * 2), 0);      // Significant
    endPiece.vertex(boxWidth, (jointHeight * 2), thickness); 
    endPiece.vertex(boxWidth, (jointHeight * 3), thickness);
    endPiece.vertex(boxWidth, (jointHeight * 2), 0);

    endPiece.vertex(boxWidth, (jointHeight * 3), 0);      // Significant
    endPiece.vertex(boxWidth, (jointHeight * 3), thickness);
    endPiece.vertex((boxWidth + thickness), (jointHeight * 3), thickness);
    endPiece.vertex(boxWidth, (jointHeight * 3), 0);

    endPiece.vertex((boxWidth + thickness), (jointHeight * 3), 0);      // Significant
    endPiece.vertex((boxWidth + thickness), (jointHeight * 3), thickness); 
    endPiece.vertex((boxWidth + thickness), (jointHeight * 4), thickness);
    endPiece.vertex((boxWidth + thickness), (jointHeight * 3), 0);


    endPiece.vertex((boxWidth + thickness), (jointHeight * 4), 0);      // Significant
    endPiece.vertex((boxWidth + thickness), (jointHeight * 4), thickness);
    endPiece.vertex(boxWidth, (jointHeight * 4), thickness);
    endPiece.vertex((boxWidth + thickness), (jointHeight * 4), 0);

    endPiece.vertex(boxWidth, (jointHeight * 4), 0);      // Significant
    endPiece.vertex(boxWidth, (jointHeight * 4), thickness);
    endPiece.vertex(boxWidth, 100, thickness);
    endPiece.vertex(boxWidth, (jointHeight * 4), 0);

    endPiece.vertex(boxWidth, boxHeight, 0);      // Significant
    endPiece.vertex(boxWidth, boxHeight, thickness);
    endPiece.vertex(0, 100, thickness);
    endPiece.vertex(boxWidth, boxHeight, 0);

    endPiece.vertex(0, boxHeight, 0);      // Significant
    endPiece.vertex(0, boxHeight, thickness);
    endPiece.vertex(0, (jointHeight * 4), thickness);
    endPiece.vertex(0, boxHeight, 0);

    endPiece.vertex(0, (jointHeight * 4), 0);      // Significant
    endPiece.vertex(0, (jointHeight * 4), thickness);
    endPiece.vertex(-thickness, (jointHeight * 4), thickness);
    endPiece.vertex(0, (jointHeight * 4), 0);

    endPiece.vertex(-thickness, (jointHeight * 4), 0);      // Significant
    endPiece.vertex(-thickness, (jointHeight * 4), thickness);
    endPiece.vertex(-thickness, (jointHeight * 3), thickness);
    endPiece.vertex(-thickness, (jointHeight * 4), 0);

    endPiece.vertex(-thickness, (jointHeight * 3), 0);      // Significant
    endPiece.vertex(-thickness, (jointHeight * 3), thickness);
    endPiece.vertex(0, (jointHeight * 3), thickness); 
    endPiece.vertex(-thickness, (jointHeight * 3), 0);

    endPiece.vertex(0, (jointHeight * 3), 0);      // Significant
    endPiece.vertex(0, (jointHeight * 3), thickness); 
    endPiece.vertex(0, (jointHeight * 2), thickness);
    endPiece.vertex(0, (jointHeight * 3), 0);

    endPiece.vertex(0, (jointHeight * 2), 0);      // Significant
    endPiece.vertex(0, (jointHeight * 2), thickness);
    endPiece.vertex(-thickness, (jointHeight * 2), thickness);
    endPiece.vertex(0, (jointHeight * 2), 0);

    endPiece.vertex(-thickness, (jointHeight * 2), 0);      // Significant
    endPiece.vertex(-thickness, (jointHeight * 2), thickness);
    endPiece.vertex(-thickness, jointHeight, thickness);
    endPiece.vertex(-thickness, (jointHeight * 2), 0); 

    endPiece.vertex(-thickness, jointHeight, 0);      // Significant
    endPiece.vertex(-thickness, jointHeight, thickness); 
    endPiece.vertex(0, jointHeight, thickness); 
    endPiece.vertex(-thickness, jointHeight, 0);

    endPiece.vertex(0, jointHeight, 0);      // Significant
    endPiece.vertex(0, jointHeight, thickness);
    endPiece.vertex(0, 0, thickness);
    endPiece.vertex(0, jointHeight, 0);
  }
}
