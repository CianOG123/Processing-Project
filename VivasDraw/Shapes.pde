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
    sidePiece.vertex(0, 0, 0);  // Significant
    sidePiece.vertex(0, 0, thickness);

    sidePiece.vertex(boxLength, 0, 0);  // Significant
    sidePiece.vertex(boxLength, 0, thickness);

    sidePiece.vertex(boxLength, jointHeight, 0);  // Significant
    sidePiece.vertex(boxLength, jointHeight, thickness);

    sidePiece.vertex(boxLength - thickness, jointHeight, 0);  // Significant
    sidePiece.vertex(boxLength - thickness, jointHeight, thickness);

    sidePiece.vertex(boxLength - thickness, (jointHeight * 2), 0);  // Significant
    sidePiece.vertex(boxLength - thickness, (jointHeight * 2), thickness);

    sidePiece.vertex(boxLength, (jointHeight * 2), 0);  // Significant
    sidePiece.vertex(boxLength, (jointHeight * 2), thickness);

    sidePiece.vertex(boxLength, (jointHeight * 3), 0);  // Significant
    sidePiece.vertex(boxLength, (jointHeight * 3), thickness);

    sidePiece.vertex(boxLength - thickness, (jointHeight * 3), 0);  // Significant
    sidePiece.vertex(boxLength - thickness, (jointHeight * 3), thickness); 

    sidePiece.vertex(boxLength - thickness, (jointHeight * 4), 0);  // Significant
    sidePiece.vertex(boxLength - thickness, (jointHeight * 4), thickness);

    sidePiece.vertex(boxLength, (jointHeight * 4), 0);  // Significant
    sidePiece.vertex(boxLength, (jointHeight * 4), thickness);

    sidePiece.vertex(boxLength, boxHeight, 0);  // Significant
    sidePiece.vertex(boxLength, boxHeight, thickness);

    sidePiece.vertex(0, boxHeight, 0);  // Significant
    sidePiece.vertex(0, boxHeight, thickness);

    sidePiece.vertex(0, (jointHeight * 4), 0);  // Significant
    sidePiece.vertex(0, (jointHeight * 4), thickness);

    sidePiece.vertex(thickness, (jointHeight * 4), 0);  // Significant
    sidePiece.vertex(thickness, (jointHeight * 4), thickness);

    sidePiece.vertex(thickness, (jointHeight * 3), 0);  // Significant
    sidePiece.vertex(thickness, (jointHeight * 3), thickness);

    sidePiece.vertex(0, (jointHeight * 3), 0);  // Significant
    sidePiece.vertex(0, (jointHeight * 3), thickness); 

    sidePiece.vertex(0, (jointHeight * 2), 0);  // Significant
    sidePiece.vertex(0, (jointHeight * 2), thickness);

    sidePiece.vertex(thickness, (jointHeight * 2), 0);  // Significant
    sidePiece.vertex(thickness, (jointHeight * 2), thickness);

    sidePiece.vertex(thickness, jointHeight, 0);  // Significant
    sidePiece.vertex(thickness, jointHeight, thickness);

    sidePiece.vertex(0, jointHeight, 0);  // Significant
    sidePiece.vertex(0, jointHeight, thickness);

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
    shape.vertex(0, 0, 0);      // Significant
    shape.vertex(0, 0, thickness);

    shape.vertex(endPieceLength, 0, 0);       // Significant
    shape.vertex(endPieceLength, 0, thickness);

    shape.vertex(endPieceLength, jointHeight, 0);      // Significant
    shape.vertex(endPieceLength, jointHeight, thickness);

    shape.vertex((endPieceLength + thickness), jointHeight, 0);      // Significant
    shape.vertex((endPieceLength + thickness), jointHeight, thickness);

    shape.vertex((endPieceLength + thickness), (jointHeight * 2), 0);      // Significant
    shape.vertex((endPieceLength + thickness), (jointHeight * 2), thickness); 

    shape.vertex(endPieceLength, (jointHeight * 2), 0);      // Significant
    shape.vertex(endPieceLength, (jointHeight * 2), thickness); 

    shape.vertex(endPieceLength, (jointHeight * 3), 0);      // Significant
    shape.vertex(endPieceLength, (jointHeight * 3), thickness);

    shape.vertex((endPieceLength + thickness), (jointHeight * 3), 0);      // Significant
    shape.vertex((endPieceLength + thickness), (jointHeight * 3), thickness); 

    shape.vertex((endPieceLength + thickness), (jointHeight * 4), 0);      // Significant
    shape.vertex((endPieceLength + thickness), (jointHeight * 4), thickness);
    
    shape.vertex(endPieceLength, (jointHeight * 4), 0);      // Significant
    shape.vertex(endPieceLength, (jointHeight * 4), thickness);

    shape.vertex(endPieceLength, boxHeight, 0);      // Significant
    shape.vertex(endPieceLength, boxHeight, thickness);

    shape.vertex(0, boxHeight, 0);      // Significant
    shape.vertex(0, boxHeight, thickness);

    shape.vertex(0, (jointHeight * 4), 0);      // Significant
    shape.vertex(0, (jointHeight * 4), thickness);

    shape.vertex(-thickness, (jointHeight * 4), 0);      // Significant
    shape.vertex(-thickness, (jointHeight * 4), thickness);

    shape.vertex(-thickness, (jointHeight * 3), 0);      // Significant
    shape.vertex(-thickness, (jointHeight * 3), thickness);

    shape.vertex(0, (jointHeight * 3), 0);      // Significant
    shape.vertex(0, (jointHeight * 3), thickness); 

    shape.vertex(0, (jointHeight * 2), 0);      // Significant
    shape.vertex(0, (jointHeight * 2), thickness);

    shape.vertex(-thickness, (jointHeight * 2), 0);      // Significant
    shape.vertex(-thickness, (jointHeight * 2), thickness);

    shape.vertex(-thickness, jointHeight, 0);      // Significant
    shape.vertex(-thickness, jointHeight, thickness); 

    shape.vertex(0, jointHeight, 0);      // Significant
    shape.vertex(0, jointHeight, thickness);
    
    shape.vertex(0, 0, 0);                // Significant
    shape.vertex(0, 0, thickness);
  }
}
