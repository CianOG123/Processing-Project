/** 
 *  Handles all exporting to .svg file types
 *  By Cian O'Gorman 18-07-2020
 */
private class SVG_Export {

  // Constants
  private static final int BOUNDARY = 10;      // The distance from the vector to the edge of the image
  private static final float PIXEL_TO_MILLIMETRE = (129600/45719.994) / 0.75 ;  // Used to convert pixel measurements to millimetre

  // Objects
  private PGraphics svg;

  // Variables
  private int boxType;    // The type of box being created 

  // Measurements
  private float boxLengthConvert;
  private float boxWidthConvert;
  private float boxHeightConvert;
  private float thicknessConvert;
  private float jointHeightConvert;
  private float endPieceLengthConvert;
  private float endPieceJointLengthConvert;
  private float sidePieceJointLengthConvert;

  // Booleans
  private boolean constructTop = false;    // When set to true a top piece will be constructed and all relevant joints
  private boolean constructBottom = false;  // When set to true a bootom piece will be constructed and all relevant joints

  SVG_Export(boolean constructTop, boolean constructBottom, int boxType) {
    this.boxType = boxType;
    this.constructTop = constructTop;
    this.constructBottom = constructBottom;
    convertMeasurements();
    svg = createGraphics((int) ((boxLengthConvert * 3) + boxWidthConvert + (thicknessConvert * 2) + (BOUNDARY * 5)), ((int)boxHeightConvert * 2) + (BOUNDARY * 3), SVG, "Project.svg");
  }

  private void constructSVGPlan() {
    svg.beginDraw();
    plotSVGSidePiece(BOUNDARY, BOUNDARY);
    plotSVGSidePiece(BOUNDARY, (int) boxHeightConvert + (BOUNDARY * 2));
    plotSVGEndPiece((int) (boxLengthConvert + thicknessConvert)+ (BOUNDARY * 2), BOUNDARY);
    plotSVGEndPiece((int) (boxLengthConvert + thicknessConvert) + (BOUNDARY * 2), (int) boxHeightConvert + (BOUNDARY * 2));
    plotSVGTopPiece(constructTop, (int) (boxLengthConvert + boxWidthConvert + thicknessConvert + (BOUNDARY * 3)), BOUNDARY + (int) thicknessConvert);
    plotSVGTopPiece(constructBottom, (int) ((boxLengthConvert * 2) + boxWidthConvert + thicknessConvert + (BOUNDARY * 4)), BOUNDARY + (int) thicknessConvert);
    svg.dispose();
    svg.endDraw();
  }

  private void convertMeasurements() {
    if (measurementType == MILLIMETRE) {
      boxLengthConvert = boxLength * PIXEL_TO_MILLIMETRE;
      boxWidthConvert = boxWidth * PIXEL_TO_MILLIMETRE;
      boxHeightConvert = boxHeight * PIXEL_TO_MILLIMETRE;
      thicknessConvert = thickness * PIXEL_TO_MILLIMETRE;
      jointHeightConvert = jointHeight * PIXEL_TO_MILLIMETRE;
      endPieceLengthConvert = endPieceLength * PIXEL_TO_MILLIMETRE;
      endPieceJointLengthConvert = endPieceJointLength * PIXEL_TO_MILLIMETRE;
      sidePieceJointLengthConvert = sidePieceJointLength * PIXEL_TO_MILLIMETRE;
    }
  }

