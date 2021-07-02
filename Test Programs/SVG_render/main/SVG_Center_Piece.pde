// Creates and Renders an SVG Center Piece to a given canvas
class SVG_Center_Piece extends SVG_Internal_Piece {

  // Constants
  private static final boolean DONT_INVERT_JOINTS = false;

  SVG_Center_Piece(PGraphics svg, int xOffset, int yOffset) {
    super(boxLengthC, sidePieceJointLengthC, DONT_INVERT_JOINTS, svg, xOffset, yOffset);
    constructCrossSlots();
    DrawTop();
    findDipPositions(sidePieceJointLengthC, constructTop);
    createBottom();
  }

  // Constructs the cross piece slots in the center piece
  private void constructCrossSlots() {
    float yPosition = thicknessC + yOffset;
    float jointYPosition = yOffset;
    if (constructTop == false) {
      yPosition = yOffset;
    }
    float centerPoint = (boxHeightC / 2) + yOffset;
    if (floorOffsetEnabled == true && constructBottom == true) {
      centerPoint = ((boxHeightC - floorOffsetC) / 2) + yOffset;
    }
    for (int i = 0; i < constructCenter.length; i++) {
      if (constructCross[i] == true) {
        // left side of joint slot
        if (crossJointPosC[i] > sidePieceJointLengthC + thicknessC && crossJointPosC[i] < sidePieceJointLengthC * 2 + thicknessC) {
          jointPointsC.add(crossJointPosC[i]);
          svg.line(crossJointPosC[i] + xOffset, jointYPosition, crossJointPosC[i] + xOffset, centerPoint);
        } else {
          jointPointsC.add(crossJointPosC[i]);
          svg.line(crossJointPosC[i] + xOffset, yPosition, crossJointPosC[i] + xOffset, centerPoint);
        }
        // right side of joint slot
        if (crossJointPosC[i] + thicknessC > sidePieceJointLengthC + thicknessC && crossJointPosC[i] + thicknessC < sidePieceJointLengthC * 2 + thicknessC) {
          svg.line(crossJointPosC[i] + thicknessC + xOffset, centerPoint, crossJointPosC[i] + thicknessC + xOffset, jointYPosition);
        } else {
          svg.line(crossJointPosC[i] + thicknessC + xOffset, centerPoint, crossJointPosC[i] + thicknessC + xOffset, yPosition);
        }
        // Bottom of joint slot
        svg.line(crossJointPosC[i] + xOffset, centerPoint, crossJointPosC[i] + thicknessC + xOffset, centerPoint);
      }
    }
  }

  // Draws the top side of the center piece
  // contructCrossSlots must be called first
  private void DrawTop() {
    boolean drawComplexTop = false;
    for (int i = 0; i < constructCross.length; i++) {
      if (constructCross[i] == true)
        drawComplexTop = true;
    }
    if (drawComplexTop == true)
      drawComplexTop();
    else
      drawNormalTop();
  }

