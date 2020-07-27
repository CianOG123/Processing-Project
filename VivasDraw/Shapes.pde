/**
 *  Class that can plot and draw a floor/ top piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
class Shape_Floor_Piece extends Shape_Template_Static {

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
class Shape_Side_Piece extends Shape_Template_Static {

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
class Shape_End_Piece extends Shape_Template_Static {

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
