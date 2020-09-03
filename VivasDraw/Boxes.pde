/** 
 *  Interface designed for all boxes to use and follow.
 *  By Cian O'Gorman 18-07-2020
 */
private interface Box_Template {

  // Handles the positioning and rotation of each individual part of the box
  void positionGeometry(PGraphics graphics);

  // Sets the graphical context container of each part of the box
  void setGraphicContext(PGraphics graphicContext);
}

/**
 *  Cross Section Box
 *  Class that can plot and draw a cross sectional box to the screen.
 *  Implements the box template interface.
 *  By Cian O'Gorman 02-09-2020.
 */
private class Box_Cross_Section implements Box_Template {

  // Constants
  private static final boolean ENABLE_TOP = true;
  private static final boolean ENABLE_FLOOR = true;

  // Declaring Objects
  private Shape_Side_Piece sidePieceOne;
  private Shape_Side_Piece sidePieceTwo;
  private Shape_End_Piece endPieceOne;
  private Shape_End_Piece endPieceTwo;
  private Shape_Floor_Piece floorPiece;
  private Shape_Floor_Piece topPiece;
  private Shape_Center_Piece centerPiece;

  // Creates a box with a center part
  Box_Cross_Section(PGraphics graphicContext) {
    // Initialising booleans
    constructCrossPiece = true;

    // Initialising Box Objects
    sidePieceOne = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    sidePieceTwo = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceOne = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceTwo = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    floorPiece = new Shape_Floor_Piece();
    topPiece = new Shape_Floor_Piece();
    centerPiece = new Shape_Center_Piece();
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

      // Render center piece
      graphics.pushMatrix();
      {
        graphics.translate(0, 0, - ((endPieceLength + thickness) / 2));
        centerPiece.draw();
      }
      graphics.popMatrix();

      // Render side piece two
      graphics.pushMatrix();
      {
        graphics.translate(0, 0, -(endPieceLength + thickness));  // Moving the graphics context on the z axis 
        sidePieceTwo.draw();
      }
      graphics.popMatrix();

      // Render end piece one
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));  // Rotating the graphic context 90 degrees
        endPieceOne.draw();
      }
      graphics.popMatrix();

      // Render end piece Two
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
        graphics.translate(0, 0, (boxLength - thickness));  // Translating on the local Z axis.
        endPieceTwo.draw();

        // Render top piece
        graphics.pushMatrix();
        {    
          graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
          topPiece.draw();
        }
        graphics.popMatrix();

        // Render floor piece
        graphics.pushMatrix();
        {    
          graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
          graphics.translate(0, (boxHeight - thickness), 0);  // Translating on the local Y axis.
          floorPiece.draw();
        }
        graphics.popMatrix();
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
    floorPiece.setGraphicContext(graphicContext);
    topPiece.setGraphicContext(graphicContext);
    centerPiece.setGraphicContext(graphicContext);
  }
}


/**
 *  Center Part Box
 *  Class that can plot and draw an open top box to the screen.
 *  Implements the box template interface.
 *  By Cian O'Gorman 30-07-2020.
 */
private class Box_Center_Part implements Box_Template {

  // Constants
  private static final boolean ENABLE_TOP = true;
  private static final boolean ENABLE_FLOOR = true;

  // Declaring Objects
  private Shape_Side_Piece sidePieceOne;
  private Shape_Side_Piece sidePieceTwo;
  private Shape_End_Piece endPieceOne;
  private Shape_End_Piece endPieceTwo;
  private Shape_Floor_Piece floorPiece;
  private Shape_Floor_Piece topPiece;
  private Shape_Center_Piece centerPiece;

  // Creates a box with a center part
  Box_Center_Part(PGraphics graphicContext) {
    // Initialising booleans
    constructCrossPiece = false;

    // Initialising Box Objects
    sidePieceOne = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    sidePieceTwo = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceOne = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceTwo = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    floorPiece = new Shape_Floor_Piece();
    topPiece = new Shape_Floor_Piece();
    centerPiece = new Shape_Center_Piece();
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

      // Render center piece
      graphics.pushMatrix();
      {
        graphics.translate(0, 0, - ((endPieceLength + thickness) / 2));
        centerPiece.draw();
      }
      graphics.popMatrix();

      // Render side piece two
      graphics.pushMatrix();
      {
        graphics.translate(0, 0, -(endPieceLength + thickness));  // Moving the graphics context on the z axis 
        sidePieceTwo.draw();
      }
      graphics.popMatrix();

      // Render end piece one
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));  // Rotating the graphic context 90 degrees
        endPieceOne.draw();
      }
      graphics.popMatrix();

      // Render end piece Two
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
        graphics.translate(0, 0, (boxLength - thickness));  // Translating on the local Z axis.
        endPieceTwo.draw();

        // Render top piece
        graphics.pushMatrix();
        {    
          graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
          topPiece.draw();
        }
        graphics.popMatrix();

        // Render floor piece
        graphics.pushMatrix();
        {    
          graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
          graphics.translate(0, (boxHeight - thickness), 0);  // Translating on the local Y axis.
          floorPiece.draw();
        }
        graphics.popMatrix();
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
    floorPiece.setGraphicContext(graphicContext);
    topPiece.setGraphicContext(graphicContext);
    centerPiece.setGraphicContext(graphicContext);
  }
}

