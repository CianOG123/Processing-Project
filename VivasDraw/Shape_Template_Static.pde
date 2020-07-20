/** 
 *  Super class designed for all static shapes.
 *  This class implements the shape interface.
 *  By Cian O'Gorman 18-07-2020
 */
class Shape_Template_Static implements Shape_Interface {

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

  void display(boolean updateBoolean, PShape shape) {
    update(updateBoolean);
    shape.draw(getGraphics());
  }

  void display(PShape shape) {
    shape.draw(getGraphics());
  }

  //TODO
  void update(boolean updateBoolean) {
    if (updateBoolean == true) {
      updateBoolean = false;
    }
  }

  void plotShape(PShape shape) {
    println("\nShape override failure.");
  }
}
