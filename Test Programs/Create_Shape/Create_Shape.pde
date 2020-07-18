/**
 *  Test program to draw a simple cube to the screen.
 *  Created using examples as a source.
 *  By Cian O'Gorman 16-07-2020.
 */

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
Box boxShape;  // Declaring a box shape

void setup() {
  size(300, 300, P3D); // Width, height, and depth of screen
  // Box dimensions
  boxShape = new Box(100, 100, 100); // Width, height, and depth of box

  // Box face colour
  boxShape.fill(#800080);  // Makes all sides of the box the same colour
  //boxShape.fill(randomColor(), S3D.FRONT); FRONT, BACK, TOP, BOTTOM, LEFT, RIGHT    // Makes the desired side of the box a certain colour

  // Box edge colour and thickness
  boxShape.stroke(color(#FFA500));
  boxShape.strokeWeight(4);

  // Wire frame or solid
  boxShape.drawMode(S3D.SOLID | S3D.WIRE);  // Currently set to draw edges and draw faces
}

void draw() {
  background(0);

  pushMatrix();
  // Move the world view coordinates [0,0,0] to the centre of the display.
  // Moves the spawn point of the shape to where you want it to be drawn.
  if ((zTrans > 100) || (zTrans < -100)) {
    zTransSlope *= -1;
  }
  if ((xTrans > 50) || (xTrans < -30)) {
    xTransSlope *= -1;
  }
  if ((yTrans > 70) || (yTrans < -40)) {
    yTransSlope *= -1;
  }
  zTrans += zTransSlope;
  xTrans += xTransSlope;
  yTrans += yTransSlope;
  translate(xTrans + (width / 2), yTrans + (height / 2), zTrans);

  // Rotate the graphics context so we view the shape from different angles making it appear to be tumbling.
  xRotate += 0.02;
  yRotate += 0.025;
  zRotate += 0.03;
  rotateX(xRotate);
  rotateY(yRotate);
  rotateZ(zRotate);
  
  // Render the shape on the main display area
  boxShape.draw(getGraphics());
  popMatrix();
}
