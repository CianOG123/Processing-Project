/** 
 *  Main GUI class responsible for containing all GUI related objects
 *  By Cian O'Gorman 19-07-2020
 */
private class GUI_Main {

  // Objects
  private GUI_Options_Panel optionsPanel;
  private GUI_Top topPanel;
  private GUI_Selector_Box selectorBox;

  private GUI_Main() {
    optionsPanel = new GUI_Options_Panel();
    topPanel = new GUI_Top();
    selectorBox = new GUI_Selector_Box();
  }

  private void draw() {
    optionsPanel.draw();
    topPanel.draw();
    selectorBox.draw();
  }

  private void mousePressed() {
    selectorBox.mousePressed();
    topPanel.mousePressed();
  }
}

/** 
 *  GUI box selector visible on left side of screen
 *  By Cian O'Gorman 20-07-2020
 */
private class GUI_Selector_Box {

  //Objects
  private PGraphics graphics;
  private Scroll_Bar scrollBar;
  private Image_Button boxOpenTopButton;
  private Image_Button boxClosedButton;
  private Image_Button boxOpenThroughButton;
  private Image_Button boxCenterPart;
  private Image_Button boxCrossSection;
  private Image_Button boxRaisedFloor;

  // Variables
  private float shiftAmount;    // The amount the selector is shifted on the x-axis
  private int areaWidth;  // The width of the area that can be scrolled

  // Constants
  private static final int BOX_EDGE_OFFSET = 10;  // Used to stop scroll surpassing edge of box

  private static final int SCROLL_Y = 137;
  private static final int SCROLL_HEIGHT = 13;
  private static final float SCROLLABLE_WIDTH = 270;  // The amount of pixels the scroll bar can move (between 0 and 270)

  private static final int BUTTON_AMOUNT = 6;                                        // The amount of selection buttons being displayed
  private static final int AREA_WIDTH = SCROLL_CONTEXT_BOX_HEIGHT;                   // The width of an option button
  private static final int AREA_HEIGHT = SCROLL_CONTEXT_BOX_HEIGHT - SCROLL_HEIGHT;  // The height of an option button
  private static final int BUTTON_WIDTH = 120;
  private static final int BUTTON_HEIGHT = 70;
  private static final int BUTTON_X_BOUNDARY = (AREA_WIDTH - BUTTON_WIDTH) / 2;      // The distance from the area edge to the button edge
  private static final int BUTTON_Y_BOUNDARY = 10;



  private GUI_Selector_Box() {
    graphics = createGraphics(SCROLL_CONTEXT_BOX_WIDTH, SCROLL_CONTEXT_BOX_HEIGHT, P2D);
    scrollBar = new Scroll_Bar(0, SCROLL_Y, SCROLL_CONTEXT_BOX_WIDTH, SCROLL_HEIGHT, graphics, SCROLL_CONTEXT_X_POSITION, SCROLL_CONTEXT_Y_POSITION);
    areaWidth = (BUTTON_AMOUNT - 2) * AREA_WIDTH;
    initialiseButtons();
  }

  private void draw() {

    calculateShift();

    graphics.beginDraw();
    {
      drawScrollableContext(shiftAmount);
      drawButtons();
      scrollBar.draw();
    }
    graphics.endDraw();


    // Drawing the graphic context to the screen
    image(graphics, SCROLL_CONTEXT_X_POSITION, SCROLL_CONTEXT_Y_POSITION);
  }

  // Initialises and positions all buttons
  private void initialiseButtons() {
    boxOpenThroughButton = new Image_Button(BUTTON_X_BOUNDARY, BUTTON_Y_BOUNDARY, BUTTON_WIDTH, BUTTON_HEIGHT, graphics, BOX_OPEN_THROUGH, "Open Top and\nBottom Box");
    boxOpenTopButton = new Image_Button(BUTTON_X_BOUNDARY + AREA_WIDTH, BUTTON_Y_BOUNDARY, BUTTON_WIDTH, BUTTON_HEIGHT, graphics, BOX_OPEN_TOP, "Open Top Box");
    boxClosedButton = new Image_Button(BUTTON_X_BOUNDARY + (AREA_WIDTH * 2), BUTTON_Y_BOUNDARY, BUTTON_WIDTH, BUTTON_HEIGHT, graphics, BOX_CLOSED, "Closed Box");
    boxCenterPart = new Image_Button(BUTTON_X_BOUNDARY + (AREA_WIDTH * 3), BUTTON_Y_BOUNDARY, BUTTON_WIDTH, BUTTON_HEIGHT, graphics, BOX_CENTER_PART, "Box with Centre\nPart");
    boxCrossSection = new Image_Button(BUTTON_X_BOUNDARY + (AREA_WIDTH * 4), BUTTON_Y_BOUNDARY, BUTTON_WIDTH, BUTTON_HEIGHT, graphics, BOX_CROSS_SECTION, "Box with Cross\n Section");
    boxRaisedFloor = new Image_Button(BUTTON_X_BOUNDARY + (AREA_WIDTH * 5), BUTTON_Y_BOUNDARY, BUTTON_WIDTH, BUTTON_HEIGHT, graphics, BOX_RAISED_FLOOR, "Box with Raised\nFloor");
  }

