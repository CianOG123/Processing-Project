/** 
 *  Handles all exporting to .svg file types
 *  By Cian O'Gorman 18-07-2020
 */
class SVG_Export {

  // Constants
  private static final int BOUNDARY = 10;      // The distance from the vector to the edge of the image

  // Objects
  private PGraphics svgSidePiece;

  SVG_Export() {
    svgSidePiece = createGraphics(400, 400, SVG, "Side-Piece.svg"); // (int) boxLength + (BOUNDARY * 2), (int) boxHeight + (BOUNDARY * 2)
  }


  // Constructs a side piece and saves it to the .svg
  // xOffset ,yOffset indicate how far from the origin the vector will be placed, leave both as '0' for default
  private void constructSVGSidePiece(int xOffset,int yOffset) {
    svgSidePiece.beginDraw();
    svgSidePiece.background(255);
    svgSidePiece.line(0 + BOUNDARY + xOffset, 0 + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, 0 + BOUNDARY + yOffset);    // 1
    svgSidePiece.line(boxLength + BOUNDARY + xOffset, 0 + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset);
    svgSidePiece.line(boxLength + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset, boxLength - thickness + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset);
    svgSidePiece.line(boxLength - thickness + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset, boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset);
    svgSidePiece.line(boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset);  // 5
    svgSidePiece.line(boxLength + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset);
    svgSidePiece.line(boxLength + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset, boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset);
    svgSidePiece.line(boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset, boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset);  // 8
    svgSidePiece.line(boxLength - thickness + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset);
    svgSidePiece.line(boxLength + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset, boxLength + BOUNDARY + xOffset, (jointHeight * 5) + BOUNDARY + yOffset);  // 10
    svgSidePiece.line(boxLength + BOUNDARY + xOffset, boxHeight + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, boxHeight + BOUNDARY + yOffset);
    svgSidePiece.line(0 + BOUNDARY + xOffset, boxHeight + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset);
    svgSidePiece.line(0 + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset, thickness + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset);
    svgSidePiece.line(thickness + BOUNDARY + xOffset, (jointHeight * 4) + BOUNDARY + yOffset, thickness + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset);
    svgSidePiece.line(thickness + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset);  // 14
    svgSidePiece.line(0 + BOUNDARY + xOffset, (jointHeight * 3) + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset);
    svgSidePiece.line(0 + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset, thickness + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset);
    svgSidePiece.line(thickness + BOUNDARY + xOffset, (jointHeight * 2) + BOUNDARY + yOffset, thickness + BOUNDARY + xOffset, (jointHeight * 1) + BOUNDARY + yOffset);
    svgSidePiece.line(thickness + BOUNDARY + xOffset, jointHeight  + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset);
    svgSidePiece.line(0 + BOUNDARY + xOffset, jointHeight + BOUNDARY + yOffset, 0 + BOUNDARY + xOffset, 0 + BOUNDARY + yOffset);  // 18
    svgSidePiece.dispose();
    svgSidePiece.endDraw();
  }
}
