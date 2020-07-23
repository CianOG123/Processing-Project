/** 
 *  Draws the grid to the screen
 *  By Cian O'Gorman 18-07-2020
 */
class Grid_Static extends Shape_Template_Static {

  // Constants
  private static final float GRID_LENGTH = 500;              // The size of the entire grid
  private final float GRID_SQUARE_LENGTH = GRID_LENGTH / 5;  // The size of a grid square

  // Object initialisation
  private PShape gridStatic;

  Grid_Static(PGraphics graphicContext) {
    setGraphicContext(graphicContext);
    gridStatic = createShape();
    gridStatic.beginShape(LINES);      // Draws the vertices as lines between every other pair of vertices
    initialise(gridStatic);
    plotShape(gridStatic);
    gridStatic.endShape();
  }


  @Override
    void initialise(PShape gridStatic) {
    gridStatic.stroke(LIGHT_GREY);
    gridStatic.strokeWeight(STROKE_WEIGHT);
    gridStatic.noFill();
  }

  private void draw() {
    pushMatrix();
    {
      // Centering object on origin
      translate(-(GRID_LENGTH / 2), (boxHeight / 2), -(GRID_LENGTH / 2));

      display(gridStatic);
    }
    popMatrix();
  }

  @Override
    void plotShape(PShape shape) {
    gridStatic.vertex(0, 0, GRID_SQUARE_LENGTH);
    gridStatic.vertex(GRID_LENGTH, 0, GRID_SQUARE_LENGTH);
    gridStatic.vertex(0, 0, (GRID_SQUARE_LENGTH * 2));
    gridStatic.vertex(GRID_LENGTH, 0, (GRID_SQUARE_LENGTH * 2));
    gridStatic.vertex(0, 0, (GRID_SQUARE_LENGTH * 3));
    gridStatic.vertex(GRID_LENGTH, 0, (GRID_SQUARE_LENGTH * 3));
    gridStatic.vertex(0, 0, (GRID_SQUARE_LENGTH * 4));
    gridStatic.vertex(GRID_LENGTH, 0, (GRID_SQUARE_LENGTH * 4));

    gridStatic.vertex(GRID_SQUARE_LENGTH, 0, 0);
    gridStatic.vertex(GRID_SQUARE_LENGTH, 0, GRID_LENGTH);
    gridStatic.vertex((GRID_SQUARE_LENGTH * 2), 0, 0);
    gridStatic.vertex((GRID_SQUARE_LENGTH * 2), 0, GRID_LENGTH);
    gridStatic.vertex((GRID_SQUARE_LENGTH * 3), 0, 0);
    gridStatic.vertex((GRID_SQUARE_LENGTH * 3), 0, GRID_LENGTH);
    gridStatic.vertex((GRID_SQUARE_LENGTH * 4), 0, 0);
    gridStatic.vertex((GRID_SQUARE_LENGTH * 4), 0, GRID_LENGTH);
  }
}
