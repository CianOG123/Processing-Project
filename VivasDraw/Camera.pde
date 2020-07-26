/** 
 *  Class to handle the user controlled camera
 *  Note: X and Y axis rotation have been split into two separate identical classes.
 *  I am aware these could be merged, however for the sake of readability and future modifiability
 *  I have left these as separate functions
 *  By Cian O'Gorman 25-07-2020
 */
class Camera {
  
  // Constants
  private static final int SCROLL_SPEED = 10;     // Higher is slower, lower is faster
  private static final float SCROLL_MAX = 0.333;  // The max scroll distance
  private static final float SCROLL_MIN = 3;      // The minimum scroll distance

  // Objects
  private PGraphics graphicsContext;

  // SettingsVariables
  private static final int ROTATE_BUTTON = CENTER;

  // General Variables
  private boolean rotatingX = false, rotatingY = false;  // Is the axis being rotated
  private int savedMouseX, savedMouseY;  // The saved mouse position on screen
  private int currentXRotation = 0, currentYRotation = 0;  // The amount of radians the y position has changed while the current button has been pressed
  private int xRotation = 10, yRotation = 30;    // The X and Y Rotation of the Graphic Context, set to 10, 30 on start up
  private float scaleAmount = 2;  // The scale of the objects in the graphic context, used for zoom
  private int scrollSlope = 0; // If the scroll is increasing or decreasing

  Camera(PGraphics graphics) {
    graphicsContext = graphics;
  }

  private void draw() {
    rotateYAxis();
    rotateXAxis();
    zoom();
    applyRotations();
  }

  // Applies all rotations and translations to the graphic context
  private void applyRotations() {
    //graphicsContext.camera(0, height / 2, (height/2) / tan(PI * 30 / 180), 0, 0, 0, 0, 1, 0);

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

  // Zooms by scaling the graphics context
  private void zoom() {
    println(scaleAmount);
    if ((scaleAmount >= SCROLL_MIN) && (scrollSlope > 0)) {
      scaleAmount = SCROLL_MIN;
      accumulatedScroll = scaleAmount * SCROLL_SPEED;
    } 
    else if((scaleAmount <= SCROLL_MAX) && (scrollSlope < 0)){
      scaleAmount = SCROLL_MAX;
      accumulatedScroll = scaleAmount * SCROLL_SPEED;
    }else {
      scaleAmount = ((accumulatedScroll / SCROLL_SPEED));
    }
  }

  private void mouseWheel(MouseEvent event) {
    scrollSlope = -event.getCount();
    accumulatedScroll += scrollSlope;
  }
}