  private void plotSVGTopPiece(boolean constructPiece, int xOffset, int yOffset) {
    if (constructPiece == true) {
      svg.line(xOffset, yOffset, xOffset + sidePieceJointLengthConvert, yOffset);
      svg.line(xOffset + sidePieceJointLengthConvert, yOffset, xOffset + sidePieceJointLengthConvert, yOffset - thicknessConvert);
      svg.line(xOffset + sidePieceJointLengthConvert, yOffset - thicknessConvert, xOffset + (sidePieceJointLengthConvert * 2), yOffset - thicknessConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset - thicknessConvert, xOffset + (sidePieceJointLengthConvert * 2), yOffset);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset, xOffset + (sidePieceJointLengthConvert * 3), yOffset);

      svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset, xOffset + (sidePieceJointLengthConvert * 3), yOffset + endPieceJointLengthConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + endPieceJointLengthConvert, xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + endPieceJointLengthConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + endPieceJointLengthConvert, xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + (endPieceJointLengthConvert * 2));
      svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + (endPieceJointLengthConvert * 2), xOffset + (sidePieceJointLengthConvert * 3), yOffset + (endPieceJointLengthConvert * 2));
      svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + (endPieceJointLengthConvert * 2), xOffset + (sidePieceJointLengthConvert * 3), yOffset + (endPieceJointLengthConvert * 3));

      svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + (endPieceJointLengthConvert * 3), xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceJointLengthConvert * 3));  
      svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceJointLengthConvert * 3), xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceJointLengthConvert * 3) + thicknessConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceJointLengthConvert * 3) + thicknessConvert, xOffset + sidePieceJointLengthConvert, yOffset + (endPieceJointLengthConvert * 3) + thicknessConvert);
      svg.line(xOffset + sidePieceJointLengthConvert, yOffset + (endPieceJointLengthConvert * 3) + thicknessConvert, xOffset + sidePieceJointLengthConvert, yOffset + (endPieceJointLengthConvert * 3));
      svg.line(xOffset + sidePieceJointLengthConvert, yOffset + (endPieceJointLengthConvert * 3), xOffset, yOffset + (endPieceJointLengthConvert * 3));
      
      svg.line(xOffset, yOffset + (endPieceJointLengthConvert * 3), xOffset, yOffset + (endPieceJointLengthConvert * 2));
      svg.line(xOffset, yOffset + (endPieceJointLengthConvert * 2), xOffset - thicknessConvert, yOffset + (endPieceJointLengthConvert * 2));
      svg.line(xOffset - thicknessConvert, yOffset + (endPieceJointLengthConvert * 2), xOffset - thicknessConvert, yOffset + endPieceJointLengthConvert);
      svg.line(xOffset - thicknessConvert, yOffset + endPieceJointLengthConvert, xOffset, yOffset + endPieceJointLengthConvert);
      svg.line(xOffset, yOffset + endPieceJointLengthConvert, xOffset, yOffset);
    }
  }

  private void plotSVGEndPiece(int xOffset, int yOffset) {
    // Plot top
    if (constructTop == false) {
      svg.line(xOffset, yOffset, xOffset + endPieceLengthConvert, yOffset);
    } else {
      svg.line(xOffset, yOffset, xOffset + endPieceJointLengthConvert, yOffset);
      svg.line(xOffset + endPieceJointLengthConvert, yOffset, xOffset + endPieceJointLengthConvert, yOffset + thicknessConvert);
      svg.line(xOffset + endPieceJointLengthConvert, yOffset + thicknessConvert, xOffset + (endPieceJointLengthConvert * 2), yOffset + thicknessConvert);
      svg.line(xOffset + (endPieceJointLengthConvert * 2), yOffset + thicknessConvert, xOffset + (endPieceJointLengthConvert * 2), yOffset);
      svg.line(xOffset + (endPieceJointLengthConvert * 2), yOffset, xOffset + endPieceLengthConvert, yOffset);
    }

    // Plot joints
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        svg.line(xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * (i - 1)), xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * i));
        svg.line(xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * i), xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * i));  // 5
      } else {
        svg.line(xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * (i - 1)), xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * i));
        svg.line(xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * i), xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * i));
      }
    }
    svg.line(xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * (jointAmount - 1)), xOffset + endPieceLengthConvert, yOffset + boxHeightConvert); // 10

    // Plot bottom
    if (constructBottom == false) {
      svg.line(xOffset + endPieceLengthConvert, yOffset + boxHeightConvert, xOffset, yOffset + boxHeightConvert);
    } else {
      svg.line(xOffset + endPieceLengthConvert, yOffset + boxHeightConvert, xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert);
      svg.line(xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert, xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert - thicknessConvert);
      svg.line(xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert - thicknessConvert, xOffset + endPieceJointLengthConvert, yOffset + boxHeightConvert - thicknessConvert);
      svg.line(xOffset + endPieceJointLengthConvert, yOffset + boxHeightConvert - thicknessConvert, xOffset + endPieceJointLengthConvert, yOffset + boxHeightConvert);
      svg.line(xOffset + endPieceJointLengthConvert, yOffset + boxHeightConvert, xOffset, yOffset + boxHeightConvert);
    }

    // Joints
    for (int i = (jointAmount - 1); i >= 1; i--) {
      if (i % 2 == 0) {
        svg.line(xOffset, yOffset + (jointHeightConvert * (i + 1)), xOffset, yOffset + (jointHeightConvert * i));
        svg.line(xOffset, yOffset + (jointHeightConvert * i), xOffset - thicknessConvert, yOffset + (jointHeightConvert * i));
      } else {
        svg.line(xOffset - thicknessConvert, yOffset + (jointHeightConvert * (i + 1)), xOffset - thicknessConvert, yOffset + (jointHeightConvert * i));
        svg.line(xOffset - thicknessConvert, yOffset + (jointHeightConvert * i), xOffset, yOffset + (jointHeightConvert * i));
      }
    }

    // Close
    svg.line(xOffset - thicknessConvert, yOffset + jointHeightConvert, xOffset, yOffset + jointHeightConvert);
    svg.line(xOffset, yOffset + jointHeightConvert, xOffset, yOffset);
  }


  // Constructs a side piece and saves it to the .svg
  // xOffset ,yOffset indicate how far from the origin the vector will be placed, leave both as '0' for default
  private void plotSVGSidePiece(int xOffset, int yOffset) {

    // Plot top
    if (constructTop == false) {
      svg.line(xOffset, yOffset, xOffset + boxLengthConvert, yOffset);
    } else {
      svg.line(xOffset, yOffset, xOffset + sidePieceJointLengthConvert + thicknessConvert, yOffset);
      svg.line(xOffset + sidePieceJointLengthConvert + thicknessConvert, yOffset, xOffset + sidePieceJointLengthConvert + thicknessConvert, yOffset + thicknessConvert);
      svg.line(xOffset + sidePieceJointLengthConvert + thicknessConvert, yOffset + thicknessConvert, xOffset + (sidePieceJointLengthConvert * 2) + thicknessConvert, yOffset + thicknessConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2) + thicknessConvert, yOffset + thicknessConvert, xOffset + (sidePieceJointLengthConvert * 2) + thicknessConvert, yOffset);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2) + thicknessConvert, yOffset, xOffset + boxLengthConvert, yOffset);
    }


    // Plot joints
    for (int i = 1; i <= (jointAmount - 1); i++) {
      if (i % 2 == 0) {
        svg.line(boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * (i - 1)) + yOffset, boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * i) + yOffset);
        svg.line(boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * i) + yOffset, boxLengthConvert + xOffset, (jointHeightConvert * i) + yOffset);
      } else {
        svg.line(boxLengthConvert + xOffset, yOffset + (jointHeightConvert * (i - 1)), boxLengthConvert + xOffset, (jointHeightConvert * i)  + yOffset);
        svg.line(boxLengthConvert + xOffset, (jointHeightConvert * i) + yOffset, boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * i) + yOffset);
      }
    }
    svg.line(boxLengthConvert + xOffset, (jointHeightConvert * (jointAmount - 1)) + yOffset, boxLengthConvert + xOffset, boxHeightConvert + yOffset);  // 10

    // Plot bottom
    if (constructBottom == false) {
      svg.line(boxLengthConvert + xOffset, boxHeightConvert + yOffset, xOffset, boxHeightConvert + yOffset);
    } else {
      svg.line(xOffset + boxLengthConvert, yOffset + boxHeightConvert, xOffset + (sidePieceJointLengthConvert * 2) + thicknessConvert, yOffset + boxHeightConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2) + thicknessConvert, yOffset + boxHeightConvert, xOffset + (sidePieceJointLengthConvert * 2) + thicknessConvert, yOffset + boxHeightConvert - thicknessConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2) + thicknessConvert, yOffset + boxHeightConvert - thicknessConvert, xOffset + sidePieceJointLengthConvert + thicknessConvert, yOffset + boxHeightConvert - thicknessConvert);
      svg.line(xOffset + sidePieceJointLengthConvert + thicknessConvert, yOffset + boxHeightConvert - thicknessConvert, xOffset + sidePieceJointLengthConvert + thicknessConvert, yOffset + boxHeightConvert);
      svg.line(xOffset + sidePieceJointLengthConvert + thicknessConvert, yOffset + boxHeightConvert, xOffset, yOffset + boxHeightConvert);
    }

    // Plot joints
    for (int i = (jointAmount - 1); i >= 1; i--) {
      if (i % 2 == 0) {
        svg.line(xOffset, (jointHeightConvert * (i + 1)) + yOffset, xOffset, (jointHeightConvert * i) + yOffset);
        svg.line(xOffset, (jointHeightConvert * i) + yOffset, thicknessConvert + xOffset, (jointHeightConvert * i) + yOffset);
      } else {
        svg.line(thicknessConvert + xOffset, (jointHeightConvert * (i + 1)) + yOffset, thicknessConvert + xOffset, (jointHeightConvert * i) + yOffset);
        svg.line(thicknessConvert + xOffset, (jointHeightConvert * i) + yOffset, xOffset, (jointHeightConvert * i) + yOffset);
      }
    }

    // Plot closing
    svg.line(xOffset, jointHeightConvert + yOffset, xOffset, yOffset);  // 18
  }
}
