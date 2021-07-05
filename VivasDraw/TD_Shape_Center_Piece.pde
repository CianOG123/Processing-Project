/**
 *  Class that can plot and draw a centre partition piece to the screen.
 *  By Cian O'Gorman 16-08-2020.
 */
private class TD_Shape_Center_Piece extends TD_Shape_Internal_Piece {

  // Constants
  private static final boolean DONT_INVERT_JOINTS = false;

  private PShape centerPiece;

  TD_Shape_Center_Piece() {
    centerPiece = constructCenterJoints(DONT_INVERT_JOINTS, boxLength);
  }

  private void draw() {
    display(centerPiece);
  }
}
