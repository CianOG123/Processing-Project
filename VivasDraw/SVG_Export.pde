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
  private float endPieceCenterJointLengthConvert;
  private float oddJointLengthConvert;

  // Booleans
  private boolean constructTop = false;     // When set to true a top piece will be constructed and all relevant joints
  private boolean constructBottom = false;  // When set to true a bottom piece will be constructed and all relevant joints
  private boolean constructCenter = false;  // When set to true a center piece will be constructed and all relevant joints
  private boolean multipleJoints = false;   // When set to true multiple joints will be drawn for the center piece to lock into

  SVG_Export(boolean constructTop, boolean constructBottom, boolean constructCenter, int boxType) {
    this.boxType = boxType;
    this.constructTop = constructTop;
    this.constructBottom = constructBottom;
    this.constructCenter = constructCenter;
    convertMeasurements();
    svg = createGraphics(calculateCanvasWidth(), calculateCanvasHeight(), SVG, "Project.svg");
  }

  SVG_Export(boolean constructTop, boolean constructBottom, boolean constructCenter, boolean multipleJoints, int boxType) {
    this.boxType = boxType;
    this.constructTop = constructTop;
    this.constructBottom = constructBottom;
    this.constructCenter = constructCenter;
    this.multipleJoints = multipleJoints;
    convertMeasurements();
    getOddJointLengthConvert();
    svg = createGraphics(calculateCanvasWidth(), calculateCanvasHeight(), SVG, "Project.svg");
  }

  SVG_Export(int boxType) {
    this.boxType = boxType;
    convertMeasurements();
    switch (boxType) {
    case BOX_OPEN_TOP:
      constructTop = false;
      constructBottom = true;
      break;
    case BOX_CLOSED:
      constructTop = true;
      constructBottom = true;
      break;
    case BOX_OPEN_THROUGH:
      constructTop = false;
      constructBottom = false;
      break;
    case BOX_CENTER_PART:
      constructTop = true;
      constructBottom = true;
      constructCenter = true;
      multipleJoints = true;
      getOddJointLengthConvert();
      break;
    default:
      constructTop = true;
      constructBottom = true;
      break;
    }
    svg = createGraphics(calculateCanvasWidth(), calculateCanvasHeight(), SVG, "Project.svg");
    constructSVGPlan();
  }

  // Calculates the amount of pixels  on the vertical needed to incase the raster image
  private int calculateCanvasHeight() {
    int canvasHeight = (int) (boxHeightConvert * 2);
    if (boxWidthConvert > canvasHeight) {
      canvasHeight = (int) boxWidthConvert;
    }

    if (constructCenter == true) {
      canvasHeight += (int) boxHeightConvert + BOUNDARY + thicknessConvert;
    }
    canvasHeight += BOUNDARY * 3;
    return canvasHeight;
  }

  // Calculates the amount of pixels needed on the horizontal axis to incase the raster image
  private int calculateCanvasWidth() {
    int canvasWidth = 0;

    if (constructTop == true) {
      canvasWidth += (int) boxLengthConvert + (BOUNDARY * 2);
    }

    if (constructTop == true) {
      canvasWidth += (int) boxLengthConvert + BOUNDARY;
    }

    canvasWidth += ((int) (boxLengthConvert + boxWidthConvert + (thicknessConvert * 2) + (BOUNDARY * 2)));
    return canvasWidth;
  }

  private void constructSVGPlan() {
    svg.beginDraw();
    plotSVGSidePiece(BOUNDARY, BOUNDARY);
    plotSVGSidePiece(BOUNDARY, (int) boxHeightConvert + (BOUNDARY * 2));
    plotSVGEndPiece((int) (boxLengthConvert + thicknessConvert)+ (BOUNDARY * 2), BOUNDARY);
    plotSVGEndPiece((int) (boxLengthConvert + thicknessConvert) + (BOUNDARY * 2), (int) boxHeightConvert + (BOUNDARY * 2));
    plotSVGTopPiece(constructTop, (int) (boxLengthConvert + boxWidthConvert + thicknessConvert + (BOUNDARY * 3)), BOUNDARY + (int) thicknessConvert);
    plotSVGTopPiece(constructBottom, (int) ((boxLengthConvert * 2) + boxWidthConvert + thicknessConvert + (BOUNDARY * 4)), BOUNDARY + (int) thicknessConvert);
    plotSVGCenterPiece(constructCenter, multipleJoints, BOUNDARY + (int) thicknessConvert, (int) ((boxHeightConvert * 2) + thicknessConvert) + (BOUNDARY * 3));
    svg.dispose();
    svg.endDraw();
  }

  // Convers all relevants to the relevant format and scale for SVG rendering
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
      endPieceCenterJointLengthConvert = endPieceCenterJointLength * PIXEL_TO_MILLIMETRE;
    }
  }

  // Calculates the length of the joints being used on the center piece
  private void getOddJointLengthConvert() {
    if (jointHeightConvert <= thicknessConvert) {
      println("Invalid geometry: center piece multiple joint");
    } else {
      oddJointLengthConvert = jointHeightConvert - thicknessConvert;
    }
  }

  private void plotSVGCenterPiece(boolean constructPiece, boolean multipleJoints, int xOffset, int yOffset) {
    if (constructPiece == true) {

      // Construct Top
      if (multipleJoints == false) {
        svg.line(xOffset, yOffset, xOffset + sidePieceJointLengthConvert, yOffset);
      } else {
        svg.line(xOffset - thicknessConvert, yOffset, xOffset + sidePieceJointLengthConvert, yOffset);
      }
      svg.line(xOffset + sidePieceJointLengthConvert, yOffset, xOffset + sidePieceJointLengthConvert, yOffset - thicknessConvert);
      svg.line(xOffset + sidePieceJointLengthConvert, yOffset - thicknessConvert, xOffset + (sidePieceJointLengthConvert * 2), yOffset - thicknessConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset - thicknessConvert, xOffset + (sidePieceJointLengthConvert * 2), yOffset);

      if (multipleJoints == false) {
        svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset, xOffset + (sidePieceJointLengthConvert * 3), yOffset);
      } else {
        svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset, xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset);
      }

      // Construct Right
      if (multipleJoints == false) {
        svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset, xOffset + (sidePieceJointLengthConvert * 3), yOffset + endPieceCenterJointLengthConvert);
        svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + endPieceCenterJointLengthConvert, xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + endPieceCenterJointLengthConvert);
        svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + endPieceCenterJointLengthConvert, xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 2));
        svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 2), xOffset + (sidePieceJointLengthConvert * 3), yOffset + (endPieceCenterJointLengthConvert * 2));
        svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + (endPieceCenterJointLengthConvert * 2), xOffset + (sidePieceJointLengthConvert * 3), yOffset + (endPieceCenterJointLengthConvert * 3));
      } else {
        // Odd joint
        svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset, xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + oddJointLengthConvert);
        svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + oddJointLengthConvert, xOffset + (sidePieceJointLengthConvert * 3), yOffset + oddJointLengthConvert);

        // Normal joint
        svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + oddJointLengthConvert, xOffset + (sidePieceJointLengthConvert * 3), yOffset + oddJointLengthConvert + jointHeightConvert);
        svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + oddJointLengthConvert + jointHeightConvert, xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + oddJointLengthConvert + jointHeightConvert);
        svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + oddJointLengthConvert + jointHeightConvert, xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + oddJointLengthConvert + (jointHeightConvert * 2));
        svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + oddJointLengthConvert + (jointHeightConvert * 2), xOffset + (sidePieceJointLengthConvert * 3), yOffset + oddJointLengthConvert + (jointHeightConvert * 2));
        svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + oddJointLengthConvert + (jointHeightConvert * 2), xOffset + (sidePieceJointLengthConvert * 3), yOffset + oddJointLengthConvert + (jointHeightConvert * 3));
        svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + oddJointLengthConvert + (jointHeightConvert * 3), xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + oddJointLengthConvert + (jointHeightConvert * 3));

        // Odd Joint
        svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + oddJointLengthConvert + (jointHeightConvert * 3), xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + (oddJointLengthConvert * 2) + (jointHeightConvert * 3));
      }

      // Construct Bottom
      if (multipleJoints == false) {
        svg.line(xOffset + (sidePieceJointLengthConvert * 3), yOffset + (endPieceCenterJointLengthConvert * 3), xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceCenterJointLengthConvert * 3));
      } else {
        svg.line(xOffset + (sidePieceJointLengthConvert * 3) + thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3), xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceCenterJointLengthConvert * 3));
      }

      svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceCenterJointLengthConvert * 3), xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceCenterJointLengthConvert * 3) + thicknessConvert);
      svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset + (endPieceCenterJointLengthConvert * 3) + thicknessConvert, xOffset + sidePieceJointLengthConvert, yOffset + (endPieceCenterJointLengthConvert * 3) + thicknessConvert);
      svg.line(xOffset + sidePieceJointLengthConvert, yOffset + (endPieceCenterJointLengthConvert * 3) + thicknessConvert, xOffset + sidePieceJointLengthConvert, yOffset + (endPieceCenterJointLengthConvert * 3));

      if (multipleJoints == false) {
        svg.line(xOffset + sidePieceJointLengthConvert, yOffset + (endPieceCenterJointLengthConvert * 3), xOffset, yOffset + (endPieceCenterJointLengthConvert * 3));
      } else {
        svg.line(xOffset + sidePieceJointLengthConvert, yOffset + (endPieceCenterJointLengthConvert * 3), xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3));
      }

      // Construct Left
      if (multipleJoints == false) {
        svg.line(xOffset, yOffset + (endPieceCenterJointLengthConvert * 3), xOffset, yOffset + (endPieceCenterJointLengthConvert * 2));
        svg.line(xOffset, yOffset + (endPieceCenterJointLengthConvert * 2), xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 2));
        svg.line(xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 2), xOffset - thicknessConvert, yOffset + endPieceCenterJointLengthConvert);
        svg.line(xOffset - thicknessConvert, yOffset + endPieceCenterJointLengthConvert, xOffset, yOffset + endPieceCenterJointLengthConvert);
        svg.line(xOffset, yOffset + endPieceCenterJointLengthConvert, xOffset, yOffset);
      } else {
        // Odd joint
        svg.line(xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3), xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert);
        svg.line(xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert, xOffset, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert);
        svg.line(xOffset, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert, xOffset, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - jointHeightConvert);
        svg.line(xOffset, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - jointHeightConvert, xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - jointHeightConvert);
        svg.line(xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - jointHeightConvert, xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - (jointHeightConvert * 2));
        svg.line(xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - (jointHeightConvert * 2), xOffset, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - (jointHeightConvert * 2));
        svg.line(xOffset, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - (jointHeightConvert * 2), xOffset, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - (jointHeightConvert * 3));
        svg.line(xOffset, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - (jointHeightConvert * 3), xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - (jointHeightConvert * 3));
        svg.line(xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - oddJointLengthConvert - (jointHeightConvert * 3), xOffset - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 3) - (oddJointLengthConvert * 2) - (jointHeightConvert * 3));
      }
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

      if (constructCenter == true) {
        svg.line(xOffset + sidePieceJointLengthConvert, yOffset + ((endPieceLengthConvert - thicknessConvert) / 2), xOffset + (sidePieceJointLengthConvert * 2), yOffset + ((endPieceLengthConvert - thicknessConvert) / 2));
        svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset + ((endPieceLengthConvert - thicknessConvert) / 2), xOffset + (sidePieceJointLengthConvert * 2), yOffset + ((endPieceLengthConvert + thicknessConvert) / 2));
        svg.line(xOffset + (sidePieceJointLengthConvert * 2), yOffset + ((endPieceLengthConvert + thicknessConvert) / 2), xOffset + sidePieceJointLengthConvert, yOffset + ((endPieceLengthConvert + thicknessConvert) / 2));
        svg.line(xOffset + sidePieceJointLengthConvert, yOffset + ((endPieceLengthConvert + thicknessConvert) / 2), xOffset + sidePieceJointLengthConvert, yOffset + ((endPieceLengthConvert - thicknessConvert) / 2));
      }
    }
  }



  // Creates an end piece
  private void plotSVGEndPiece(int xOffset, int yOffset) {
    // Plot top
    if (constructTop == false) {
      if (multipleJoints == false) {
        svg.line(xOffset, yOffset, xOffset + endPieceLengthConvert, yOffset);
      } else {
        svg.line(xOffset, yOffset, xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset);
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset, xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + jointHeightConvert);
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + jointHeightConvert, xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + jointHeightConvert);
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + jointHeightConvert, xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset);
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset, xOffset + endPieceLengthConvert, yOffset);
      }
    } else {
      svg.line(xOffset, yOffset, xOffset + endPieceJointLengthConvert, yOffset);
      svg.line(xOffset + endPieceJointLengthConvert, yOffset, xOffset + endPieceJointLengthConvert, yOffset + thicknessConvert);

      if (multipleJoints == false) {
        svg.line(xOffset + endPieceJointLengthConvert, yOffset + thicknessConvert, xOffset + (endPieceJointLengthConvert * 2), yOffset + thicknessConvert);
      } else {
        svg.line(xOffset + endPieceJointLengthConvert, yOffset + thicknessConvert, xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + thicknessConvert);
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + thicknessConvert, xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + thicknessConvert + oddJointLengthConvert);
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + thicknessConvert + oddJointLengthConvert, xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + thicknessConvert + oddJointLengthConvert);
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + thicknessConvert + oddJointLengthConvert, xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + thicknessConvert);
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + thicknessConvert, xOffset + (endPieceJointLengthConvert * 2), yOffset + thicknessConvert);
      }

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
      if (multipleJoints == false) {
        svg.line(xOffset + endPieceLengthConvert, yOffset + boxHeightConvert, xOffset, yOffset + boxHeightConvert);
      } else {
        svg.line(xOffset + endPieceLengthConvert, yOffset + boxHeightConvert, xOffset + endPieceLengthConvert - ((boxWidthConvert - thicknessConvert) / 2) + thicknessConvert, yOffset + boxHeightConvert);
        svg.line(xOffset + endPieceLengthConvert - ((boxWidthConvert - thicknessConvert) / 2) + thicknessConvert, yOffset + boxHeightConvert, xOffset + endPieceLengthConvert - ((boxWidthConvert - thicknessConvert) / 2) + thicknessConvert, yOffset + boxHeightConvert - thicknessConvert);
        svg.line(xOffset + endPieceLengthConvert - ((boxWidthConvert - thicknessConvert) / 2) + thicknessConvert, yOffset + boxHeightConvert - thicknessConvert, xOffset + endPieceLengthConvert - ((boxWidthConvert - thicknessConvert) / 2), yOffset + boxHeightConvert - thicknessConvert);
        svg.line(xOffset + endPieceLengthConvert - ((boxWidthConvert - thicknessConvert) / 2), yOffset + boxHeightConvert - thicknessConvert, xOffset + endPieceLengthConvert - ((boxWidthConvert - thicknessConvert) / 2), yOffset + boxHeightConvert);
        svg.line(xOffset + endPieceLengthConvert - ((boxWidthConvert - thicknessConvert) / 2), yOffset + boxHeightConvert, xOffset, yOffset + boxHeightConvert);
      }
    } else {
      svg.line(xOffset + endPieceLengthConvert, yOffset + boxHeightConvert, xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert);
      svg.line(xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert, xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert - thicknessConvert);

      if (multipleJoints == false) {
        svg.line(xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert - thicknessConvert, xOffset + endPieceJointLengthConvert, yOffset + boxHeightConvert - thicknessConvert);
      } else {
        svg.line(xOffset + (endPieceJointLengthConvert * 2), yOffset + boxHeightConvert - thicknessConvert, xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + boxHeightConvert - thicknessConvert);
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + boxHeightConvert - thicknessConvert, xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + boxHeightConvert - thicknessConvert - oddJointLengthConvert);
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2) - thicknessConvert, yOffset + boxHeightConvert - thicknessConvert - oddJointLengthConvert, xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + boxHeightConvert - thicknessConvert - oddJointLengthConvert);
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + boxHeightConvert - thicknessConvert - oddJointLengthConvert, xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + boxHeightConvert - thicknessConvert);
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + boxHeightConvert - thicknessConvert, xOffset + endPieceJointLengthConvert, yOffset + boxHeightConvert - thicknessConvert);
      }

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

    // Adding center joint
    if (constructCenter == true) {
      if (multipleJoints == false) {
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + endPieceCenterJointLengthConvert + thicknessConvert, xOffset + ((boxWidthConvert + thicknessConvert) / 2)  - thicknessConvert, yOffset + endPieceCenterJointLengthConvert + thicknessConvert);
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2)  - thicknessConvert, yOffset + endPieceCenterJointLengthConvert + thicknessConvert, xOffset + ((boxWidthConvert + thicknessConvert) / 2)  - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 2) + thicknessConvert);
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2)  - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 2) + thicknessConvert, xOffset + ((boxWidthConvert - thicknessConvert) / 2)  - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 2) + thicknessConvert);
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2)  - thicknessConvert, yOffset + (endPieceCenterJointLengthConvert * 2) + thicknessConvert, xOffset + ((boxWidthConvert - thicknessConvert) / 2)  - thicknessConvert, yOffset + endPieceCenterJointLengthConvert + thicknessConvert);
      } else {
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2) - thicknessConvert, yOffset + (jointHeightConvert * 2), xOffset + ((boxWidthConvert + thicknessConvert) / 2)  - thicknessConvert, yOffset + (jointHeightConvert * 2));
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2)  - thicknessConvert, yOffset + (jointHeightConvert * 2), xOffset + ((boxWidthConvert + thicknessConvert) / 2)  - thicknessConvert, yOffset + (jointHeightConvert * 3));
        svg.line(xOffset + ((boxWidthConvert + thicknessConvert) / 2)  - thicknessConvert, yOffset + (jointHeightConvert * 3), xOffset + ((boxWidthConvert - thicknessConvert) / 2)  - thicknessConvert, yOffset + (jointHeightConvert * 3));
        svg.line(xOffset + ((boxWidthConvert - thicknessConvert) / 2)  - thicknessConvert, yOffset + (jointHeightConvert * 3), xOffset + ((boxWidthConvert - thicknessConvert) / 2)  - thicknessConvert, yOffset + (jointHeightConvert * 2));
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

    // Adding center joint
    //if (constructCenter == true) {
    //  svg.line(xOffset + ((boxLengthConvert - thicknessConvert) / 2), yOffset + endPieceCenterJointLengthConvert + thicknessConvert, xOffset + ((boxLengthConvert + thicknessConvert) / 2), yOffset + endPieceCenterJointLengthConvert + thicknessConvert);
    //  svg.line(xOffset + ((boxLengthConvert + thicknessConvert) / 2), yOffset + endPieceCenterJointLengthConvert + thicknessConvert, xOffset + ((boxLengthConvert + thicknessConvert) / 2), yOffset + (endPieceCenterJointLengthConvert * 2) + thicknessConvert);
    //  svg.line(xOffset + ((boxLengthConvert + thicknessConvert) / 2), yOffset + (endPieceCenterJointLengthConvert * 2) + thicknessConvert, xOffset + ((boxLengthConvert - thicknessConvert) / 2), yOffset + (endPieceCenterJointLengthConvert * 2) + thicknessConvert);
    //  svg.line(xOffset + ((boxLengthConvert - thicknessConvert) / 2), yOffset + (endPieceCenterJointLengthConvert * 2) + thicknessConvert, xOffset + ((boxLengthConvert - thicknessConvert) / 2), yOffset + endPieceCenterJointLengthConvert + thicknessConvert);
    //}

    // Plot closing
    svg.line(xOffset, jointHeightConvert + yOffset, xOffset, yOffset);  // 18
  }
}
