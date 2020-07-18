/** 
 *  The 3D graphical context that all the boxes are drawn in
 *  By Cian O'Gorman 18-07-2020
 */
class Graphic_Context_3D_Container {

  // Object declaration
  PGraphics graphicContainer;    // The 3D Graphic Context that the 3D geometry are displayed in

  // Box Declaration
  Box_Open_Through boxOpenThrough;

  Graphic_Context_3D_Container() {
    graphicContainer = createGraphics(width, height, P3D);
    boxOpenThrough = new Box_Open_Through(graphicContainer);
  }

  void draw() {
    // Drawing within the graphic container
    graphicContainer.beginDraw();
    {
      graphicContainer.background(#A4A4A4);
      boxOpenThrough.draw();
    }
    graphicContainer.endDraw();

    // Drawing the graphic container to the screen
    image(graphicContainer, -350, 0);
  }
}
