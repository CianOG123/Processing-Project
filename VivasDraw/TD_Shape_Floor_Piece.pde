/**
 *  Class that can plot and draw a floor/top piece to the screen.
 *  By Cian O'Gorman 16-07-2020.
 */
private class TD_Shape_Floor_Piece extends TD_Shape_Template {

  // Objects
  private PShape floorPiece;                // Declaring the side piece shape

  TD_Shape_Floor_Piece() {
    floorPiece = createShape();
    floorPiece.beginShape(TRIANGLE_STRIP);
    initialise(floorPiece);
    plotShape(floorPiece);
    floorPiece.endShape(CLOSE);
  }

  private void draw() {
    display(floorPiece);
  }

    void plotShape(PShape shape) {

    floorPiece.vertex(0, 0, 0);
    floorPiece.vertex(0, thickness, 0);


    floorPiece.vertex(sidePieceJointLength, 0, 0);
    floorPiece.vertex(sidePieceJointLength, thickness, 0);

    floorPiece.vertex(sidePieceJointLength, 0, -thickness);
    floorPiece.vertex(sidePieceJointLength, thickness, -thickness);

    floorPiece.vertex((sidePieceJointLength * 2), 0, -thickness); 
    floorPiece.vertex((sidePieceJointLength * 2), thickness, -thickness); 

    floorPiece.vertex((sidePieceJointLength * 2), 0, 0); 
    floorPiece.vertex((sidePieceJointLength * 2), thickness, 0); 


    floorPiece.vertex(sidePieceLength, 0, 0); 
    floorPiece.vertex(sidePieceLength, thickness, 0);

    floorPiece.vertex(sidePieceLength, 0, endPieceJointLength); 
    floorPiece.vertex(sidePieceLength, thickness, endPieceJointLength); 

    floorPiece.vertex((sidePieceLength + thickness), 0, endPieceJointLength); 
    floorPiece.vertex((sidePieceLength + thickness), thickness, endPieceJointLength); 

    floorPiece.vertex((sidePieceLength + thickness), 0, (endPieceJointLength * 2)); 
    floorPiece.vertex((sidePieceLength + thickness), thickness, (endPieceJointLength * 2)); 

    floorPiece.vertex(sidePieceLength, 0, (endPieceJointLength * 2)); 
    floorPiece.vertex(sidePieceLength, thickness, (endPieceJointLength * 2)); 


    floorPiece.vertex(sidePieceLength, 0, endPieceLength); 
    floorPiece.vertex(sidePieceLength, thickness, endPieceLength); 

    floorPiece.vertex((sidePieceJointLength * 2), 0, endPieceLength); 
    floorPiece.vertex((sidePieceJointLength * 2), thickness, endPieceLength);

    floorPiece.vertex((sidePieceJointLength * 2), 0, endPieceLength + thickness); 
    floorPiece.vertex((sidePieceJointLength * 2), thickness, endPieceLength + thickness);

    floorPiece.vertex(sidePieceJointLength, 0, endPieceLength + thickness); 
    floorPiece.vertex(sidePieceJointLength, thickness, endPieceLength + thickness); 

    floorPiece.vertex(sidePieceJointLength, 0, endPieceLength);
    floorPiece.vertex(sidePieceJointLength, thickness, endPieceLength);


    floorPiece.vertex(0, 0, endPieceLength); 
    floorPiece.vertex(0, thickness, endPieceLength);

    floorPiece.vertex(0, 0, (endPieceJointLength * 2)); 
    floorPiece.vertex(0, thickness, (endPieceJointLength * 2));

    floorPiece.vertex(-thickness, 0, (endPieceJointLength * 2)); 
    floorPiece.vertex(-thickness, thickness, (endPieceJointLength * 2));

    floorPiece.vertex(-thickness, 0, endPieceJointLength); 
    floorPiece.vertex(-thickness, thickness, endPieceJointLength);

    floorPiece.vertex(0, 0, endPieceJointLength); 
    floorPiece.vertex(0, thickness, endPieceJointLength);


    floorPiece.vertex(0, 0, 0); 
    floorPiece.vertex(0, thickness, 0);
  }
}
