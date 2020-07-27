/** 
 *  Class to handle text input boxes
 *  Cursor errors will occur if placed directly beside 3D Container
 *  By Cian O'Gorman 20-07-2020
 */
class Text_Input {

  // Constants
  protected static final int INPUT_TIME_LIMIT = 9;            // The amount of frames that will elapse between considered user inputs

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
      if (charPressedBuffer >= INPUT_TIME_LIMIT) {
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
          } else {
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
class Joint_Input extends Text_Input {

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
          if(value % 1 != 0){
            value = (int) value;
          }
          if(value < 3){
            value = 3;
          }
          if(value % 2 == 0){
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
