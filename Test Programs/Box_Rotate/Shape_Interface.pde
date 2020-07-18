/**
 *  Interface that all shapes must follow.
 *  Created using examples as a source.
 *  By Cian O'Gorman 16-07-2020.
 */
interface Shape_Interface {

  // Constants
  static final color SHAPE_COLOR = #00FF00;      // color of the shape
  static final float STROKE_WEIGHT = 1.2;        // Stroke weight of the shape
  
  // Sets the stroke, stroke weight, and other appearance settings of the shape
  void initialise(PShape shape);

  // Draws the shape to the screen (functions as draw loop)
  void display(boolean updateBoolean, PShape shape);

  // Updates the dimensions of the shape if the update boolean is set to true
  void update(boolean updateBoolean);

  // Plots the vertices of the shape 
  void plotShape(PShape shape);
}
