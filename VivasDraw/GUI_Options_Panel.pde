/** 
 *  GUI Options panel that is visible on the right hand side of the screen
 *  By Cian O'Gorman 19-07-2020
 */
class GUI_Options_Panel {
  
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
  private static final int INPUT_HEIGHT = 27;
  
  // Objects
  Text_Input boxLengthInput;
  Text_Input boxWidthInput;
  Text_Input boxHeightInput;
  Text_Input boxThicknessInput;
  Text_Input boxJointAmountInput;
  
  
  GUI_Options_Panel(){
    boxLengthInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET, INPUT_HEIGHT, "Length: ", boxLength, LENGTH);
    boxWidthInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET + (TRIM_SELECT_Y_OFFSET), INPUT_HEIGHT, "Width: ", boxWidth, WIDTH);
    boxHeightInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET + (TRIM_SELECT_Y_OFFSET * 2), INPUT_HEIGHT, "Height: ", boxHeight, HEIGHT);
    boxThicknessInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET + (TRIM_SELECT_Y_OFFSET * 3), INPUT_HEIGHT, "Material Thickness: ", thickness, THICKNESS);
    boxJointAmountInput = new Text_Input(UNDERLINE_TRIM_X_POSITION, UNDERLINE_TRIM_Y_POSITION - TEXT_BUTTON_Y_OFFSET + (TRIM_SELECT_Y_OFFSET * 4), INPUT_HEIGHT, "Joint Amount: ", jointAmount, JOINT_AMOUNT);
  }
  
  private void draw(){
    drawBackground();
    drawValues();
  }
  
  // Draws the text and values
  private void drawValues(){
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
  private void drawBackground(){
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
