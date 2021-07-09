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

  TD_Shape_Cross_Piece() {
    crossPiece = constructCenterJoints(INVERT_JOINTS);
    slots = constructSlots(IS_NOT_CENTER_PIECE, endPieceJointLength, centerJointPos, constructCenter);
    createTop();
  } 

  private void draw() {
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
      float startPosition = endPieceJointLengthC + thicknessC;
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
        startPosition = jointDipPos + thicknessC;
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
