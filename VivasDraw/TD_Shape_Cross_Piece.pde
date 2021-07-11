/**
 *  Class that can plot and draw a cross partition piece to the screen.
 *  By Cian O'Gorman 05-07-2021.
 */
private class TD_Shape_Cross_Piece extends TD_Shape_Internal_Piece {

  // Constants
  private static final boolean INVERT_JOINTS = true;
  private static final boolean IS_NOT_CENTER_PIECE = false;

  private PShape crossPiece;
  private PShape slots;
  private PShape top;
  private PShape bottom;

  TD_Shape_Cross_Piece() {
    crossPiece = constructCenterJoints(INVERT_JOINTS);
    slots = constructSlots(IS_NOT_CENTER_PIECE, endPieceJointLength, centerJointPos, constructCenter);
    createTop();
    drawBottom();
  } 

  private void draw() {
    display(bottom);
    display(top);
    display(crossPiece);
    display(slots);
    graphicContext.pushMatrix();
    {
      graphicContext.translate(boxWidth, 0, thickness);
      graphicContext.rotateY(radians(180));
      display(crossPiece);
    }
    graphicContext.popMatrix();
  }

  // Draws the top side of the center piece
  // contructCrossSlots must be called first
  private void drawBottom() {
    bottom = createShape(GROUP);
    bottom.beginShape();
    initialise(bottom);
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
    PShape complexBottom = createShape(GROUP);
    complexBottom.beginShape();
    initialise(complexBottom);
    Collections.sort(jointPoints);
    float startPoint = thickness;
    float yPosition = boxHeight - thickness;
    if (floorOffsetEnabled == true) {
      yPosition -= floorOffset;
    }
    if (constructBottom == false) {
      yPosition = boxHeight;
    }
    boolean pastJointStart = false;
    boolean pastJointEnd = false;
    boolean lastJoint = false;
    int i = 0;
    float jointPoint = jointPoints.get(i);
    while (i < jointPoints.size()) {
      if (i == jointPoints.size() - 1)
        lastJoint = true;
      jointPoint = jointPoints.get(i);
      if (constructBottom == false) {
        //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
        PShape noJoint = createShape();
        noJoint.beginShape(TRIANGLE_STRIP);
        initialise(noJoint);
        noJoint.vertex(startPoint, yPosition, 0);
        noJoint.vertex(startPoint, yPosition, thickness);
        noJoint.vertex(jointPoint, yPosition, 0);
        noJoint.vertex(jointPoint, yPosition, thickness);
        if (lastJoint == false) {
          if (jointPoints.get(i + 1) < endPieceJointLength * 2 + thickness && pastJointStart == true) {
            startPoint = drawDip(noJoint, jointPoint, jointPoints.get(i + 1));
          } else
            startPoint = jointPoint + thickness;
        } else
          startPoint = jointPoint + thickness;
        noJoint.endShape(CLOSE);
        complexBottom.addChild(noJoint);
      } else {
        // joint on start edge
        if (jointPoint <= endPieceJointLength + thickness && jointPoint + thickness > endPieceJointLength + thickness) {
          pastJointStart = true;
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          PShape startEdge = createShape();
          startEdge.beginShape(TRIANGLE_STRIP);
          initialise(startEdge);
          startEdge.vertex(startPoint, yPosition, 0);
          startEdge.vertex(startPoint, yPosition, thickness);
          startEdge.vertex(jointPoint, yPosition, 0);
          startEdge.vertex(jointPoint, yPosition, thickness);
          if (lastJoint == false) {
            if (jointPoints.get(i + 1) < endPieceJointLength * 2 + thickness && jointPoints.get(i + 1) > endPieceJointLength + thickness) {
              startPoint = drawDip(startEdge, jointPoint, jointPoints.get(i + 1));
            }
          } else
            startPoint = jointPoint;
          yPosition += thickness;
          startEdge.endShape(CLOSE);
          complexBottom.addChild(startEdge);
        }
        // joint on end edge
        else if (jointPoint <= endPieceJointLength * 2 + thickness && jointPoint + thickness > endPieceJointLength * 2 + thickness) {
          pastJointEnd = true;
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          PShape endEdge = createShape();
          endEdge.beginShape(TRIANGLE_STRIP);
          initialise(endEdge);
          endEdge.vertex(startPoint, yPosition, 0);
          endEdge.vertex(startPoint, yPosition, thickness);
          endEdge.vertex(jointPoint, yPosition, 0);
          endEdge.vertex(jointPoint, yPosition, thickness);
          endEdge.endShape(CLOSE);
          complexBottom.addChild(endEdge);
          startPoint = jointPoint + thickness;
          yPosition -= thickness;
        }
        // joint past start and start edge not drawn
        else if (jointPoint >= endPieceJointLength + thickness && pastJointStart == false) {
          i--;
          pastJointStart = true;
          jointPoint = endPieceJointLength + thickness;
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          //svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition + thicknessC);
          PShape pastStart = createShape();
          pastStart.beginShape(TRIANGLE_STRIP);
          initialise(pastStart);
          pastStart.vertex(startPoint, yPosition, 0);
          pastStart.vertex(startPoint, yPosition, thickness);
          pastStart.vertex(jointPoint, yPosition, 0);
          pastStart.vertex(jointPoint, yPosition, thickness);
          pastStart.vertex(jointPoint, yPosition + thickness, 0);
          pastStart.vertex(jointPoint, yPosition + thickness, thickness);
          pastStart.endShape(CLOSE);
          complexBottom.addChild(pastStart);
          startPoint = jointPoint;
          yPosition += thickness;
        }
        // joint past end
        else if (jointPoint >= endPieceJointLength * 2 + thickness && pastJointEnd == false) {
          i--;
          pastJointEnd = true;
          jointPoint = (endPieceJointLength * 2) + thickness;
          //svg.line(startPoint, yPosition, jointPoint, yPosition);
          //svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition - thicknessC);
          PShape pastEnd = createShape();
          pastEnd.beginShape(TRIANGLE_STRIP);
          initialise(pastEnd);
          pastEnd.vertex(startPoint, yPosition, 0);
          pastEnd.vertex(startPoint, yPosition, thickness);
          pastEnd.vertex(jointPoint, yPosition, 0);
          pastEnd.vertex(jointPoint, yPosition, thickness);
          pastEnd.vertex(jointPoint, yPosition - thickness, 0);
          pastEnd.vertex(jointPoint, yPosition - thickness, thickness);
          pastEnd.endShape(CLOSE);
          complexBottom.addChild(pastEnd);
          startPoint = jointPoint;
          yPosition -= thickness;
        }
        // joint before start
        else {
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          PShape jointBeforeStart = createShape();
          jointBeforeStart.beginShape(TRIANGLE_STRIP);
          initialise(jointBeforeStart);
          jointBeforeStart.vertex(startPoint, yPosition, 0);
          jointBeforeStart.vertex(startPoint, yPosition, thickness);
          jointBeforeStart.vertex(jointPoint, yPosition, 0);
          jointBeforeStart.vertex(jointPoint, yPosition, thickness);
          if (lastJoint == false) {
            if (jointPoints.get(i + 1) < endPieceJointLength * 2 + thickness && pastJointStart == true) {
              startPoint = drawDip(jointBeforeStart, jointPoint, jointPoints.get(i + 1));
            } else
              startPoint = jointPoint + thickness;
          } else
            startPoint = jointPoint + thickness;
          jointBeforeStart.endShape(CLOSE);
          complexBottom.addChild(jointBeforeStart);
        }
      }
      i++;
    }
    if (pastJointEnd == false && constructBottom == true) {
      pastJointEnd = true;
      jointPoint = (endPieceJointLength * 2) + thickness;
      //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
      //svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition - thicknessC);
      PShape pastEnd = createShape();
      pastEnd.beginShape(TRIANGLE_STRIP);
      initialise(pastEnd);
      pastEnd.vertex(startPoint, yPosition, 0);
      pastEnd.vertex(startPoint, yPosition, thickness);
      pastEnd.vertex(jointPoint, yPosition, 0);
      pastEnd.vertex(jointPoint, yPosition, thickness);
      pastEnd.vertex(jointPoint, yPosition - thickness, 0);
      pastEnd.vertex(jointPoint, yPosition - thickness, thickness);
      pastEnd.endShape(CLOSE);
      complexBottom.addChild(pastEnd);
      startPoint = jointPoint;
      yPosition -= thickness;
    }
    //svg.line(startPoint, yPosition, endPieceLengthC + thicknessC + xOffset, yPosition);
    PShape close = createShape();
    close.beginShape(TRIANGLE_STRIP);
    initialise(close);
    close.vertex(startPoint, yPosition, 0);
    close.vertex(startPoint, yPosition, thickness);
    close.vertex(endPieceLength + thickness, yPosition, 0);
    close.vertex(endPieceLength + thickness, yPosition, thickness);
    close.endShape(CLOSE);
    complexBottom.addChild(close);
    bottom.addChild(complexBottom);
  }

