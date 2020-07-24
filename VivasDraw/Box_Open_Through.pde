/**
 *  Class that can plot and draw an open top and bottom box to the screen.
 *  Implements the box template interface.
 *  By Cian O'Gorman 18-07-2020.
 */
class Box_Open_Through implements Box_Template {

  // Declaring Objects
  private Shape_Side_Piece sidePieceOne;
  private Shape_Side_Piece sidePieceTwo;
  private Shape_End_Piece endPieceOne;
  private Shape_End_Piece endPieceTwo;

  Box_Open_Through(PGraphics graphicContext) {
    // Initialising Box Objects
    sidePieceOne = new Shape_Side_Piece();
    sidePieceTwo = new Shape_Side_Piece();
    endPieceOne = new Shape_End_Piece();
    endPieceTwo = new Shape_End_Piece();
    setGraphicContext(graphicContext);
  }

  private void draw(PGraphics graphics) {
    positionGeometry(graphics);
  }

  void positionGeometry(PGraphics graphics) {
    pushMatrix();
    {      
      // Centering object on origin
      translate(-(boxLength / 2), -(boxHeight / 2), (boxWidth / 2));
      translate(0, 0, -thickness);
      
      
      // Individual piece positioning
      
      // Render side piece one
      //sidePieceOne.draw();
      
      pushMatrix();
      {
        translate(0, 0, -(endPieceLength + thickness)); // Moving the graphics context on the z axis 
        //sidePieceTwo.draw();
      }
      popMatrix();

      // Render end piece one
      pushMatrix();
      {
        rotateY(radians(90));                     // Rotating the graphic context 90 degrees
        //endPieceOne.draw();
      }
      popMatrix();

      // Render end piece Two
      pushMatrix();
      {
        rotateY(radians(90));                     // Rotating the graphic context 90 degrees
        translate(0, 0, (boxLength - thickness)); // Translating on the local z axis.
        endPieceTwo.draw();
      }
      popMatrix();
    }
    popMatrix();
  }

  void setGraphicContext(PGraphics graphicContext) {
    sidePieceOne.setGraphicContext(graphicContext);
    sidePieceTwo.setGraphicContext(graphicContext);
    endPieceOne.setGraphicContext(graphicContext);
    endPieceTwo.setGraphicContext(graphicContext);
  }
}
