/** 
 *  Main GUI class responsible for containing all GUI related objects
 *  By Cian O'Gorman 19-07-2020
 */
private class GUI_Main {

  // Objects
  private GUI_Options_Panel optionsPanel;
  private GUI_Top topPanel;
  private GUI_Selector_Box selectorBox;

  GUI_Main() {
    optionsPanel = new GUI_Options_Panel();
    topPanel = new GUI_Top();
    selectorBox = new GUI_Selector_Box();
  }

  private void draw() {
    optionsPanel.draw();
    topPanel.draw();
    selectorBox.draw();
  }
}

/** 
 *  GUI box selector visible on left side of screen
 *  By Cian O'Gorman 20-07-2020
 */
private class GUI_Selector_Box {

  //Objects
  private PGraphics graphics;

  // Constants
  private static final int X_POSITION = 960;
  private static final int Y_POSITION = 115;
  private static final int BOX_WIDTH = 310;
  private static final int BOX_HEIGHT = 150;
  
  private static final int SCROLL_Y = 137;
  private static final int SCROLL_HEIGHT = 13;
  


  GUI_Selector_Box() {
    graphics = createGraphics(BOX_WIDTH, BOX_HEIGHT, P2D);
  }

  private void draw() {
    graphics.beginDraw();
    {
      graphics.fill(255);
      noStroke();
      graphics.rect(0, 0, BOX_WIDTH, BOX_HEIGHT);
      graphics.fill(0);
      graphics.rect(0, SCROLL_Y, BOX_WIDTH, SCROLL_HEIGHT);
    }
    graphics.endDraw();

    // Drawing the graphic context to the screen
    image(graphics, X_POSITION, Y_POSITION);
  }
}

/** 
 *  GUI top panel that is visible on the top of the screen
 *  By Cian O'Gorman 20-07-2020
 */
private class GUI_Top {

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
  private void drawValues() {
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

/** 
 *  GUI Options panel that is visible on the right hand side of the screen
 *  By Cian O'Gorman 19-07-2020
 */
private class GUI_Options_Panel {

  // Constants
  private static final int PANEL_ORIGIN_X_POSITION = 930;
  private static final int PANEL_ORIGIN_Y_POSITION = 50;
  private static final int PANEL_WIDTH = 350;
  private static final int PANEL_HEIGHT = 670;

  private static final int VALUES_OFFSET = 10;

  private static final int TRIM_THICKNESS = 1;
  private static final int SCROLL_TRIM_X_POSITION = 950;
  private static final int SCROLL_TRIM_Y_POSITION = 60;
  private static final int SCROLL_TRIM_HEIGHT = 650;
  private static final int HEADER_TRIM_Y_POSITION = 105;
  private static final int UNDERLINE_TRIM_X_POSITION = 960;
  private static final int UNDERLINE_TRIM_Y_POSITION = 310;
  private static final int UNDERLINE_TRIM_WIDTH = 310;
  private static final int TRIM_SELECT_Y_OFFSET = 55;

  private static final int TEXT_BUTTON_Y_OFFSET = 35;

  // Objects
  Text_Input boxLengthInput;
  Text_Input boxWidthInput;
  Text_Input boxHeightInput;
  Text_Input boxThicknessInput;
  Joint_Input boxJointAmountInput;


  GUI_Options_Panel() {
    boxLengthInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET, "Length: ", boxLength, LENGTH);
    boxWidthInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET + (TRIM_SELECT_Y_OFFSET), "Width: ", boxWidth, WIDTH);
    boxHeightInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET + (TRIM_SELECT_Y_OFFSET * 2), "Height: ", boxHeight, HEIGHT);
    boxThicknessInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET + (TRIM_SELECT_Y_OFFSET * 3), "Material Thickness: ", thickness, THICKNESS);
    boxJointAmountInput = new Joint_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET + (TRIM_SELECT_Y_OFFSET * 4), "Joint Amount: ", jointAmount, JOINT_AMOUNT);
  }

  private void draw() {
    drawBackground();
    drawValues();
  }

  // Draws the text and values
  private void drawValues() {
    fill(TEXT_WHITE);
    textFont(robotoLight25);
    text("Box Type: ", UNDERLINE_TRIM_X_POSITION, HEADER_TRIM_Y_POSITION - VALUES_OFFSET);
    boxLengthInput.draw();
    boxWidthInput.draw();
    boxHeightInput.draw();
    boxThicknessInput.draw();
    boxJointAmountInput.draw();
  }

  // Draws the background of the panel
  private void drawBackground() {
    // Background Square
    fill(STANDARD_GREY);
    noStroke();
    rect(PANEL_ORIGIN_X_POSITION, PANEL_ORIGIN_Y_POSITION, PANEL_WIDTH, PANEL_HEIGHT);

    // Trim Lines
    fill(TRIM_GREY);
    noStroke();
    rect(PANEL_ORIGIN_X_POSITION, PANEL_ORIGIN_Y_POSITION, TRIM_THICKNESS, PANEL_HEIGHT);
    //rect(PANEL_ORIGIN_X_POSITION, PANEL_ORIGIN_Y_POSITION, PANEL_WIDTH, TRIM_THICKNESS); 
    rect(SCROLL_TRIM_X_POSITION, SCROLL_TRIM_Y_POSITION, TRIM_THICKNESS, SCROLL_TRIM_HEIGHT);
    rect(UNDERLINE_TRIM_X_POSITION, HEADER_TRIM_Y_POSITION, UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
    rect(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION, UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
    rect(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION + TRIM_SELECT_Y_OFFSET, UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
    rect(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION + (TRIM_SELECT_Y_OFFSET * 2), UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
    rect(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION + (TRIM_SELECT_Y_OFFSET * 3), UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
    rect(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION + (TRIM_SELECT_Y_OFFSET * 4), UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
    //rect(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION + (TRIM_SELECT_Y_OFFSET * 5), UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
    //rect(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION + (TRIM_SELECT_Y_OFFSET * 6), UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
    //rect(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION + (TRIM_SELECT_Y_OFFSET * 7), UNDERLINE_TRIM_WIDTH, TRIM_THICKNESS);
  }
}
