/** 
 *  Super class designed for all static shapes. There is no 
 *  intention to create dynamic geometry, however another superclass 
 *  could be made for that reason if necessary in the future.
 *  This class implements the shape interface.
 *  By Cian O'Gorman 18-07-2020
 */
class Shape_Super_Template_Static implements Shape_Interface {

  // Objects
  PGraphics graphicContext;        // The graphical context in which the shape is placed

  void setGraphicContext(PGraphics graphicContext) {
    this.graphicContext = graphicContext;
  }

  void initialise(PShape shape) {
    shape.stroke(SHAPE_COLOR);
    shape.strokeWeight(STROKE_WEIGHT);
    shape.noFill();
  }

  void display(boolean updateBoolean, PShape shape) {
    update(updateBoolean);
    shape.draw(getGraphics());
  }

  //TODO
  void update(boolean updateBoolean) {
    if (updateBoolean == true) {
      updateBoolean = false;
    }
  }

  void plotShape(PShape shape) {
  }
}
