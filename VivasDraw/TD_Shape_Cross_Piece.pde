/**
 *  Class that can plot and draw a cross partition piece to the screen.
 *  By Cian O'Gorman 05-07-2021.
 */
private class TD_Shape_Cross_Piece extends TD_Shape_Internal_Piece {

  // Constants
  private static final boolean INVERT_JOINTS = true;

  private PShape crossPiece;

  TD_Shape_Cross_Piece() {
    crossPiece = constructCenterJoints(INVERT_JOINTS, boxWidth);
  } 
  
  private void draw() {
    display(crossPiece);
  }
}
