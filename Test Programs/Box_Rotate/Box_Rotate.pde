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
float yRotate, zRotate;  // Used to rotate the graphic context of the box on the x, y, z axis
float xTrans, yTrans, zTrans;     // Used to translate the graphic context of the box on the x, y, z axis
float xTransSlope = 1, yTransSlope = 1, zTransSlope = 1;
float xScale, yScale, zScale;
float xScaleSlope = 0.4, yScaleSlope = 0.4, zScaleSlope = 0.4;


// Declaring 3D Objects
Shape_Side_Piece sidePieceOne;
Shape_Side_Piece sidePieceTwo;
Shape_End_Piece endPieceOne;
Shape_End_Piece endPieceTwo;

void setup() {
  size(600, 600, P3D); // Width, height, and depth of screen

  // Initialising Objects
  sidePieceOne = new Shape_Side_Piece();
  sidePieceTwo = new Shape_Side_Piece();
  endPieceOne = new Shape_End_Piece();
  endPieceTwo = new Shape_End_Piece();
}

void draw() {
  background(0);

  pushMatrix();

  // Move the world view coordinates [0,0,0] to the centre of the display.
  // Moves the spawn point of the shape (world origin) to where you want it to be drawn.
  translate((width / 2), (height / 2));
  
  translate(0, 0, 200);

  // Rotate the graphics context so we view the shape from different angles making it appear to be tumbling.
  rotateX(xRotate);
  yRotate -= 0.008;
  rotateY(yRotate);
  rotateZ(zRotate);

  // Moves the origin so the box rotates in the centre of the screen
  translate(-(boxLength / 2), 0, (boxWidth / 2));
  

  // Render side piece one
  sidePieceOne.draw();

  // Render side piece two
  pushMatrix();
  translate(0, 0, -(boxWidth + thickness));     // Moving the graphics context on the z axis 
  sidePieceTwo.draw();
  popMatrix();

  // Render end piece one
  pushMatrix();
  rotateY(radians(90));      // Rotating the graphic context 90 degrees
  endPieceOne.draw();
  popMatrix();

  // Render end piece Two
  pushMatrix();
  rotateY(radians(90));      // Rotating the graphic context 90 degrees
  translate(0, 0, (boxLength - thickness));      // Translating on the local z axis.
  endPieceTwo.draw();
  popMatrix();

  popMatrix();

  // Centre screen rectangle
  //rect(width / 2, height / 2, 10, 10);
}
