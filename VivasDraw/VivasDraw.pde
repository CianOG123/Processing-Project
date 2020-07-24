import peasy.*;

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

PeasyCam cam;

void setup() {
  initialiseFonts();
  frameRate(60);
  size(1280, 720, P2D); // Width, height, and depth of screen
  cam = new PeasyCam(this, 400);
  cam.setMinimumDistance(180);
  cam.setMaximumDistance(600);
  cam.setFreeRotationMode();

  // Initialising Objects
  container3D = new Graphic_Context_3D_Container();
  userInterface = new GUI_Main();
  svgTest = new SVG_Export();
}

void draw() {
  float[] rotations = cam.getRotations();
  //if(rotations
  //cam.setRotations(0,rotations[1]);
  background(0);
  container3D.draw();
  userInterface.draw();  
  if (testSVG == false) {
    testSVG = true;
    svgTest.constructSVGPlan();
  }
}

// Switching graphic container temporarily
PGraphics this_g;
public void beginDraw(PGraphics pg) {
  pg.beginDraw();
  this_g = g;  // backup g
  this.g = pg; // replace g
}

public void endDraw(PGraphics pg) {
  this.g = this_g; // restore g
  pg.endDraw();
}
