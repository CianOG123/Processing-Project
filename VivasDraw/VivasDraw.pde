/**
 *  Test program to draw multiple complex shapes to the screen.
 *  Created using examples as a source.
 *  By Cian O'Gorman 17-07-2020.
 */

// User modifiable dimension variables
float boxLength = 130;
float boxWidth = 70;
float boxHeight = 50;
float thickness = 3;
// Other Dimension variables
float jointHeight = boxHeight / 5;
float endPieceLength = boxWidth - (thickness * 2);

// Colors
final color STANDARD_GREY = #757575;
final color LIGHT_GREY = #A4A4A4;
final color HEADING_LIGHT_GREY = #7D7D7D;
final color HEADING_DARK_GREY = #1C1C1C;
final color TRIM_GREY = #8C8C8C;
final color TEXT_WHITE = #FAFAFA;
final color CANCEL_RED = #E53935;
final color GEO_GREEN = #00FF00;

// Global Variables
float globalYRotate = 0;                          // The rotation applied to the geometry every frame, used for auto rotate

// Declaring Objects
Graphic_Context_3D_Container container3D;

void setup() {
  frameRate(60);
  size(1280, 720, P3D); // Width, height, and depth of screen

  // Initialising Objects
  container3D = new Graphic_Context_3D_Container();
}

void draw() {
  background(0);
  container3D.draw();
}