  // Draws a dip between two given slots
  // Returns the new start position
  private float drawDip(PShape shape, float jointPos1, float jointPos2) {
    float yPosition = boxHeight;
    if (floorOffsetEnabled == true) {
      yPosition -= floorOffset;
    }
    float dipPosition = (abs(jointPos2 + jointPos1) / 2);
    //svg.line(jointPos1 + thicknessC + xOffset, yPosition, dipPosition, yPosition);
    shape.vertex(jointPos1 + thickness, yPosition, 0);
    shape.vertex(jointPos1 + thickness, yPosition, thickness);
    //svg.line(dipPosition, yPosition, dipPosition, yPosition - thicknessC);
    shape.vertex(dipPosition, yPosition, 0);
    shape.vertex(dipPosition, yPosition, thickness);
    //svg.line(dipPosition, yPosition - thicknessC, dipPosition + thicknessC,  yPosition - thicknessC);
    shape.vertex(dipPosition, yPosition - thickness, 0);
    shape.vertex(dipPosition, yPosition - thickness, thickness);
    //svg.line(dipPosition + thicknessC, yPosition - thicknessC, dipPosition + thicknessC, yPosition);
    shape.vertex(dipPosition + thickness, yPosition - thickness, 0);
    shape.vertex(dipPosition + thickness, yPosition - thickness, thickness);
    shape.vertex(dipPosition + thickness, yPosition, 0);
    shape.vertex(dipPosition + thickness, yPosition, thickness);
    return dipPosition + thickness;
  }

