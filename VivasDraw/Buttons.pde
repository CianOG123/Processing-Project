/** 
 *  Class to handle scroll bars
 *  By Cian O'Gorman 28-07-2020
 */
private class Scroll_Bar {
  // Variables
  private int xPosition;
  private int yPosition;
  private int scrollWidth;
  private int scrollHeight;

  // Return Variables
  private int scrollOffset = 0;  // The amount of pixels the scroll bar is displaced by

  Scroll_Bar(int xPosition, int yPosition, int scrollWidth, int scrollHeight) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.scrollWidth = scrollWidth;
    this.scrollHeight = scrollHeight;
  }
}


/** 
 *  Class to handle check boxes
 *  By Cian O'Gorman 28-07-2020
 */
private class Check_Box {
  // Variables
  private int xPosition, yPosition;
  private int checkBoxWidth, checkBoxHeight;
  private String label;
  private boolean buttonSelected = false;
  private int xOffset;  
  private PGraphics graphics;

  // Constants
  private static final int BOUNDARY = 10;
  private static final int TEXT_SIZE = 15;
  private static final color LABEL_COLOR = TEXT_WHITE;
  private static final color BUTTON_COLOR = TEXT_WHITE;
  private final PFont BUTTON_FONT = robotoLight25;

  Check_Box(int xPosition, int yPosition, int checkBoxWidth, int checkBoxHeight, String label, int xOffset, PGraphics pg) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.checkBoxWidth = checkBoxWidth;
    this.checkBoxHeight = checkBoxHeight;
    this.label = label;
    this.xOffset = xOffset;
    graphics = pg;
  }

  private void draw(PGraphics graphicContext) {
    if ((isMouseHovering()) || (buttonAutoRotate == true)) {
      graphics.stroke(BUTTON_COLOR);
    } else {
      graphics.stroke(HEADING_DARK_GREY);
    }
    if (buttonSelected) {
      graphicContext.fill(BUTTON_COLOR);
      graphicContext.rect(xPosition, yPosition, checkBoxWidth, checkBoxHeight);
      graphicContext.fill(LABEL_COLOR);
      graphicContext.textFont(BUTTON_FONT);
      graphicContext.text(label, (xPosition + checkBoxWidth + BOUNDARY), yPosition + ((textAscent() + textDescent()) / 2));
    } else {
      graphicContext.fill(LABEL_COLOR);
      graphicContext.rect(xPosition, yPosition, checkBoxWidth, checkBoxHeight);
      graphicContext.textFont(BUTTON_FONT);
      graphicContext.textSize(TEXT_SIZE);
      graphicContext.text(label, (xPosition + checkBoxWidth + BOUNDARY), yPosition + ((textAscent() + textDescent()) / 2));
    }
  }

  private void isCheckBoxPressed() {
    if (isMouseHovering()) {
      buttonAutoRotate = !buttonAutoRotate;
    }
  }

  private void mousePressed() {
    isCheckBoxPressed();
  }

  private boolean isMouseHovering() {
    boolean enableHover = false;
    if ((mouseX > xPosition + xOffset) && (mouseX < (xPosition + checkBoxWidth + xOffset))) {
      if ((mouseY > yPosition) && (mouseY < (yPosition + checkBoxHeight))) {
        enableHover = true;
      }
    }
    return enableHover;
  }
}

/** 
 *  Class to handle text input boxes
 *  Cursor errors will occur if placed directly beside 3D Container
 *  By Cian O'Gorman 20-07-2020
 */
private class Text_Input {

  // Constants
  protected static final int INPUT_TIME_LIMIT = 15;            // The amount of frames that will elapse between considered user inputs

  // Variables
  protected int xPosition, yPosition, buttonHeight, buttonWidth;  // Positioning and size of the button on screen
  protected String valueTitle;
  protected float value;
  protected String inputBuffer;
  protected int charPressedBuffer = 0;                            // Stops the user from erasing all letters when pressing backspace, or double typing a letter
  protected int mousePressedBuffer = 0;
  protected int measureType = 0;                                  // The type of measurements the button corresponds to (used for updating the public variables)
  protected String measurementString = "";

  // Booleans
  protected boolean cursorChanged = false;                        // Used to change the cursor image
  protected boolean inputMode = false;                            // Set to true when user is inputting values

  // Arrays
  protected char[] validChars = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'};   // The characters that are accepted as input from the user


