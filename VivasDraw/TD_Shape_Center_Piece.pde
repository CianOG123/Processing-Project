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
  private PShape top;
  private PShape bottom;

  TD_Shape_Center_Piece() {
    joints = constructCenterJoints(DONT_INVERT_JOINTS);
    slots = constructSlots(IS_CENTER_PIECE, sidePieceJointLength, crossJointPos, constructCross);
    findDipPositions(sidePieceJointLength, constructTop);
    createBottom();
    DrawTop();
  }

  private void draw() {
    display(top);
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
  private void createBottom() {
    bottom = createShape(GROUP);
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
  }

  // Draws the top side of the center piece
  // contructCrossSlots must be called first
  private void DrawTop() {
    top = createShape(GROUP);
    top.beginShape();
    initialise(top);
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
    Collections.sort(jointPoints);
    float startPoint = thickness;
    float yPosition = thickness;
    if (constructTop == false) {
      yPosition = 0;
    }
    boolean pastJointStart = false;
    boolean pastJointEnd = false;
    boolean lastJoint = false;
    int i = 0;
    float jointPoint = jointPoints.get(i);
    PShape complexTop = createShape(GROUP);
    complexTop.beginShape();
    initialise(complexTop);
    while (i < jointPoints.size()) {
      if (i == jointPoints.size() - 1)
        lastJoint = true;
      jointPoint = jointPoints.get(i);
      if (constructTop == false) {
        PShape leftTop = createShape();
        leftTop.beginShape(TRIANGLE_STRIP);
        initialise(leftTop);
        //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
        leftTop.vertex(startPoint, yPosition, 0);
        leftTop.vertex(startPoint, yPosition, thickness);
        leftTop.vertex(jointPoint, yPosition, 0);
        leftTop.vertex(jointPoint, yPosition, thickness);
        leftTop.endShape(CLOSE);
        complexTop.addChild(leftTop);
        if (lastJoint == false) {
          if (jointPoints.get(i + 1) < sidePieceJointLength * 2 + thickness && pastJointStart == true) {
            startPoint = drawDip(complexTop, jointPoint, jointPoints.get(i + 1));
          } else
            startPoint = jointPoint + thickness;
        } else
          startPoint = jointPoint + thickness;
      } else {
        // joint on start edge
        if (jointPoint <= sidePieceJointLength + thickness && jointPoint + thickness > sidePieceJointLength + thickness) {
          pastJointStart = true;
          PShape startEdge = createShape();
          startEdge.beginShape(TRIANGLE_STRIP);
          initialise(startEdge);
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          startEdge.vertex(startPoint, yPosition, 0);
          startEdge.vertex(startPoint, yPosition, thickness);
          startEdge.vertex(jointPoint, yPosition, 0);
          startEdge.vertex(jointPoint, yPosition, thickness);
          startEdge.endShape(CLOSE);
          complexTop.addChild(startEdge);
          if (lastJoint == false) {
            if (jointPoints.get(i + 1) < sidePieceJointLength * 2 + thickness && jointPoints.get(i + 1) > sidePieceJointLength + thickness) {
              startPoint = drawDip(complexTop, jointPoint, jointPoints.get(i + 1));
            }
          } else
            startPoint = jointPoint;
          yPosition -= thickness;
        }
        // joint on end edge
        else if (jointPoint <= sidePieceJointLength * 2 + thickness && jointPoint + thickness > sidePieceJointLength * 2 + thickness) {
          pastJointEnd = true;
          PShape endEdge = createShape();
          endEdge.beginShape(TRIANGLE_STRIP);
          initialise(endEdge);
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          endEdge.vertex(startPoint, yPosition, 0);
          endEdge.vertex(startPoint, yPosition, thickness);
          endEdge.vertex(jointPoint, yPosition, 0);
          endEdge.vertex(jointPoint, yPosition, thickness);
          endEdge.endShape(CLOSE);
          complexTop.addChild(endEdge);
          startPoint = jointPoint + thickness;
          yPosition += thickness;
        }
        // joint past start and start edge not drawn
        else if (jointPoint >= sidePieceJointLength + thickness && pastJointStart == false) {
          i--;
          pastJointStart = true;
          jointPoint = sidePieceJointLength + thickness;
          PShape pastStart = createShape();
          pastStart.beginShape(TRIANGLE_STRIP);
          initialise(pastStart);
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          pastStart.vertex(startPoint, yPosition, 0);
          pastStart.vertex(startPoint, yPosition, thickness);
          pastStart.vertex(jointPoint, yPosition, 0);
          pastStart.vertex(jointPoint, yPosition, thickness);
          //svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition - thicknessC);
          pastStart.vertex(startPoint, yPosition, 0);
          pastStart.vertex(startPoint, yPosition, thickness);
          pastStart.vertex(jointPoint, yPosition - thickness, 0);
          pastStart.vertex(jointPoint, yPosition - thickness, thickness);
          pastStart.endShape(CLOSE);
          complexTop.addChild(pastStart);
          startPoint = jointPoint;
          yPosition -= thickness;
        }
        // joint past end
        else if (jointPoint >= sidePieceJointLength * 2 + thickness && pastJointEnd == false) {
          i--;
          pastJointEnd = true;
          jointPoint = (sidePieceJointLength * 2) + thickness;
          PShape pastEnd = createShape();
          pastEnd.beginShape(TRIANGLE_STRIP);
          initialise(pastEnd);
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          pastEnd.vertex(startPoint, yPosition, 0);
          pastEnd.vertex(startPoint, yPosition, thickness);
          pastEnd.vertex(jointPoint, yPosition, 0);
          pastEnd.vertex(jointPoint, yPosition, thickness);
          //svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition + thicknessC);
          pastEnd.vertex(jointPoint, yPosition, 0);
          pastEnd.vertex(jointPoint, yPosition, thickness);
          pastEnd.vertex(jointPoint, yPosition + thickness, 0);
          pastEnd.vertex(jointPoint, yPosition + thickness, thickness);
          pastEnd.endShape(CLOSE);
          complexTop.addChild(pastEnd);
          startPoint = jointPoint;
          yPosition += thickness;
        }
        // joint before start
        else {
          //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
          if (lastJoint == false) {
            if (jointPoints.get(i + 1) < sidePieceJointLength * 2 + thickness && pastJointStart == true) {
              startPoint = drawDip(complexTop, jointPoint, jointPoints.get(i + 1));
            } else
              startPoint = jointPoint + thickness;
          } else
            startPoint = jointPoint + thickness;
        }
      }
      i++;
    }
    if (pastJointEnd == false && constructTop == true) {
      pastJointEnd = true;
      jointPoint = (sidePieceJointLength * 2) + thickness;
      PShape pastEnd = createShape();
      pastEnd.beginShape(TRIANGLE_STRIP);
      initialise(pastEnd);
      //svg.line(startPoint, yPosition, jointPoint + xOffset, yPosition);
      pastEnd.vertex(startPoint, yPosition, 0);
      pastEnd.vertex(startPoint, yPosition, thickness);
      pastEnd.vertex(jointPoint, yPosition, 0);
      pastEnd.vertex(jointPoint, yPosition, thickness);
      //svg.line(jointPoint + xOffset, yPosition, jointPoint + xOffset, yPosition + thicknessC);
      pastEnd.vertex(jointPoint, yPosition, 0);
      pastEnd.vertex(jointPoint, yPosition, thickness);
      pastEnd.vertex(jointPoint, yPosition + thickness, 0);
      pastEnd.vertex(jointPoint, yPosition + thickness, thickness);
      pastEnd.endShape(CLOSE);
      complexTop.addChild(pastEnd);
      startPoint = jointPoint;
      yPosition += thickness;
    }
    //svg.line(startPoint, yPosition, sidePieceLengthC + thicknessC + xOffset, yPosition);
    PShape close = createShape();
    close.beginShape(TRIANGLE_STRIP);
    initialise(close);
    close.vertex(startPoint, yPosition, 0);
    close.vertex(startPoint, yPosition, thickness);
    close.vertex(sidePieceLength + thickness, yPosition, 0);
    close.vertex(sidePieceLength + thickness, yPosition, thickness);
    close.endShape(CLOSE);
    complexTop.addChild(close);
    top.addChild(complexTop);
  }

  // Draws a dip between two given slots
  // Returns the new start position
  private float drawDip(PShape shape, float jointPos1, float jointPos2) {
    float dipPosition = (abs(jointPos2 + jointPos1) / 2);
    //svg.line(jointPos1 + thickness, 0, dipPosition, 0);
    shape.vertex(jointPos1 + thickness, 0, 0);
    shape.vertex(jointPos1 + thickness, 0, thickness);
    shape.vertex(dipPosition, 0, 0);
    shape.vertex(dipPosition, 0, thickness);
    //svg.line(dipPosition, 0, dipPosition, thickness);
    shape.vertex(dipPosition, 0, 0);
    shape.vertex(dipPosition, 0, thickness);
    shape.vertex(dipPosition, thickness, 0);
    shape.vertex(dipPosition, thickness, thickness);
    //svg.line(dipPosition, thickness, dipPosition + thickness, thickness);
    shape.vertex(dipPosition, thickness, 0);
    shape.vertex(dipPosition, thickness, thickness);
    shape.vertex(dipPosition + thickness, thickness, 0);
    shape.vertex(dipPosition + thickness, thickness, thickness);
    //svg.line(dipPosition + thickness, thickness, dipPosition + thickness, 0);
    //shape.vertex(dipPosition + thickness, thickness, 0);
    //shape.vertex(dipPosition + thickness,thickness, thickness);
    //shape.vertex(dipPosition + thickness, 0, 0);
    //shape.vertex(dipPosition + thickness, 0, thickness);
    return dipPosition + thickness;
  }

  private void drawNormalTop() {
    PShape normalTop = createShape();
    normalTop.beginShape(TRIANGLE_STRIP);
    initialise(normalTop);
    if (constructTop == false) {
      //svg.line(thicknessC + xOffset, yOffset, boxLengthC - thicknessC + xOffset, yOffset);
      normalTop.vertex(thickness, 0, 0);
      normalTop.vertex(thickness, 0, thickness);
      normalTop.vertex(boxLength - thickness, 0, 0);
      normalTop.vertex(boxLength - thickness, 0, thickness);
    } else {
      //svg.line(thickness, thickness, sidePieceJointLength + thickness, thickness);
      normalTop.vertex(thickness, thickness, 0);
      normalTop.vertex(thickness, thickness, thickness);
      normalTop.vertex(sidePieceJointLength + thickness, thickness, 0);
      normalTop.vertex(sidePieceJointLength + thickness, thickness, thickness);
      //svg.line(sidePieceJointLength + thickness, thickness, sidePieceJointLength + thickness, 0);
      normalTop.vertex(sidePieceJointLength + thickness, thickness, 0);
      normalTop.vertex(sidePieceJointLength + thickness, thickness, thickness);
      normalTop.vertex(sidePieceJointLength + thickness, 0, 0);
      normalTop.vertex(sidePieceJointLength + thickness, 0, thickness);
      //svg.line(sidePieceJointLength + thickness, 0, sidePieceJointLength * 2 + thickness, 0);
      normalTop.vertex(sidePieceJointLength + thickness, 0, 0);
      normalTop.vertex(sidePieceJointLength + thickness, 0, thickness);
      normalTop.vertex(sidePieceJointLength * 2 + thickness, 0, 0);
      normalTop.vertex(sidePieceJointLength * 2 + thickness, 0, thickness);
      //svg.line(sidePieceJointLength * 2 + thickness, 0, sidePieceJointLength * 2 + thickness, thickness);
      normalTop.vertex(sidePieceJointLength * 2 + thickness, 0, 0);
      normalTop.vertex(sidePieceJointLength * 2 + thickness, 0, thickness);
      normalTop.vertex(sidePieceJointLength * 2 + thickness, thickness, 0);
      normalTop.vertex(sidePieceJointLength * 2 + thickness, thickness, thickness);
      //svg.line(sidePieceJointLength * 2 + thickness, thickness, boxLength - thickness, thickness);
      normalTop.vertex(sidePieceJointLength * 2 + thickness, thickness, 0);
      normalTop.vertex(sidePieceJointLength * 2 + thickness, thickness, thickness);
      normalTop.vertex(boxLength - thickness, thickness, 0);
      normalTop.vertex(boxLength - thickness, thickness, thickness);
    }
    normalTop.endShape(CLOSE);
    top.addChild(normalTop);
  }
}
