class Graphic_Context_3D_Container {

  // Object declaration
  PGraphics graphicContainer;    // The 3D Graphic Context that the 3D geometry are displayed in

  // Declaring 3D transform variables and constants
  private final float GLOBAL_X_ROTATE = radians(-15);       // The amount of degrees the graphic context is shifted, giving the appearance of looking down onto the 3D geometry
  private float globalYRotate = 0;                          // The rotation applied to the geometry every frame, used for auto rotate

  Graphic_Context_3D_Container() {
    graphicContainer = createGraphics(width, height, P3D);
    sidePieceOne.setGraphicalContext(graphicContainer);
    sidePieceTwo.setGraphicalContext(graphicContainer);
    endPieceOne.setGraphicalContext(graphicContainer);
    endPieceTwo.setGraphicalContext(graphicContainer);
  }

  void draw() {
    // Drawing within the graphic container
    graphicContainer.beginDraw();
    graphicContainer.background(111);
    pushMatrix();

    // Move the world view coordinates [0,0,0] to the centre of the display.
    // Moves the spawn point of the shape (world origin) to where you want it to be drawn.
    translate((width / 2), (height / 2), 400);

    // Rotate the graphics context so we view the shape from different angles making it appear to be tumbling.
    rotateX(GLOBAL_X_ROTATE);
    globalYRotate -= 0.008;
    rotateY(globalYRotate);

    // Moves the origin so the box rotates in the centre of the screen
    translate(-(boxLength / 2), 0, (boxWidth / 2));

    // Render side piece one
    sidePieceOne.draw();

    // Render side piece two
    pushMatrix();
    translate(0, 0, -(boxWidth + thickness)); // Moving the graphics context on the z axis 
    sidePieceTwo.draw();
    popMatrix();

    // Render end piece one
    pushMatrix();
    rotateY(radians(90));                     // Rotating the graphic context 90 degrees
    endPieceOne.draw();
    popMatrix();

    // Render end piece Two
    pushMatrix();
    rotateY(radians(90));                     // Rotating the graphic context 90 degrees
    translate(0, 0, (boxLength - thickness)); // Translating on the local z axis.
    endPieceTwo.draw();
    popMatrix();

    popMatrix();
    graphicContainer.endDraw();
    
    // Drawing the graphic container to the screen
    image(graphicContainer, -350, 0);
  }
}
