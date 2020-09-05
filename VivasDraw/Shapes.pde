/**
 *  Class that can plot and draw a centre partition piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
private class Shape_Center_Piece extends Shape_Template_Static {

  // Objects
  private PShape topJoint, bottomJoint;                // Declaring the side piece shape
  private PShape jointsUpperOne, jointsUpperTwo, jointsLowerOne, jointsLowerTwo;  // The dynamically generated joints of the center piece (used to easily draw multiple joints with same algorithm as .svg export)

  // Variables
  private float pieceDimension = boxLength;  // Length with joints
  private float pieceJointLength = sidePieceJointLength;
  private float pieceLength = sidePieceLength;  // Length without joints

  // Booleans
  private boolean isCrossSectionPiece = false;  // When set to true the piece will be treated as a cross piece as opposed to a center piece
  private  boolean singleSideJoint = false;  // When set to false multiple joints will be created through the end piece to align with the side piece

  // Joint Options
  private boolean wasDrawingOutwards = false;  // When set to true the joint will be plotted outwards, when false it will be plotted inwards
  private boolean disableExtendedJoint = false;  // Disables the top piece extension when set to true

  Shape_Center_Piece(boolean isCrossSectionPiece) {
    
    // Piece measurements (differs for center piece / cross section piece)
    pieceDimension = boxLength;
    pieceJointLength = sidePieceJointLength;
    pieceLength = sidePieceLength;
    if(isCrossSectionPiece == true){
      pieceDimension = boxWidth;
      pieceJointLength = endPieceJointLength;
      pieceLength = endPieceLength;
    }

    this.isCrossSectionPiece = isCrossSectionPiece;

    // Creating joints
    getMiddleJointType(isCrossSectionPiece);

    jointsUpperOne = createShape();
    jointsUpperOne.beginShape(TRIANGLE_STRIP);
    initialise(jointsUpperOne);
    plotJoints(jointsUpperOne, -sidePieceLength, thickness, true);
    jointsUpperOne.endShape();

    jointsUpperTwo = createShape();
    jointsUpperTwo.beginShape(TRIANGLE_STRIP);
    initialise(jointsUpperTwo);
    plotJoints(jointsUpperTwo, -sidePieceLength, thickness, true);
    jointsUpperTwo.endShape();

    jointsLowerOne = createShape();
    jointsLowerOne.beginShape(TRIANGLE_STRIP);
    initialise(jointsLowerOne);
    plotJoints(jointsLowerOne, -sidePieceLength, thickness, false);
    jointsLowerOne.endShape();

    jointsLowerTwo = createShape();
    jointsLowerTwo.beginShape(TRIANGLE_STRIP);
    initialise(jointsLowerTwo);
    plotJoints(jointsLowerTwo, -sidePieceLength, thickness, false);
    jointsLowerTwo.endShape();

    topJoint = createShape();
    topJoint.beginShape(TRIANGLE_STRIP);
    initialise(topJoint);
    boolean isTopPiece = true;
    plotShape(topJoint, isCrossSectionPiece, isTopPiece);
    topJoint.endShape();

    bottomJoint = createShape();
    bottomJoint.beginShape(TRIANGLE_STRIP);
    initialise(bottomJoint);
    isTopPiece = false;
    plotShape(bottomJoint, isCrossSectionPiece, isTopPiece);
    bottomJoint.endShape();
  }

  private void draw() {
    graphicContext.pushMatrix();
    {
      graphicContext.translate(thickness, 0, 0);
      display(topJoint);
    }
    graphicContext.popMatrix();

    graphicContext.pushMatrix();
    {
      graphicContext.rotateX(radians(180));
      graphicContext.translate(thickness, -boxHeight, -thickness);
      display(bottomJoint);
    }
    graphicContext.popMatrix();

    graphicContext.pushMatrix();
    {
      graphicContext.translate(thickness, 0, thickness);
      graphicContext.rotateY(radians(180));
      display(jointsUpperOne);
    }
    graphicContext.popMatrix();

    // Display joints upper two
    graphicContext.pushMatrix();
    {
      graphicContext.translate(pieceDimension - thickness, 0, 0);
      display(jointsUpperTwo);
    }
    graphicContext.popMatrix();

    // Display joints lower one
    graphicContext.pushMatrix();
    {
      graphicContext.rotateX(radians(180));
      graphicContext.rotateY(radians(180));
      graphicContext.translate(-thickness, -boxHeight, 0);
      display(jointsLowerOne);
    }
    graphicContext.popMatrix();

    // Display joints lower two
    graphicContext.pushMatrix();
    {
      graphicContext.rotateX(radians(180));
      graphicContext.translate(pieceDimension - thickness, -boxHeight, -thickness);
      display(jointsLowerTwo);
    }
    graphicContext.popMatrix();
  }

  // Returns if the middle joint of the center piece should be extruded or intruded
  // Invert joint inverts whether the middle joint will be in or out
  private void getMiddleJointType(boolean invertJoint) {
    if (invertJoint == false) {
      middleJointExtrude = false;
    } else {
      middleJointExtrude = true;
    }
    if ((jointAmount - 1) % 4 == 0) {
      if (invertJoint == false) {
        middleJointExtrude = true;
      } else {
        middleJointExtrude = false;
      }
    }
  }

  // Plot the dynamic multiple joints of a center piece quarter
  private void plotJoints(PShape joint, float xOffset, float yOffset, boolean drawCenterJoint) {
    // Construct Right Joints
    wasDrawingOutwards = true;
    if (multipleJoints == false) {

      // Single joint
      joint.vertex(xOffset + (sidePieceJointLength * 3) + thickness, yOffset + thickness);
      joint.vertex(xOffset + (sidePieceJointLength * 3) + thickness, yOffset + thickness, thickness);

      joint.vertex(xOffset + (sidePieceJointLength * 3) + thickness, yOffset + thickness + endPieceCenterJointLength);
      joint.vertex(xOffset + (sidePieceJointLength * 3) + thickness, yOffset + thickness + endPieceCenterJointLength, thickness);

      joint.vertex(xOffset + (sidePieceJointLength * 3) + (thickness * 2), yOffset + thickness + endPieceCenterJointLength);
      joint.vertex(xOffset + (sidePieceJointLength * 3) + (thickness * 2), yOffset + thickness + endPieceCenterJointLength, thickness);

      joint.vertex(xOffset + (sidePieceJointLength * 3) + (thickness * 2), yOffset + thickness + (endPieceCenterJointLength * 2));
      joint.vertex(xOffset + (sidePieceJointLength * 3) + (thickness * 2), yOffset + thickness + (endPieceCenterJointLength * 2), thickness);

      joint.vertex(xOffset + (sidePieceJointLength * 3) + thickness, yOffset + thickness + (endPieceCenterJointLength * 2));
      joint.vertex(xOffset + (sidePieceJointLength * 3) + thickness, yOffset + thickness + (endPieceCenterJointLength * 2), thickness);
    } else {

      // Creating center joint
      float intrusionOffset = 0;
      if (middleJointExtrude == false) {
        intrusionOffset = thickness;
      }
      if (drawCenterJoint == true) {
        joint.vertex(xOffset + boxLength - thickness - intrusionOffset, yOffset + (boxHeight / 2) + (jointHeight / 2) - thickness);
        joint.vertex(xOffset + boxLength - thickness - intrusionOffset, yOffset + (boxHeight / 2) + (jointHeight / 2) - thickness, thickness);
      }

      joint.vertex(xOffset + boxLength - thickness - intrusionOffset, yOffset + (boxHeight / 2) - (jointHeight / 2) - thickness);
      joint.vertex(xOffset + boxLength - thickness - intrusionOffset, yOffset + (boxHeight / 2) - (jointHeight / 2) - thickness, thickness);

      // Creating Main joints
      float jointExtrudeStart = thickness;  // The start position of the given joint
      float jointExtrudeEnd = 0; // The end position of the given joint
      if (middleJointExtrude == false) {
        wasDrawingOutwards = false;
      }
      float yJointOffset = (boxHeight / 2) - (jointHeight / 2) - thickness;
      // Loop to create normal joints from center indefinitely
      for (int i = 0; yJointOffset - (jointHeight * i) >= 0; i++) {  // Add yOffset to both sides of condition if errors occur
        // Flipping direction of joints being drawn
        if (wasDrawingOutwards == true) {
          wasDrawingOutwards = false;
          jointExtrudeStart = thickness;
          jointExtrudeEnd = 0;
        } else {
          wasDrawingOutwards = true;
          jointExtrudeStart = 0;
          jointExtrudeEnd = thickness;
        }

        // Drawing horizontal
        if ((int) (yOffset + yJointOffset - (jointHeight * i)) != (int) yOffset) {
          disableExtendedJoint = false;
          joint.vertex(xOffset - jointExtrudeStart + boxLength - thickness, yOffset + yJointOffset - (jointHeight * i));
          joint.vertex(xOffset - jointExtrudeStart + boxLength - thickness, yOffset + yJointOffset - (jointHeight * i), thickness);
        } else {
          disableExtendedJoint = true;
        }

        // Drawing vertical
        if (yOffset + yJointOffset - (jointHeight * (i + 1)) > yOffset) {
          joint.vertex(xOffset + jointExtrudeEnd + boxLength - (thickness * 2), yOffset + yJointOffset - (jointHeight * i));
          joint.vertex(xOffset + jointExtrudeEnd + boxLength - (thickness * 2), yOffset + yJointOffset - (jointHeight * i), thickness);

          joint.vertex(xOffset + jointExtrudeEnd + boxLength - (thickness * 2), yOffset + yJointOffset - (jointHeight * (i + 1)));
          joint.vertex(xOffset + jointExtrudeEnd + boxLength - (thickness * 2), yOffset + yJointOffset - (jointHeight * (i + 1)), thickness);
        }

        // Constructing odd joint vertical if all normal joints are created
        if (yOffset + yJointOffset - (jointHeight * (i + 1)) <= yOffset) {
          // Inward ending
          if (wasDrawingOutwards == false) {
            joint.vertex(xOffset + jointExtrudeStart - thickness + (boxLength - (thickness * 2)), yOffset + yJointOffset - (jointHeight * i));
            joint.vertex(xOffset + jointExtrudeStart - thickness + (boxLength - (thickness * 2)), yOffset + yJointOffset - (jointHeight * i), thickness);

            joint.vertex(xOffset + jointExtrudeStart - thickness + (boxLength - (thickness * 2)), yOffset);
            joint.vertex(xOffset + jointExtrudeStart - thickness + (boxLength - (thickness * 2)), yOffset, thickness);
          } else {
            if (disableExtendedJoint == false) {
              joint.vertex(xOffset + jointExtrudeStart - thickness + boxLength, yOffset + yJointOffset - (jointHeight * i));
              joint.vertex(xOffset + jointExtrudeStart - thickness + boxLength, yOffset + yJointOffset - (jointHeight * i), thickness);

              joint.vertex(xOffset + jointExtrudeStart - thickness + boxLength, yOffset);
              joint.vertex(xOffset + jointExtrudeStart - thickness + boxLength, yOffset, thickness);
            }
          }
        }
      }
    }
  }

  // Plots the top and bottom side of the center piece
  @Override
    void plotShape(PShape shape, boolean isCrossSectionPiece, boolean isTopPiece) {

    // Setting whether to extrude the joint on this side of the shape
    boolean extrudeJoint = centerExtrudeThroughFloor;
    if (isTopPiece == true) {
      extrudeJoint = centerExtrudeThroughTop;
    }
    
    // Setting whether to draw a slot on this side of the shape
    boolean  createSlot = false;
    if(isCrossSectionPiece == isTopPiece){
      createSlot = true;
    }

    // Draw side joint inwards
    if ((wasDrawingOutwards == false) || (disableExtendedJoint == true)) {
      shape.vertex(0, thickness);
      shape.vertex(0, thickness, thickness);
    }
    // Draw side joint Outwards
    else {
      shape.vertex(-thickness, thickness);
      shape.vertex(-thickness, thickness, thickness);
    }

    // Drawing top/bottom joint
    if (extrudeJoint == true) {
      shape.vertex(pieceJointLength, thickness);
      shape.vertex(pieceJointLength, thickness, thickness);

      shape.vertex(pieceJointLength, 0);
      shape.vertex(pieceJointLength, 0, thickness);

      // Draw Cross section slot with top/bottom joint
      if (createSlot == true) {
        shape.vertex(((pieceDimension - thickness) / 2) - thickness, 0);
        shape.vertex(((pieceDimension - thickness) / 2) - thickness, 0, thickness);

        shape.vertex(((pieceDimension - thickness) / 2) - thickness, (boxHeight / 2));
        shape.vertex(((pieceDimension - thickness) / 2) - thickness, (boxHeight / 2), thickness);

        shape.vertex(((pieceDimension + thickness) / 2) - thickness, (boxHeight / 2));
        shape.vertex(((pieceDimension + thickness) / 2) - thickness, (boxHeight / 2), thickness);

        shape.vertex(((pieceDimension + thickness) / 2) - thickness, 0);
        shape.vertex(((pieceDimension + thickness) / 2) - thickness, 0, thickness);
      }

      shape.vertex((pieceJointLength * 2), 0);
      shape.vertex((pieceJointLength * 2), 0, thickness);


      shape.vertex((pieceJointLength * 2), thickness);
      shape.vertex((pieceJointLength * 2), thickness, thickness);
    }

    // Drawing cross section slot without top/bottom joint
    if ((extrudeJoint == false) && (createSlot == true)) {
      shape.vertex(((pieceDimension - thickness) / 2) - thickness, thickness);
      shape.vertex(((pieceDimension - thickness) / 2) - thickness, thickness, thickness);

      shape.vertex(((pieceDimension - thickness) / 2) - thickness, (boxHeight / 2));
      shape.vertex(((pieceDimension - thickness) / 2) - thickness, (boxHeight / 2), thickness);

      shape.vertex(((pieceDimension + thickness) / 2) - thickness, (boxHeight / 2));
      shape.vertex(((pieceDimension + thickness) / 2) - thickness, (boxHeight / 2), thickness);

      shape.vertex(((pieceDimension + thickness) / 2) - thickness, thickness);
      shape.vertex(((pieceDimension + thickness) / 2) - thickness, thickness, thickness);
    }

    // Draw joint inwards
    if ((wasDrawingOutwards == false) || (disableExtendedJoint == true)) {
      shape.vertex(pieceLength, thickness); 
      shape.vertex(pieceLength, thickness, thickness);
    }
    // Draw joint outwards
    else {
      shape.vertex(pieceLength + thickness, thickness); 
      shape.vertex(pieceLength + thickness, thickness, thickness);
    }
  }
}


/**
 *  Class that can plot and draw a floor/top piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
private class Shape_Floor_Piece extends Shape_Template_Static {

  // Objects
  private PShape floorPiece;                // Declaring the side piece shape

  Shape_Floor_Piece() {
    floorPiece = createShape();
    floorPiece.beginShape(TRIANGLE_STRIP);
    initialise(floorPiece);
    plotShape(floorPiece);
    floorPiece.endShape(CLOSE);
  }

  private void draw() {
    display(floorPiece);
  }

  @Override
    void plotShape(PShape shape) {

    floorPiece.vertex(0, 0, 0);
    floorPiece.vertex(0, thickness, 0);


    floorPiece.vertex(sidePieceJointLength, 0, 0);
    floorPiece.vertex(sidePieceJointLength, thickness, 0);

    floorPiece.vertex(sidePieceJointLength, 0, -thickness);
    floorPiece.vertex(sidePieceJointLength, thickness, -thickness);

    floorPiece.vertex((sidePieceJointLength * 2), 0, -thickness); 
    floorPiece.vertex((sidePieceJointLength * 2), thickness, -thickness); 

    floorPiece.vertex((sidePieceJointLength * 2), 0, 0); 
    floorPiece.vertex((sidePieceJointLength * 2), thickness, 0); 


    floorPiece.vertex(sidePieceLength, 0, 0); 
    floorPiece.vertex(sidePieceLength, thickness, 0);

    floorPiece.vertex(sidePieceLength, 0, endPieceJointLength); 
    floorPiece.vertex(sidePieceLength, thickness, endPieceJointLength); 

    floorPiece.vertex((sidePieceLength + thickness), 0, endPieceJointLength); 
    floorPiece.vertex((sidePieceLength + thickness), thickness, endPieceJointLength); 

    floorPiece.vertex((sidePieceLength + thickness), 0, (endPieceJointLength * 2)); 
    floorPiece.vertex((sidePieceLength + thickness), thickness, (endPieceJointLength * 2)); 

    floorPiece.vertex(sidePieceLength, 0, (endPieceJointLength * 2)); 
    floorPiece.vertex(sidePieceLength, thickness, (endPieceJointLength * 2)); 


    floorPiece.vertex(sidePieceLength, 0, endPieceLength); 
    floorPiece.vertex(sidePieceLength, thickness, endPieceLength); 

    floorPiece.vertex((sidePieceJointLength * 2), 0, endPieceLength); 
    floorPiece.vertex((sidePieceJointLength * 2), thickness, endPieceLength);

    floorPiece.vertex((sidePieceJointLength * 2), 0, endPieceLength + thickness); 
    floorPiece.vertex((sidePieceJointLength * 2), thickness, endPieceLength + thickness);

    floorPiece.vertex(sidePieceJointLength, 0, endPieceLength + thickness); 
    floorPiece.vertex(sidePieceJointLength, thickness, endPieceLength + thickness); 

    floorPiece.vertex(sidePieceJointLength, 0, endPieceLength);
    floorPiece.vertex(sidePieceJointLength, thickness, endPieceLength);


    floorPiece.vertex(0, 0, endPieceLength); 
    floorPiece.vertex(0, thickness, endPieceLength);

    floorPiece.vertex(0, 0, (endPieceJointLength * 2)); 
    floorPiece.vertex(0, thickness, (endPieceJointLength * 2));

    floorPiece.vertex(-thickness, 0, (endPieceJointLength * 2)); 
    floorPiece.vertex(-thickness, thickness, (endPieceJointLength * 2));

    floorPiece.vertex(-thickness, 0, endPieceJointLength); 
    floorPiece.vertex(-thickness, thickness, endPieceJointLength);

    floorPiece.vertex(0, 0, endPieceJointLength); 
    floorPiece.vertex(0, thickness, endPieceJointLength);


    floorPiece.vertex(0, 0, 0); 
    floorPiece.vertex(0, thickness, 0);
  }
}

/**
 *  Class that can plot and draw a side piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
private class Shape_Side_Piece extends Shape_Template_Static {

  // Objects
  private PShape sidePiece;                // Declaring the side piece shape

  // Booleans
  private boolean enableBottomJoint = false;  // When set to true a joint will be created on the bottom of the piece
  private boolean enableTopJoint = false;     // When set to true a joint will be created on the top of the piece

  Shape_Side_Piece(boolean enableTopJoint, boolean enableBottomJoint) {
    this.enableBottomJoint = enableBottomJoint;
    this.enableTopJoint = enableTopJoint;
    sidePiece = createShape();
    sidePiece.beginShape(TRIANGLE_STRIP);
    initialise(sidePiece);
    plotShape(sidePiece);
    sidePiece.endShape(CLOSE);
  }

  private void draw() {
    display(sidePiece);
  }

  @Override
    void plotShape(PShape shape) {
    // Construct top
    sidePiece.vertex(0, 0, 0);  // Significant
    sidePiece.vertex(0, 0, thickness);

    // Construct top joint
    if (enableTopJoint == true) {
      shape.vertex((sidePieceJointLength + thickness), 0, 0);
      shape.vertex((sidePieceJointLength + thickness), 0, thickness);

      shape.vertex((sidePieceJointLength + thickness), thickness, 0);
      shape.vertex((sidePieceJointLength + thickness), thickness, thickness);

      shape.vertex((sidePieceJointLength * 2) + thickness, thickness, 0);
      shape.vertex((sidePieceJointLength * 2) + thickness, thickness, thickness);

      shape.vertex((sidePieceJointLength * 2) + thickness, 0, 0);
      shape.vertex((sidePieceJointLength * 2) + thickness, 0, thickness);
    }

    sidePiece.vertex(boxLength, 0, 0);  // Significant
    sidePiece.vertex(boxLength, 0, thickness);

    // Construct joints
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        sidePiece.vertex(boxLength - thickness, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(boxLength - thickness, (jointHeight * i), thickness);

        sidePiece.vertex(boxLength, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(boxLength, (jointHeight * i), thickness);
      } else {
        sidePiece.vertex(boxLength, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(boxLength, (jointHeight * i), thickness);

        sidePiece.vertex(boxLength - thickness, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(boxLength - thickness, (jointHeight * i), thickness);
      }
    }

    // Construct bottom
    sidePiece.vertex(boxLength, boxHeight, 0);  // Significant
    sidePiece.vertex(boxLength, boxHeight, thickness);

    // Construct bottom joint
    if (enableBottomJoint == true) {
      shape.vertex((sidePieceJointLength * 2) + thickness, boxHeight, 0);
      shape.vertex((sidePieceJointLength * 2) + thickness, boxHeight, thickness);

      shape.vertex((sidePieceJointLength * 2) + thickness, (boxHeight - thickness), 0);
      shape.vertex((sidePieceJointLength * 2) + thickness, (boxHeight - thickness), thickness);

      shape.vertex(sidePieceJointLength + thickness, (boxHeight - thickness), 0);
      shape.vertex(sidePieceJointLength + thickness, (boxHeight - thickness), thickness);

      shape.vertex(sidePieceJointLength + thickness, boxHeight, 0);
      shape.vertex(sidePieceJointLength + thickness, boxHeight, thickness);
    }

    sidePiece.vertex(0, boxHeight, 0);  // Significant
    sidePiece.vertex(0, boxHeight, thickness);

    // Construct joints
    for (int i = (jointAmount - 1); i >= 1; i--) {
      if (i % 2 == 0) {
        sidePiece.vertex(0, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(0, (jointHeight * i), thickness);

        sidePiece.vertex(thickness, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(thickness, (jointHeight * i), thickness);
      } else {
        sidePiece.vertex(thickness, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(thickness, (jointHeight * i), thickness);

        sidePiece.vertex(0, (jointHeight * i), 0);  // Significant
        sidePiece.vertex(0, (jointHeight * i), thickness);
      }
    }

    // Close
    sidePiece.vertex(0, 0, 0);  // Significant
    sidePiece.vertex(0, 0, thickness);
  }
}


/**
 *  Class that can plot and draw a side piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
private class Shape_End_Piece extends Shape_Template_Static {

  // Objects
  private PShape endPiece;                // Declaring the end piece shape

  // Booleans
  private boolean enableBottomJoint = false;  // When set to true a joint will be created on the bottom of the piece
  private boolean enableTopJoint = false;     // When set to true a joint will be created on the top of the piece

  Shape_End_Piece(boolean enableTopJoint, boolean enableBottomJoint) {
    this.enableTopJoint = enableTopJoint;
    this.enableBottomJoint = enableBottomJoint;
    endPiece = createShape();
    endPiece.beginShape(TRIANGLE_STRIP);
    initialise(endPiece);
    plotShape(endPiece);
    endPiece.endShape(CLOSE);
  }

  private void draw() {
    display(endPiece);
  }

  @Override
    void plotShape(PShape shape) {
    // Construct top
    shape.vertex(0, 0, 0);      // Significant
    shape.vertex(0, 0, thickness);

    // Construct top joint
    if (enableTopJoint == true) {
      shape.vertex(endPieceJointLength, 0, 0);
      shape.vertex(endPieceJointLength, 0, thickness);

      shape.vertex(endPieceJointLength, thickness, 0);
      shape.vertex(endPieceJointLength, thickness, thickness);

      shape.vertex((endPieceJointLength * 2), thickness, 0);
      shape.vertex((endPieceJointLength * 2), thickness, thickness);

      shape.vertex((endPieceJointLength * 2), 0, 0);
      shape.vertex((endPieceJointLength * 2), 0, thickness);
    }

    shape.vertex(endPieceLength, 0, 0);       // Significant
    shape.vertex(endPieceLength, 0, thickness);

    // Construct joints
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        shape.vertex((endPieceLength + thickness), (jointHeight * i), 0);      // Significant
        shape.vertex((endPieceLength + thickness), (jointHeight * i), thickness); 

        shape.vertex(endPieceLength, (jointHeight * i), 0);      // Significant
        shape.vertex(endPieceLength, (jointHeight * i), thickness);
      } else {
        shape.vertex(endPieceLength, (jointHeight * i), 0);      // Significant
        shape.vertex(endPieceLength, (jointHeight * i), thickness);

        shape.vertex((endPieceLength + thickness), (jointHeight * i), 0);      // Significant
        shape.vertex((endPieceLength + thickness), (jointHeight * i), thickness);
      }
    }


    // Construct bottom
    shape.vertex(endPieceLength, boxHeight, 0);      // Significant
    shape.vertex(endPieceLength, boxHeight, thickness);

    // Construct bottom joint
    if (enableBottomJoint == true) {
      shape.vertex((endPieceJointLength * 2), boxHeight, 0);
      shape.vertex((endPieceJointLength * 2), boxHeight, thickness);

      shape.vertex((endPieceJointLength * 2), (boxHeight - thickness), 0);
      shape.vertex((endPieceJointLength * 2), (boxHeight - thickness), thickness);

      shape.vertex(endPieceJointLength, (boxHeight - thickness), 0);
      shape.vertex(endPieceJointLength, (boxHeight - thickness), thickness);

      shape.vertex(endPieceJointLength, boxHeight, 0);
      shape.vertex(endPieceJointLength, boxHeight, thickness);
    }

    shape.vertex(0, boxHeight, 0);      // Significant
    shape.vertex(0, boxHeight, thickness);

    // Construct joints
    for (int i = (jointAmount - 1); i >= 1; i--) {
      if (i % 2 == 0) {
        shape.vertex(0, (jointHeight * i), 0);      // Significant
        shape.vertex(0, (jointHeight * i), thickness);

        shape.vertex(-thickness, (jointHeight * i), 0);      // Significant
        shape.vertex(-thickness, (jointHeight * i), thickness);
      } else {
        shape.vertex(-thickness, (jointHeight * i), 0);      // Significant
        shape.vertex(-thickness, (jointHeight * i), thickness);

        shape.vertex(0, (jointHeight * i), 0);      // Significant
        shape.vertex(0, (jointHeight * i), thickness);
      }
    } 

    // Closing
    shape.vertex(0, jointHeight, 0);      // Significant
    shape.vertex(0, jointHeight, thickness);

    shape.vertex(0, 0, 0);                // Significant
    shape.vertex(0, 0, thickness);
  }
}
