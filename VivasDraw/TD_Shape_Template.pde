/** 
 *  Super class designed for all static shapes.
 *  This class implements the shape interface.
 *  By Cian O'Gorman 18-07-2020
 */
private class TD_Shape_Template {

  public static final float STROKE_WEIGHT = 1.2;   // Stroke weight of the shape
  protected PGraphics graphicContext;              // The graphic context in which the shape is placed

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
}
