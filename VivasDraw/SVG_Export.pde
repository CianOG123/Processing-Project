/** 
 *  Handles all exporting to .svg file types
 *  By Cian O'Gorman 18-07-2020
 */
class SVG_Export {

  // Constants
  private static final int BOUNDARY = 10;      // The distance from the vector to the edge of the image

  // Objects
  private PGraphics svg;

  SVG_Export() {
    svg = createGraphics((int) boxLength + (BOUNDARY * 2) + 1000, ((int)boxHeight * 2) + (BOUNDARY * 2), SVG, "Project.svg");
  }

  private void constructSVGPlan() {
    svg.beginDraw();
    plotSVGSidePiece(0, 0);
    plotSVGSidePiece(0, (int) boxHeight + BOUNDARY);
    svg.dispose();
    svg.endDraw();
  }
  
  private void plotSVGEndPiece(){
    //svg.line(0, 0);
  }


  // Constructs a side piece and saves it to the .svg
  // xOffset ,yOffset indicate how far from the origin the vector will be placed, leave both as '0' for default
  private void plotSVGSidePiece(int xOffset, int yOffset) {
    svg.line(0 + BOUNDARY + xOffset, 0 + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, 0 + BOUNDARY + yOffset);    // 1
    svg.line(boxLength + BOUNDARY + xOffset, 0 + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset);
    svg.line(boxLength + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset, boxLength - thickness + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset);
    svg.line(boxLength - thickness + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset, boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset);
    svg.line(boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset);  // 5
    svg.line(boxLength + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset);
    svg.line(boxLength + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset, boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset);
    svg.line(boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset, boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset);  // 8
    svg.line(boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset);
    svg.line(boxLength + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, (jointHeight * 5) + BOUNDARY + yOffset);  // 10
    svg.line(boxLength + BOUNDARY + xOffset, boxHeight + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, boxHeight + BOUNDARY + yOffset);
    svg.line(0 + BOUNDARY + xOffset, boxHeight + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset);
    svg.line(0 + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset, thickness + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset);
    svg.line(thickness + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset, thickness + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset);
    svg.line(thickness + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset);  // 14
    svg.line(0 + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset);
    svg.line(0 + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset, thickness + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset);
    svg.line(thickness + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset, thickness + BOUNDARY + xOffset, (jointHeight * 1) + BOUNDARY + yOffset);
    svg.line(thickness + BOUNDARY + xOffset, jointHeight  + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset);
    svg.line(0 + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, 0 + BOUNDARY + yOffset);  // 18
  }
}
