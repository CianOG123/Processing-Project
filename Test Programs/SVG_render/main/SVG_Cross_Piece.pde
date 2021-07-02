// Creates and Renders an SVG Center Piece to a given canvas
class SVG_Cross_Piece extends SVG_Internal_Piece {

  // Constants
  private static final boolean INVERT_JOINTS = true;

  SVG_Cross_Piece(PGraphics svg, int xOffset, int yOffset) {
    super(boxWidthC, endPieceJointLengthC, INVERT_JOINTS, svg, xOffset, yOffset);
    constructCenterSlots();
    DrawBottom();
    findDipPositions(endPieceJointLengthC, constructBottom);
    createTop();
  }
  
  // Constructs the center piece slots in the cross piece
  private void constructCenterSlots() {
    float yPosition = boxHeightC - thicknessC + yOffset;
    float jointYPosition = yOffset + boxHeightC;
    if (constructBottom == false) {
      yPosition = yOffset + boxHeightC;
    }
    if(floorOffsetEnabled == true && constructBottom == true){
      yPosition -= floorOffsetC;
      jointYPosition -= floorOffsetC;
    }
    float centerPoint = (boxHeightC / 2) + yOffset;
    if (floorOffsetEnabled == true && constructBottom == true) {
      centerPoint = ((boxHeightC - floorOffsetC) / 2) + yOffset;
    }
    for (int i = 0; i < constructCross.length; i++) {
      if (constructCenter[i] == true) {
        // left side of joint slot
        if (centerJointPosC[i] > endPieceJointLengthC + thicknessC && centerJointPosC[i] < endPieceJointLengthC * 2 + thicknessC) {
          jointPointsC.add(centerJointPosC[i]);
          svg.line(centerJointPosC[i] + xOffset, jointYPosition, centerJointPosC[i] + xOffset, centerPoint);
        } else {
          jointPointsC.add(centerJointPosC[i]);
          svg.line(centerJointPosC[i] + xOffset, yPosition, centerJointPosC[i] + xOffset, centerPoint);
        }
        // right side of joint slot
        if (centerJointPosC[i] + thicknessC > endPieceJointLengthC + thicknessC && centerJointPosC[i] + thicknessC < endPieceJointLengthC * 2 + thicknessC) {
          svg.line(centerJointPosC[i] + thicknessC + xOffset, centerPoint, centerJointPosC[i] + thicknessC + xOffset, jointYPosition);
        } else {
          svg.line(centerJointPosC[i] + thicknessC + xOffset, centerPoint, centerJointPosC[i] + thicknessC + xOffset, yPosition);
        }
        // Bottom of joint slot
        svg.line(centerJointPosC[i] + xOffset, centerPoint, centerJointPosC[i] + thicknessC + xOffset, centerPoint);
      }
    }
  }
  
    // Draws the top side of the center piece
  // contructCrossSlots must be called first
  private void DrawBottom() {
    boolean drawComplexBottom = false;
    for (int i = 0; i < constructCenter.length; i++) {
      if (constructCenter[i] == true)
        drawComplexBottom = true;
    }
    if (drawComplexBottom == true)
      drawComplexBottom();
    else
      drawNormalBottom();
  }
  
