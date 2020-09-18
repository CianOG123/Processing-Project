/** 
 *  Handles the exportation and rendering of .svg files
 *  By Cian O'Gorman 17-09-2020
 */
private class SVG_Render {

  // Objects
  protected PGraphics svg;  // Used to render all shapes to same canvas

  // Hidden booleans
  protected boolean disableExtendedJoint = false;  // Used to stop artifacting when jointHeight is equal to the thickness

  SVG_Render(int boxType) {
    disableExtendedJoint = false;
    switch (boxType) {
    case BOX_OPEN_TOP:
      constructTop = false;
      constructBottom = true;
      floorOffset = 0;
      break;
    case BOX_CLOSED:
      constructTop = true;
      constructBottom = true;
      floorOffset = 0;
      break;
    case BOX_OPEN_THROUGH:
      constructTop = false;
      constructBottom = false;
      floorOffset = 0;
      break;
    case BOX_CENTER_PART:
      constructTop = true;
      constructBottom = true;
      constructCenter[0] = true;
      floorOffset = 0;
      getOddJointLengthConvert();
      getMiddleJointType();
      break;
    case BOX_CROSS_SECTION:
      constructTop = true;
      constructBottom = true;
      constructCenter[0] = true;
      constructCross[0] = true;
      floorOffset = 0;
      getOddJointLengthConvert();
      getMiddleJointType();
      break;
    case BOX_RAISED_FLOOR:
      constructTop = false;
      constructBottom = true;
      floorOffset = 10;
      break;
    default:
      constructTop = true;
      constructBottom = true;
      floorOffset = 0;
      break;
    }
    svg = createGraphics(1000, 1000, SVG, "Render.svg");
    constructSVGPlan();
  }

  // Calculates the amount of pixels  on the vertical needed to incase the raster image
  private int calculateCanvasHeight() {
    int canvasHeight = (int) (boxHeightC * 2);
    if (boxWidthC > canvasHeight) {
      canvasHeight = (int) boxWidthC;
    }
    for (int i = 0; i < constructCenter.length; i++) {
      if (constructCenter[i] == true) {
        canvasHeight += (int) boxHeightC + BOUNDARY + thicknessC;
      }
      if (constructCross[i] == true) {
        canvasHeight += (int) boxHeightC + BOUNDARY + thicknessC;
      }
    }
    canvasHeight += BOUNDARY * 3;
    return canvasHeight;
  }

  // Calculates the amount of pixels needed on the horizontal axis to incase the raster image
  private int calculateCanvasWidth() {
    int canvasWidth = 0;

    if (constructTop == true) {
      canvasWidth += (int) boxLengthC + (BOUNDARY * 2);
    }

    if (constructBottom == true) {
      canvasWidth += (int) boxLengthC + BOUNDARY;
    }

    canvasWidth += ((int) (boxLengthC + boxWidthC + (thicknessC * 2) + (BOUNDARY * 2)));
    return canvasWidth;
  }

  // Creates all necessary pieces and adds them to the .svg
  private void constructSVGPlan() {
    svg.beginDraw();
    SVG_Side_Piece sidePiece;
    sidePiece = new SVG_Side_Piece(svg, 50, 50, boxLengthC, constructCross, crossJointPosC);
    svg.dispose();
    svg.endDraw();
  }

  // MOVE IF POSSIBLE
  // ----------------------------------------------------------------------------------------------------
  // Calculates the length of the joints being used on the center piece
  private void getOddJointLengthConvert() {
    float jointAccumulation = 0;
    while (jointAccumulation <= thicknessC) {
      jointAccumulation += (jointHeightC * 2);
    }
    if (jointAccumulation >= jointHeightC) {
      jointAccumulation -= jointHeightC;
    }
    oddJointLengthC = jointAccumulation - thicknessC;
  }

  // Returns if the middle joint of the center piece should be extruded or intruded
  private void getMiddleJointType() {
    middleJointExtrude = false;
    if ((jointAmount - 1) % 4 == 0) {
      middleJointExtrude = true;
    }
  }
}

// SVG_Shape class, used for shared functions between different shapes i.e constructJoints
private class SVG_Shape {

  // Objects
  protected PGraphics svg;

  // Variables
  private int xOffset;  // Used to position the piece on the canvas, to avoid overlapping between pieces
  private int yOffset;

  SVG_Shape(PGraphics svg, int xOffset, int yOffset) {
    this.svg = svg;
    this.xOffset = xOffset;
    this.yOffset = yOffset;
  }