  Text_Input(int xPosition, int yPosition, String valueTitle, float value, int measureType) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    textFont(robotoLight25);    // Used to get height of text
    this.buttonHeight = int (textAscent() + textDescent());
    this.valueTitle = valueTitle;
    this.value = value;
    this.inputBuffer = Float.toString(value);
    this.measureType = measureType;
    setMeasurementString();
  }

  protected void draw() {
    changeCursor();
    getTextWidth();
    userInput();
    enableInputMode();
    displayButton();
  }

  // Displays the button on the screen
  protected void displayButton() {
    textFont(robotoLight25);
    fill(TEXT_WHITE);
    if (inputMode == false) {
      text(valueTitle + value + measurementString, xPosition, yPosition + textAscent() + textDescent());
    } else {
      text(valueTitle + inputBuffer + measurementString, xPosition, yPosition + textAscent() + textDescent());
    }
  }

  // Returns the width of the text
  protected void getTextWidth() {
    buttonWidth = (int) textWidth(valueTitle + value + measurementString);
  }

  // Changes the cursor icon to indicate the user can change the value of the text
  protected void changeCursor() {
    if ((mouseX > xPosition) && (mouseX < xPosition + buttonWidth) && (mouseY >= yPosition) && (mouseY <= yPosition + buttonHeight)) {
      if (cursorChanged == false) {
        cursorChanged = true;
        cursor(TEXT);
      }
    } else if (cursorChanged == true) {
      cursor(ARROW);
      cursorChanged = false;
    }
  }

  // Handles user input
  protected void userInput() {
    if ((inputMode == true) && (keyPressed) && (charPressedBuffer == 0)) {
      charPressedBuffer = 1;
      switch(key) {
      case BACKSPACE:
        if (inputBuffer.length() != 1) {
          inputBuffer = inputBuffer.substring(0, inputBuffer.length() - 2);
          inputBuffer += '_';
        }
        break;
      case ENTER:
        saveToValue();
        inputMode = false;
        inputEnabledElseWhere = false;
        break;
      default:
        for (int i = 0; i < validChars.length; i++) {
          if (key == validChars[i]) {
            String character = Character.toString(key);
            inputBuffer = inputBuffer.substring(0, inputBuffer.length() - 1);
            inputBuffer += character;
            inputBuffer += '_';
            i = validChars.length;
          }
        }
        break;
      }
    } else if (charPressedBuffer != 0) {
      charPressedBuffer++;
      if ((charPressedBuffer >= INPUT_TIME_LIMIT) || (keyPressed == false)) {
        charPressedBuffer = 0;
      }
    }
  }

  // Checks to see if the box has been clicked and enables input mode if it has
  protected void enableInputMode() {
    if (mousePressed == true) {
      if ((mouseX > xPosition) && (mouseX < xPosition + buttonWidth) && (mouseY >= yPosition) && (mouseY <= yPosition + buttonHeight)) {
        if (mousePressedBuffer == 0) {
          mousePressedBuffer = 1;
          if ((inputMode == false) && (inputEnabledElseWhere == false)) {
            inputMode = true;
            inputEnabledElseWhere = true;
            inputBuffer = String.valueOf(value);
            inputBuffer += '_';
          } else if (inputEnabledElseWhere == false) {
            saveToValue();
            inputMode = false;
            inputEnabledElseWhere = false;
          }
        } else {
          mousePressedBuffer++;
          if (mousePressedBuffer >= INPUT_TIME_LIMIT) {
            mousePressedBuffer = 0;
          }
        }
      }
    }
  }

  // Saves the inputBuffer to value
  protected void saveToValue() {
    inputBuffer = inputBuffer.substring(0, inputBuffer.length() - 1);
    if (inputBuffer != "") {
      try {
        float newValue = Float.parseFloat(inputBuffer);
        if (newValue != value) {
          value = newValue;
          updateMeasurement();              // Position means, shapes are only updated if new measurement is valid
          println("\nMeasurement update");
        }
      } 
      catch(Exception NumberFormatException) {
      }
    }
  }

  // Updates the public variables for length, width, height, etc
  protected void updateMeasurement() {
    refreshBox = true;
    switch (measureType) {
    case LENGTH:
      boxLength = value;
      break;
    case WIDTH:
      boxWidth = value;
      break;
    case HEIGHT:
      boxHeight = value;
      break;
    case THICKNESS:
      thickness = value;
      break;
    case JOINT_AMOUNT:
      jointAmount = (int) value;
      break;
    }
  }

  // Sets the measurement string base on the button type
  protected void setMeasurementString() {
    if (measureType == JOINT_AMOUNT) {
      measurementString = "";
    } else {
      measurementString = "mm";
    }
  }
}


/** 
 *  Modified subclass for dealing with joint amount input
 *  By Cian O'Gorman 27-07-2020
 */
private class Joint_Input extends Text_Input {

  Joint_Input(int xPosition, int yPosition, String valueTitle, int value, int measureType) {
    super(xPosition, yPosition, valueTitle, value, measureType);
  }

  // Displays the button on the screen
  @Override
    protected void displayButton() {
    textFont(robotoLight25);
    fill(TEXT_WHITE);
    if (inputMode == false) {
      text(valueTitle + (int) value + measurementString, xPosition, yPosition + textAscent() + textDescent());
    } else {
      text(valueTitle + inputBuffer + measurementString, xPosition, yPosition + textAscent() + textDescent());
    }
  }

  // Saves the inputBuffer to value
  @Override
    protected void saveToValue() {
    inputBuffer = inputBuffer.substring(0, inputBuffer.length() - 1);
    if (inputBuffer != "") {
      try {
        float newValue = Float.parseFloat(inputBuffer);
        if (newValue != value) {
          value = newValue;
          if (value % 1 != 0) {
            value = (int) value;
          }
          if (value < 3) {
            value = 3;
          }
          if (value % 2 == 0) {
            value++;
          }
          updateMeasurement();              // Position means, shapes are only updated if new measurement is valid
          println("\nMeasurement update");
        }
      } 
      catch(Exception NumberFormatException) {
      }
    }
  }
}