  private void drawComplexBottom() {
    Collections.sort(jointPointsC);
    float startPoint = thicknessC + xOffset;
    float yPosition = boxHeightC - thicknessC + yOffset;
    if (floorOffsetEnabled == true) {
        yPosition -= floorOffsetC;
      }
    if (constructBottom == false) {
      yPosition = boxHeightC + yOffset;
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
      if (constructBottom == false) {
        svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
        if (lastJoint == false) {
          if (jointPointsC.get(i + 1) < endPieceJointLengthC * 2 + thicknessC && pastJointStart == true) {
            startPoint = drawDip(jointPoint, jointPointsC.get(i + 1));
          } else
            startPoint = jointPoint + thicknessC + xOffset;
        } else
          startPoint = jointPoint + thicknessC + xOffset;
      } else {
        // joint on start edge
        if (jointPoint <= endPieceJointLengthC + thicknessC && jointPoint + thicknessC > endPieceJointLengthC + thicknessC) {
          pastJointStart = true;
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          if (lastJoint == false) {
            if (jointPointsC.get(i + 1) < endPieceJointLengthC * 2 + thicknessC && jointPointsC.get(i + 1) > endPieceJointLengthC + thicknessC) {
              startPoint = drawDip(jointPoint, jointPointsC.get(i + 1));
            }
          } else
            startPoint = jointPoint + xOffset;
          yPosition += thicknessC;
        }
        // joint on end edge
        else if (jointPoint <= endPieceJointLengthC * 2 + thicknessC && jointPoint + thicknessC > endPieceJointLengthC * 2 + thicknessC) {
          pastJointEnd = true;
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          startPoint = jointPoint + thicknessC + xOffset;
          yPosition -= thicknessC;
        }
        // joint past start and start edge not drawn
        else if (jointPoint >= endPieceJointLengthC + thicknessC && pastJointStart == false) {
          i--;
          pastJointStart = true;
          jointPoint = endPieceJointLengthC + thicknessC;
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition + thicknessC);
          startPoint = jointPoint + xOffset;
          yPosition += thicknessC;
        }
        // joint past end
        else if (jointPoint >= endPieceJointLengthC * 2 + thicknessC && pastJointEnd == false) {
          i--;
          pastJointEnd = true;
          jointPoint = (endPieceJointLengthC * 2) + thicknessC;
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition - thicknessC);
          startPoint = jointPoint + xOffset;
          yPosition -= thicknessC;
        }
        // joint before start
        else {
          svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          if (lastJoint == false) {
            if (jointPointsC.get(i + 1) < endPieceJointLengthC * 2 + thicknessC && pastJointStart == true) {
              startPoint = drawDip(jointPoint, jointPointsC.get(i + 1));
            } else
              startPoint = jointPoint + thicknessC + xOffset;
          } else
            startPoint = jointPoint + thicknessC + xOffset;
        }
      }
      i++;
    }
    if (pastJointEnd == false && constructBottom == true) {
      pastJointEnd = true;
      jointPoint = (endPieceJointLengthC * 2) + thicknessC;
      svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
      svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition - thicknessC);
      startPoint = jointPoint + xOffset;
      yPosition -= thicknessC;
    }
    svg.line(startPoint, yPosition, endPieceLengthC + thicknessC + xOffset, yPosition);
  }
  
  // Draws a dip between two given slots
  // Returns the new start position
  private float drawDip(float jointPos1, float jointPos2) {
    float yPosition = boxHeightC + yOffset;
    if(floorOffsetEnabled == true){
      yPosition -= floorOffsetC;
    }
    float dipPosition = (abs(jointPos2 + jointPos1) / 2) + xOffset;
    svg.line(jointPos1 + thicknessC + xOffset, yPosition, dipPosition, yPosition);
    svg.line(dipPosition, yPosition, dipPosition, yPosition - thicknessC);
    svg.line(dipPosition, yPosition - thicknessC, dipPosition + thicknessC,  yPosition - thicknessC);
    svg.line(dipPosition + thicknessC, yPosition - thicknessC, dipPosition + thicknessC, yPosition);
    return dipPosition + thicknessC;
  }
  
  private void drawNormalBottom() {
    if (constructBottom == false) {
      svg.line(thicknessC + xOffset, boxHeightC + yOffset, boxWidthC - thicknessC + xOffset, boxHeightC + yOffset);
    } else {
      float yPosition = boxHeightC + yOffset;
      if (floorOffsetEnabled == true) {
        yPosition -= floorOffsetC;
      }
      svg.line(thicknessC + xOffset, yPosition, endPieceJointLengthC + thicknessC + xOffset, yPosition);
      svg.line(endPieceJointLengthC + thicknessC + xOffset, yPosition, endPieceJointLengthC + thicknessC + xOffset, yPosition - thicknessC);
      svg.line(endPieceJointLengthC + thicknessC + xOffset, yPosition - thicknessC, endPieceJointLengthC * 2 + thicknessC + xOffset, yPosition - thicknessC);
      svg.line(endPieceJointLengthC * 2 + thicknessC + xOffset, yPosition - thicknessC, endPieceJointLengthC * 2 + thicknessC + xOffset, yPosition);
      svg.line(endPieceJointLengthC * 2 + thicknessC + xOffset, yPosition, boxWidthC - thicknessC + xOffset, yPosition);
    }
  }
  
  // Draws the top of the cross piece
  private void createTop() {
    if (constructTop == false) {
      svg.line(thicknessC + xOffset, yOffset, boxWidthC - thicknessC + xOffset, yOffset);
    } else {
      float yPosition = yOffset + thicknessC;
      // Left of joint
      svg.line(thicknessC + xOffset, yPosition, endPieceJointLengthC + thicknessC + xOffset, yPosition);
      svg.line(endPieceJointLengthC + thicknessC + xOffset, yPosition, endPieceJointLengthC + thicknessC + xOffset, yPosition - thicknessC);

      // Joint
      float startPosition = endPieceJointLengthC + thicknessC + xOffset;
      for (int i = 0; i < jointDipsC.size(); i++) {
        float jointDipPos = jointDipsC.get(i);
        svg.line(startPosition, yPosition - thicknessC, jointDipPos, yPosition - thicknessC);
        svg.line(jointDipPos, yPosition - thicknessC, jointDipPos, yPosition);
        svg.line(jointDipPos, yPosition, jointDipPos + thicknessC, yPosition);
        svg.line(jointDipPos + thicknessC, yPosition, jointDipPos + thicknessC, yPosition - thicknessC);
        startPosition = jointDipPos + thicknessC;
      }
      svg.line(startPosition, yPosition - thicknessC, (endPieceJointLengthC * 2) + thicknessC + xOffset, yPosition - thicknessC);

      // Right of Joint
      svg.line((endPieceJointLengthC * 2) + thicknessC + xOffset, yPosition - thicknessC, (endPieceJointLengthC * 2) + thicknessC + xOffset, yPosition);
      svg.line((endPieceJointLengthC * 2) + thicknessC + xOffset, yPosition, endPieceLengthC + thicknessC + xOffset, yPosition);
    }
  }
}
