/** 
 *  Handles all exporting to .svg file types
 *  By Cian O'Gorman 18-07-2020
 */
class SVG_Export {

  // Constants
  private static final int BOUNDARY = 10;      // The distance from the vector to the edge of the image
  private static final float PIXEL_TO_MILLIMETRE = (129600/45719.994) / 0.75 ;  // Used to convert pixel measurements to millimetre

  // Objects
  private PGraphics svg;

  // Variables
  float boxLengthConvert;
  float boxWidthConvert;
  float boxHeightConvert;
  float thicknessConvert;
  float jointAmountConvert;
  float jointHeightConvert;
  float endPieceLengthConvert;

  SVG_Export() {
    convertMeasurements();
    svg = createGraphics((int) (boxLengthConvert + boxWidthConvert) + (BOUNDARY * 3), ((int)boxHeightConvert * 2) + (BOUNDARY * 3), SVG, "Project.svg");
  }

  private void constructSVGPlan() {
    svg.beginDraw();
    plotSVGSidePiece(BOUNDARY, BOUNDARY);
    plotSVGSidePiece(BOUNDARY, (int) boxHeightConvert + (BOUNDARY * 2));
    plotSVGEndPiece((int) (boxLengthConvert + thicknessConvert)+ (BOUNDARY * 2), BOUNDARY);
    plotSVGEndPiece((int) (boxLengthConvert + thicknessConvert) + (BOUNDARY * 2), (int) boxHeightConvert + (BOUNDARY * 2));
    svg.dispose();
    svg.endDraw();
  }

  private void convertMeasurements() {
    if (measurementType == MILLIMETRE) {
      boxLengthConvert = boxLength * PIXEL_TO_MILLIMETRE;
      boxWidthConvert = boxWidth * PIXEL_TO_MILLIMETRE;
      boxHeightConvert = boxHeight * PIXEL_TO_MILLIMETRE;
      thicknessConvert = thickness * PIXEL_TO_MILLIMETRE;
      jointAmountConvert = jointAmount * PIXEL_TO_MILLIMETRE;
      jointHeightConvert = jointHeight * PIXEL_TO_MILLIMETRE;
      endPieceLengthConvert = endPieceLength * PIXEL_TO_MILLIMETRE;
    }
  }

  private void plotSVGEndPiece(int xOffset, int yOffset) {
    // Plot top
    svg.line(xOffset, yOffset, xOffset + endPieceLengthConvert, yOffset);

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

    // Plot bottom
    svg.line(xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * (jointAmount - 1)), xOffset + endPieceLengthConvert, yOffset + boxHeightConvert); // 10
    svg.line(xOffset + endPieceLengthConvert, yOffset + boxHeightConvert, xOffset, yOffset + boxHeightConvert);

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
    svg.line(xOffset, yOffset, boxLengthConvert + xOffset, yOffset);

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

    // Plot bottom
    svg.line(boxLengthConvert + xOffset, (jointHeightConvert * (jointAmount - 1)) + yOffset, boxLengthConvert + xOffset, boxHeightConvert + yOffset);  // 10
    svg.line(boxLengthConvert + xOffset, boxHeightConvert + yOffset, xOffset, boxHeightConvert + yOffset);

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
