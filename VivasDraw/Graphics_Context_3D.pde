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
  private Box_Center_Part boxCenterPart;
  private Box_Cross_Section boxCrossSection;
  private Box_Raised_Floor boxRaisedFloor;

  private Graphic_Context_3D_Container() {
    graphicContainer = createGraphics(width, height, P3D);

    // Button Initialisation
    checkBox = new Check_Box(-GRAPHIC_CONTAINER_OFFSET + 10, 700, 15, 15, "Enable auto-rotate", GRAPHIC_CONTAINER_OFFSET, graphicContainer);

    // Box Initialisation
    boxClosed = new Box_Closed(graphicContainer);
    boxOpenThrough = new Box_Open_Through(graphicContainer);
    boxOpenTop = new Box_Open_Top(graphicContainer);
    boxCenterPart = new Box_Center_Part(graphicContainer);
    boxCrossSection = new Box_Cross_Section(graphicContainer);
    boxRaisedFloor = new Box_Raised_Floor(graphicContainer);

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

  // Switches the boxes being displayed based on the value stored in the displayedBox variable and draws it to the screen
  private void drawBox() {
    switch (displayedBox) {
    case BOX_OPEN_TOP:
      boxOpenTop.draw(graphicContainer);
      break;
    case BOX_CLOSED:
      boxClosed.draw(graphicContainer);
      break;
    case BOX_OPEN_THROUGH:
      boxOpenThrough.draw(graphicContainer);
      break;
    case BOX_CENTER_PART:
      boxCenterPart.draw(graphicContainer);
      break;
    case BOX_CROSS_SECTION:
      boxCrossSection.draw(graphicContainer);
      break;
    case BOX_RAISED_FLOOR:
      boxRaisedFloor.draw(graphicContainer);
      break;
    default:
      boxOpenTop.draw(graphicContainer);
      break;
    }
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
        drawBox();
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
      refreshEndPieceCenterJointLength();
      refreshTopPieceJointLength();
      boxOpenThrough = new Box_Open_Through(graphicContainer);
      boxOpenTop = new Box_Open_Top(graphicContainer);
      boxClosed = new Box_Closed(graphicContainer);
      boxCenterPart = new Box_Center_Part(graphicContainer);
      boxCrossSection = new Box_Cross_Section(graphicContainer);
      boxRaisedFloor = new Box_Raised_Floor(graphicContainer);
      // Sort Arrays
      crossJointPos = sort(crossJointPos);
      centerJointPos = sort(centerJointPos);
      convertMeasurements();
    }
  }

  // Updates the top piece (end side) joint length
  private void refreshTopPieceJointLength() {
    topPieceJointLength = (boxWidth / 3);
  }

  // Updates the end piece center joint length
  private void refreshEndPieceCenterJointLength() {
    endPieceCenterJointLength = ((boxHeight - (thickness * 2)) / 3);
  }

  // Updates the joint height
  private void refreshJointHeight() {
    jointHeight = boxHeight / jointAmount;
  }

  // Updates the side piece length (excluding joints)
  private void refreshSidePieceLength() {
    sidePieceLength = boxLength - (thickness * 2);
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

  // Converts and updates all svg measurements
  private void convertMeasurements() {
    if (measurementType == MILLIMETRE) {
      boxLengthC = boxLength * PIXEL_TO_MILLIMETRE;
      boxWidthC = boxWidth * PIXEL_TO_MILLIMETRE;
      boxHeightC = boxHeight * PIXEL_TO_MILLIMETRE;
      thicknessC = thickness * PIXEL_TO_MILLIMETRE;
      jointHeightC = jointHeight * PIXEL_TO_MILLIMETRE;
      sidePieceLengthC = sidePieceLength * PIXEL_TO_MILLIMETRE;
      endPieceLengthC = endPieceLength * PIXEL_TO_MILLIMETRE;
      endPieceJointLengthC = endPieceJointLength * PIXEL_TO_MILLIMETRE;
      sidePieceJointLengthC = sidePieceJointLength * PIXEL_TO_MILLIMETRE;
      endPieceCenterJointLengthC = endPieceCenterJointLength * PIXEL_TO_MILLIMETRE;
      floorOffsetC = floorOffset * PIXEL_TO_MILLIMETRE;
      for (int i = 0; i < crossJointPos.length; i++) {
        crossJointPosC[i] = crossJointPos[i] * PIXEL_TO_MILLIMETRE;
        centerJointPosC[i] = centerJointPos[i] * PIXEL_TO_MILLIMETRE;
      }
    }
  }
}
