/**
 *  Test program to draw multiple complex shapes to the screen.
 *  Created using examples as a source.
 *  By Cian O'Gorman 17-07-2020.
 */

// Libraries
import processing.svg.*;

boolean testSVG = false;

// Declaring Objects
private Graphic_Context_3D_Container container3D;
private GUI_Main userInterface;
private SVG_Export svgTest;

void setup() {
  initialiseFonts();
  frameRate(60);
  size(1280, 720, P3D); // Width, height, and depth of screen

  // Initialising Objects
  container3D = new Graphic_Context_3D_Container();
  userInterface = new GUI_Main();
  svgTest = new SVG_Export(true, true, 1);
}

void draw() {
  background(0);
  container3D.draw();
  userInterface.draw();  
  if (testSVG == false) {
    testSVG = true;
    svgTest.constructSVGPlan();
  }
}

void mouseWheel(MouseEvent event) {
  scrollSlope = -event.getCount();
  accumulatedScroll += scrollSlope;
}
