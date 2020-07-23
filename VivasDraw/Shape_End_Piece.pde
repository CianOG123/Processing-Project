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
    endPiece.beginShape();
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
    shape.vertex(endPieceLength, 0, thickness);
    shape.vertex(0, 0, 0);


    shape.vertex(endPieceLength, 0, 0);       // Significant
    shape.vertex(endPieceLength, 0, thickness);
    shape.vertex(endPieceLength, jointHeight, thickness);
    shape.vertex(endPieceLength, 0, 0);

    shape.vertex(endPieceLength, jointHeight, 0);      // Significant
    shape.vertex(endPieceLength, jointHeight, thickness);
    shape.vertex((endPieceLength + thickness), jointHeight, thickness);
    shape.vertex(endPieceLength, jointHeight, 0);

    shape.vertex((endPieceLength + thickness), jointHeight, 0);      // Significant
    shape.vertex((endPieceLength + thickness), jointHeight, thickness);
    shape.vertex((endPieceLength + thickness), (jointHeight * 2), thickness);
    shape.vertex((endPieceLength + thickness), jointHeight, 0);

    shape.vertex((endPieceLength + thickness), (jointHeight * 2), 0);      // Significant
    shape.vertex((endPieceLength + thickness), (jointHeight * 2), thickness); 
    shape.vertex(endPieceLength, (jointHeight * 2), thickness); 
    shape.vertex((endPieceLength + thickness), (jointHeight * 2), 0);

    shape.vertex(endPieceLength, (jointHeight * 2), 0);      // Significant
    shape.vertex(endPieceLength, (jointHeight * 2), thickness); 
    shape.vertex(endPieceLength, (jointHeight * 3), thickness);
    shape.vertex(endPieceLength, (jointHeight * 2), 0);

    shape.vertex(endPieceLength, (jointHeight * 3), 0);      // Significant
    shape.vertex(endPieceLength, (jointHeight * 3), thickness);
    shape.vertex((endPieceLength + thickness), (jointHeight * 3), thickness);
    shape.vertex(endPieceLength, (jointHeight * 3), 0);

    shape.vertex((endPieceLength + thickness), (jointHeight * 3), 0);      // Significant
    shape.vertex((endPieceLength + thickness), (jointHeight * 3), thickness); 
    shape.vertex((endPieceLength + thickness), (jointHeight * 4), thickness);
    shape.vertex((endPieceLength + thickness), (jointHeight * 3), 0);


    shape.vertex((endPieceLength + thickness), (jointHeight * 4), 0);      // Significant
    shape.vertex((endPieceLength + thickness), (jointHeight * 4), thickness);
    shape.vertex(endPieceLength, (jointHeight * 4), thickness);
    shape.vertex((endPieceLength + thickness), (jointHeight * 4), 0);

    shape.vertex(endPieceLength, (jointHeight * 4), 0);      // Significant
    shape.vertex(endPieceLength, (jointHeight * 4), thickness);
    shape.vertex(endPieceLength, boxHeight, thickness);
    shape.vertex(endPieceLength, (jointHeight * 4), 0);

    shape.vertex(endPieceLength, boxHeight, 0);      // Significant
    shape.vertex(endPieceLength, boxHeight, thickness);
    shape.vertex(0, boxHeight, thickness);
    shape.vertex(endPieceLength, boxHeight, 0);

    shape.vertex(0, boxHeight, 0);      // Significant
    shape.vertex(0, boxHeight, thickness);
    shape.vertex(0, (jointHeight * 4), thickness);
    shape.vertex(0, boxHeight, 0);

    shape.vertex(0, (jointHeight * 4), 0);      // Significant
    shape.vertex(0, (jointHeight * 4), thickness);
    shape.vertex(-thickness, (jointHeight * 4), thickness);
    shape.vertex(0, (jointHeight * 4), 0);

    shape.vertex(-thickness, (jointHeight * 4), 0);      // Significant
    shape.vertex(-thickness, (jointHeight * 4), thickness);
    shape.vertex(-thickness, (jointHeight * 3), thickness);
    shape.vertex(-thickness, (jointHeight * 4), 0);

    shape.vertex(-thickness, (jointHeight * 3), 0);      // Significant
    shape.vertex(-thickness, (jointHeight * 3), thickness);
    shape.vertex(0, (jointHeight * 3), thickness); 
    shape.vertex(-thickness, (jointHeight * 3), 0);

    shape.vertex(0, (jointHeight * 3), 0);      // Significant
    shape.vertex(0, (jointHeight * 3), thickness); 
    shape.vertex(0, (jointHeight * 2), thickness);
    shape.vertex(0, (jointHeight * 3), 0);

    shape.vertex(0, (jointHeight * 2), 0);      // Significant
    shape.vertex(0, (jointHeight * 2), thickness);
    shape.vertex(-thickness, (jointHeight * 2), thickness);
    shape.vertex(0, (jointHeight * 2), 0);

    shape.vertex(-thickness, (jointHeight * 2), 0);      // Significant
    shape.vertex(-thickness, (jointHeight * 2), thickness);
    shape.vertex(-thickness, jointHeight, thickness);
    shape.vertex(-thickness, (jointHeight * 2), 0); 

    shape.vertex(-thickness, jointHeight, 0);      // Significant
    shape.vertex(-thickness, jointHeight, thickness); 
    shape.vertex(0, jointHeight, thickness); 
    shape.vertex(-thickness, jointHeight, 0);

    shape.vertex(0, jointHeight, 0);      // Significant
    shape.vertex(0, jointHeight, thickness);
    shape.vertex(0, 0, thickness);
    shape.vertex(0, jointHeight, 0);
  }
}