  private void drawNormalBottom() {
    PShape normalBottom = createShape();
    normalBottom.beginShape(TRIANGLE_STRIP);
    initialise(normalBottom);
    if (constructBottom == false) {
      //svg.line(thicknessC + xOffset, boxHeightC + yOffset, boxWidthC - thicknessC + xOffset, boxHeightC + yOffset);
      normalBottom.vertex(thickness, boxHeight, 0);
      normalBottom.vertex(thickness, boxHeight, thickness);
      normalBottom.vertex(boxWidth - thickness, boxHeight, 0);
      normalBottom.vertex(boxWidth - thickness, boxHeight, thickness);
    } else {
      float yPosition = boxHeight - thickness;
      if (floorOffsetEnabled == true) {
        yPosition -= floorOffset;
      }
      //svg.line(thicknessC + xOffset, yPosition, endPieceJointLengthC + thicknessC + xOffset, yPosition);
      normalBottom.vertex(thickness, yPosition, 0);
      normalBottom.vertex(thickness, yPosition, thickness);
      //svg.line(endPieceJointLength + thickness, yPosition, endPieceJointLength + thickness, yPosition - thickness);
      normalBottom.vertex(endPieceJointLength + thickness, yPosition, 0);
      normalBottom.vertex(endPieceJointLength + thickness, yPosition, thickness);
      //svg.line(endPieceJointLength + thickness, yPosition - thickness, endPieceJointLength * 2 + thickness, yPosition - thickness);
      normalBottom.vertex(endPieceJointLength + thickness, yPosition + thickness, 0);
      normalBottom.vertex(endPieceJointLength + thickness, yPosition + thickness, thickness);
      //svg.line(endPieceJointLength * 2 + thickness, yPosition - thickness, endPieceJointLength * 2 + thickness, yPosition);
      normalBottom.vertex(endPieceJointLength * 2 + thickness, yPosition + thickness, 0);
      normalBottom.vertex(endPieceJointLength * 2 + thickness, yPosition + thickness, thickness);
      //svg.line(endPieceJointLength * 2 + thickness, yPosition, boxWidth - thickness, yPosition);
      normalBottom.vertex(endPieceJointLength * 2 + thickness, yPosition, 0);
      normalBottom.vertex(endPieceJointLength * 2 + thickness, yPosition, thickness);
      normalBottom.vertex(boxWidth - thickness, yPosition, 0);
      normalBottom.vertex(boxWidth - thickness, yPosition, thickness);
    }
    normalBottom.endShape(CLOSE);
    bottom.addChild(normalBottom);
  }

