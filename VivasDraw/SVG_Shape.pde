// SVG_Shape class, used for shared functions between different shapes i.e constructJoints
class SVG_Shape {

  // Objects
  protected PGraphics svg;

  // Variables
  protected int xOffset;  // Used to position the piece on the canvas, to avoid overlapping between pieces
  protected int yOffset;
  protected boolean bottomCenterSlotsIntersect = false; // set to true the floor joint is intersecting the slots for the center piece
  protected boolean topCenterSlotsIntersect = false; // set to true the top joint is intersecting the slots for the center piece

  SVG_Shape(PGraphics svg, int xOffset, int yOffset) {
    this.svg = svg;
    this.xOffset = xOffset;
    this.yOffset = yOffset;
  }

  // ----------------------------------------------------------------------------------------------------------------------------------

  // FINISHED FUNCTIONS THAT WORK PERFECTLY

  // ----------------------------------------------------------------------------------------------------------------------------------
  // SIDE AND END PIECE FUNCTIONS
  // ----------------------------------------------------------------------------------------------------------------------------------

  // Constructs the bottom for a side or end piece
  protected void sideCreateBottom(boolean invertJoints, float boxDimensionC, float jointLengthC, float[] jointPosC, boolean[] constructPiece) {
    float yPosition = yOffset + boxHeightC;
    float[] startEndPoint = getTopStartEndPoint(boxDimensionC, invertJoints);
    float startPoint = startEndPoint[0];
    float endPoint = startEndPoint[1];
    if (constructBottom == true && (floorOffsetEnabled == false || floorOffsetC == 0)) {
      // check if case is 3 or 4
      createBottomJointTemplate(startPoint, endPoint, yPosition, jointLengthC);
      startPoint += jointLengthC;
      endPoint -= jointLengthC;
      if (invertJoints == false) {
        startPoint += thicknessC;
        endPoint -= thicknessC;
      }
      yPosition -= thicknessC;
      joinSlots(jointPosC, constructPiece, startPoint, yPosition, endPoint, bottomCenterSlotsIntersect);
    } else if (constructBottom == false && bottomCenterSlotsIntersect == true) {
      // check if case 2
      joinSlots(jointPosC, constructPiece, startPoint, yPosition, endPoint, bottomCenterSlotsIntersect);
    } else {
      // case 1
      svg.line(startPoint + xOffset, yPosition, endPoint + xOffset, yPosition);
    }
  }

  // Draws the template for a bottom joint
  // Used by the sideCreateBottom function
  private void createBottomJointTemplate(float startPoint, float endPoint, float yPosition, float jointLengthC) {
    svg.line(startPoint + xOffset, yPosition, jointLengthC + thicknessC + xOffset, yPosition);
    svg.line(jointLengthC + thicknessC + xOffset, yPosition, jointLengthC + thicknessC + xOffset, yPosition - thicknessC);
    svg.line((jointLengthC * 2) + thicknessC + xOffset, yPosition, (jointLengthC * 2) + thicknessC + xOffset, yPosition - thicknessC);
    svg.line((jointLengthC * 2) + thicknessC + xOffset, yPosition, endPoint + xOffset, yPosition);
  }

  // ----------------------------------------------------------------------------------------------------------------------------------

  // Constructs the top for a side or end piece
  protected void sideCreateTop(boolean invertJoints, float boxDimensionC, float jointLengthC, float[] jointPosC, boolean[] constructPiece, boolean extrudeThroughSide) {
    float yPosition = yOffset;
    float[] startEndPoint = getTopStartEndPoint(boxDimensionC, invertJoints);
    float startPoint = startEndPoint[0];
    float endPoint = startEndPoint[1];
    if (constructTop == false) {
      if (topCenterSlotsIntersect == true) {
        if (invertJoints == true && extrudeThroughSide == true) {
          joinSlots(jointPosC, constructPiece, startPoint, yPosition, endPoint, topCenterSlotsIntersect);
          return;
        }
      } else {
        closeTop(startPoint, endPoint, yPosition);
        return;
      }
    } else {
      sideDrawTopSlotTemplate(startPoint, endPoint, yPosition, jointLengthC);
      startPoint = jointLengthC + thicknessC;
      endPoint = (jointLengthC * 2) + thicknessC;
      yPosition += thicknessC;
    }
    if (topCenterSlotsIntersect == true) joinSlots(jointPosC, constructPiece, startPoint, yPosition, endPoint, topCenterSlotsIntersect);
    else closeTop(startPoint, endPoint, yPosition);
  }

