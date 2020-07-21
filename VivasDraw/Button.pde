/** 
 *  Class to handle buttons
 *  By Cian O'Gorman 20-07-2020
 */
class Button {
}


/** 
 *  Class to handle text input boxes
 *  Cursor errors will occur if placed directly beside 3D Container
 *  By Cian O'Gorman 20-07-2020
 */
class Text_Input {

  // Constants
  private static final int INPUT_TIME_LIMIT = 9;            // The amount of frames that will elapse between considered user inputs

  // Variables
  private int xPosition, yPosition, buttonHeight, buttonWidth;  // Positioning and size of the button on screen
  private String valueTitle;
  private float value;
  private String inputBuffer;
  private int charPressedBuffer = 0;                            // Stops the user from erasing all letters when pressing backspace, or double typing a letter
  private int mousePressedBuffer = 0;

  // Booleans
  private boolean cursorChanged = false;                        // Used to change the cursor image
  private boolean inputMode = false;                            // Set to true when user is inputting values

  // Arrays
  private char[] validChars = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'};   // The characters that are accepted as input from the user


  Text_Input(int xPosition, int yPosition, int buttonWidth, int buttonHeight, String valueTitle, float value) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.buttonHeight = buttonHeight;
    this.buttonWidth = buttonWidth;
    this.valueTitle = valueTitle;
    this.value = value;
    this.inputBuffer = Float.toString(value);
  }

  private void draw() {
    changeCursor();
    userInput();
    enableInputMode();
    displayButton();
  }

  // Displays the button on the screen
  private void displayButton() {
    textFont(robotoLight25);
    fill(TEXT_WHITE);
    if (inputMode == false) {
      text(valueTitle + value + "mm", xPosition, yPosition + textAscent() + textDescent());
    } else {
      text(valueTitle + inputBuffer + "mm", xPosition, yPosition + textAscent() + textDescent());
    }
  }

  // Changes the cursor icon to indicate the user can change the value of the text
  private void changeCursor() {
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
  private void userInput() {
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
  private void enableInputMode() {
    if (mousePressed == true) {
      if ((mouseX > xPosition) && (mouseX < xPosition + buttonWidth) && (mouseY >= yPosition) && (mouseY <= yPosition + buttonHeight)) {
        if (mousePressedBuffer == 0) {
          mousePressedBuffer = 1;
          if (inputMode == false) {
            inputBuffer = String.valueOf(value);
            inputBuffer += '_';
            inputMode = true;
          } else {
            saveToValue();
            inputMode = false;
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
  private void saveToValue() {
    inputBuffer = inputBuffer.substring(0, inputBuffer.length() - 1);
    if (inputBuffer != "") {
      try {
        value = Float.parseFloat(inputBuffer);
      } 
      catch(Exception NumberFormatException) {
      }
    }
  }
}
