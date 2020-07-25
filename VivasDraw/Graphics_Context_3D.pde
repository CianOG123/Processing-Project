/** 
 *  The 3D graphical context that all the boxes are drawn in
 *  By Cian O'Gorman 18-07-2020
 */
class Graphic_Context_3D_Container {

  // Variables
  private boolean cursorCross = false;

  // Constants
  private static final int GRAPHIC_CONTAINER_OFFSET = -175;  // offset to create space for GUI on right of screen
  private static final int CONTAINER_WIDTH = 930;
  private static final int CONTAINER_Y_POSITION = 50;

  // Object declaration
  private PGraphics graphicContainer;    // The 3D Graphic Context that the 3D geometry are displayed in
  private Grid_Static grid;              // Grid floor

  // Box Declaration
  private Box_Open_Through boxOpenThrough;

  Graphic_Context_3D_Container() {
    graphicContainer = createGraphics(width, height, P3D);
    boxOpenThrough = new Box_Open_Through(graphicContainer);
    grid = new Grid_Static(graphicContainer);
  }

  private void draw() {
    changeCursor();
    refreshBox();
    draw3DGeometry();
  }

  // Draws all the 3D objects in the container
  private void draw3DGeometry() {

    // Drawing within the graphic container
    graphicContainer.beginDraw();
    {
      graphicContainer.background(VOID_GREY);
      

      graphicContainer.pushMatrix();
      {
        //Global postioning
        // Moving origin to centre of screen
        graphicContainer.translate(width / 2, height / 2);
        graphicContainer.rotateX(GLOBAL_X_ROTATE);
        globalYRotate += Y_ROTATE_SPEED;
        graphicContainer.rotateY(globalYRotate);//

        grid.draw(graphicContainer);
        boxOpenThrough.draw(graphicContainer);
      }
      graphicContainer.popMatrix();
    }
    graphicContainer.endDraw();
    
    // Drawing the graphic container to the screen
    image(graphicContainer, GRAPHIC_CONTAINER_OFFSET, 0);
  }

  // Changes the mouse cursor to the desired shape while over the 3D container
  private void changeCursor() {
    if ((mouseX >= 0) && (mouseX < CONTAINER_WIDTH) && (mouseY >= CONTAINER_Y_POSITION) && (mouseY <= width)) {
      if (cursorCross == false) {
        cursorCross = true;
        cursor(CROSS);
      }
    } else if (cursorCross == true) {
      cursorCross = false;
      cursor(ARROW);
    }
  }

  // Updates the measurements of the box being displayed
  private void refreshBox() {
    if (refreshBox == true) {
      refreshBox = false;
      refreshJointHeight();
      refreshEndPieceLength();
      boxOpenThrough = new Box_Open_Through(graphicContainer);
    }
  }

  // Updates the joint height
  private void refreshJointHeight() {
    jointHeight = boxHeight / jointAmount;
  }

  // Updates the end piece length (excluding joints)
  private void refreshEndPieceLength() {
    endPieceLength = boxWidth - (thickness * 2);
  }
}
