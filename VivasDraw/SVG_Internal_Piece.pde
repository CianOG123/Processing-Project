// Creates and Renders an SVG Center Piece to a given canvas
class SVG_Internal_Piece extends SVG_Shape {

  boolean invertJoints;
  protected ArrayList<Float> jointPointsC = new ArrayList<Float>();
  protected ArrayList<Float> jointDipsC = new ArrayList<Float>();

  SVG_Internal_Piece(float pieceLength, float pieceJointLength, boolean invertJoints, PGraphics svg, int xOffset, int yOffset) {
    super(svg, xOffset, yOffset);
    this.invertJoints = invertJoints;
    drawGuideLines(pieceLength, pieceJointLength);
    constructCenterJoints(invertJoints, pieceLength);
  }
  
  // Draws the guide lines for the center piece
  private void drawGuideLines(float pieceLength, float pieceJointLength) {
    if (ENABLE_GUIDES) {
      svg.stroke(color(#FF0000));
      // Top
      drawDashLine(xOffset, yOffset, pieceLength + xOffset, yOffset, 100);
      svg.line(thicknessC + xOffset, thicknessC + yOffset, pieceJointLength + thicknessC + xOffset, thicknessC + yOffset);
      svg.line(pieceJointLength + thicknessC + xOffset, thicknessC + yOffset, pieceJointLength + thicknessC + xOffset, yOffset);
      svg.line(pieceJointLength + thicknessC + xOffset, yOffset, (pieceJointLength * 2)+ thicknessC + xOffset, yOffset);
      svg.line((pieceJointLength * 2) + thicknessC + xOffset, yOffset, (pieceJointLength * 2) + thicknessC + xOffset, thicknessC + yOffset);
      svg.line((pieceJointLength * 2) + thicknessC + xOffset, thicknessC + yOffset, pieceLength - thicknessC + xOffset, thicknessC + yOffset);
      // Left
      drawDashLine(thicknessC + xOffset, thicknessC + yOffset, thicknessC + xOffset, boxHeightC - thicknessC + yOffset, 100);
      // Right
      drawDashLine(pieceLength - thicknessC + xOffset, thicknessC + yOffset, pieceLength - thicknessC + xOffset, boxHeightC - thicknessC + yOffset, 100);
      // Bottom
      drawDashLine(xOffset, boxHeightC + yOffset, pieceLength + xOffset, boxHeightC + yOffset, 100);
      svg.line(thicknessC + xOffset, boxHeightC - thicknessC + yOffset, pieceJointLength + thicknessC + xOffset, boxHeightC - thicknessC + yOffset);
      svg.line(pieceJointLength + thicknessC + xOffset, boxHeightC - thicknessC + yOffset, pieceJointLength + thicknessC + xOffset, boxHeightC + yOffset);
      svg.line(pieceJointLength + thicknessC + xOffset, boxHeightC + yOffset, (pieceJointLength * 2) + thicknessC + xOffset, boxHeightC + yOffset);
      svg.line((pieceJointLength * 2) + thicknessC + xOffset, boxHeightC + yOffset, (pieceJointLength * 2) + thicknessC + xOffset, boxHeightC - thicknessC + yOffset);
      svg.line((pieceJointLength * 2) + thicknessC + xOffset, boxHeightC - thicknessC + yOffset, pieceLength - thicknessC + xOffset, boxHeightC - thicknessC + yOffset);
      // Center line
      drawDashLine(thicknessC + xOffset, (boxHeightC / 2) + yOffset, pieceLength - thicknessC + xOffset, (boxHeightC / 2) + yOffset, 100);

      // Corner joints
      constructCornerJoints(invertJoints, pieceLength);
      svg.stroke(color(#000000));
    }
  }
  
  protected void findDipPositions(float pieceJointLength, boolean constructPiece) {
    Collections.sort(jointPointsC);
    float startPoint = thicknessC + xOffset;
    boolean pastJointStart = false;
    boolean pastJointEnd = false;
    boolean lastJoint = false;
    int i = 0;
    float jointPoint;
    try{
    jointPoint = jointPointsC.get(i);
    } catch(IndexOutOfBoundsException e){
    }
    while (i < jointPointsC.size()) {
      if (i == jointPointsC.size() - 1)
        lastJoint = true;
      jointPoint = jointPointsC.get(i);
      // joint on start edge
      if (jointPoint <= pieceJointLength + thicknessC && jointPoint + thicknessC > pieceJointLength + thicknessC) {
        pastJointStart = true;
        if (lastJoint == false && jointPointsC.get(i + 1) < pieceJointLength * 2 + thicknessC && jointPointsC.get(i + 1) > pieceJointLength + thicknessC) {
          startPoint = (abs(jointPoint + jointPointsC.get(i + 1)) / 2) + xOffset;
          jointDipsC.add(startPoint);
        } else
          startPoint = jointPoint + xOffset;
      }
      // joint on end edge
      else if (jointPoint <= pieceJointLength * 2 + thicknessC && jointPoint + thicknessC > pieceJointLength * 2 + thicknessC) {
        pastJointEnd = true;
        startPoint = jointPoint + thicknessC + xOffset;
      }
      // joint past start and start edge not drawn
      else if (jointPoint >= pieceJointLength + thicknessC && pastJointStart == false) {
        i--;
        pastJointStart = true;
        jointPoint = pieceJointLength + thicknessC;
        startPoint = jointPoint + xOffset;
      }
      // joint past end
      else if (jointPoint >= pieceJointLength * 2 + thicknessC && pastJointEnd == false) {
        i--;
        pastJointEnd = true;
        jointPoint = (pieceJointLength * 2) + thicknessC;
        startPoint = jointPoint + xOffset;
      }
      // joint before start
      else {
        if (lastJoint == false) {
          if (jointPointsC.get(i + 1) < pieceJointLength * 2 + thicknessC && pastJointStart == true) {
            startPoint = (abs(jointPoint + jointPointsC.get(i + 1)) / 2) + xOffset;
            jointDipsC.add(startPoint);
          } else
            startPoint = jointPoint + thicknessC + xOffset;
        } else
          startPoint = jointPoint + thicknessC + xOffset;
      }
      i++;
    }
    if (pastJointEnd == false && constructPiece == true) {
      pastJointEnd = true;
      jointPoint = (pieceJointLength * 2) + thicknessC;
      startPoint = jointPoint + xOffset;
    }
  }

  // Draws the joints of a center/cross piece
  private void constructCenterJoints(boolean invertJoints, float pieceLengthC) {
    float startPoint = 0;
    float endPoint = boxHeightC;
    if (constructTop == true)
      startPoint += thicknessC; 
    if (constructBottom == true) {
      endPoint -= thicknessC;
      if (floorOffsetEnabled == true)
        endPoint -= floorOffsetC;
    }
    // Variables used to invert the joints 
    float extrudeOffset = 0;
    float intrudeOffset = 0;
    if (invertJoints == true) {
      extrudeOffset = thicknessC;
      intrudeOffset = -thicknessC;
    }
    float jointStartYPosition = startPoint;
    boolean jointStartInwards = false;
    float jointEndYPosition = endPoint;
    boolean jointEndInwards = false;
    boolean jointStartFound = false;
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        // Outwards to inwards
        // Inner edges
        if (jointHeightC * (i - 1)  >= startPoint && jointHeightC * i <= endPoint) {
          svg.line(extrudeOffset + pieceLengthC - thicknessC + xOffset, (jointHeightC * (i - 1)) + yOffset, extrudeOffset + pieceLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset);
          svg.line(intrudeOffset + thicknessC + xOffset, (jointHeightC * (i - 1)) + yOffset, intrudeOffset + thicknessC + xOffset, (jointHeightC * i) + yOffset);
          if (jointStartFound == false) {
            jointStartFound = true;
            jointStartInwards = true;
            jointStartYPosition = (jointHeightC * (i - 1)) + yOffset;
          }
          jointEndInwards = true;
          jointEndYPosition = (jointHeightC * i) + yOffset;
        }
        // Upper edges
        if (jointHeightC * i >= startPoint && jointHeightC * i <= endPoint) {
          svg.line(pieceLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset, pieceLengthC + xOffset, (jointHeightC * i) + yOffset);
          svg.line(thicknessC +  xOffset, (jointHeightC * i) + yOffset, xOffset, (jointHeightC * i) + yOffset);
          if (jointStartFound == false) {
            jointStartFound = true;
            if (invertJoints == true)
              jointStartInwards = false;
            else
              jointStartInwards = true;
            jointStartYPosition = (jointHeightC * i) + yOffset;
          }
          if (invertJoints == true)
            jointEndInwards = true;
          else
            jointEndInwards = false;
          jointEndYPosition = (jointHeightC * i) + yOffset;
        }
      } else {
        // Inwards to outwards
        if (jointHeightC * (i - 1) >= startPoint && jointHeightC * i <= endPoint) {
          // Outer edges
          svg.line(intrudeOffset + pieceLengthC + xOffset, yOffset + (jointHeightC * (i - 1)), intrudeOffset + pieceLengthC + xOffset, (jointHeightC * i)  + yOffset);
          svg.line(extrudeOffset + xOffset, (jointHeightC * (i - 1)) + yOffset, extrudeOffset + xOffset, (jointHeightC * i) + yOffset);
          if (jointStartFound == false) {
            jointStartFound = true;
            if(invertJoints == true)
              jointStartInwards = true;
            else
              jointStartInwards = false;
            jointStartYPosition = (jointHeightC * (i - 1)) + yOffset;
          }
          jointEndInwards = false;
          jointEndYPosition = (jointHeightC * i) + yOffset;
        }
        // Bottom edges
        if (jointHeightC * i >= startPoint && jointHeightC * i <= endPoint) {
          svg.line(pieceLengthC + xOffset, (jointHeightC * i) + yOffset, pieceLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset);
          svg.line(xOffset, (jointHeightC * i) + yOffset, thicknessC + xOffset, (jointHeightC * i) + yOffset);
          if (jointStartFound == false) {
            jointStartFound = true;
            if (invertJoints == true)
              jointStartInwards = true;
            else
              jointStartInwards = false;
            jointStartYPosition = (jointHeightC * i) + yOffset;
          }
          if (invertJoints == true)
            jointEndInwards = false;
          else
            jointEndInwards = true;
          jointEndYPosition = (jointHeightC * i) + yOffset;
        }
      }
    }
    // Connect startPoint to joints
    if (jointStartInwards == true) {
      svg.line(thicknessC + xOffset, startPoint + yOffset, thicknessC + xOffset, jointStartYPosition);
      svg.line(pieceLengthC - thicknessC + xOffset, startPoint + yOffset, pieceLengthC - thicknessC + xOffset, jointStartYPosition);
    } else {
      // Left side
      svg.line(xOffset, startPoint + yOffset, xOffset, jointStartYPosition);
      svg.line(xOffset, startPoint + yOffset, thicknessC + xOffset, startPoint + yOffset);
      // Right Side
      svg.line(pieceLengthC + xOffset, startPoint + yOffset, pieceLengthC + xOffset, jointStartYPosition);
      svg.line(pieceLengthC + xOffset, startPoint + yOffset, pieceLengthC - thicknessC + xOffset, startPoint + yOffset);
    }
    if (jointEndInwards == true) {
      if(constructBottom == true)
        endPoint += thicknessC;
      svg.line(thicknessC + xOffset, jointEndYPosition, thicknessC + xOffset, endPoint + yOffset);
      svg.line(pieceLengthC - thicknessC + xOffset, jointEndYPosition, pieceLengthC - thicknessC + xOffset, endPoint + yOffset);
    } else {
      // Left side
      svg.line(xOffset, endPoint + yOffset, xOffset, jointEndYPosition);
      svg.line(xOffset, endPoint + yOffset, thicknessC + xOffset, endPoint + yOffset);
      // Right Side
      svg.line(pieceLengthC + xOffset, endPoint + yOffset, pieceLengthC + xOffset, jointEndYPosition);
      svg.line(pieceLengthC + xOffset, endPoint + yOffset, pieceLengthC - thicknessC + xOffset, endPoint + yOffset);
    }
  }
}