  protected void constructLeftRightJoints(PGraphics svg, int xOffset, int yOffset) {
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        // Outwards to inwards
        // Right Side
        svg.line(boxLengthC - thicknessC + xOffset, (jointHeightC * (i - 1)) + yOffset, boxLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset);
        svg.line(boxLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset, boxLengthC + xOffset, (jointHeightC * i) + yOffset);

        // Left Side
        svg.line(thicknessC + xOffset, (jointHeightC * (i - 1)) + yOffset, thicknessC + xOffset, (jointHeightC * i) + yOffset);
        svg.line(thicknessC +  xOffset, (jointHeightC * i) + yOffset, xOffset, (jointHeightC * i) + yOffset);
      } else {
        // Inwards to outwards
        // Right Side
        svg.line(boxLengthC + xOffset, yOffset + (jointHeightC * (i - 1)), boxLengthC + xOffset, (jointHeightC * i)  + yOffset);
        svg.line(boxLengthC + xOffset, (jointHeightC * i) + yOffset, boxLengthC - thicknessC + xOffset, (jointHeightC * i) + yOffset);

        // Left Side
        svg.line(xOffset, (jointHeightC * (i - 1)) + yOffset, xOffset, (jointHeightC * i) + yOffset);
        svg.line(xOffset, (jointHeightC * i) + yOffset, thicknessC + xOffset, (jointHeightC * i) + yOffset);
      }
    }
    // construct last joint to connect to bottom line
    // Right
    svg.line(boxLengthC + xOffset, (jointHeightC * (jointAmount - 1)) + yOffset, boxLengthC + xOffset, boxHeightC + yOffset);
    // Left
    svg.line(xOffset, (jointHeightC * (jointAmount - 1)) + yOffset, xOffset, boxHeightC + yOffset);
  }
}

class SVG_Side_Piece extends SVG_Shape {

  // Variables
  int xOffset;
  int yOffset;

  SVG_Side_Piece(PGraphics svg, int xOffset, int yOffset, float pieceLengthC, boolean[] intersectPieces, float[]intersectJointPos) {
    super(svg, xOffset, yOffset);
    constructLeftRightJoints(svg, xOffset, yOffset);
    constructTop(svg, xOffset, yOffset, pieceLengthC, intersectPieces, intersectJointPos);
  }

  private void constructTop(PGraphics svg, int xOffset, int yOffset, float pieceLengthC, boolean[] intersectPieces, float[]intersectJointPos) {
    float pieceLengthWithoutJoints = pieceLengthC - (thicknessC * 2);
    float pieceJointLengthC = pieceLengthWithoutJoints / 3;

    // Construct Edges of Top
    // From left
    svg.line(xOffset, yOffset, sidePieceJointLengthC + xOffset, yOffset);
    // From Right
    svg.line(pieceLengthC + xOffset, yOffset, pieceLengthC - sidePieceJointLengthC + xOffset, yOffset);
    // Construct Edges of Bottom
    // From left
    svg.line(xOffset, boxHeightC + yOffset, sidePieceJointLengthC + xOffset, boxHeightC + yOffset);
    // From Right
    svg.line(pieceLengthC + xOffset, boxHeightC + yOffset, pieceLengthC - sidePieceJointLengthC + xOffset, boxHeightC + yOffset);

    if (constructTop == true) {
      // Creating sides of top joint
      svg.line(pieceJointLengthC + xOffset, yOffset, pieceJointLengthC + xOffset, thicknessC + yOffset);
      svg.line(pieceLengthC - pieceJointLengthC + xOffset, yOffset, pieceLengthC - pieceJointLengthC + xOffset, thicknessC + yOffset);
    }
    if(constructBottom == true){
      // Creating sides of Bottom joint
      svg.line(pieceJointLengthC + xOffset, boxHeightC + yOffset, pieceJointLengthC + xOffset, boxHeightC - thicknessC + yOffset);
      svg.line(pieceLengthC - pieceJointLengthC + xOffset, boxHeightC + yOffset, pieceLengthC - pieceJointLengthC + xOffset, boxHeightC - thicknessC + yOffset);
    }

    boolean isTopJoints = true;
    createMiniJoints(xOffset, yOffset, isTopJoints, crossExtrudeThroughSide, pieceLengthC, pieceJointLengthC, intersectPieces, intersectJointPos);
    isTopJoints = false;
    createMiniJoints(xOffset, yOffset, isTopJoints, crossExtrudeThroughSide, pieceLengthC, pieceJointLengthC, intersectPieces, intersectJointPos);

    if (constructTop == false) {
      // Creating a straight line across if there is no top piece
      svg.line(pieceJointLengthC + xOffset, yOffset, pieceLengthC - pieceJointLengthC + xOffset, yOffset);
    }
  }

