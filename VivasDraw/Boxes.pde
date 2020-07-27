/** 
 *  Interface designed for all boxes to use and follow.
 *  By Cian O'Gorman 18-07-2020
 */
interface Box_Template {

  // Handles the positioning and rotation of each individual part of the box
  void positionGeometry(PGraphics graphics);

  // Sets the graphical context container of each part of the box
  void setGraphicContext(PGraphics graphicContext);
}


/**
 *  Open Through Box
 *  Class that can plot and draw an open top and bottom box to the screen.
 *  Implements the box template interface.
 *  By Cian O'Gorman 18-07-2020.
 */
class Box_Open_Through implements Box_Template {
  
  // Constants
  private static final boolean ENABLE_TOP = false;
  private static final boolean ENABLE_FLOOR = false;

  // Declaring Objects
  private Shape_Side_Piece sidePieceOne;
  private Shape_Side_Piece sidePieceTwo;
  private Shape_End_Piece endPieceOne;
  private Shape_End_Piece endPieceTwo;

  Box_Open_Through(PGraphics graphicContext) {
    // Initialising Box Objects
    sidePieceOne = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    sidePieceTwo = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceOne = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceTwo = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    setGraphicContext(graphicContext);
  }

  private void draw(PGraphics graphics) {
    positionGeometry(graphics);
  }

  void positionGeometry(PGraphics graphics) {
    graphics.pushMatrix();
    {      
      // Centering object on origin
      graphics.translate(-(boxLength / 2), -(boxHeight / 2), (boxWidth / 2));
      graphics.translate(0, 0, -thickness);


      // Individual piece positioning

      // Render side piece one
      sidePieceOne.draw();

      graphics.pushMatrix();
      {
        graphics.translate(0, 0, -(endPieceLength + thickness)); // Moving the graphics context on the z axis 
        sidePieceTwo.draw();
      }
      graphics.popMatrix();

      // Render end piece one
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));                     // Rotating the graphic context 90 degrees
        endPieceOne.draw();
      }
      graphics.popMatrix();

      // Render end piece Two
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));                     // Rotating the graphic context 90 degrees
        graphics.translate(0, 0, (boxLength - thickness)); // Translating on the local z axis.
        endPieceTwo.draw();
      }
      graphics.popMatrix();
    }
    graphics.popMatrix();
  }

  void setGraphicContext(PGraphics graphicContext) {
    sidePieceOne.setGraphicContext(graphicContext);
    sidePieceTwo.setGraphicContext(graphicContext);
    endPieceOne.setGraphicContext(graphicContext);
    endPieceTwo.setGraphicContext(graphicContext);
  }
}
