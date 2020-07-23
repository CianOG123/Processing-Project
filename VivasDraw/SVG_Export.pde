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
  
  private void convertMeasurements(){
    if(measurementType == MILLIMETRE){
      boxLengthConvert = boxLength * PIXEL_TO_MILLIMETRE;
      boxWidthConvert = boxWidth * PIXEL_TO_MILLIMETRE;
      boxHeightConvert = boxHeight * PIXEL_TO_MILLIMETRE;
      thicknessConvert = thickness * PIXEL_TO_MILLIMETRE;
      jointAmountConvert = jointAmount * PIXEL_TO_MILLIMETRE;
      jointHeightConvert = jointHeight * PIXEL_TO_MILLIMETRE;
      endPieceLengthConvert = endPieceLength * PIXEL_TO_MILLIMETRE;
    }
  }
  
  private void plotSVGEndPiece(int xOffset, int yOffset){
    svg.line(xOffset, yOffset, xOffset + endPieceLengthConvert, yOffset);
    svg.line(xOffset + endPieceLengthConvert, yOffset, xOffset + endPieceLengthConvert, yOffset + jointHeightConvert);
    svg.line(xOffset + endPieceLengthConvert, yOffset + jointHeightConvert, xOffset + endPieceLengthConvert + thicknessConvert, yOffset + jointHeightConvert);
    svg.line(xOffset + endPieceLengthConvert + thicknessConvert, yOffset + jointHeightConvert, xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * 2));
    svg.line(xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * 2), xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * 2));  // 5
    svg.line(xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * 2), xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * 3));
    svg.line(xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * 3), xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * 3));  // 7
    svg.line(xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * 3), xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * 4));
    svg.line(xOffset + endPieceLengthConvert + thicknessConvert, yOffset + (jointHeightConvert * 4), xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * 4));
    svg.line(xOffset + endPieceLengthConvert, yOffset + (jointHeightConvert * 4), xOffset + endPieceLengthConvert, yOffset + boxHeightConvert); // 10
    svg.line(xOffset + endPieceLengthConvert, yOffset + boxHeightConvert, xOffset, yOffset + boxHeightConvert);
    svg.line(xOffset, yOffset + boxHeightConvert, xOffset, yOffset + (jointHeightConvert * 4));
    svg.line(xOffset, yOffset + (jointHeightConvert * 4), xOffset - thicknessConvert, yOffset + (jointHeightConvert * 4));
    svg.line(xOffset - thicknessConvert, yOffset + (jointHeightConvert * 4), xOffset - thicknessConvert, yOffset + (jointHeightConvert * 3));
    svg.line(xOffset - thicknessConvert, yOffset + (jointHeightConvert * 3), xOffset, yOffset + (jointHeightConvert * 3));  // 15
    svg.line(xOffset, yOffset + (jointHeightConvert * 3), xOffset, yOffset + (jointHeightConvert * 2));
    svg.line(xOffset, yOffset + (jointHeightConvert * 2), xOffset - thicknessConvert, yOffset + (jointHeightConvert * 2));
    svg.line(xOffset, yOffset + (jointHeightConvert * 2), xOffset - thicknessConvert, yOffset + (jointHeightConvert * 2)); 
    svg.line(xOffset - thicknessConvert, yOffset + (jointHeightConvert * 2), xOffset - thicknessConvert, yOffset + jointHeightConvert);  // 18
    svg.line(xOffset - thicknessConvert, yOffset + jointHeightConvert, xOffset, yOffset + jointHeightConvert);
    svg.line(xOffset, yOffset + jointHeightConvert, xOffset, yOffset);
  }


  // Constructs a side piece and saves it to the .svg
  // xOffset ,yOffset indicate how far from the origin the vector will be placed, leave both as '0' for default
  private void plotSVGSidePiece(int xOffset, int yOffset) {
    svg.line(xOffset, yOffset, boxLengthConvert + xOffset, yOffset);    // 1
    svg.line(boxLengthConvert + xOffset,yOffset, boxLengthConvert + xOffset, jointHeightConvert  + yOffset);
    svg.line(boxLengthConvert + xOffset, jointHeightConvert + yOffset, boxLengthConvert - thicknessConvert + xOffset, jointHeightConvert + yOffset);
    svg.line(boxLengthConvert - thicknessConvert + xOffset, jointHeightConvert + yOffset, boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * 2) + yOffset);
    svg.line(boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * 2) + yOffset, boxLengthConvert + xOffset, (jointHeightConvert * 2) + yOffset);  // 5
    svg.line(boxLengthConvert + xOffset, (jointHeightConvert * 2) + yOffset, boxLengthConvert + xOffset, (jointHeightConvert * 3) + yOffset);
    svg.line(boxLengthConvert + xOffset, (jointHeightConvert * 3) + yOffset, boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * 3) + yOffset);
    svg.line(boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * 3) + yOffset, boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * 4) + yOffset);  // 8
    svg.line(boxLengthConvert - thicknessConvert + xOffset, (jointHeightConvert * 4) + yOffset, boxLengthConvert + xOffset, (jointHeightConvert * 4) + yOffset);
    svg.line(boxLengthConvert + xOffset, (jointHeightConvert * 4) + yOffset, boxLengthConvert + xOffset, (jointHeightConvert * 5) + yOffset);  // 10
    svg.line(boxLengthConvert + xOffset, boxHeightConvert + yOffset, xOffset, boxHeightConvert + yOffset);
    svg.line(xOffset, boxHeightConvert + yOffset, xOffset, (jointHeightConvert * 4) + yOffset);
    svg.line(xOffset, (jointHeightConvert * 4) + yOffset, thicknessConvert + xOffset, (jointHeightConvert * 4) + yOffset);
    svg.line(thicknessConvert + xOffset, (jointHeightConvert * 4) + yOffset, thicknessConvert + xOffset, (jointHeightConvert * 3) + yOffset);
    svg.line(thicknessConvert + xOffset, (jointHeightConvert * 3) + yOffset, xOffset, (jointHeightConvert * 3) + yOffset);  // 14
    svg.line( xOffset, (jointHeightConvert * 3) + yOffset, + xOffset, (jointHeightConvert * 2) + yOffset);
    svg.line(xOffset, (jointHeightConvert * 2) + yOffset, thicknessConvert + xOffset, (jointHeightConvert * 2) + yOffset);
    svg.line(thicknessConvert + xOffset, (jointHeightConvert * 2) + yOffset, thicknessConvert + xOffset, jointHeightConvert + yOffset);
    svg.line(thicknessConvert + xOffset, jointHeightConvert + yOffset, xOffset, jointHeightConvert + yOffset);
    svg.line(xOffset, jointHeightConvert + yOffset, xOffset,  yOffset);  // 18
  }
}