  // Constructs miniature joint slots
  // Bottom mini joints will be made when isTopJoints is set to false
  private void createMiniJoints(int xOffset, int yOffset, boolean isTopJoints, boolean extrudeThroughSide, float pieceLengthC, float pieceJointLengthC, boolean[] intersectPieces, float[] intersectJointPos) {
    boolean enableTop;
    boolean enableBottom;
    if (isTopJoints == true) {
      enableTop = true;
      enableBottom = false;
    } else {
      enableTop = false;
      enableBottom = true;
    }

    // Checking if miniature joints should be created
    // Note: This code checks to see if the top piece is intersecting a joint and allows it to be constructed if necessary
    boolean createMiniJoints = false;
    float jointHeightSum = jointHeightC; // The sum of the joint heights until it is greater than the thickness
    int counter = 1;
    while (jointHeightSum < thicknessC) {
      jointHeightSum += jointHeightC;
      counter++;
    }
    if (counter % 2 == 0) {
      createMiniJoints = true;
    }
    // Disabling floor joints if floor is offset
    boolean floorIsOffset = false;
    if (floorOffset != 0) {
      floorIsOffset = true;
    }

    if ((createMiniJoints == true) && (extrudeThroughSide == true)) {
      float previousXPos = pieceJointLengthC;
      // Cycling through each miniature joint
      for (int i = 0; i < intersectPieces.length; i++) {
        if (intersectPieces[i] == true) {

          // Checking it is within the space of the top joint
          if ((intersectJointPos[i] >= pieceJointLengthC) && (intersectJointPos[i] <= (pieceJointLengthC * 2))) {

            // Constructing Miniature Joint
            if ((constructTop == true) && (enableTop == true)) {
              svg.line(previousXPos + xOffset, thicknessC + yOffset, intersectJointPos[i] + xOffset, thicknessC + yOffset);
              svg.line(intersectJointPos[i] + xOffset, thicknessC + yOffset, intersectJointPos[i] + xOffset, jointHeightSum + yOffset);
              svg.line(intersectJointPos[i] + xOffset, jointHeightSum + yOffset, intersectJointPos[i] + thicknessC + xOffset, jointHeightSum + yOffset);
              svg.line(intersectJointPos[i] + thicknessC + xOffset, jointHeightSum + yOffset, intersectJointPos[i] + thicknessC + xOffset, thicknessC + yOffset);
            }
            if ((constructBottom == true) && (enableBottom) && (floorIsOffset == false)) {
              svg.line(previousXPos + xOffset, boxHeightC - thicknessC + yOffset, intersectJointPos[i] + xOffset, boxHeightC - thicknessC + yOffset);
              svg.line(intersectJointPos[i] + xOffset, boxHeightC - thicknessC + yOffset, intersectJointPos[i] + xOffset, boxHeightC - jointHeightSum + yOffset);
              svg.line(intersectJointPos[i] + xOffset, boxHeightC - jointHeightSum + yOffset, intersectJointPos[i] + thicknessC + xOffset, boxHeightC - jointHeightSum + yOffset);
              svg.line(intersectJointPos[i] + thicknessC + xOffset, boxHeightC - jointHeightSum + yOffset, intersectJointPos[i] + thicknessC + xOffset, boxHeightC - thicknessC + yOffset);
            }
            previousXPos = intersectJointPos[i] + thicknessC;
          }
        }
      }
      // Closing the joint
      if ((constructTop == true) && (enableTop == true)) {
        svg.line(previousXPos + xOffset, thicknessC + yOffset, pieceLengthC - pieceJointLengthC + xOffset, thicknessC + yOffset);
      } else if ((constructBottom == true) && (enableBottom) && (floorIsOffset == false)) {
        svg.line(previousXPos + xOffset, boxHeightC - thicknessC + yOffset, pieceLengthC - pieceJointLengthC + xOffset, boxHeightC - thicknessC + yOffset);
      }
    } else {
      // Construct Joint with no miniature joints
      if ((constructTop == true)  && (enableTop == true)) {
        svg.line(pieceJointLengthC + xOffset, thicknessC + yOffset, pieceLengthC - pieceJointLengthC + xOffset, thicknessC + yOffset);
      } else if (((constructBottom == true)  && (enableBottom == true)) || (floorIsOffset == true)) {
        svg.line(pieceJointLengthC + xOffset, boxHeightC - thicknessC + yOffset, pieceLengthC - pieceJointLengthC + xOffset, boxHeight - thicknessC + yOffset);
      }
    }
  }
}
