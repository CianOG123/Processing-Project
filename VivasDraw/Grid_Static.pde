/** 
 *  Draws the grid to the screen
 *  By Cian O'Gorman 18-07-2020
 */
class Grid_Static extends Shape_Template_Static {

  // Object initialisation
  PShape gridStatic;

  Grid_Static(PGraphics graphicContext) {
    setGraphicContext(graphicContext);
    gridStatic = createShape();
    gridStatic.beginShape();
    initialise(gridStatic);
    plotShape(gridStatic);
    gridStatic.endShape(CLOSE);
  }


  @Override
    void initialise(PShape gridStatic) {
    gridStatic.stroke(255);
    gridStatic.strokeWeight(STROKE_WEIGHT);
    gridStatic.noFill();
  }

  void draw() {
    pushMatrix();

    translate((width / 2), (height / 2));
    translate(-15, 200);
    display(gridStatic);
    popMatrix();
  }

  @Override
    void plotShape(PShape shape) {
    beginShape(TRIANGLES);
    gridStatic.vertex(30, 75);
    gridStatic.vertex(40, 20);
    gridStatic.vertex(50, 75);
    gridStatic.vertex(60, 20);
    gridStatic.vertex(70, 75);
    gridStatic.vertex(80, 20);
    endShape();
  }
}