  // Draws the top piece joint template for the top of a side piece
  // Used by sideCreateTop function
  private void sideDrawTopSlotTemplate(float startPoint, float endPoint, float yPosition, float jointLengthC) {
    svg.line(startPoint + xOffset, yPosition, jointLengthC + thicknessC + xOffset, yPosition);
    svg.line(jointLengthC + thicknessC + xOffset, yPosition, jointLengthC + thicknessC + xOffset, yPosition + thicknessC);
    svg.line(endPoint + xOffset, yPosition, (jointLengthC * 2) + thicknessC + xOffset, yPosition);
    svg.line((jointLengthC * 2) + thicknessC + xOffset, yPosition, (jointLengthC * 2) + thicknessC + xOffset, yPosition + thicknessC);
  }

  // Closes the top of the piece by drawing the final line if there are no joints in the given section
  // Used by sideCreateTop function
  private void closeTop(float startPoint, float endPoint, float yPosition) {
    svg.line(startPoint + xOffset, yPosition, endPoint + xOffset, yPosition);
  }

  // Gets the start and end point for the top
  // Used by sideCreateTop function
  private float[] getTopStartEndPoint(float boxDimensionC, boolean invertJoints) {
    float startPoint = 0;
    float endPoint = boxDimensionC;
    if (invertJoints == true) {
      startPoint += thicknessC;
      endPoint -= thicknessC;
    }
    float[] returnValue = {startPoint, endPoint};
    return returnValue;
  }

  // ----------------------------------------------------------------------------------------------------------------------------------

  // Constructs a raised floor slot for a side or end piece
  // This function:
  // Draws the base template with startPoint and endPoint
  // Creates a boolean array with one index for each center/cross piece
  // Sets the index of a cross piece to true if it is disabled or out of bounds.
  // Finds the smallest pieceJointPos value from all the center pieces that are false.
  // Draws a line from the startPoint to the found pieceJointPos
  // Sets the new startPoint = pieceJointPos + thickness and repeats until all index are true
  protected void createRaisedFloorSlot(boolean[] constructPiece, float[] pieceJointPos, float pieceJointLengthC) {
    if (constructBottom == false) return;
    if (floorOffsetEnabled == false) return;
    if (floorOffsetC == 0) return;
    float startPoint = getStartPoint(pieceJointLengthC);
    float endPoint = getEndPoint(pieceJointLengthC);
    drawOffsetFloorJointTemplate(startPoint, endPoint);
    float yPosition = boxHeightC - (thicknessC + floorOffsetC) + yOffset;
    if (bottomCenterSlotsIntersect == true) {
      joinSlots(pieceJointPos, constructPiece, startPoint, yPosition, endPoint, bottomCenterSlotsIntersect);
    } else drawStraightTopLine(startPoint, endPoint, yPosition);
  }

  // Draws a line straight across the top of the raised floor joint
  // Used by the createRaisedFloorSlot function
  private void drawStraightTopLine(float startPoint, float endPoint, float yPosition) {
    svg.line(startPoint + xOffset, yPosition, endPoint + xOffset, yPosition);
  }