  // Draws the button to the screen
  private void drawButtons() {
    boxOpenTopButton.draw(shiftAmount);
    boxClosedButton.draw(shiftAmount);
    boxOpenThroughButton.draw(shiftAmount);
    boxCenterPart.draw(shiftAmount);
    boxCrossSection.draw(shiftAmount);
    boxRaisedFloor.draw(shiftAmount);
  }

  // Creates the scrollable context area
  private void drawScrollableContext(float shiftAmount) {

    // Variables
    final float trimXPosition = AREA_WIDTH;
    final int trimYPosition = 10;
    final int trimWidth = 1;
    final int trimHeight = AREA_HEIGHT - 20;

    // Drawing button spaces
    graphics.noStroke();
    for (int i = 0; i < BUTTON_AMOUNT; i++) {
      graphics.fill(STANDARD_GREY);
      graphics.rect(((i * AREA_WIDTH) + shiftAmount), 0, AREA_WIDTH, AREA_HEIGHT);
      graphics.fill(TRIM_GREY);
      graphics.rect(((i * trimXPosition) + shiftAmount), trimYPosition, trimWidth, trimHeight);
    }
    graphics.rect(((BUTTON_AMOUNT * trimXPosition) + shiftAmount) - 1, trimYPosition, trimWidth, trimHeight);
  }

  // Used to calculate the shift amount of the dialogue box 
  private void calculateShift() {
    float scrollBarOffset = scrollBar.getScrollOffset();
    float scrollInset = scrollBarOffset / SCROLLABLE_WIDTH; // The percentage to the right the scroll bar has moved
    shiftAmount = ((areaWidth - BOX_EDGE_OFFSET) * -scrollInset);  // Applying the ratio to the scrollable area
  }

  private void mousePressed() {
    boxOpenThroughButton.mousePressed();
    boxOpenTopButton.mousePressed();
    boxClosedButton.mousePressed();
    boxCenterPart.mousePressed();
    boxCrossSection.mousePressed();
    boxRaisedFloor.mousePressed();
  }
}

/** 
 *  GUI top panel that is visible on the top of the screen
 *  By Cian O'Gorman 20-07-2020
 */
private class GUI_Top {

  // Objects
  Text_Button exportButton;
  SVG_Export svgExporter;

  // Constants
  private static final int BACKGROUND_HEIGHT = 50;
  private static final int TRIM_WIDTH = 1;
  private static final int GRADIENT_X_POSITION = 200;
  private static final int LOGO_X_POSITION = 15;
  private static final int LOGO_Y_POSITION = 10;

  private GUI_Top() {
    exportButton = new Text_Button(1220, 25, "export", BUTTON_EXPORT);
  }

  private void draw() {
    drawBackground();
    drawLogo();
    exportButton.draw();
  }

  // Draws the logo to the screen
  private void drawLogo() {
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
    //setGradient(GRADIENT_X_POSITION, 0, width, BACKGROUND_HEIGHT, HEADING_DARK_GREY, HEADING_LIGHT_GREY, X_AXIS);

    // Bottom Trim
    fill(TRIM_GREY);
    noStroke();
    rect(0, BACKGROUND_HEIGHT, width, TRIM_WIDTH);
  }

  // Handles the events that happen if a button is pressed
  private void mousePressed() {
    if (exportButton.mousePressed() != EVENT_NULL) {
      svgExporter = new SVG_Export(displayedBox);
    }
  }

  // Creates a gradient (Used for the background)
  private void setGradient(int xPosition, int yPosition, float gradientWidth, float gradientHeight, color color1, color color2, int axis ) {
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
