/** 
 *  The 3D graphical context that all the boxes are drawn in
 *  By Cian O'Gorman 18-07-2020
 */
private class Graphic_Context_3D_Container {

  // Variables
  private boolean cursorCross = false;

  // Constants
  private static final int GRAPHIC_CONTAINER_OFFSET = -175;  // offset to create space for GUI on right of screen
  private static final int CONTAINER_WIDTH = 930;
  private static final int CONTAINER_Y_POSITION = 50;

  // Object declaration
  private Camera camera;
  private PGraphics graphicContainer;    // The 3D Graphic Context that the 3D geometry are displayed in
  private Grid_Static grid;              // Grid floor

  // Button Declaration
  Check_Box checkBox;

  // Box Declaration
  private Box_Open_Through boxOpenThrough;
  private Box_Open_Top boxOpenTop;
  private Box_Closed boxClosed;

  private Graphic_Context_3D_Container() {
    graphicContainer = createGraphics(width, height, P3D);

    // Button Initialisation
    checkBox = new Check_Box(-GRAPHIC_CONTAINER_OFFSET + 10, 700, 15, 15, "Enable auto-rotate", GRAPHIC_CONTAINER_OFFSET, graphicContainer);

    // Box Initialisation
    boxClosed = new Box_Closed(graphicContainer);
    boxOpenThrough = new Box_Open_Through(graphicContainer);
    boxOpenTop = new Box_Open_Top(graphicContainer);
    // Grid Initialisation
    grid = new Grid_Static(graphicContainer);

    // Camera Initialisation
    camera = new Camera(graphicContainer);
  }

  private void draw() {
    changeCursor();
    refreshBox();
    draw3DGeometry();
  }

  // Draws all the 3D objects in the container
  private void draw3DGeometry() {

    // Drawing 3D elements within the graphic context
    graphicContainer.beginDraw();
    {
      graphicContainer.background(VOID_GREY);

      graphicContainer.pushMatrix();
      {
        //Global postioning
        // Moving origin to centre of screen
        graphicContainer.translate(width / 2, height / 2);
        graphicContainer.rotateX(GLOBAL_X_ROTATE);
        camera.draw();
        grid.draw(graphicContainer);
        boxClosed.draw(graphicContainer);
        //boxOpenTop.draw(graphicContainer);
        //boxOpenThrough.draw(graphicContainer);
      }
      graphicContainer.popMatrix();
    }
    graphicContainer.endDraw();

    // Drawing 2D elements (HUD)
    graphicContainer.beginDraw();
    {
      checkBox.draw(graphicContainer);
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
      refreshEndPieceJointLength();
      refreshSidePieceLength();
      refreshSidePieceJointLength();
      boxOpenThrough = new Box_Open_Through(graphicContainer);
      boxOpenTop = new Box_Open_Top(graphicContainer);
      boxClosed = new Box_Closed(graphicContainer);
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

  // Updates the end piece joint length
  private void refreshEndPieceJointLength() {
    endPieceJointLength = endPieceLength / 3;
  }

  // Updates the side piece joint length
  private void refreshSidePieceJointLength() {
    sidePieceJointLength = (sidePieceLength / 3);
  }

  // Updates the side piece length (excluding joints)
  private void refreshSidePieceLength() {
    sidePieceLength = boxLength - (thickness * 2);
  }
}
