/** 
 *  Class to handle the user controlled camera
 *  Cursor errors will occur if placed directly beside 3D Container
 *  By Cian O'Gorman 25-07-2020
 */
class Camera {

  // Objects
  PGraphics graphicsContext;

  private boolean rotatingY = false, rotatingX = false;  // Is the axis being rotated
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
        if (rotatingY == false) {
          rotatingY = true;
          savedMouseX = mouseX;
        }
        // While button is pressed
        else {
          float mouseYDifference = mouseX - savedMouseX;
          currentYRotation = (int) mouseYDifference / 5;
        }
      }
      // When mouse is released
    } else if (rotatingY == true) {
      rotatingY = false;
      yRotation += currentYRotation;
      currentYRotation = 0;
    }
  }
  
  // Rotates the graphic context on the x-axis when the center mouse buton is pressed
  private void rotateXAxis() {
    if (mousePressed == true) {
      if (mouseButton == CENTER) {
        // When button is initially pressed
        if (rotatingX == false) {
          rotatingX = true;
          savedMouseY = mouseY;
        }
        // While button is pressed
        else {
          float mouseXDifference = mouseY - savedMouseY;
          currentXRotation = (int) mouseXDifference / 5;
        }
      }
      // When mouse is released
    } else if (rotatingX == true) {
      rotatingX = false;
      xRotation += currentXRotation;
      currentXRotation = 0;
    }
  }
}