  // Joins the piece slots to the raised floor joint
  // Used by the createRaisedFloorSlot function
  // Used by sideCreateTop function
  // Used by sideCreateBottom
  private void joinSlots(float[] pieceJointPos, boolean[] constructPiece, float startPoint, float yPosition, float endPoint, boolean isIntersecting) {
    float leftBound = startPoint;
    float rightBound = endPoint;
    boolean[] slotDrawn = getSlotDrawnArray(constructPiece, pieceJointPos, leftBound, rightBound);
    if (isIntersecting == true) {
      while (allSlotsDrawn(slotDrawn) == false) {
        int minSlotPosIndex = getMinSlotPosIndex(slotDrawn, pieceJointPos, constructPiece, leftBound, rightBound);
        slotDrawn[minSlotPosIndex] = true;
        float jointVertex = pieceJointPos[minSlotPosIndex];
        svg.line(startPoint + xOffset, yPosition, jointVertex + xOffset, yPosition);
        startPoint = jointVertex + thicknessC;
      }
    }
    svg.line(startPoint + xOffset, yPosition, endPoint + xOffset, yPosition);
  }

  // Gets the array index of the slot with the min x coord
  // Used by the createRaisedFloorSlot function
  private int getMinSlotPosIndex( boolean[] slotDrawn, float[] pieceJointPos, boolean[] constructPiece, float leftBound, float rightBound) {
    float minPos = 0;
    int minIndex = 0;
    boolean firstLoop = true;
    for (int i = 0; i < constructPiece.length; i++) {
      if (constructPiece[i] == true && slotDrawn[i] == false) {
        if (pieceJointPos[i] + thicknessC > leftBound && pieceJointPos[i] < rightBound) {
          if ((pieceJointPos[i] < minPos) || (firstLoop == true)) {
            minPos = pieceJointPos[i];
            minIndex = i;
            firstLoop = false;
          }
        }
      }
    }
    return minIndex;
  }

  // Checks if all slots drawn are true
  // Used by the createRaisedFloorSlot function
  private boolean allSlotsDrawn(boolean[] slotDrawn) {
    for (int i = 0; i < slotDrawn.length; i++) {
      if (slotDrawn[i] == false) return false;
    }
    return true;
  }


  // Draws the base template for the raisedFloorSlot
  // Used by the createRaisedFloorSlot function
  private void drawOffsetFloorJointTemplate(float startPoint, float endPoint) {
    svg.line(startPoint + xOffset, boxHeightC - (floorOffsetC + thicknessC) + yOffset, startPoint + xOffset, boxHeightC - floorOffsetC + yOffset);
    svg.line(endPoint + xOffset, boxHeightC - floorOffsetC + yOffset, endPoint + xOffset, boxHeightC - (floorOffsetC + thicknessC) + yOffset);
    if (floorOffsetC != 0) {
      svg.line(startPoint + xOffset, boxHeightC - floorOffsetC + yOffset, endPoint + xOffset, boxHeightC - floorOffsetC + yOffset);
    }
  }

  // Gets the initial startPoint
  // Used for connecting center piece slots to the raised floor joint
  // Used by the createRaisedFloorSlot function
  private float getStartPoint(float pieceJointLengthC) {
    float startPoint = thicknessC + pieceJointLengthC;
    return startPoint;
  }

  // Gets the initial endPoint
  // Used for connecting center piece slots to the raised floor joint
  // Used by the createRaisedFloorSlot function
  private float getEndPoint(float pieceJointLengthC) {
    float endPoint = thicknessC + (pieceJointLengthC * 2);
    return endPoint;
  }



  // Creates a slotDrawn array for deciding which center piece joint slots have already been drawn
  // Used by the createRaisedFloorSlot function
  private boolean[] getSlotDrawnArray(boolean[] constructPiece, float[] pieceJointPos, float leftBound, float rightBound) {
    boolean[] slotDrawn = new boolean[CENTER_PIECE_LIMIT];
    for (int i = 0; i < slotDrawn.length; i++) {
      if (constructPiece[i] == true) slotDrawn[i] = false;
      else slotDrawn[i] = true;
      if (pieceJointPos[i] + thicknessC < leftBound || pieceJointPos[i] > rightBound) {
        slotDrawn[i] = true;
      }
    }
    return slotDrawn;
  }

  // ----------------------------------------------------------------------------------------------------------------------------------

