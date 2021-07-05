/**
 *  Class that can plot and draw a centre partition piece to the screen.
 *  By Cian O'Gorman 16-08-2020.
 */
private class TD_Shape_Center_Piece extends TD_Shape_Template {

  // Constants
  private static final boolean DONT_INVERT_JOINTS = false;

  private PShape centerPiece;
  private PShape joints;

  TD_Shape_Center_Piece() {
    //centerPiece = createShape();
    //centerPiece.beginShape(TRIANGLE_STRIP);
    //initialise(centerPiece);
    //plotShape();
    //centerPiece.endShape(CLOSE);

    centerPiece = createShape(GROUP);
    //initialise(centerPiece);
    constructCenterJoints(DONT_INVERT_JOINTS, boxLength);
  }

  private void draw() {
    display(centerPiece);
  }

  // Draws the joints of a center/cross piece
  private void constructCenterJoints(boolean invertJoints, float pieceLength) {
    joints = createShape();
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
      extrudeOffset = thickness;
      intrudeOffset = -thickness;
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

          joints.vertex(extrudeOffset + thickness, (jointHeight * (i - 1)), 0);
          joints.vertex(extrudeOffset + thickness, (jointHeight * (i - 1)), thickness);
          joints.vertex(extrudeOffset + thickness, (jointHeight * i), 0);
          joints.vertex(extrudeOffset + thickness, (jointHeight * i), thickness);
          
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

          joints.vertex(thickness, (jointHeight * i), 0);
          joints.vertex(thickness, (jointHeight * i), thickness);
          joints.vertex(0, (jointHeight * i), 0);
          joints.vertex(0, (jointHeight * i), thickness);
          
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
          
          joints.vertex(intrudeOffset, (jointHeight * (i - 1)), 0);
          joints.vertex(intrudeOffset, (jointHeight * (i - 1)), thickness);
          joints.vertex(intrudeOffset, (jointHeight * i), 0);
          joints.vertex(intrudeOffset, (jointHeight * i), thickness);
          
          if (jointStartFound == false) {
            jointStartFound = true;
            if(invertJoints == true)
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
          
          joints.vertex(0, (jointHeight * i), 0);
          joints.vertex(0, (jointHeight * i), thickness);
          joints.vertex(thickness, (jointHeight * i), 0);
          joints.vertex(thickness, (jointHeight * i), thickness);
          
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
      
      joints.vertex(thickness, startPoint, 0);//ok
      joints.vertex(thickness, jointStartYPosition, 0); //ok
      
    } else {
      PShape jointStart = createShape();
      jointStart.beginShape(TRIANGLE_STRIP);
      initialise(jointStart);
      jointStart.vertex(0, startPoint, 0);
      jointStart.vertex(0, startPoint, thickness);
      jointStart.vertex(0, jointStartYPosition, 0);
      jointStart.vertex(0, jointStartYPosition, thickness);
      
      jointStart.vertex(0, startPoint, 0);
      jointStart.vertex(0, startPoint, thickness);
      jointStart.vertex(thickness, startPoint, 0);
      jointStart.vertex(thickness, startPoint, thickness);
      jointStart.endShape();
      centerPiece.addChild(jointStart);
    }
    if (jointEndInwards == true) {
      if(constructBottom == false)
        endPoint += thickness;  // Add control boolean of some sort if joint is ending short
        
      joints.vertex(thickness, jointEndYPosition, 0);
      joints.vertex(thickness, jointEndYPosition, thickness);
      joints.vertex(thickness, endPoint, 0);
      joints.vertex(thickness, endPoint, thickness);
      
    } else {
      
      joints.vertex(0, endPoint, 0);
      joints.vertex(0, endPoint, thickness);
      joints.vertex(0, jointEndYPosition, 0);
      joints.vertex(0, jointEndYPosition, thickness);

      joints.vertex(0, endPoint, 0);
      joints.vertex(0, endPoint, thickness);
      joints.vertex(thickness, endPoint, 0);
      joints.vertex(thickness, endPoint, thickness);
      
    }
    joints.endShape();
    centerPiece.addChild(joints);
  }

  void plotShape() {

    joints.vertex(0, 0, 0);
    joints.vertex(0, thickness, 0);


    centerPiece.vertex(sidePieceJointLength, 0, 0);
    centerPiece.vertex(sidePieceJointLength, thickness, 0);

    centerPiece.vertex(sidePieceJointLength, 0, -thickness);
    centerPiece.vertex(sidePieceJointLength, thickness, -thickness);

    centerPiece.vertex((sidePieceJointLength * 2), 0, -thickness); 
    centerPiece.vertex((sidePieceJointLength * 2), thickness, -thickness); 

    centerPiece.vertex((sidePieceJointLength * 2), 0, 0); 
    centerPiece.vertex((sidePieceJointLength * 2), thickness, 0); 


    centerPiece.vertex(sidePieceLength, 0, 0); 
    centerPiece.vertex(sidePieceLength, thickness, 0);

    centerPiece.vertex(sidePieceLength, 0, endPieceJointLength); 
    centerPiece.vertex(sidePieceLength, thickness, endPieceJointLength); 

    centerPiece.vertex((sidePieceLength + thickness), 0, endPieceJointLength); 
    centerPiece.vertex((sidePieceLength + thickness), thickness, endPieceJointLength); 

    centerPiece.vertex((sidePieceLength + thickness), 0, (endPieceJointLength * 2)); 
    centerPiece.vertex((sidePieceLength + thickness), thickness, (endPieceJointLength * 2)); 

    centerPiece.vertex(sidePieceLength, 0, (endPieceJointLength * 2)); 
    centerPiece.vertex(sidePieceLength, thickness, (endPieceJointLength * 2)); 


    centerPiece.vertex(sidePieceLength, 0, endPieceLength); 
    centerPiece.vertex(sidePieceLength, thickness, endPieceLength); 

    centerPiece.vertex((sidePieceJointLength * 2), 0, endPieceLength); 
    centerPiece.vertex((sidePieceJointLength * 2), thickness, endPieceLength);

    centerPiece.vertex((sidePieceJointLength * 2), 0, endPieceLength + thickness); 
    centerPiece.vertex((sidePieceJointLength * 2), thickness, endPieceLength + thickness);

    centerPiece.vertex(sidePieceJointLength, 0, endPieceLength + thickness); 
    centerPiece.vertex(sidePieceJointLength, thickness, endPieceLength + thickness); 

    centerPiece.vertex(sidePieceJointLength, 0, endPieceLength);
    centerPiece.vertex(sidePieceJointLength, thickness, endPieceLength);


    centerPiece.vertex(0, 0, endPieceLength); 
    centerPiece.vertex(0, thickness, endPieceLength);

    centerPiece.vertex(0, 0, (endPieceJointLength * 2)); 
    centerPiece.vertex(0, thickness, (endPieceJointLength * 2));

    centerPiece.vertex(-thickness, 0, (endPieceJointLength * 2)); 
    centerPiece.vertex(-thickness, thickness, (endPieceJointLength * 2));

    centerPiece.vertex(-thickness, 0, endPieceJointLength); 
    centerPiece.vertex(-thickness, thickness, endPieceJointLength);

    centerPiece.vertex(0, 0, endPieceJointLength); 
    centerPiece.vertex(0, thickness, endPieceJointLength);


    centerPiece.vertex(0, 0, 0); 
    centerPiece.vertex(0, thickness, 0);
  }
}
