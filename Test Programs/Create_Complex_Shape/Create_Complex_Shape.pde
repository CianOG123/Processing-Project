/**
 *  Test program to draw a complex shape to the screen.
 *  Created using examples as a source.
 *  By Cian O'Gorman 16-07-2020.
 */

// Importing necessary libraries
import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.org.apache.commons.math.*;
import shapes3d.org.apache.commons.math.geometry.*;
import shapes3d.path.*;
import shapes3d.utils.*;

// Declaring variables
float xRotate, yRotate, zRotate;  // Used to rotate the graphic context of the box on the x, y, z axis
float xTrans, yTrans, zTrans;     // Used to translate the graphic context of the box on the x, y, z axis
float xTransSlope = 1, yTransSlope = 1, zTransSlope = 1;
float xScale, yScale, zScale;
float xScaleSlope = 0.4, yScaleSlope = 0.4, zScaleSlope = 0.4;


// Declaring 3D Objects
Shape_Side_Piece sidePiece;

void setup() {
  size(600, 600, P3D); // Width, height, and depth of screen
  
  // Initialising Objects
  sidePiece = new Shape_Side_Piece();
  
}

void draw() {
  background(0);

  pushMatrix();
  
  // Move the world view coordinates [0,0,0] to the centre of the display.
  // Moves the spawn point of the shape (world origin) to where you want it to be drawn.
  translate(xTrans + (width / 2), yTrans + (height / 2), zTrans);

  // Rotate the graphics context so we view the shape from different angles making it appear to be tumbling.
  xRotate += 0.01;
  yRotate += 0.02;
  zRotate += 0.02;
  rotateX(xRotate);
  rotateY(yRotate);
  rotateZ(zRotate);

  // Render the shape on the main display area
  sidePiece.display();
  
  popMatrix();
}
