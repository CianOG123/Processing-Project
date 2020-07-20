/** 
 *  GUI top panel that is visible on the top of the screen
 *  By Cian O'Gorman 20-07-2020
 */
class GUI_Top {

  // Constants
  private static final int BACKGROUND_HEIGHT = 50;
  private static final int TRIM_WIDTH = 1;
  private static final int GRADIENT_X_POSITION = 200;
  private static final int LOGO_X_POSITION = 15;
  private static final int LOGO_Y_POSITION = 10;

  private void draw() {
    drawBackground();
    drawValues();
  }
  
  // Draws the text and figures to the screen
  private void drawValues(){
    fill(TEXT_WHITE);
    textFont(robotoLight25);
    text("VivasDraw", LOGO_X_POSITION, LOGO_Y_POSITION + (textAscent() + textDescent()));
  }

  // Draws the background to the screen
  private void drawBackground() {
    // Background square
    fill(HEADING_DARK_GREY);
    noStroke();
    rect(0, 0, width, BACKGROUND_HEIGHT);
    setGradient(GRADIENT_X_POSITION, 0, width, BACKGROUND_HEIGHT, HEADING_DARK_GREY, HEADING_LIGHT_GREY, X_AXIS);

    // Bottom Trim
    fill(TRIM_GREY);
    noStroke();
    rect(0, BACKGROUND_HEIGHT, width, TRIM_WIDTH);
  }

  // Creates a gradient (Used for the background)
  void setGradient(int xPosition, int yPosition, float gradientWidth, float gradientHeight, color color1, color color2, int axis ) {
    noFill();
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = yPosition; i <= yPosition + gradientHeight; i++) {
        float inter = map(i, yPosition, yPosition + gradientHeight, 0, 1);
        color constructedColor = lerpColor(color1, color2, inter);
        stroke(constructedColor);
        line(xPosition, i, xPosition + gradientWidth, i);
      }
    } else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = xPosition; i <= xPosition + gradientWidth; i++) {
        float inter = map(i, xPosition, xPosition + gradientWidth, 0, 1);
        color constructedColor = lerpColor(color1, color2, inter);
        stroke(constructedColor);
        line(i, yPosition, i, yPosition + gradientHeight);
      }
    }
  }
}
