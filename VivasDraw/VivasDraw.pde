/**
 * Application designed to help students to create plans for subtractive manufacturing machines
 *  By Cian O'Gorman 17-07-2020.
 */

// Libraries
import processing.svg.*;
import java.util.Arrays;
import java.util.Collections;

// Constants
private static final int FRAME_RATE = 60;
private static final int[] SCREEN_DIMENSIONS = {1280, 720};
private static final color BACKGROUND_COLOR = 0;

// Declaring Objects
private Graphic_Context_3D_Container container3D;
private GUI_Main userInterface;

void settings() {
  size(SCREEN_DIMENSIONS[0], SCREEN_DIMENSIONS[1], P3D);
  initialiseFonts();
}

void setup() {
  frameRate(FRAME_RATE);
  smooth();
  initialiseConstructBooleans();
  setCenterJointPosition();
  container3D = new Graphic_Context_3D_Container();
  userInterface = new GUI_Main();
  initialiseConstructBooleans();
  convertMeasurements();
}

void draw() {
  background(BACKGROUND_COLOR);
  container3D.draw();
  userInterface.draw();  
}

void mouseWheel(MouseEvent event) {
  scrollSlope = -event.getCount();
  accumulatedScroll += scrollSlope;
}

void mousePressed() {
  container3D.checkBox.mousePressed();
  userInterface.mousePressed();
}
