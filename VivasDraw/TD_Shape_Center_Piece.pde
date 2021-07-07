/**
 *  Class that can plot and draw a centre partition piece to the screen.
 *  By Cian O'Gorman 16-08-2020.
 */
private class TD_Shape_Center_Piece extends TD_Shape_Internal_Piece {

  // Constants
  private static final boolean DONT_INVERT_JOINTS = false;
  private static final boolean IS_CENTER_PIECE = true;

  private PShape joints;
  private PShape slots;

  TD_Shape_Center_Piece() {
    joints = constructCenterJoints(DONT_INVERT_JOINTS);
    slots = constructSlots(IS_CENTER_PIECE, sidePieceJointLength, crossJointPos, constructCross);
  }

  private void draw() {
    display(slots);
    display(joints);
    graphicContext.pushMatrix();
    {
      graphicContext.translate(boxLength, 0, thickness);
      graphicContext.rotateY(radians(180));
      display(joints);
    }
    graphicContext.popMatrix();
  }
}
