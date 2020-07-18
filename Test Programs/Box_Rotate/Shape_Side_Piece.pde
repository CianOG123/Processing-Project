/**
 *  Class that can plot and draw a side piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
class Shape_Side_Piece extends Shape_Super_Template_Static {

  // Objects
  PShape sidePiece;                // Declaring the side piece shape

  // Booleans
  private boolean updateShape = false;     // When set to true, the vertices of the shape will be replotted.

  Shape_Side_Piece() {
    sidePiece = createShape();
    sidePiece.beginShape();
    initialise(sidePiece);
    plotShape(sidePiece);
    sidePiece.endShape(CLOSE);
  }

  void draw() {
    display(updateShape, sidePiece);
  }

  @Override
    void plotShape(PShape shape) {
    sidePiece.vertex(0, 0, 0);      // Significant
    sidePiece.vertex(0, 0, thickness);
    sidePiece.vertex(boxLength, 0, thickness);
    sidePiece.vertex(0, 0, 0);

    sidePiece.vertex(boxLength, 0, 0);       // Significant
    sidePiece.vertex(boxLength, 0, thickness);
    sidePiece.vertex(boxLength, jointHeight, thickness);
    sidePiece.vertex(boxLength, 0, 0);

    sidePiece.vertex(boxLength, jointHeight, 0);      // Significant
    sidePiece.vertex(boxLength, jointHeight, thickness);
    sidePiece.vertex(boxLength - thickness, 20, thickness);
    sidePiece.vertex(boxLength, jointHeight, 0);

    sidePiece.vertex(boxLength - thickness, jointHeight, 0);      // Significant
    sidePiece.vertex(boxLength - thickness, jointHeight, thickness);
    sidePiece.vertex(boxLength - thickness, (jointHeight * 2), thickness);
    sidePiece.vertex(boxLength - thickness, jointHeight, 0);

    sidePiece.vertex(boxLength - thickness, (jointHeight * 2), 0);      // Significant
    sidePiece.vertex(boxLength - thickness, (jointHeight * 2), thickness);
    sidePiece.vertex(boxLength, (jointHeight * 2), thickness);
    sidePiece.vertex((boxLength - thickness), (jointHeight * 2), 0);

    sidePiece.vertex(boxLength, (jointHeight * 2), 0);      // Significant
    sidePiece.vertex(boxLength, (jointHeight * 2), thickness);
    sidePiece.vertex(boxLength, (jointHeight * 3), thickness);
    sidePiece.vertex(boxLength, (jointHeight * 2), 0);

    sidePiece.vertex(boxLength, (jointHeight * 3), 0);      // Significant
    sidePiece.vertex(boxLength, (jointHeight * 3), thickness);
    sidePiece.vertex((boxLength - thickness), (jointHeight * 3), thickness);
    sidePiece.vertex(boxLength, (jointHeight * 3), 0);

    sidePiece.vertex(boxLength - thickness, (jointHeight * 3), 0);      // Significant
    sidePiece.vertex(boxLength - thickness, (jointHeight * 3), thickness); 
    sidePiece.vertex(boxLength - thickness, (jointHeight * 4), thickness);
    sidePiece.vertex(boxLength - thickness, (jointHeight * 3), 0);

    sidePiece.vertex(boxLength - thickness, (jointHeight * 4), 0);      // Significant
    sidePiece.vertex(boxLength - thickness, (jointHeight * 4), thickness);
    sidePiece.vertex(boxLength, (jointHeight * 4), thickness); 
    sidePiece.vertex(boxLength - thickness, (jointHeight * 4), 0); 

    sidePiece.vertex(boxLength, (jointHeight * 4), 0);      // Significant
    sidePiece.vertex(boxLength, (jointHeight * 4), thickness);
    sidePiece.vertex(boxLength, boxHeight, thickness); 
    sidePiece.vertex(boxLength, (jointHeight * 4), 0);

    sidePiece.vertex(boxLength, boxHeight, 0);      // Significant
    sidePiece.vertex(boxLength, boxHeight, thickness);
    sidePiece.vertex(0, boxHeight, thickness);
    sidePiece.vertex(boxLength, boxHeight, 0);

    sidePiece.vertex(0, boxHeight, 0);      // Significant
    sidePiece.vertex(0, boxHeight, thickness);
    sidePiece.vertex(0, (jointHeight * 4), thickness);
    sidePiece.vertex(0, boxHeight, 0);

    sidePiece.vertex(0, (jointHeight * 4), 0);      // Significant
    sidePiece.vertex(0, (jointHeight * 4), thickness);
    sidePiece.vertex(thickness, (jointHeight * 4), thickness);
    sidePiece.vertex(0, (jointHeight * 4), 0);

    sidePiece.vertex(thickness, (jointHeight * 4), 0);      // Significant
    sidePiece.vertex(thickness, (jointHeight * 4), thickness);
    sidePiece.vertex(thickness, (jointHeight * 3), thickness);
    sidePiece.vertex(thickness, (jointHeight * 4), 0);

    sidePiece.vertex(thickness, (jointHeight * 3), 0);      // Significant
    sidePiece.vertex(thickness, (jointHeight * 3), thickness);
    sidePiece.vertex(0, (jointHeight * 3), thickness);
    sidePiece.vertex(thickness, (jointHeight * 3), 0);

    sidePiece.vertex(0, (jointHeight * 3), 0);      // Significant
    sidePiece.vertex(0, (jointHeight * 3), thickness); 
    sidePiece.vertex(0, (jointHeight * 2), thickness); 
    sidePiece.vertex(0, (jointHeight * 3), 0);

    sidePiece.vertex(0, (jointHeight * 2), 0);      // Significant
    sidePiece.vertex(0, (jointHeight * 2), thickness);
    sidePiece.vertex(thickness, (jointHeight * 2), thickness);
    sidePiece.vertex(0, (jointHeight * 2), 0);

    sidePiece.vertex(thickness, (jointHeight * 2), 0);      // Significant
    sidePiece.vertex(thickness, (jointHeight * 2), thickness);
    sidePiece.vertex(thickness, jointHeight, thickness); 
    sidePiece.vertex(thickness, (jointHeight * 2), 0);

    sidePiece.vertex(thickness, jointHeight, 0);      // Significant
    sidePiece.vertex(thickness, jointHeight, thickness);
    sidePiece.vertex(0, jointHeight, thickness);
    sidePiece.vertex(thickness, jointHeight, 0);

    sidePiece.vertex(0, jointHeight, 0);      // Significant
    sidePiece.vertex(0, jointHeight, thickness);
    sidePiece.vertex(0, 0, thickness);
    sidePiece.vertex(0, jointHeight, 0);
  }
}
