/**
 *  Class that can plot and draw a cross partition piece to the screen.
 *  By Cian O'Gorman 05-07-2021.
 */
private class TD_Shape_Cross_Piece extends TD_Shape_Internal_Piece {

  // Constants
  private static final boolean INVERT_JOINTS = true;
  private static final boolean IS_NOT_CENTER_PIECE = false;

  private PShape crossPiece;
  private PShape slots;

  TD_Shape_Cross_Piece() {
    crossPiece = constructCenterJoints(INVERT_JOINTS);
    slots = constructSlots(IS_NOT_CENTER_PIECE, endPieceJointLength, centerJointPos, constructCenter);
  } 
  
  private void draw() {
    display(crossPiece);
    display(slots);
    graphicContext.pushMatrix();
    {
      graphicContext.translate(boxWidth, 0, thickness);
      graphicContext.rotateY(radians(180));
      display(crossPiece);
    }
    graphicContext.popMatrix();
  }
}