  // Constructs center piece joint slots
  // This function:
  // Gets the joint starting point.
  // Gets the joint end point.
  // Draws joint slots between the start and end points.
  protected void createCenterSlots(boolean invertJoints, boolean[] constructPiece, boolean extrudeThroughSide, float[] pieceJointPos, float pieceJointLengthC) {
    if (extrudeThroughSide == false) 
      return;
    float jointStartPoint = getJointStartPoint(invertJoints);
    float jointEndPoint = getJointEndPoint(invertJoints);
    float jointBottom = getJointBottom(invertJoints, jointStartPoint);
    topCenterSlotsIntersect = getTopIntersect(jointStartPoint);
    bottomCenterSlotsIntersect = getBottomIntersect(jointEndPoint);
    createTopSlot(constructPiece, pieceJointPos, pieceJointLengthC, jointBottom, jointStartPoint, topCenterSlotsIntersect);

    jointBottom += jointHeightC * 2;
    float jointTop = jointBottom - jointHeightC;
    float[] jointTopBottom = createSlots(invertJoints, constructPiece, pieceJointPos, jointTop, jointBottom, jointEndPoint);
    jointTop = jointTopBottom[0];
    jointBottom = jointTopBottom[1];
    createBottomSlot(constructPiece, pieceJointPos, pieceJointLengthC, jointTop, jointEndPoint, bottomCenterSlotsIntersect);
  }


  // Gets bottom intersect
  // When true the bottom slot will intersect with the bottom piece slot
  // Used by createCenterSlots function
  private boolean getBottomIntersect(float jointEndPoint) {
    if (jointEndPoint == boxHeightC)
      return true;
    else if (jointEndPoint == boxHeightC - thicknessC && constructBottom == true)
      return true;
    else if (jointEndPoint == boxHeightC - thicknessC - floorOffsetC && floorOffsetEnabled == true)
      return true;
    else
      return false;
  }

  // Gets top intersect
  // When true the top slot will intersect with the top piece slot
  // Used by createCenterSlots function
  private boolean getTopIntersect(float jointStartPoint) {
    if (((jointStartPoint == thicknessC) && constructTop == true) || jointStartPoint == 0) {
      return true;
    }
    return false;
  }

  // Gets the position of the bottom of the first joint
  // Used by createCenterSlots function
  private float getJointBottom(boolean invertJoints, float jointStartPoint) {
    float jointBottom = jointHeightC * 2;
    if (invertJoints == true) {
      jointBottom = jointHeightC;
    }
    while (jointBottom < jointStartPoint) {
      jointBottom += jointHeightC * 2;
    }
    return jointBottom;
  }

  // Draws a top slot for a center or cross piece
  // Used by createCenterSlots function
  private void createTopSlot(boolean[] constructPiece, float[] pieceJointPos, float pieceJointLengthC, float jointBottom, float jointStartPoint, boolean topIntersect) {
    for (int i = 0; i < constructPiece.length; i++) {
      if (constructPiece[i] == true) {
        if (closeTopSlot(topIntersect, pieceJointPos[i], pieceJointLengthC) == true) {
          svg.line(pieceJointPos[i] + xOffset, jointStartPoint + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointStartPoint + yOffset);
        }
        svg.line(pieceJointPos[i] + xOffset, jointStartPoint + yOffset, pieceJointPos[i] + xOffset, jointBottom + yOffset);
        svg.line(pieceJointPos[i] + thicknessC + xOffset, jointStartPoint + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointBottom + yOffset);
        svg.line(pieceJointPos[i] + xOffset, jointBottom + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointBottom + yOffset);
      }
    }
  }

  // Returns if the top joint should be closed or not
  // Used by the createCenterSlots function
  private boolean closeTopSlot(boolean topIntersect, float pieceJointPos, float pieceJointLengthC) {
    boolean closeJoint = true;
    if (constructTop == true) {
      if (topIntersect == true) {
        if (pieceJointPos + thicknessC > pieceJointLengthC + thicknessC && pieceJointPos < (pieceJointLengthC * 2) + thicknessC) {
          // case 3
          closeJoint = false;
        } else {
          // Case 4
          closeJoint = true;
        }
      } else {
        // Case 7
        closeJoint = true;
      }
    } else {
      if (topIntersect == true) {
        // Case 2
        closeJoint = false;
      } else {
        // Case 1
        closeJoint = true;
      }
    }
    return closeJoint;
  }

