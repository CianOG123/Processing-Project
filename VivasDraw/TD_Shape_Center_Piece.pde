/**
 *  Class that can plot and draw a centre partition piece to the screen.
 *  By Cian O'Gorman 16-08-2020.
 */
private class TD_Shape_Center_Piece extends TD_Shape_Internal_Piece {

  // Constants
  private static final boolean DONT_INVERT_JOINTS = false;

  private PShape joints;
  private PShape slots;

  TD_Shape_Center_Piece() {
    joints = constructCenterJoints(DONT_INVERT_JOINTS);
    slots = constructCrossSlots();
  }

  private void draw() {
    display(joints);
    display(slots);
    graphicContext.pushMatrix();
    {
      graphicContext.translate(boxLength, 0, thickness);
      graphicContext.rotateY(radians(180));
      display(joints);
    }
    graphicContext.popMatrix();
  }

  // Constructs the cross piece slots in the center piece
  private PShape constructCrossSlots() {
    PShape crossSlots = createShape(GROUP);
    float yPosition = thickness;
    float jointYPosition = 0;
    if (constructTop == false) {
      yPosition = 0;
    }
    float centerPoint = (boxHeight / 2);
    if (floorOffsetEnabled == true && constructBottom == true) {
      centerPoint = ((boxHeight - floorOffset) / 2);
    }
    for (int i = 0; i < constructCenter.length; i++) {
      if (constructCross[i] == true) {
        PShape slot = createShape();
        slot.beginShape(TRIANGLE_STRIP);
        initialise(slot);
        // left side of joint slot
        if (crossJointPos[i] > sidePieceJointLength + thickness && crossJointPos[i] < sidePieceJointLength * 2 + thickness) {
          jointPoints.add(crossJointPos[i]);
          slot.vertex(crossJointPos[i], jointYPosition, 0);
          slot.vertex(crossJointPos[i], jointYPosition, thickness);
          slot.vertex(crossJointPos[i], centerPoint, 0);
          slot.vertex(crossJointPos[i], centerPoint, thickness);
        } else {
          jointPoints.add(crossJointPosC[i]);
          slot.vertex(crossJointPos[i], yPosition, 0);
          slot.vertex(crossJointPos[i], yPosition, thickness);
          slot.vertex(crossJointPos[i], centerPoint, 0);
          slot.vertex(crossJointPos[i], centerPoint, thickness);
        }
        // right side of joint slot
        if (crossJointPos[i] + thickness > sidePieceJointLength + thickness && crossJointPos[i] + thickness < sidePieceJointLength * 2 + thickness) {
          slot.vertex(crossJointPos[i] + thickness, centerPoint, 0);
          slot.vertex(crossJointPos[i] + thickness, centerPoint, thickness);
          slot.vertex(crossJointPos[i] + thickness, jointYPosition, 0);
          slot.vertex(crossJointPos[i] + thickness, jointYPosition, thickness);
        } else {
          slot.vertex(crossJointPos[i] + thickness, centerPoint, 0);
          slot.vertex(crossJointPos[i] + thickness, centerPoint, thickness);
          slot.vertex(crossJointPos[i] + thickness, yPosition, 0);
          slot.vertex(crossJointPos[i] + thickness, yPosition, thickness);
        }
        slot.endShape();
        crossSlots.addChild(slot);
      }
    }
    return crossSlots;
  }
}