  private void drawComplexTop() {
    Collections.sort(jointPointsC);
    float startPoint = thicknessC + xOffset;
    float yPosition = thicknessC + yOffset;
    if (constructTop == false) {
      yPosition = yOffset;
    }
    boolean pastJointStart = false;
    boolean pastJointEnd = false;
    boolean lastJoint = false;
    int i = 0;
    float jointPoint = jointPointsC.get(i);
    while (i < jointPointsC.size()) {
      if (i == jointPointsC.size() - 1)
        lastJoint = true;
      jointPoint = jointPointsC.get(i);
      if (constructTop == false) {
        svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
        if (lastJoint == false) {
          if (jointPointsC.get(i + 1) < sidePieceJointLengthC * 2 + thicknessC && pastJointStart == true) {
            startPoint = drawDip(jointPoint, jointPointsC.get(i + 1));
          } else
            startPoint = jointPoint + thicknessC + xOffset;
        } else
          startPoint = jointPoint + thicknessC + xOffset;
      } else {
        // joint on start edge
        if (jointPoint <= sidePieceJointLengthC + thicknessC && jointPoint + thicknessC > sidePieceJointLengthC + thicknessC) {
          pastJointStart = true;
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          if (lastJoint == false) {
            if (jointPointsC.get(i + 1) < sidePieceJointLengthC * 2 + thicknessC && jointPointsC.get(i + 1) > sidePieceJointLengthC + thicknessC) {
              startPoint = drawDip(jointPoint, jointPointsC.get(i + 1));
            }
          } else
            startPoint = jointPoint + xOffset;
          yPosition -= thicknessC;
        }
        // joint on end edge
        else if (jointPoint <= sidePieceJointLengthC * 2 + thicknessC && jointPoint + thicknessC > sidePieceJointLengthC * 2 + thicknessC) {
          pastJointEnd = true;
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          startPoint = jointPoint + thicknessC + xOffset;
          yPosition += thicknessC;
        }
        // joint past start and start edge not drawn
        else if (jointPoint >= sidePieceJointLengthC + thicknessC && pastJointStart == false) {
          i--;
          pastJointStart = true;
          jointPoint = sidePieceJointLengthC + thicknessC;
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition - thicknessC);
          startPoint = jointPoint + xOffset;
          yPosition -= thicknessC;
        }
        // joint past end
        else if (jointPoint >= sidePieceJointLengthC * 2 + thicknessC && pastJointEnd == false) {
          i--;
          pastJointEnd = true;
          jointPoint = (sidePieceJointLengthC * 2) + thicknessC;
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition + thicknessC);
          startPoint = jointPoint + xOffset;
          yPosition += thicknessC;
        }
        // joint before start
        else {
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          if (lastJoint == false) {
            if (jointPointsC.get(i + 1) < sidePieceJointLengthC * 2 + thicknessC && pastJointStart == true) {
              startPoint = drawDip(jointPoint, jointPointsC.get(i + 1));
            } else
              startPoint = jointPoint + thicknessC + xOffset;
          } else
            startPoint = jointPoint + thicknessC + xOffset;
        }
      }
      i++;
    }
    if (pastJointEnd == false && constructTop == true) {
      pastJointEnd = true;
      jointPoint = (sidePieceJointLengthC * 2) + thicknessC;
      svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
      svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition + thicknessC);
      startPoint = jointPoint + xOffset;
      yPosition += thicknessC;
    }
    svg.line(startPoint, yPosition, sidePieceLengthC + thicknessC + xOffset, yPosition);
  }

  // Draws a dip between two given slots
  // Returns the new start position
  private float drawDip(float jointPos1, float jointPos2) {
    float dipPosition = (abs(jointPos2 + jointPos1) / 2) + xOffset;
    svg.line(jointPos1 + thicknessC + xOffset, yOffset, dipPosition, yOffset);
    svg.line(dipPosition, yOffset, dipPosition, yOffset + thicknessC);
    svg.line(dipPosition, yOffset + thicknessC, dipPosition + thicknessC, yOffset + thicknessC);
    svg.line(dipPosition + thicknessC, yOffset + thicknessC, dipPosition + thicknessC, yOffset);
    return dipPosition + thicknessC;
  }

  private void drawNormalTop() {
    if (constructTop == false) {
      svg.line(thicknessC + xOffset, yOffset, boxLengthC - thicknessC + xOffset, yOffset);
    } else {
      svg.line(thicknessC + xOffset, thicknessC + yOffset, sidePieceJointLengthC + thicknessC + xOffset, thicknessC + yOffset);
      svg.line(sidePieceJointLengthC + thicknessC + xOffset, thicknessC + yOffset, sidePieceJointLengthC + thicknessC + xOffset, yOffset);
      svg.line(sidePieceJointLengthC + thicknessC + xOffset, yOffset, sidePieceJointLengthC * 2 + thicknessC + xOffset, yOffset);
      svg.line(sidePieceJointLengthC * 2 + thicknessC + xOffset, yOffset, sidePieceJointLengthC * 2 + thicknessC + xOffset, yOffset + thicknessC);
      svg.line(sidePieceJointLengthC * 2 + thicknessC + xOffset, yOffset + thicknessC, boxLengthC - thicknessC + xOffset, yOffset + thicknessC);
    }
  }

  // Draws the bottom of the center piece
  private void createBottom() {
    if (constructBottom == false) {
      svg.line(thicknessC + xOffset, boxHeightC + yOffset, boxLengthC - thicknessC + xOffset, boxHeightC + yOffset);
    } else {
      float yPosition = boxHeightC - thicknessC + yOffset;
      if (floorOffsetEnabled == true) {
        yPosition -= floorOffsetC;
      }
      // Left of joint
      svg.line(thicknessC + xOffset, yPosition, sidePieceJointLengthC + thicknessC + xOffset, yPosition);
      svg.line(sidePieceJointLengthC + thicknessC + xOffset, yPosition, sidePieceJointLengthC + thicknessC + xOffset, yPosition + thicknessC);

      // Joint
      float startPosition = sidePieceJointLengthC + thicknessC + xOffset;
      for (int i = 0; i < jointDipsC.size(); i++) {
        float jointDipPos = jointDipsC.get(i);
        svg.line(startPosition, yPosition + thicknessC, jointDipPos, yPosition + thicknessC);
        svg.line(jointDipPos, yPosition + thicknessC, jointDipPos, yPosition);
        svg.line(jointDipPos, yPosition, jointDipPos + thicknessC, yPosition);
        svg.line(jointDipPos + thicknessC, yPosition, jointDipPos + thicknessC, yPosition + thicknessC);
        startPosition = jointDipPos + thicknessC;
      }
      svg.line(startPosition, yPosition + thicknessC, (sidePieceJointLengthC * 2) + thicknessC + xOffset, yPosition + thicknessC);

      // Right of Joint
      svg.line((sidePieceJointLengthC * 2) + thicknessC + xOffset, yPosition + thicknessC, (sidePieceJointLengthC * 2) + thicknessC + xOffset, yPosition);
      svg.line((sidePieceJointLengthC * 2) + thicknessC + xOffset, yPosition, sidePieceLengthC + thicknessC + xOffset, yPosition);
    }
  }
}
