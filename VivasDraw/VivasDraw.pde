/**
 * Application designed to help students to create plans for subtractive manufacturing machines
 *  By Cian O'Gorman 17-07-2020.
 */

// Libraries
import processing.svg.*;

boolean testSVG = false;

// Declaring Objects
private Graphic_Context_3D_Container container3D;
private GUI_Main userInterface;

void setup() {
  initialiseFonts();
  frameRate(60);
  smooth();
  size(1280, 720, P3D); // Width, height, and depth of screen

  // Initialising Objects
  container3D = new Graphic_Context_3D_Container();
  userInterface = new GUI_Main();
  
  // Initialising Construct booleans
  initialiseConstructBooleans();
  
  // initialise SVG Measurements
  container3D.convertMeasurements();
}

void draw() {
  background(0);
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
