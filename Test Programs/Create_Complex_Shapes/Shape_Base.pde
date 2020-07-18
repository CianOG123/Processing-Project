/**
 *  Interface that all shapes must follow.
 *  Created using examples as a source.
 *  By Cian O'Gorman 16-07-2020.
 */
interface Shape_Base {
  
  // Constants
  static final color SHAPE_COLOR = #00FF00;      // color of the shape
  static final int STROKE_WEIGHT = 1;            // Stroke weight of the shape
  
  // Draws the shape to the screen
  void display();
  
  // Updates the dimensions of the shape
  void update();
  
  // Plots the vertices of the shape 
  void plotShape();
}
