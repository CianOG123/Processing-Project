/**
 *  Class that can plot and draw a side piece to the screen.
 *  Created using examples as a source.
 *  By Cian O'Gorman 16-07-2020.
 */
class Shape_Side_Piece extends Shape_Base {

  // Objects
  PShape sidePiece;                // Declaring the side piece shape

  // Booleans
  protected boolean updateShape = false;     // When set to true, the vertices of the shape will be replotted.

  Shape_Side_Piece() {
    initialiseShape(sidePiece);
  }

  @Override
  void display() {
    sidePiece.draw(getGraphics());
  }

  void update() {
    if (updateShape == true) {
      updateShape = false;
    }
  }

  void plotShape() {
    sidePiece.vertex(0, 0, 0);      // Significant
    sidePiece.vertex(0, 0, 10);
    sidePiece.vertex(200, 0, 10);
    sidePiece.vertex(0, 0, 0);

    sidePiece.vertex(200, 0, 0);       // Significant
    sidePiece.vertex(200, 0, 10);
    sidePiece.vertex(200, 20, 10);
    sidePiece.vertex(200, 0, 0);

    sidePiece.vertex(200, 20, 0);      // Significant
    sidePiece.vertex(200, 20, 10);
    sidePiece.vertex(180, 20, 10);
    sidePiece.vertex(200, 20, 0);

    sidePiece.vertex(180, 20, 0);      // Significant
    sidePiece.vertex(180, 20, 10);
    sidePiece.vertex(180, 40, 10);
    sidePiece.vertex(180, 20, 0);

    sidePiece.vertex(180, 40, 0);      // Significant
    sidePiece.vertex(180, 40, 10);
    sidePiece.vertex(200, 40, 10);
    sidePiece.vertex(180, 40, 0);

    sidePiece.vertex(200, 40, 0);      // Significant
    sidePiece.vertex(200, 40, 10);
    sidePiece.vertex(200, 60, 10);
    sidePiece.vertex(200, 40, 0);

    sidePiece.vertex(200, 60, 0);      // Significant
    sidePiece.vertex(200, 60, 10);
    sidePiece.vertex(180, 60, 10);
    sidePiece.vertex(200, 60, 0);

    sidePiece.vertex(180, 60, 0);      // Significant
    sidePiece.vertex(180, 60, 10); 
    sidePiece.vertex(180, 80, 10);
    sidePiece.vertex(180, 60, 0);

    sidePiece.vertex(180, 80, 0);      // Significant
    sidePiece.vertex(180, 80, 10);
    sidePiece.vertex(200, 80, 10); 
    sidePiece.vertex(180, 80, 0); 

    sidePiece.vertex(200, 80, 0);      // Significant
    sidePiece.vertex(200, 80, 10);
    sidePiece.vertex(200, 100, 10); 
    sidePiece.vertex(200, 80, 0);

    sidePiece.vertex(200, 100, 0);      // Significant
    sidePiece.vertex(200, 100, 10);
    sidePiece.vertex(0, 100, 10);
    sidePiece.vertex(200, 100, 0);

    sidePiece.vertex(0, 100, 0);      // Significant
    sidePiece.vertex(0, 100, 10);
    sidePiece.vertex(0, 80, 10);
    sidePiece.vertex(0, 100, 0);

    sidePiece.vertex(0, 80, 0);      // Significant
    sidePiece.vertex(0, 80, 10);
    sidePiece.vertex(20, 80, 10);
    sidePiece.vertex(0, 80, 0);

    sidePiece.vertex(20, 80, 0);      // Significant
    sidePiece.vertex(20, 80, 10);
    sidePiece.vertex(20, 60, 10);
    sidePiece.vertex(20, 80, 0);

    sidePiece.vertex(20, 60, 0);      // Significant
    sidePiece.vertex(20, 60, 10);
    sidePiece.vertex(0, 60, 10);
    sidePiece.vertex(20, 60, 0);

    sidePiece.vertex(0, 60, 0);      // Significant
    sidePiece.vertex(0, 60, 10); 
    sidePiece.vertex(0, 40, 10); 
    sidePiece.vertex(0, 60, 0);

    sidePiece.vertex(0, 40, 0);      // Significant
    sidePiece.vertex(0, 40, 10);
    sidePiece.vertex(20, 40, 10);
    sidePiece.vertex(0, 40, 0);

    sidePiece.vertex(20, 40, 0);      // Significant
    sidePiece.vertex(20, 40, 10);
    sidePiece.vertex(20, 20, 10); 
    sidePiece.vertex(20, 40, 0);

    sidePiece.vertex(20, 20, 0);      // Significant
    sidePiece.vertex(20, 20, 10);
    sidePiece.vertex(0, 20, 10);
    sidePiece.vertex(20, 20, 0);

    sidePiece.vertex(0, 20, 0);      // Significant
    sidePiece.vertex(0, 20, 10);
    sidePiece.vertex(0, 0, 10);
    sidePiece.vertex(0, 20, 0);
  }
}
