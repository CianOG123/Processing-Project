/**
 *  Class that can plot and draw a side piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
private class TD_Shape_Side_Piece extends TD_Shape_Template {

  // Objects
  private PShape sidePiece;                // Declaring the side piece shape

  // Booleans
  private boolean enableBottomJoint = false;  // When set to true a joint will be created on the bottom of the piece
  private boolean enableTopJoint = false;     // When set to true a joint will be created on the top of the piece

  TD_Shape_Side_Piece(boolean enableTopJoint, boolean enableBottomJoint) {
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