/**
 *  Closed Box
 *  Class that can plot and draw an open top box to the screen.
 *  Implements the box template interface.
 *  By Cian O'Gorman 27-07-2020.
 */
private class Box_Closed implements Box_Template {

  // Constants
  private static final boolean ENABLE_TOP = true;
  private static final boolean ENABLE_FLOOR = true;

  // Declaring Objects
  private Shape_Side_Piece sidePieceOne;
  private Shape_Side_Piece sidePieceTwo;
  private Shape_End_Piece endPieceOne;
  private Shape_End_Piece endPieceTwo;
  private Shape_Floor_Piece floorPiece;
  private Shape_Floor_Piece topPiece;

  Box_Closed(PGraphics graphicContext) {
    // Initialising booleans
    constructCrossPiece = false;

    // Initialising Box Objects
    sidePieceOne = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    sidePieceTwo = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceOne = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceTwo = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    floorPiece = new Shape_Floor_Piece();
    topPiece = new Shape_Floor_Piece();
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
        graphics.translate(0, 0, -(endPieceLength + thickness));  // Moving the graphics context on the z axis 
        sidePieceTwo.draw();
      }
      graphics.popMatrix();

      // Render end piece one
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));  // Rotating the graphic context 90 degrees
        endPieceOne.draw();
      }
      graphics.popMatrix();

      // Render end piece Two
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
        graphics.translate(0, 0, (boxLength - thickness));  // Translating on the local Z axis.
        endPieceTwo.draw();

        // Render top piece
        graphics.pushMatrix();
        {    
          graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
          topPiece.draw();
        }
        graphics.popMatrix();

        // Render floor piece
        graphics.pushMatrix();
        {    
          graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
          graphics.translate(0, (boxHeight - thickness), 0);  // Translating on the local Y axis.
          floorPiece.draw();
        }
        graphics.popMatrix();
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
    floorPiece.setGraphicContext(graphicContext);
    topPiece.setGraphicContext(graphicContext);
  }
}

/**
 *  Open Top Box
 *  Class that can plot and draw an open top box to the screen.
 *  Implements the box template interface.
 *  By Cian O'Gorman 27-07-2020.
 */
private class Box_Open_Top implements Box_Template {

  // Constants
  private static final boolean ENABLE_TOP = false;
  private static final boolean ENABLE_FLOOR = true;

  // Declaring Objects
  private Shape_Side_Piece sidePieceOne;
  private Shape_Side_Piece sidePieceTwo;
  private Shape_End_Piece endPieceOne;
  private Shape_End_Piece endPieceTwo;
  private Shape_Floor_Piece floorPiece;

  Box_Open_Top(PGraphics graphicContext) {
    // Initialising booleans
    constructCrossPiece = false;

    // Initialising Box Objects
    sidePieceOne = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    sidePieceTwo = new Shape_Side_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceOne = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    endPieceTwo = new Shape_End_Piece(ENABLE_TOP, ENABLE_FLOOR);
    floorPiece = new Shape_Floor_Piece();
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
        graphics.translate(0, 0, -(endPieceLength + thickness));  // Moving the graphics context on the z axis 
        sidePieceTwo.draw();
      }
      graphics.popMatrix();

      // Render end piece one
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));  // Rotating the graphic context 90 degrees
        endPieceOne.draw();
      }
      graphics.popMatrix();

      // Render end piece Two
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
        graphics.translate(0, 0, (boxLength - thickness));  // Translating on the local Z axis.
        endPieceTwo.draw();
      }

      // Render floor piece
      graphics.pushMatrix();
      {    
        graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
        graphics.translate(0, (boxHeight - thickness), 0);  // Translating on the local Y axis.
        floorPiece.draw();
      }
      graphics.popMatrix();

      graphics.popMatrix();
    }
    graphics.popMatrix();
  }

  void setGraphicContext(PGraphics graphicContext) {
    sidePieceOne.setGraphicContext(graphicContext);
    sidePieceTwo.setGraphicContext(graphicContext);
    endPieceOne.setGraphicContext(graphicContext);
    endPieceTwo.setGraphicContext(graphicContext);
    floorPiece.setGraphicContext(graphicContext);
  }
}


/**
 *  Open Through Box
 *  Class that can plot and draw an open top and bottom box to the screen.
 *  Implements the box template interface.
 *  By Cian O'Gorman 18-07-2020.
 */
private class Box_Open_Through implements Box_Template {

  // Constants
  private static final boolean ENABLE_TOP = false;
  private static final boolean ENABLE_FLOOR = false;

  // Declaring Objects
  private Shape_Side_Piece sidePieceOne;
  private Shape_Side_Piece sidePieceTwo;
  private Shape_End_Piece endPieceOne;
  private Shape_End_Piece endPieceTwo;

  Box_Open_Through(PGraphics graphicContext) {
    // Initialising booleans
    constructCrossPiece = false;

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