  // Draws a bottom slot for a center or cross piece
  // Used by createCenterSlots function
  private void createBottomSlot(boolean[] constructPiece, float[] pieceJointPos, float pieceJointLengthC, float jointTop, float jointEndPoint, boolean bottomIntersect) {
    if (jointEndPoint > jointTop) {
      for (int i = 0; i < constructPiece.length; i++) {
        if (constructPiece[i] == true) {
          svg.line(pieceJointPos[i] + xOffset, jointTop + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointTop + yOffset);
          svg.line(pieceJointPos[i] + xOffset, jointTop + yOffset, pieceJointPos[i] + xOffset, jointEndPoint + yOffset);
          svg.line(pieceJointPos[i] + thicknessC + xOffset, jointTop + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointEndPoint + yOffset);
          if (closeBottomSlot(bottomIntersect, pieceJointPos[i], pieceJointLengthC) == true) {
            svg.line(pieceJointPos[i] + xOffset, jointEndPoint + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointEndPoint + yOffset);
          }
        }
      }
    }
  }

  // Returns if the bottom joint should be closed or not for the center piece slots
  // Used by the createCenterSlots function
  private boolean closeBottomSlot(boolean bottomIntersect, float pieceJointPos, float pieceJointLengthC) {
    boolean closeJoint = true;
    if (constructBottom == true) {
      if (bottomIntersect == true) {
        if (pieceJointPos + thicknessC > pieceJointLengthC + thicknessC && pieceJointPos < (pieceJointLengthC * 2) + thicknessC) {
          // case 3
          closeJoint = false;
        } else {
          // Case 4
          closeJoint = true;
        }
      } else {
        // Case 7
        closeJoint = false;  // This may need to be true change if errors occur
      }
    } else {
      if (bottomIntersect == true) {
        // Case 2
        closeJoint = false;
      } else {
        // Case 1
        closeJoint = true;
      }
    }
    return closeJoint;
  }

  // Draws all joint slots for a center or cross piece
  // Does not draw the first or last joint slots
  // Used by createCenterSlots function
  private float[] createSlots(boolean invertJoints, boolean[] constructPiece, float[] pieceJointPos, float jointTop, float jointBottom, float jointEndPoint) {
    float endPointOffset = 0;
    if (constructBottom == false && invertJoints == true) endPointOffset = jointHeightC; //jointHeightC * 2 if problems persist
    while (jointBottom < jointEndPoint - endPointOffset) {
      for (int i = 0; i < constructPiece.length; i++) {
        if (constructPiece[i] == true) {
          svg.line(pieceJointPos[i] + xOffset, jointTop + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointTop + yOffset);
          svg.line(pieceJointPos[i] + xOffset, jointTop + yOffset, pieceJointPos[i] + xOffset, jointBottom + yOffset);
          svg.line(pieceJointPos[i] + thicknessC + xOffset, jointTop + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointBottom + yOffset);
          svg.line(pieceJointPos[i] + xOffset, jointBottom + yOffset, pieceJointPos[i] + thicknessC + xOffset, jointBottom + yOffset);
        }
      }
      jointBottom += jointHeightC * 2;
      jointTop += jointHeightC * 2;
    }
    if (invertJoints == true && constructBottom == false) {
    }
    float[] returnValue = {jointTop, jointBottom};
    return returnValue;
  }

  // This method finds a y coord that is the first position that the center slots can be drawn in the side piece
  // This method is used exclusively by the createFloorJoints method
  private float getJointStartPoint(boolean invertJoints) {
    float jointStartPoint = 0;
    if (constructTop == true) jointStartPoint = thicknessC;
    float safeStart = jointHeightC;
    float safeEnd = jointHeightC * 2;
    if (invertJoints == true) {
      safeStart = 0;
      safeEnd = jointHeightC;
    }
    while (jointStartPoint < safeStart || jointStartPoint > safeEnd) {
      if (jointStartPoint < safeStart) jointStartPoint = safeStart;
      else if (jointStartPoint > safeEnd) {
        safeStart += jointHeightC * 2;
        safeEnd += jointHeightC * 2;
      }
    }
    return jointStartPoint;
  }

