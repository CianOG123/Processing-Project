/** 
 *  Class to handle the user controlled camera
 *  Note: X and Y axis rotation have been split into two separate identical classes.
 *  I am aware these could be merged, however for the sake of readability and future modifiability
 *  I have left these as separate functions
 *  By Cian O'Gorman 25-07-2020
 */
private class Camera {

  // Constants
  private static final int SCROLL_SPEED = 10;     // Higher is slower, lower is faster
  private static final float SCROLL_MAX = 0.333;  // The max scroll distance
  private static final float SCROLL_MIN = 5;      // The minimum scroll distance

  // Objects
  private PGraphics graphicsContext;              // Reference to the graphic context used

  // Settings Variables
  private static final int ROTATE_BUTTON = CENTER;         // The button that will be used to rotate around the geometry

  // General Variables
  private boolean rotatingX = false, rotatingY = false;    // Is the axis being rotated
  private int savedMouseX, savedMouseY;                    // The saved mouse position on screen
  private int currentXRotation = 0, currentYRotation = 0;  // The amount of radians the y position has changed while the current button has been pressed
  private int xRotation = 10, yRotation = 30;              // The X and Y Rotation of the Graphic Context, set to 10, 30 on start up
  private float scaleAmount = 2;                           // The scale of the objects in the graphic context, used for zoom

  private Camera(PGraphics graphics) {
    graphicsContext = graphics;
  }

  private void draw() {
    rotateYAxis();
    rotateXAxis();
    zoom();
    applyRotations();
    autoRotate();
  }

  // Applies the auto-rotate rotation
  private void autoRotate() {
    if (buttonAutoRotate == true) {
      globalYRotate +=  Y_ROTATE_SPEED;
    }
    graphicsContext.rotateY(globalYRotate);
  }

  // Applies all rotations to the graphic context
  private void applyRotations() {
    graphicsContext.scale(scaleAmount, scaleAmount, scaleAmount);

    // Rotating the X-axis after the Y-axis results in an undesirable tilt.
    graphicsContext.rotateX(radians(-(xRotation + currentXRotation)));
    graphicsContext.rotateY(radians(yRotation + currentYRotation));

    // Auto-rotate
    //globalYRotate += Y_ROTATE_SPEED;
    //graphicsContext.rotateY(globalYRotate);
  }

  // Rotates the graphic context on the y-axis when the center mouse buton is pressed
  private void rotateYAxis() {
    if (mousePressed == true) {
      if (mouseButton == ROTATE_BUTTON) {
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
      if (mouseButton == ROTATE_BUTTON) {
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

  // Scales the graphics context using the scroll wheel value
  private void zoom() {
    if ((scaleAmount >= SCROLL_MIN) && (scrollSlope > 0)) {
      scaleAmount = SCROLL_MIN;
      accumulatedScroll = scaleAmount * SCROLL_SPEED;
    } else if ((scaleAmount <= SCROLL_MAX) && (scrollSlope < 0)) {
      scaleAmount = SCROLL_MAX;
      accumulatedScroll = scaleAmount * SCROLL_SPEED;
    } else {
      scaleAmount = ((accumulatedScroll / SCROLL_SPEED));
    }
  }
}
