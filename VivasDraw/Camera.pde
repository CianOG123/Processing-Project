/** 
 *  Class to handle the user controlled camera
 *  Cursor errors will occur if placed directly beside 3D Container
 *  By Cian O'Gorman 25-07-2020
 */
class Camera {

  // Objects
  PGraphics graphicsContext;

  private boolean centerReleased = false, leftReleased = false;  // Is the button after being released
  private boolean centerPressed = false, leftPressed = false;  // Is the button after being pressed
  private int savedMouseX, savedMouseY;  // The saved mouse position on screen
  private int currentYRotation = 0, currentXRotation = 0;  // The amount of radians the y position has changed while the current button has been pressed
  private int yRotation = 0, xRotation = 0;

  Camera(PGraphics graphics) {
    graphicsContext = graphics;
  }

  private void draw() {
    rotateYAxis();
    rotateXAxis();
    applyRotations();
  }

  // Applies all rotations and translations to the graphic context
  private void applyRotations() {
    // Rotating the X-axis after the Y-axis results in an undesirable tilt.
    graphicsContext.rotateX(radians(-(xRotation + currentXRotation)));
    graphicsContext.rotateY(radians(yRotation + currentYRotation));
  }

  // Rotates the graphic context on the y-axis when the center mouse buton is pressed
  private void rotateYAxis() {
    if (mousePressed == true) {
      if (mouseButton == CENTER) {
        // When button is initially pressed
        if (centerPressed == false) {
          centerPressed = true;
          savedMouseX = mouseX;
        }
        // While button is pressed
        else {
          float mouseYDifference = mouseX - savedMouseX;
          currentYRotation = (int) mouseYDifference / 5;
        }
      }
      // When mouse is released
    } else if (centerPressed == true) {
      centerPressed = false;
      yRotation += currentYRotation;
      currentYRotation = 0;
    }
  }
  
  // Rotates the graphic context on the x-axis when the center mouse buton is pressed
  private void rotateXAxis() {
    if (mousePressed == true) {
      if (mouseButton == LEFT) {
        // When button is initially pressed
        if (centerPressed == false) {
          centerPressed = true;
          savedMouseY = mouseY;
        }
        // While button is pressed
        else {
          float mouseXDifference = mouseY - savedMouseY;
          currentXRotation = (int) mouseXDifference / 5;
        }
      }
      // When mouse is released
    } else if (centerPressed == true) {
      centerPressed = false;
      xRotation += currentXRotation;
      currentXRotation = 0;
    }
  }
}
