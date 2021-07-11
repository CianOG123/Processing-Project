/**
 *  Shared functions between cross and center classes.
 *  By Cian O'Gorman 05-07-2021.
 */
private class TD_Shape_Internal_Piece extends TD_Shape_Template {

  protected ArrayList<Float> jointPoints = new ArrayList<Float>();
  protected ArrayList<Float> jointDips = new ArrayList<Float>();

  // Constructs the cross piece slots in the center piece
  protected PShape constructSlots(boolean isCrossPiece, float pieceJointLength, float[] jointPos, boolean[] constructPiece) {
    PShape crossSlots = createShape(GROUP);
    float yPosition;
    float jointYPosition;
    if (isCrossPiece == true) {
      yPosition = thickness;
      jointYPosition = 0;
      if (constructTop == false) {
        yPosition = 0;
      }
    } else {
      yPosition = boxHeight - thickness;
      jointYPosition = boxHeight;
      if (constructBottom == false) {
        yPosition = boxHeight;
      } else if (floorOffsetEnabled == true) {
        yPosition -= floorOffset;
        jointYPosition -= floorOffset;
      }
    }
    float centerPoint = (boxHeight / 2);
    if (floorOffsetEnabled == true && constructBottom == true) {
      centerPoint = ((boxHeight - floorOffset) / 2);
    }
    for (int i = 0; i < constructCenter.length; i++) {
      if (constructPiece[i] == true) {
        PShape slot = createShape();
        slot.beginShape(TRIANGLE_STRIP);
        initialise(slot);
        // left side of joint slot
        if (jointPos[i] > pieceJointLength + thickness && jointPos[i] < pieceJointLength * 2 + thickness) {
          jointPoints.add(jointPos[i]);
          slot.vertex(jointPos[i], jointYPosition, 0);
          slot.vertex(jointPos[i], jointYPosition, thickness);
          slot.vertex(jointPos[i], centerPoint, 0);
          slot.vertex(jointPos[i], centerPoint, thickness);
        } else {
          jointPoints.add(jointPos[i]);
          slot.vertex(jointPos[i], yPosition, 0);
          slot.vertex(jointPos[i], yPosition, thickness);
          slot.vertex(jointPos[i], centerPoint, 0);
          slot.vertex(jointPos[i], centerPoint, thickness);
        }
        // right side of joint slot
        if (jointPos[i] + thickness > pieceJointLength + thickness && jointPos[i] + thickness < pieceJointLength * 2 + thickness) {
          slot.vertex(jointPos[i] + thickness, centerPoint, 0);
          slot.vertex(jointPos[i] + thickness, centerPoint, thickness);
          slot.vertex(jointPos[i] + thickness, jointYPosition, 0);
          slot.vertex(jointPos[i] + thickness, jointYPosition, thickness);
        } else {
          slot.vertex(jointPos[i] + thickness, centerPoint, 0);
          slot.vertex(jointPos[i] + thickness, centerPoint, thickness);
          slot.vertex(jointPos[i] + thickness, yPosition, 0);
          slot.vertex(jointPos[i] + thickness, yPosition, thickness);
        }
        slot.endShape();
        crossSlots.addChild(slot);
      }
    }
    return crossSlots;
  }

  protected void findDipPositions(float pieceJointLength, boolean constructPiece) {
    Collections.sort(jointPoints);
    float startPoint = thickness;
    boolean pastJointStart = false;
    boolean pastJointEnd = false;
    boolean lastJoint = false;
    int i = 0;
    float jointPoint;
    try {
      jointPoint = jointPoints.get(i);
    } 
    catch(IndexOutOfBoundsException e) {
    }
    while (i < jointPoints.size()) {
      if (i == jointPoints.size() - 1)
        lastJoint = true;
      jointPoint = jointPoints.get(i);
      // joint on start edge
      if (jointPoint <= pieceJointLength + thickness && jointPoint + thickness > pieceJointLength + thickness) {
        pastJointStart = true;
        if (lastJoint == false && jointPoints.get(i + 1) < pieceJointLength * 2 + thickness && jointPoints.get(i + 1) > pieceJointLength + thickness) {
          startPoint = (abs(jointPoint + jointPoints.get(i + 1)) / 2);
          jointDips.add(startPoint);
        } else
          startPoint = jointPoint;
      }
      // joint on end edge
      else if (jointPoint <= pieceJointLength * 2 + thickness && jointPoint + thickness > pieceJointLength * 2 + thickness) {
        pastJointEnd = true;
        startPoint = jointPoint + thickness;
      }
      // joint past start and start edge not drawn
      else if (jointPoint >= pieceJointLength + thickness && pastJointStart == false) {
        i--;
        pastJointStart = true;
        jointPoint = pieceJointLength + thickness;
        startPoint = jointPoint;
      }
      // joint past end
      else if (jointPoint >= pieceJointLength * 2 + thickness && pastJointEnd == false) {
        i--;
        pastJointEnd = true;
        jointPoint = (pieceJointLength * 2) + thickness;
        startPoint = jointPoint;
      }
      // joint before start
      else {
        if (lastJoint == false) {
          if (jointPoints.get(i + 1) < pieceJointLength * 2 + thickness && pastJointStart == true) {
            startPoint = (abs(jointPoint + jointPoints.get(i + 1)) / 2);
            jointDips.add(startPoint);
          } else
            startPoint = jointPoint + thickness;
        } else
          startPoint = jointPoint + thickness;
      }
      i++;
    }
    if (pastJointEnd == false && constructPiece == true) {
      pastJointEnd = true;
      jointPoint = (pieceJointLength * 2) + thickness;
      startPoint = jointPoint;
    }
  }

