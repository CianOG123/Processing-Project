/** 
 *  Handles the exportation and rendering of .svg files
 *  By Cian O'Gorman 17-09-2020
 */
class SVG_Render {

  // Objects
  protected PGraphics svg;  // Used to render all shapes to same canvas

  // Hidden booleans
  protected boolean disableExtendedJoint = false;  // Used to stop artifacting when jointHeight is equal to the thickness
  protected boolean middleJointExtrude = false;  // When set to true the middle joint of the center piece will be extruded

  SVG_Render() {
    svg = createGraphics(calculateCanvasWidth(), calculateCanvasHeight(), SVG, "Render.svg");
    constructSVGPlan();
  }

  // Creates all necessary pieces and adds them to the .svg
  private void constructSVGPlan() {
    svg.beginDraw();
    {
      SVG_Side_Piece sidePiece;
      SVG_End_Piece endPiece;
      SVG_Top_Piece topPiece, bottomPiece;
      SVG_Center_Piece centerPiece;
      SVG_Cross_Piece crossPiece;
      sidePiece = new SVG_Side_Piece(svg, BOUNDARY, BOUNDARY);
      sidePiece = new SVG_Side_Piece(svg, (int) boxLengthC + (BOUNDARY * 2), BOUNDARY);
      endPiece = new SVG_End_Piece(svg, BOUNDARY, (int) boxHeightC + (BOUNDARY * 2));
      endPiece = new SVG_End_Piece(svg, (int) boxWidthC + (BOUNDARY * 2), (int) boxHeightC + (BOUNDARY * 2));
      int bottomPieceXOffset = BOUNDARY;
      if (constructTop == true) {
        topPiece = new SVG_Top_Piece(svg, BOUNDARY, (int) (boxHeightC * 2) + (BOUNDARY * 3));
        bottomPieceXOffset = (int) boxLengthC + (BOUNDARY * 2);
      }
      if (constructBottom == true) {
        bottomPiece = new SVG_Top_Piece(svg, bottomPieceXOffset, (int) (boxHeightC * 2) + (BOUNDARY * 3));
      }
      float xPosition = (boxWidthC * 2) + (BOUNDARY * 3);
      float yPosition = boxHeightC + (BOUNDARY * 2);
      for (int i = 0; i < constructCenter.length; i++) {
        if (constructCenter[i] == true) {
          centerPiece = new SVG_Center_Piece(svg, (int) xPosition, (int) yPosition);
          xPosition += boxLengthC + BOUNDARY;
        }
      }
      xPosition = (boxLengthC * 2) + (BOUNDARY * 3);
      yPosition = BOUNDARY;
      for (int i = 0; i < constructCross.length; i++) {
        if (constructCross[i] == true) {
          crossPiece = new SVG_Cross_Piece(svg, (int) xPosition, (int) yPosition);
          xPosition += boxWidthC + BOUNDARY;
        }
      }
    }
    svg.dispose();
    svg.endDraw();
  }
  
  // Calculates the amount of pixels  on the vertical needed to incase the raster image
  private int calculateCanvasHeight() {
    float canvasHeight = (boxHeightC * 2) + (BOUNDARY * 3);
    for (int i = 0; i < constructCenter.length; i++) {
      if (constructCenter[i] == true) {
        canvasHeight +=  boxHeightC + BOUNDARY + thicknessC;
      }
      if (constructCross[i] == true) {
        canvasHeight +=  boxHeightC + BOUNDARY + thicknessC;
      }
    }
    if(constructTop == true || constructBottom == true){
      canvasHeight += boxWidthC + BOUNDARY;
    }
    return (int) canvasHeight;
  }

  // Calculates the amount of pixels needed on the horizontal axis to incase the raster image
  private int calculateCanvasWidth() {
    float canvasWidth = BOUNDARY * 2;
    if (boxLengthC > boxWidthC) {
      canvasWidth += boxLengthC * 2; 
      if (constructCenter[0] == true) {
        canvasWidth += boxLengthC;
      }
    } else {
      canvasWidth += boxWidthC * 2; 
      if (constructCross[0] == true) {
        canvasWidth += boxWidthC;
      }
    }
    float centerPieceWidth = (boxWidthC * 2) + (BOUNDARY * 3);
    for (int i = 0; i < constructCenter.length; i++) {
      if (constructCenter[i] == true) {
        centerPieceWidth += boxLengthC + BOUNDARY;
      }
    }
    if (centerPieceWidth > canvasWidth) {
      canvasWidth = centerPieceWidth;
    }
    float crossPieceWidth = (boxLengthC * 2) + (BOUNDARY * 3);
    for (int i = 0; i < constructCross.length; i++) {
      if (constructCross[i] == true) {
        crossPieceWidth += boxWidthC + BOUNDARY;
      }
    }
    if (crossPieceWidth > canvasWidth) {
      canvasWidth = crossPieceWidth;
    }
    return (int) canvasWidth;
  }
}
