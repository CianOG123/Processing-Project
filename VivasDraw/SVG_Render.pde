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
      floorOffsetEnabled = false;
      break;
    case BOX_CLOSED:
      constructTop = true;
      constructBottom = true;
      floorOffsetEnabled = false;
      break;
    case BOX_OPEN_THROUGH:
      constructTop = false;
      constructBottom = false;
      floorOffsetEnabled = false;
      break;
    case BOX_CENTER_PART:
      constructTop = true;
      constructBottom = true;
      constructCenter[0] = true;
      floorOffsetEnabled = false;

      getOddJointLengthConvert();
      getMiddleJointType();
      break;
    case BOX_CROSS_SECTION:
      constructTop = true;
      constructBottom = true;
      constructCenter[0] = true;
      constructCross[0] = true;
      floorOffsetEnabled = false;

      getOddJointLengthConvert();
      getMiddleJointType();
      break;
    case BOX_RAISED_FLOOR:
      constructTop = false;
      constructBottom = true;
      constructCenter[0] = true;
      constructCross[0] = true;
      floorOffsetEnabled = true;
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

    SVG_End_Piece endPiece;
    endPiece = new SVG_End_Piece(svg, 50, 330, boxWidthC, constructCenter, centerJointPosC);
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

  // Constructs the corner joints of a side or end piece
  protected void constructCornerJoints(boolean invertJoints, PGraphics svg, float pieceLengthC, int xOffset, int yOffset) {
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



  // Constructs the top and bottom of a side or end piece
  protected void sideEndConstructTopBottom(boolean invertJoints, PGraphics svg, int xOffset, int yOffset, boolean extrudeThroughSide, float pieceLengthC, boolean[] intersectPieces, float[]intersectJointPos) {

    // Piece measurements
    float localXOffset = float(xOffset);
    float pieceLengthWithoutJoints = pieceLengthC - (thicknessC * 2);
    float pieceJointLengthC = pieceLengthWithoutJoints / 3;

    // Creating offset if joints are inverted
    float invertOffset = 0;
    if (invertJoints == true) {
      invertOffset = thicknessC;
    }
    localXOffset += invertOffset;

    // Construct Edges of Top
    // From left
    svg.line(localXOffset, yOffset, pieceJointLengthC + localXOffset, yOffset);
    // From Right
    svg.line(pieceLengthC + localXOffset, yOffset, pieceLengthC - pieceJointLengthC + localXOffset, yOffset);

    // Construct Edges of Bottom
    // From left
    svg.line(localXOffset, boxHeightC + yOffset, pieceJointLengthC + localXOffset, boxHeightC + yOffset);
    // From Right
    svg.line(pieceLengthC + localXOffset, boxHeightC + yOffset, pieceLengthC - pieceJointLengthC + localXOffset, boxHeightC + yOffset);

    if (constructTop == true) {
      // Creating sides of top joint
      svg.line(pieceJointLengthC + localXOffset, yOffset, pieceJointLengthC + localXOffset, thicknessC + yOffset);
      svg.line(pieceLengthC - pieceJointLengthC + localXOffset, yOffset, pieceLengthC - pieceJointLengthC + localXOffset, thicknessC + yOffset);
    }
    if ((constructBottom == true) && ((floorOffset == 0) || (floorOffsetEnabled == false))) {
      // Creating sides of Bottom joint
      svg.line(pieceJointLengthC + localXOffset, boxHeightC + yOffset, pieceJointLengthC + localXOffset, boxHeightC - thicknessC + yOffset);
      svg.line(pieceLengthC - pieceJointLengthC + localXOffset, boxHeightC + yOffset, pieceLengthC - pieceJointLengthC + localXOffset, boxHeightC - thicknessC + yOffset);
    }


    // Creating Mini Joints
    // For top
    boolean isTopJoints = true;
    createMiniJoints(localXOffset, yOffset, invertJoints, isTopJoints, extrudeThroughSide, pieceLengthC, pieceJointLengthC, intersectPieces, intersectJointPos);

    // For Bottom
    if ((floorOffsetEnabled == false) || (floorOffset == 0)) {
      isTopJoints = false;
      createMiniJoints(localXOffset, yOffset, invertJoints, isTopJoints, extrudeThroughSide, pieceLengthC, pieceJointLengthC, intersectPieces, intersectJointPos);
    }


    if (constructTop == false) {
      // Creating a straight line across if there is no top piece
      svg.line(pieceJointLengthC + localXOffset, yOffset, pieceLengthC - pieceJointLengthC + localXOffset, yOffset);
    }

    if ((constructBottom == false) || ((floorOffset != 0) && (floorOffsetEnabled == true))) {
      // Creating a straight line across if there is no bottom piece
      svg.line(pieceJointLengthC + localXOffset, boxHeightC + yOffset, pieceLengthC - pieceJointLengthC + localXOffset, boxHeightC + yOffset);
    }
  }



  // Constructs miniature joint slots
  // Bottom mini joints will be made when isTopJoints is set to false
  protected void createMiniJoints(float xOffset, int yOffset, boolean invertJoints, boolean isTopJoints, boolean extrudeThroughSide, float pieceLengthC, float pieceJointLengthC, boolean[] intersectPieces, float[] intersectJointPos) {
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

    // Inverting the creation of mini joints if the joints of the piece are inverted
    if (invertJoints == true) {
      createMiniJoints = !createMiniJoints;
    }

    // Disabling mini joints if multiple joints is false 
    if (multipleJoints == false) {
      createMiniJoints = false;
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
            if ((constructBottom == true) && (enableBottom == true)) {
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
      } else if ((constructBottom == true) && (enableBottom == true) && ((floorOffset == 0) || (floorOffsetEnabled == false))) {
        svg.line(previousXPos + xOffset, boxHeightC - thicknessC + yOffset, pieceLengthC - pieceJointLengthC + xOffset, boxHeightC - thicknessC + yOffset);
      }
    } else {
      // Construct Top Joint with no miniature joints
      if ((constructTop == true)  && (enableTop == true)) {
        svg.line(pieceJointLengthC + xOffset, thicknessC + yOffset, pieceLengthC - pieceJointLengthC + xOffset, thicknessC + yOffset);
      } 
      // Construct Bottom Joint with no miniature joints
      if ((constructBottom == true) && (enableBottom == true)) {
        svg.line(pieceJointLengthC + xOffset, boxHeightC - thicknessC + yOffset, pieceLengthC - pieceJointLengthC + xOffset, boxHeightC - thicknessC + yOffset);
      }
    }
  }



  // Creates a Raised Floor Joint if necessary
  protected void createRaisedFloorJoint(boolean invertJoints, PGraphics svg, int xOffset, int yOffset, float pieceLengthC, float pieceJointLengthC, boolean extrudeThroughSide, boolean[] intersectPieces, float[] intersectJointPos) {

    if ((constructBottom == true) && (floorOffset != 0) && (floorOffsetEnabled == true)) {
      println(floorOffsetC);
      // Creating bottom and side edges of joint
      // Left
      svg.line(pieceJointLengthC + xOffset, boxHeightC - floorOffsetC + yOffset, pieceJointLengthC + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset);
      // Right
      svg.line((pieceJointLengthC * 2) + xOffset, boxHeightC - floorOffsetC + yOffset, (pieceJointLengthC * 2) + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset);
      // Bottom
      svg.line(pieceJointLengthC + xOffset, boxHeightC - floorOffsetC + yOffset, (pieceJointLengthC * 2) + xOffset, boxHeightC - floorOffsetC + yOffset);

      // If multiple Joints is enabled
      if (multipleJoints == true) {

        // If the center/ cross isn't extruding through the side
        if (extrudeThroughSide == false) {

          // Creating straight line across top of joint
          svg.line(pieceJointLengthC + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset, (pieceJointLengthC * 2) + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset);
        } else {
          
          int counter = 1;
          while ((boxHeightC - (jointHeightC * counter)) > (boxHeightC - (floorOffsetC + thicknessC))) {
            counter++;
          }
          float jointTop = boxHeightC - (jointHeightC * counter);
          
          boolean enableJoints = false;  // When set to true, mini joints will be drawn
          if (counter % 2 == 0) {
            enableJoints = true;
          }
          
          // Inverting if the joint should be created based on input
          if (invertJoints == true) {
            enableJoints = !enableJoints;
          }
          
          // Creating joints if they have been enabled
          if (enableJoints == true) {
            float previousXPos = pieceJointLengthC;
            for (int i = 0; i < intersectPieces.length; i++) {
              // Checking that the piece is enabled
              if (intersectPieces[i] == true) {
                // Checking the piece position is within the bottom joints space
                if ((intersectJointPos[i] > pieceJointLengthC) && ((intersectJointPos[i] + thicknessC) < (pieceJointLengthC * 2))) {
                  // Creating mini joints
                  svg.line(previousXPos + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset, intersectJointPos[i] + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset);
                  svg.line(intersectJointPos[i] + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset, intersectJointPos[i] + xOffset, jointTop + yOffset);
                  svg.line(intersectJointPos[i] + xOffset, jointTop + yOffset, thicknessC + intersectJointPos[i] + xOffset, jointTop + yOffset);
                  svg.line(thicknessC + intersectJointPos[i] + xOffset, jointTop + yOffset, thicknessC + intersectJointPos[i] + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset);
                  previousXPos = thicknessC + intersectJointPos[i];
                }
              }
            }

            // Closing line
            svg.line(previousXPos + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset, (pieceJointLengthC * 2) + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset);
          } else {
            // Drawing line straight across if joints are disabled
            svg.line(pieceJointLengthC + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset, (pieceJointLengthC * 2) + xOffset, (boxHeightC - floorOffsetC) - thicknessC + yOffset);
          }
        }
        // If multiple joints is disabled
      } else {
      }
    }
  }
}

