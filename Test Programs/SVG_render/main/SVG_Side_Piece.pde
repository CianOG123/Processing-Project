// Creates and Renders an SVG Side Piece to a given canvas
class SVG_Side_Piece extends SVG_Shape {

  // Constants
  private static final boolean DONT_INVERT_JOINTS = false;

  SVG_Side_Piece(PGraphics svg, int xOffset, int yOffset) {
    super(svg, xOffset, yOffset);  
    constructCornerJoints(DONT_INVERT_JOINTS, boxLengthC);
    createCenterSlots(DONT_INVERT_JOINTS, constructCross, crossExtrudeThroughSideEnabled, crossJointPosC, sidePieceJointLengthC);
    sideCreateTop(DONT_INVERT_JOINTS, boxLengthC, sidePieceJointLengthC, crossJointPosC, constructCross, crossExtrudeThroughSideEnabled);
    createRaisedFloorSlot(constructCross, crossJointPosC, sidePieceJointLengthC);
    sideCreateBottom(DONT_INVERT_JOINTS, boxLengthC, sidePieceJointLengthC, crossJointPosC, constructCross);
  }
}
