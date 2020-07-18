class Graphic_Context_3D_Container {

  PGraphics container;

  Graphic_Context_3D_Container() {
    container = createGraphics(500, 500, P3D);
    sidePieceOne.setGraphicalContext(container);
    sidePieceTwo.setGraphicalContext(container);
    endPieceOne.setGraphicalContext(container);
    endPieceTwo.setGraphicalContext(container);
  }

  void draw() {

    fill(111);
    pushMatrix();

    // Move the world view coordinates [0,0,0] to the centre of the display.
    // Moves the spawn point of the shape (world origin) to where you want it to be drawn.
    translate((width / 2), (height / 2), 400);

    // Rotate the graphics context so we view the shape from different angles making it appear to be tumbling.
    rotateX(xRotate);
    yRotate -= 0.008;
    rotateY(yRotate);
    rotateZ(zRotate);

    // Moves the origin so the box rotates in the centre of the screen
    translate(-(boxLength / 2), 0, (boxWidth / 2));


    // Render side piece one
    sidePieceOne.draw();

    // Render side piece two
    pushMatrix();
    translate(0, 0, -(boxWidth + thickness));     // Moving the graphics context on the z axis 
    sidePieceTwo.draw();
    popMatrix();

    // Render end piece one
    pushMatrix();
    rotateY(radians(90));      // Rotating the graphic context 90 degrees
    endPieceOne.draw();
    popMatrix();

    // Render end piece Two
    pushMatrix();
    rotateY(radians(90));      // Rotating the graphic context 90 degrees
    translate(0, 0, (boxLength - thickness));      // Translating on the local z axis.
    endPieceTwo.draw();
    popMatrix();

    popMatrix();
  }
}