  // This method finds a y coord that is the last position that the center slots can be drawn in the side piece
  // This method is used exclusively by the createFloorJoints method
  private float getJointEndPoint(boolean invertJoints) {
    float jointEndPoint = boxHeightC;
    if (constructBottom == true) {
      jointEndPoint -= thicknessC;
      if (floorOffsetEnabled == true)
        jointEndPoint -= floorOffsetC;
    }
    float safeStart = boxHeightC - jointHeightC;
    float safeEnd = boxHeightC - (jointHeightC * 2);
    if (invertJoints == true) {
      safeStart = boxHeightC;
      safeEnd = boxHeightC - jointHeightC;
    }
    while (jointEndPoint > safeStart || jointEndPoint < safeEnd) {
      if (jointEndPoint > safeStart) jointEndPoint = safeStart;
      else if (jointEndPoint < safeEnd) {
        safeStart -= jointHeightC * 2;
        safeEnd -= jointHeightC * 2;
      }
    }
    return jointEndPoint;
  }

  // ----------------------------------------------------------------------------------------------------------------------------------

  protected void drawDashLine(float startX, float startY, float endX, float endY, int segmentAmount) {
    float dashLengthX = abs(startX - endX) / segmentAmount;
    float dashLengthY = abs(startY - endY) / segmentAmount;
    for (int i = 0; i < segmentAmount / 2; i++) {
      svg.line(startX, startY, startX + dashLengthX, startY + dashLengthY);
      startX += (dashLengthX  * 2);
      startY += (dashLengthY * 2);
    }
    svg.line(startX, startY, endX, endY);
  }

  // Constructs the corner joints of a side or end piece
  protected void constructCornerJoints(boolean invertJoints, float pieceLengthC) {
    // Variables used to invert the joints 
    float extrudeOffset = 0;
    float intrudeOffset = 0;
    if (invertJoints == true) {
      extrudeOffset = thicknessC;
      intrudeOffset = -thicknessC;
    }
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        // Outwards to inwards
        // Right Side
        svg.line(extrudeOffset + pieceLengthC - thicknessC + xOffset, (jointHeightC * (i - 1)) + yOffset, extrudeOffset + pieceLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset);
        svg.line(pieceLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset, pieceLengthC + xOffset, (jointHeightC * i) + yOffset);
        // Left Side
        svg.line(intrudeOffset + thicknessC + xOffset, (jointHeightC * (i - 1)) + yOffset, intrudeOffset + thicknessC + xOffset, (jointHeightC * i) + yOffset);
        svg.line(thicknessC +  xOffset, (jointHeightC * i) + yOffset, xOffset, (jointHeightC * i) + yOffset);
      } else {
        // Inwards to outwards
        // Right Side
        svg.line(intrudeOffset + pieceLengthC + xOffset, yOffset + (jointHeightC * (i - 1)), intrudeOffset + pieceLengthC + xOffset, (jointHeightC * i)  + yOffset);
        svg.line( pieceLengthC + xOffset, (jointHeightC * i) + yOffset, pieceLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset);
        // Left Side
        svg.line(extrudeOffset + xOffset, (jointHeightC * (i - 1)) + yOffset, extrudeOffset + xOffset, (jointHeightC * i) + yOffset);
        svg.line(xOffset, (jointHeightC * i) + yOffset, thicknessC + xOffset, (jointHeightC * i) + yOffset);
      }
    }
    // construct last joint to connect to bottom line
    // Right
    svg.line( intrudeOffset + pieceLengthC + xOffset, (jointHeightC * (jointAmount - 1)) + yOffset, intrudeOffset + pieceLengthC + xOffset, boxHeightC + yOffset);
    // Left
    svg.line(extrudeOffset + xOffset, (jointHeightC * (jointAmount - 1)) + yOffset, extrudeOffset + xOffset, boxHeightC + yOffset);
  }
}