// Creates and Renders an SVG Side Piece to a given canvas
class SVG_Side_Piece extends SVG_Shape {

  // Constants
  private static final boolean DONT_INVERT_JOINTS = false;

  SVG_Side_Piece(PGraphics svg, int xOffset, int yOffset, float pieceLengthC, boolean[] intersectPieces, float[]intersectJointPos) {
    super(svg, xOffset, yOffset);

    // Calculating measurements
    float pieceJointLengthC = (pieceLengthC - (thicknessC * 2));
    pieceJointLengthC /= 3;

    constructCornerJoints(DONT_INVERT_JOINTS, svg, pieceLengthC, xOffset, yOffset);
    sideEndConstructTopBottom(DONT_INVERT_JOINTS, svg, xOffset, yOffset, crossExtrudeThroughSide, pieceLengthC, intersectPieces, intersectJointPos);
    createRaisedFloorJoint(DONT_INVERT_JOINTS, svg, xOffset, yOffset, pieceLengthC, pieceJointLengthC, crossExtrudeThroughSide, intersectPieces, intersectJointPos);
  }
}

// Creates and Renders an SVG End Piece to a given canvas
class SVG_End_Piece extends SVG_Shape {

  // Constants
  private static final boolean INVERT_JOINTS = true;

  SVG_End_Piece(PGraphics svg, int xOffset, int yOffset, float pieceLengthC, boolean[] intersectPieces, float[]intersectJointPos) {

    super(svg, xOffset, yOffset);

    // Calculating measurements
    float pieceTopLengthC = pieceLengthC - (thicknessC * 2);  // The length of straight top of the piece without joints
    float pieceJointLengthC = pieceTopLengthC / 3;

    constructCornerJoints(INVERT_JOINTS, svg, pieceLengthC, xOffset, yOffset);
    sideEndConstructTopBottom(INVERT_JOINTS, svg, xOffset, yOffset, centerExtrudeThroughSide, pieceTopLengthC, intersectPieces, intersectJointPos);
    createRaisedFloorJoint(INVERT_JOINTS, svg, xOffset, yOffset, pieceLengthC, pieceJointLengthC, centerExtrudeThroughSide, intersectPieces, intersectJointPos);
  }
}
