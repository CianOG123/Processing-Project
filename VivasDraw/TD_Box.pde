/**
 *  Default Box
 *  Used for all boxes
 *  Created 07-07-2021
 */
private class TD_Box {

  // Declaring Objects
  private TD_Shape_Side_Piece sidePieceOne;
  private TD_Shape_Side_Piece sidePieceTwo;
  private TD_Shape_End_Piece endPieceOne;
  private TD_Shape_End_Piece endPieceTwo;
  private TD_Shape_Floor_Piece floorPiece;
  private TD_Shape_Floor_Piece topPiece;
  private TD_Shape_Center_Piece[] centerPieces = new TD_Shape_Center_Piece[constructCenter.length];
  private TD_Shape_Cross_Piece[] crossPieces = new TD_Shape_Cross_Piece[constructCross.length];

  TD_Box(PGraphics graphicContext) {

    boolean enableFloorJoint = enableFloorJoint();

    // Initialising Shape Objects
    sidePieceOne = new TD_Shape_Side_Piece(constructTop, enableFloorJoint);
    sidePieceTwo = new TD_Shape_Side_Piece(constructTop, enableFloorJoint);
    endPieceOne = new TD_Shape_End_Piece(constructTop, enableFloorJoint);
    endPieceTwo = new TD_Shape_End_Piece(constructTop, enableFloorJoint);
    floorPiece = new TD_Shape_Floor_Piece();
    topPiece = new TD_Shape_Floor_Piece();
    for (int i = 0; i < centerPieces.length; i++) {
      centerPieces[i] = new TD_Shape_Center_Piece();
      crossPieces[i] = new TD_Shape_Cross_Piece();
    }
    setGraphicContext(graphicContext);
  }

  private boolean enableFloorJoint() {
    if (constructBottom == true && (floorOffsetEnabled == false || floorOffset == 0))
      return true;
    else
      return false;
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
        for (int i = 0; i < constructCenter.length; i++) {
          if (constructCenter[i] == true) {
            graphics.pushMatrix();
            {
              graphics.translate(0, 0, -centerJointPos[i]);
              centerPieces[i].draw();
            }
            graphics.popMatrix();
          }
        }
      }
      graphics.popMatrix();

      // Render cross-section piece
      graphics.pushMatrix();
      {
        graphics.rotateY(radians(90)); 
        for (int i = 0; i < constructCross.length; i++) {
          if (constructCross[i] == true) {
            graphics.pushMatrix();
            {
              graphics.translate(-thickness, 0, crossJointPos[i]);
              crossPieces[i].draw();
            }
            graphics.popMatrix();
          }
        }
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
        if (constructTop == true) {
          graphics.pushMatrix();
          {    
            graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
            topPiece.draw();
          }
          graphics.popMatrix();
        }

        // Render floor piece
        if (constructBottom == true) {
          graphics.pushMatrix();
          {    
            graphics.rotateY(radians(90));                      // Rotating the graphic context 90 degrees
            graphics.translate(0, (boxHeight - thickness), 0);  // Translating on the local Y axis.
            floorPiece.draw();
          }
          graphics.popMatrix();
        }
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
    for (int i = 0; i < centerPieces.length; i++) {
      centerPieces[i].setGraphicContext(graphicContext);
      crossPieces[i].setGraphicContext(graphicContext);
    }
  }
}