  // Draws the top of the cross piece
  private void createTop() {
    top = createShape(GROUP);
    top.beginShape();
    initialise(top);
    if (constructTop == false) {
      //svg.line(thicknessC + xOffset, yOffset, boxWidthC - thicknessC + xOffset, yOffset);
      PShape straightTop = createShape();
      straightTop.beginShape(TRIANGLE_STRIP);
      initialise(straightTop);
      straightTop.vertex(thickness, 0, 0);
      straightTop.vertex(thickness, 0, thickness);
      straightTop.vertex(boxWidth - thickness, 0, 0);
      straightTop.vertex(boxWidth - thickness, 0, thickness);
      straightTop.endShape();
      top.addChild(straightTop);
    } else {
      float yPosition = thickness;
      // Left of joint
      //svg.line(thicknessC + xOffset, yPosition, endPieceJointLengthC + thicknessC + xOffset, yPosition);
      //svg.line(endPieceJointLengthC + thicknessC + xOffset, yPosition, endPieceJointLengthC + thicknessC + xOffset, yPosition - thicknessC);
      PShape leftTop = createShape();
      leftTop.beginShape(TRIANGLE_STRIP);
      initialise(leftTop);
      leftTop.vertex(thickness, yPosition, 0);
      leftTop.vertex(thickness, yPosition, thickness);
      leftTop.vertex(endPieceJointLength + thickness, yPosition, 0);
      leftTop.vertex(endPieceJointLength + thickness, yPosition, thickness);

      leftTop.vertex(endPieceJointLength + thickness, yPosition, 0);
      leftTop.vertex(endPieceJointLength + thickness, yPosition, thickness);
      leftTop.vertex(endPieceJointLength + thickness, yPosition - thickness, 0);
      leftTop.vertex(endPieceJointLength + thickness, yPosition - thickness, thickness);
      leftTop.endShape(CLOSE);
      top.addChild(leftTop);
      // Joint
      float startPosition = endPieceJointLength + thickness;
      for (int i = 0; i < jointDips.size(); i++) {
        float jointDipPos = jointDips.get(i);
        //svg.line(startPosition, yPosition - thicknessC, jointDipPos, yPosition - thicknessC);
        //svg.line(jointDipPos, yPosition - thicknessC, jointDipPos, yPosition);
        //svg.line(jointDipPos, yPosition, jointDipPos + thicknessC, yPosition);
        //svg.line(jointDipPos + thicknessC, yPosition, jointDipPos + thicknessC, yPosition - thicknessC);
        PShape joint = createShape();
        joint.beginShape(TRIANGLE_STRIP);
        initialise(joint);
        leftTop.vertex(startPosition, yPosition - thickness, 0);
        leftTop.vertex(startPosition, yPosition - thickness, thickness);
        leftTop.vertex(jointDipPos, yPosition - thickness, 0);
        leftTop.vertex(jointDipPos, yPosition - thickness, thickness);

        leftTop.vertex(jointDipPos, yPosition - thickness, 0);
        leftTop.vertex(jointDipPos, yPosition - thickness, thickness);
        leftTop.vertex(jointDipPos, yPosition, 0);
        leftTop.vertex(jointDipPos, yPosition, thickness);

        leftTop.vertex(jointDipPos, yPosition, 0);
        leftTop.vertex(jointDipPos, yPosition, thickness);
        leftTop.vertex(jointDipPos + thickness, yPosition, 0);
        leftTop.vertex(jointDipPos + thickness, yPosition, thickness);

        leftTop.vertex(jointDipPos + thickness, yPosition, 0);
        leftTop.vertex(jointDipPos + thickness, yPosition, thickness);
        leftTop.vertex(jointDipPos + thickness, yPosition - thickness, 0);
        leftTop.vertex(jointDipPos + thickness, yPosition - thickness, thickness);
        joint.endShape(CLOSE);
        top.addChild(joint);
        startPosition = jointDipPos + thickness;
      }
      //svg.line(startPosition, yPosition - thicknessC, (endPieceJointLengthC * 2) + thicknessC + xOffset, yPosition - thicknessC);
      PShape close = createShape();
      close.beginShape(TRIANGLE_STRIP);
      initialise(close);
      close.vertex(startPosition, yPosition - thickness, 0);
      close.vertex(startPosition, yPosition - thickness, thickness);
      close.vertex((endPieceJointLength * 2) + thickness, yPosition - thickness, 0);
      close.vertex((endPieceJointLength * 2) + thickness, yPosition - thickness, thickness);
      close.endShape(CLOSE);
      top.addChild(close);
      // Right of Joint
      //svg.line((endPieceJointLengthC * 2) + thicknessC + xOffset, yPosition - thicknessC, (endPieceJointLengthC * 2) + thicknessC + xOffset, yPosition);
      //svg.line((endPieceJointLengthC * 2) + thicknessC + xOffset, yPosition, endPieceLengthC + thicknessC + xOffset, yPosition);
      PShape rightTop = createShape();
      rightTop.beginShape(TRIANGLE_STRIP);
      initialise(rightTop);
      rightTop.vertex((endPieceJointLength * 2) + thickness, yPosition - thickness, 0);
      rightTop.vertex((endPieceJointLength * 2) + thickness, yPosition - thickness, thickness);
      rightTop.vertex((endPieceJointLength * 2) + thickness, yPosition, 0);
      rightTop.vertex((endPieceJointLength * 2) + thickness, yPosition, thickness);

      rightTop.vertex((endPieceJointLength * 2) + thickness, yPosition, 0);
      rightTop.vertex((endPieceJointLength * 2) + thickness, yPosition, thickness);
      rightTop.vertex(endPieceLength + thickness, yPosition, 0);
      rightTop.vertex(endPieceLength + thickness, yPosition, thickness);
      rightTop.endShape(CLOSE);
      top.addChild(rightTop);
    }
  }
}