  // Draws the joints of a center/cross piece
  protected PShape constructCenterJoints(boolean invertJoints) {
    PShape centerJoints = createShape(GROUP);
    PShape joints = createShape();
    joints.beginShape(TRIANGLE_STRIP);
    initialise(joints);
    float startPoint = 0;
    float endPoint = boxHeight;
    if (constructTop == true)
      startPoint += thickness; 
    if (constructBottom == true) {
      endPoint -= thickness;
      if (floorOffsetEnabled == true)
        endPoint -= floorOffset;
    }
    // Variables used to invert the joints 
    float extrudeOffset = 0;
    float intrudeOffset = 0;
    if (invertJoints == true) {
      extrudeOffset = -thickness;
      intrudeOffset = thickness;
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
        if (jointHeight * (i - 1)  >= startPoint && jointHeight * i <= endPoint) {
          joints.vertex(extrudeOffset + thickness, jointHeight * (i - 1), 0);
          joints.vertex(extrudeOffset + thickness, jointHeight * (i - 1), thickness);
          joints.vertex(extrudeOffset + thickness, jointHeight * i, 0);
          joints.vertex(extrudeOffset + thickness, jointHeight * i, thickness);
          if (jointStartFound == false) {
            jointStartFound = true;
            jointStartInwards = true;
            jointStartYPosition = (jointHeight * (i - 1));
          }
          jointEndInwards = true;
          jointEndYPosition = (jointHeight * i);
        }
        // Upper edges
        if (jointHeight * i >= startPoint && jointHeight * i <= endPoint) {

          if (invertJoints) {
            joints.vertex(0, jointHeight * i, 0);
            joints.vertex(0, jointHeight * i, thickness);
          } else {
            joints.vertex(thickness, jointHeight * i, 0);
            joints.vertex(thickness, jointHeight * i, thickness);
          }

          if (jointStartFound == false) {
            jointStartFound = true;
            if (invertJoints == true)
              jointStartInwards = false;
            else
              jointStartInwards = true;
            jointStartYPosition = (jointHeight * i);
          }
          if (invertJoints == true)
            jointEndInwards = true;
          else
            jointEndInwards = false;
          jointEndYPosition = (jointHeight * i);
        }
      } else {
        // Inwards to outwards
        if (jointHeight * (i - 1) >= startPoint && jointHeight * i <= endPoint) {
          // Outer edges
          joints.vertex(intrudeOffset, jointHeight * (i - 1), 0);
          joints.vertex(intrudeOffset, jointHeight * (i - 1), thickness);
          joints.vertex(intrudeOffset, jointHeight * i, 0);
          joints.vertex(intrudeOffset, jointHeight * i, thickness);

          if (jointStartFound == false) {
            jointStartFound = true;
            if (invertJoints == true)
              jointStartInwards = true;
            else
              jointStartInwards = false;
            jointStartYPosition = (jointHeight * (i - 1));
          }
          jointEndInwards = false;
          jointEndYPosition = (jointHeight * i);
        }
        // Bottom edges
        if (jointHeight * i >= startPoint && jointHeight * i <= endPoint) {
          if (invertJoints) {
            joints.vertex(thickness, jointHeight * i, 0);
            joints.vertex(thickness, jointHeight * i, thickness);
          } else {
            joints.vertex(0, jointHeight * i, 0);
            joints.vertex(0, jointHeight * i, thickness);
          }
          if (jointStartFound == false) {
            jointStartFound = true;
            if (invertJoints == true)
              jointStartInwards = true;
            else
              jointStartInwards = false;
            jointStartYPosition = (jointHeight * i);
          }
          if (invertJoints == true)
            jointEndInwards = false;
          else
            jointEndInwards = true;
          jointEndYPosition = (jointHeight * i);
        }
      }
    }
    // Connect startPoint to joints
    if (jointStartInwards == true) {
      PShape jointStart = createShape();
      jointStart.beginShape(TRIANGLE_STRIP);
      initialise(jointStart);
      jointStart.vertex(thickness, startPoint, 0);
      jointStart.vertex(thickness, startPoint, thickness);
      jointStart.vertex(thickness, jointStartYPosition, 0);
      jointStart.vertex(thickness, jointStartYPosition, thickness);
      jointStart.endShape();
      centerJoints.addChild(jointStart);
    } else {
      PShape jointStart = createShape();
      jointStart.beginShape(TRIANGLE_STRIP);
      initialise(jointStart);
      jointStart.vertex(0, jointStartYPosition, 0);
      jointStart.vertex(0, jointStartYPosition, thickness);
      jointStart.vertex(0, startPoint, 0);
      jointStart.vertex(0, startPoint, thickness);

      jointStart.vertex(0, startPoint, 0);
      jointStart.vertex(0, startPoint, thickness);
      jointStart.vertex(thickness, startPoint, 0);
      jointStart.vertex(thickness, startPoint, thickness);
      jointStart.endShape();
      centerJoints.addChild(jointStart);
    }
    if (jointEndInwards == true) {
      if (constructBottom == false)
        endPoint += 0;  // If thickness needs to be added here then something needs to change
      joints.vertex(thickness, jointEndYPosition, 0);
      joints.vertex(thickness, jointEndYPosition, thickness);
      joints.vertex(thickness, endPoint, 0);
      joints.vertex(thickness, endPoint, thickness);
    } else {
      joints.vertex(0, jointEndYPosition, 0);
      joints.vertex(0, jointEndYPosition, thickness);
      joints.vertex(0, endPoint, 0);
      joints.vertex(0, endPoint, thickness);

      joints.vertex(0, endPoint, 0);
      joints.vertex(0, endPoint, thickness);
      joints.vertex(thickness, endPoint, 0);
      joints.vertex(thickness, endPoint, thickness);
    }
    joints.endShape();
    centerJoints.addChild(joints);
    return centerJoints;
  }
}
