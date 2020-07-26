/**
 *  Class that can plot and draw a side piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
class Shape_Side_Piece extends Shape_Template_Static {

  // Objects
  private PShape sidePiece;                // Declaring the side piece shape

  // Booleans
  private boolean updateShape = false;     // When set to true, the vertices of the shape will be replotted.

  Shape_Side_Piece() {
    sidePiece = createShape();
    sidePiece.beginShape(TRIANGLE_STRIP);
    initialise(sidePiece);
    plotShape(sidePiece);
    sidePiece.endShape(CLOSE);
  }

  private void draw() {
    display(updateShape, sidePiece);
  }

  @Override
    void plotShape(PShape shape) {
    // Construct top
    sidePiece.vertex(0, 0, 0);  // Significant
    sidePiece.vertex(0, 0, thickness);

    sidePiece.vertex(boxLength, 0, 0);  // Significant
    sidePiece.vertex(boxLength, 0, thickness);

    // Construct joints
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        sidePiece.vertex(boxLength - thickness, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(boxLength - thickness, (jointHeight * i), thickness);

        sidePiece.vertex(boxLength, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(boxLength, (jointHeight * i), thickness);
      } else {
        sidePiece.vertex(boxLength, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(boxLength, (jointHeight * i), thickness);

        sidePiece.vertex(boxLength - thickness, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(boxLength - thickness, (jointHeight * i), thickness);
      }
    }

    // Construct bottom
    sidePiece.vertex(boxLength, boxHeight, 0);  // Significant
    sidePiece.vertex(boxLength, boxHeight, thickness);

    sidePiece.vertex(0, boxHeight, 0);  // Significant
    sidePiece.vertex(0, boxHeight, thickness);

    // Construct joints
    for (int i = (jointAmount - 1); i >= 1; i--) {
      if (i % 2 == 0) {
        sidePiece.vertex(0, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(0, (jointHeight * i), thickness);

        sidePiece.vertex(thickness, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(thickness, (jointHeight * i), thickness);
      } else {
        sidePiece.vertex(thickness, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(thickness, (jointHeight * i), thickness);

        sidePiece.vertex(0, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(0, (jointHeight * i), thickness);
      }
    }

    // Close
    sidePiece.vertex(0, 0, 0);  // Significant
    sidePiece.vertex(0, 0, thickness);
  }
}


/**
 *  Class that can plot and draw a side piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
class Shape_End_Piece extends Shape_Template_Static {

  // Objects
  private PShape endPiece;                // Declaring the end piece shape

  // Booleans
  private boolean updateShape = false;     // When set to true, the vertices of the shape will be replotted.

  Shape_End_Piece() {
    endPiece = createShape();
    endPiece.beginShape(TRIANGLE_STRIP);
    initialise(endPiece);
    plotShape(endPiece);
    endPiece.endShape(CLOSE);
  }

  private void draw() {
    display(updateShape, endPiece);
  }

  @Override
    void plotShape(PShape shape) {
    // Construct top
    shape.vertex(0, 0, 0);      // Significant
    shape.vertex(0, 0, thickness);

    shape.vertex(endPieceLength, 0, 0);       // Significant
    shape.vertex(endPieceLength, 0, thickness);

    // Construct joints
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        shape.vertex((endPieceLength + thickness), (jointHeight * i), 0);      // Significant
        shape.vertex((endPieceLength + thickness), (jointHeight * i), thickness); 

        shape.vertex(endPieceLength, (jointHeight * i), 0);      // Significant
        shape.vertex(endPieceLength, (jointHeight * i), thickness);
      } else {
        shape.vertex(endPieceLength, (jointHeight * i), 0);      // Significant
        shape.vertex(endPieceLength, (jointHeight * i), thickness);

        shape.vertex((endPieceLength + thickness), (jointHeight * i), 0);      // Significant
        shape.vertex((endPieceLength + thickness), (jointHeight * i), thickness);
      }
    }


    // Construct bottom
    shape.vertex(endPieceLength, boxHeight, 0);      // Significant
    shape.vertex(endPieceLength, boxHeight, thickness);

    shape.vertex(0, boxHeight, 0);      // Significant
    shape.vertex(0, boxHeight, thickness);

    // Construct joints
    for (int i = (jointAmount - 1); i >= 1; i--) {
      if (i % 2 == 0) {
        shape.vertex(0, (jointHeight * i), 0);      // Significant
        shape.vertex(0, (jointHeight * i), thickness);

        shape.vertex(-thickness, (jointHeight * i), 0);      // Significant
        shape.vertex(-thickness, (jointHeight * i), thickness);
      } else {
        shape.vertex(-thickness, (jointHeight * i), 0);      // Significant
        shape.vertex(-thickness, (jointHeight * i), thickness);

        shape.vertex(0, (jointHeight * i), 0);      // Significant
        shape.vertex(0, (jointHeight * i), thickness);
      }
    } 

    // Construct bottom
    shape.vertex(0, jointHeight, 0);      // Significant
    shape.vertex(0, jointHeight, thickness);

    shape.vertex(0, 0, 0);                // Significant
    shape.vertex(0, 0, thickness);
  }
}
