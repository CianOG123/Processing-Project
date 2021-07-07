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
  private PShape bottom;

  TD_Shape_Center_Piece() {
    joints = constructCenterJoints(DONT_INVERT_JOINTS);
    slots = constructSlots(IS_CENTER_PIECE, sidePieceJointLength, crossJointPos, constructCross);
    findDipPositions(sidePieceJointLength, constructTop);
    bottom = createBottom();
  }

  private void draw() {
    display(bottom);
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

  // Draws the bottom of the center piece
  private PShape createBottom() {
    PShape bottom = createShape(GROUP);
    bottom.beginShape();
    initialise(bottom);
    if (constructBottom == false) {
      //svg.line(thicknessC + xOffset, boxHeightC + yOffset, boxLengthC - thicknessC + xOffset, boxHeightC + yOffset);
      PShape straightBottom = createShape();
      straightBottom.beginShape(TRIANGLE_STRIP);
      initialise(straightBottom);
      straightBottom.vertex(thickness, boxHeight, 0);
      straightBottom.vertex(thickness, boxHeight, thickness);
      straightBottom.vertex(boxLength - thickness, boxHeight, 0);
      straightBottom.vertex(boxLength - thickness, boxHeight, thickness);
      straightBottom.endShape();
      bottom.addChild(straightBottom);
    } else {
      float yPosition = boxHeight - thickness;
      if (floorOffsetEnabled == true) {
        yPosition -= floorOffset;
      }
      // Left of joint
      //svg.line(thicknessC + xOffset, yPosition, sidePieceJointLengthC + thicknessC + xOffset, yPosition);
      //svg.line(sidePieceJointLengthC + thicknessC + xOffset, yPosition, sidePieceJointLengthC + thicknessC + xOffset, yPosition + thicknessC);
      PShape leftBottom = createShape();
      leftBottom.beginShape(TRIANGLE_STRIP);
      initialise(leftBottom);
      leftBottom.vertex(thickness, yPosition, 0);
      leftBottom.vertex(thickness, yPosition, thickness);
      leftBottom.vertex(sidePieceJointLength + thickness, yPosition, 0);
      leftBottom.vertex(sidePieceJointLength + thickness, yPosition, thickness);
      
      leftBottom.vertex(sidePieceJointLength + thickness, yPosition, 0);
      leftBottom.vertex(sidePieceJointLength + thickness, yPosition, thickness);
      leftBottom.vertex(sidePieceJointLength + thickness, yPosition + thickness, 0);
      leftBottom.vertex(sidePieceJointLength + thickness, yPosition + thickness, thickness);
      leftBottom.endShape(CLOSE);
      bottom.addChild(leftBottom);
      // Joint
      float startPosition = sidePieceJointLength + thickness;
      for (int i = 0; i < jointDips.size(); i++) {
        float jointDipPos = jointDips.get(i);
        PShape joint = createShape();
        joint.beginShape(TRIANGLE_STRIP);
        initialise(joint);
        //svg.line(startPosition, yPosition + thicknessC, jointDipPos, yPosition + thicknessC);
        joint.vertex(startPosition, yPosition + thickness, 0);
        joint.vertex(startPosition, yPosition + thickness, thickness);
        joint.vertex(jointDipPos, yPosition + thickness, 0);
        joint.vertex(jointDipPos, yPosition + thickness, thickness);
        //svg.line(jointDipPos, yPosition + thicknessC, jointDipPos, yPosition);
        joint.vertex(jointDipPos, yPosition + thickness, 0);
        joint.vertex(jointDipPos, yPosition + thickness, thickness);
        joint.vertex(jointDipPos, yPosition, 0);
        joint.vertex(jointDipPos, yPosition, thickness);
        //svg.line(jointDipPos, yPosition, jointDipPos + thicknessC, yPosition);
        joint.vertex(jointDipPos, yPosition, 0);
        joint.vertex(jointDipPos, yPosition, thickness);
        joint.vertex(jointDipPos + thickness, yPosition, 0);
        joint.vertex(jointDipPos + thickness, yPosition, thickness);
        //svg.line(jointDipPos + thicknessC, yPosition, jointDipPos + thicknessC, yPosition + thicknessC);
        joint.vertex(jointDipPos + thickness, yPosition, 0);
        joint.vertex(jointDipPos + thickness, yPosition, thickness);
        joint.vertex(jointDipPos + thickness, yPosition + thickness, 0);
        joint.vertex(jointDipPos + thickness, yPosition + thickness, thickness);
        joint.endShape(CLOSE);
        bottom.addChild(joint);
        startPosition = jointDipPos + thickness;
      }
      //svg.line(startPosition, yPosition + thicknessC, (sidePieceJointLengthC * 2) + thicknessC + xOffset, yPosition + thicknessC);
      PShape close = createShape();
      close.beginShape(TRIANGLE_STRIP);
      initialise(close);
      close.vertex(startPosition, yPosition + thickness, 0);
      close.vertex(startPosition, yPosition + thickness, thickness);
      close.vertex((sidePieceJointLength * 2) + thickness, yPosition + thickness, 0);
      close.vertex((sidePieceJointLength * 2) + thickness, yPosition + thickness, thickness);
      close.endShape(CLOSE);
      bottom.addChild(close);

      // Right of Joint
      PShape rightJoint = createShape();
      rightJoint.beginShape(TRIANGLE_STRIP);
      initialise(rightJoint);
      //svg.line((sidePieceJointLengthC * 2) + thicknessC + xOffset, yPosition + thicknessC, (sidePieceJointLengthC * 2) + thicknessC + xOffset, yPosition);
      rightJoint.vertex((sidePieceJointLength * 2) + thickness, yPosition + thickness, 0);
      rightJoint.vertex((sidePieceJointLength * 2) + thickness, yPosition + thickness, thickness);
      rightJoint.vertex((sidePieceJointLength * 2) + thickness, yPosition, 0);
      rightJoint.vertex((sidePieceJointLength * 2) + thickness, yPosition, thickness);
      //svg.line((sidePieceJointLengthC * 2) + thicknessC + xOffset, yPosition, sidePieceLengthC + thicknessC + xOffset, yPosition);
      rightJoint.vertex((sidePieceJointLength * 2) + thickness, yPosition, 0);
      rightJoint.vertex((sidePieceJointLength * 2) + thickness, yPosition, thickness);
      rightJoint.vertex(sidePieceLength + thickness, yPosition, 0);
      rightJoint.vertex(sidePieceLength + thickness, yPosition, thickness);
      rightJoint.endShape(CLOSE);
      bottom.addChild(rightJoint);
    }
    return bottom;
  }
}
