// Creates and Renders an SVG End Piece to a given canvas
class SVG_End_Piece extends SVG_Shape {

  // Constants
  private static final boolean INVERT_JOINTS = true;

  SVG_End_Piece(PGraphics svg, int xOffset, int yOffset) {
    super(svg, xOffset, yOffset);
    constructCornerJoints(INVERT_JOINTS, boxWidthC);
    createCenterSlots(INVERT_JOINTS, constructCenter, centerExtrudeThroughSideEnabled, centerJointPosC, endPieceJointLengthC);
    sideCreateTop(INVERT_JOINTS, boxWidthC, endPieceJointLengthC, centerJointPosC, constructCenter, centerExtrudeThroughSideEnabled);
    createRaisedFloorSlot(constructCenter, centerJointPosC, endPieceJointLengthC);
    sideCreateBottom(INVERT_JOINTS, boxWidthC, endPieceJointLengthC, centerJointPosC, constructCenter);
  }
}
