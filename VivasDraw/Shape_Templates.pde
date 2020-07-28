/**
 *  Interface that all shapes must follow.
 *  Created using examples as a source.
 *  By Cian O'Gorman 16-07-2020.
 */
private abstract interface Shape_Interface {

  // Constants
  public static final float STROKE_WEIGHT = 1.2;        // Stroke weight of the shape
  
  // Sets the graphical context for the shape
  abstract void setGraphicContext(PGraphics graphicContext);
  
  // Sets the stroke, stroke weight, and other appearance settings of the shape
  abstract void initialise(PShape shape);

  // Draws the shape to the screen (functions as draw loop)
  abstract void display(PShape shape);

  // Plots the vertices of the shape 
  abstract void plotShape(PShape shape);
}


/** 
 *  Super class designed for all static shapes.
 *  This class implements the shape interface.
 *  By Cian O'Gorman 18-07-2020
 */
private class Shape_Template_Static implements Shape_Interface {

  // Objects
  protected PGraphics graphicContext;        // The graphic context in which the shape is placed

  void setGraphicContext(PGraphics graphicContext) {
    this.graphicContext = graphicContext;
  }

  void initialise(PShape shape) {
    shape.stroke(GEO_GREEN);
    shape.strokeWeight(STROKE_WEIGHT);
    shape.noFill();
  }

  void display(PShape shape) {
    shape.draw(graphicContext);
  }

  void plotShape(PShape shape) {
    println("\nShape override failure.");
  }
}
