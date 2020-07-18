/**
 *  Test program to draw multiple complex shapes to the screen.
 *  Created using examples as a source.
 *  By Cian O'Gorman 17-07-2020.
 */

// Importing necessary libraries
import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.org.apache.commons.math.*;
import shapes3d.org.apache.commons.math.geometry.*;
import shapes3d.path.*;
import shapes3d.utils.*;

// User modifiable dimension variables
float boxLength = 130;
float boxWidth = 70;
float boxHeight = 50;
float thickness = 3;
// Other Dimension variables
float jointHeight = boxHeight / 5;
float endPieceLength = boxWidth - (thickness * 2);

// Declaring 3D transform variables
float xRotate = radians(-15);
float yRotate, zRotate;

// Declaring 3D Objects
Shape_Side_Piece sidePieceOne;
Shape_Side_Piece sidePieceTwo;
Shape_End_Piece endPieceOne;
Shape_End_Piece endPieceTwo;
Graphic_Context_3D_Container container3D;

void setup() {
  size(1280, 720, P3D); // Width, height, and depth of screen

  // Initialising Objects
  sidePieceOne = new Shape_Side_Piece();
  sidePieceTwo = new Shape_Side_Piece();
  endPieceOne = new Shape_End_Piece();
  endPieceTwo = new Shape_End_Piece();
  container3D = new Graphic_Context_3D_Container();
}

void draw() {
  background(0);
  container3D.draw();
}
