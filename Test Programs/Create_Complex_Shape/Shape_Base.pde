/**
 *  Interface that all shapes must follow.
 *  Created using examples as a source.
 *  By Cian O'Gorman 16-07-2020.
 */
class Shape_Base {
  
  // Constants
  protected static final color SHAPE_COLOR = #00FF00;      // color of the shape
  protected static final int STROKE_WEIGHT = 1;            // Stroke weight of the shape
  
  // Objects
  PShape shape;
  
  void initialiseShape(PShape shape) {
    // Side piece initialisation
    this.shape = shape;
    shape = createShape();
    shape.beginShape();
    shape.stroke(SHAPE_COLOR);
    shape.strokeWeight(STROKE_WEIGHT);
    //sidePiece.noFill();
    shape.noFill();
    plotShape(shape);
    shape.endShape(CLOSE);
  }
  
  // Draws the shape to the screen
  void display(PShape shape){
    
  }
  
  // Updates the dimensions of the shape
  void update(PShape shape){
    
  }
  
  // Plots the vertices of the shape 
  void plotShape(PShape shape){
    
  }
}
