// Creates and Renders an SVG Top / Floor Piece to a given canvas
class SVG_Top_Piece extends SVG_Shape {

  // Measurements
  float pieceTop = yOffset + thicknessC;
  float pieceBottom = yOffset + boxWidthC - thicknessC;
  float pieceLeft = xOffset + thicknessC;
  float pieceRight = xOffset + boxLengthC - thicknessC;

  float complexTop = pieceTop  + endPieceJointLengthC;
  float complexBottom = pieceBottom - endPieceJointLengthC;
  float complexLeft = pieceLeft + sidePieceJointLengthC;
  float complexRight = pieceRight - sidePieceJointLengthC;

  float[] verticalIslandPoints;
  float[] horizontalIslandPoints;

  SVG_Top_Piece(PGraphics svg, int xOffset, int yOffset) {
    super(svg, xOffset, yOffset); 
    drawExterior();
    drawSlots();
  }

  // Draws the Top Piece Center Slots
  private void drawSlots() {
    boolean drawCenterSlots = false;
    boolean drawCrossSlots = false;
    for (int i = 0; i < constructCenter.length; i++) {
      if (constructCenter[i] == true)
        drawCenterSlots = true;
    }
    for (int i = 0; i < constructCross.length; i++) {
      if (constructCross[i] == true)
        drawCrossSlots = true;
    }
    if (drawCenterSlots == true && drawCrossSlots == true) {
      drawComplexCenterSlots();
      drawComplexCrossSlots();
      closeVerticalIslandLines();
      closeHorizontalIslandLines();
      drawCrossSingleSlots();
      drawCenterSingleSlots();
      drawComplexCenterCaps();
      drawComplexCrossCaps();
    }
    else if(drawCenterSlots == true){
      drawCenterSlots();
    }
    else if(drawCrossSlots == true){
      drawCrossSlots();
    }
  }
  
  // Draws center slots on their own without other joints
  private void drawCrossSlots(){
    for(int i = 0; i < constructCross.length; i++){
      if(constructCross[i] == true){
        svg.line(crossJointPosC[i] + xOffset, endPieceJointLengthC + yOffset, crossJointPosC[i] + thicknessC + xOffset, endPieceJointLengthC + yOffset);
        svg.line(crossJointPosC[i] + thicknessC + xOffset, endPieceJointLengthC + yOffset, crossJointPosC[i] + thicknessC + xOffset, endPieceJointLengthC * 2 + yOffset);
        svg.line(crossJointPosC[i] + thicknessC + xOffset, endPieceJointLengthC * 2 + yOffset, crossJointPosC[i] + xOffset, endPieceJointLengthC * 2 + yOffset);
        svg.line(crossJointPosC[i] + xOffset, endPieceJointLengthC * 2 + yOffset, crossJointPosC[i] + xOffset, endPieceJointLengthC + yOffset);
      }
    }
  }
  
  // Draws cross slots on their own without other joints
  private void drawCenterSlots(){
    for(int i = 0; i < constructCenter.length; i++){
      if(constructCenter[i] == true){
        svg.line(sidePieceJointLengthC + thicknessC + xOffset, centerJointPosC[i] + yOffset, sidePieceJointLengthC * 2 + thicknessC + xOffset, centerJointPosC[i] + yOffset);
        svg.line(sidePieceJointLengthC * 2 + thicknessC + xOffset, centerJointPosC[i] + yOffset, sidePieceJointLengthC * 2 + thicknessC + xOffset, centerJointPosC[i] + thicknessC + yOffset);
        svg.line(sidePieceJointLengthC * 2 + thicknessC + xOffset, centerJointPosC[i] + thicknessC + yOffset, sidePieceJointLengthC + thicknessC + xOffset, centerJointPosC[i] + thicknessC + yOffset);
        svg.line(sidePieceJointLengthC + thicknessC + xOffset, centerJointPosC[i] + thicknessC + yOffset, sidePieceJointLengthC + thicknessC + xOffset, centerJointPosC[i] + yOffset);
      }
    }
  }

  // Draws all center slot caps in the complex area
  private void drawComplexCrossCaps() {
    boolean drawTopCaps = true;
    boolean drawBottomCaps = true;
    for (int i = 0; i < centerJointPosC.length; i++) {
      if (centerJointPosC[i] + yOffset < complexTop && centerJointPosC[i] + thicknessC + yOffset > complexTop) {
        drawTopCaps = false;
      }
      if (centerJointPosC[i] + yOffset < complexBottom && centerJointPosC[i] + thicknessC + yOffset > complexBottom) {
        drawBottomCaps = false;
      }
    }
    for (int i = 0; i < crossJointPosC.length; i++) {
      if (constructCross[i] == true) {
        if (crossJointPosC[i] + thicknessC + xOffset > complexLeft && crossJointPosC[i] + xOffset < complexRight) {
          float startPoint = complexLeft;
          float endPoint = complexRight;
          if (drawTopCaps == true) {
            if (crossJointPosC[i] + xOffset > complexLeft) {
              startPoint = crossJointPosC[i] + xOffset;
            }
            if (crossJointPosC[i] + thicknessC + xOffset < complexRight) {
              endPoint = crossJointPosC[i] + thicknessC + xOffset;
            }
            svg.line(startPoint, complexTop, endPoint, complexTop);
          }
          if (drawBottomCaps == true) {
            if (crossJointPosC[i] + xOffset > complexLeft) {
              startPoint = crossJointPosC[i] + xOffset;
            }
            if (crossJointPosC[i] + thicknessC + xOffset < complexRight) {
              endPoint = crossJointPosC[i] + thicknessC + xOffset;
            }
            svg.line(startPoint, complexBottom, endPoint, complexBottom);
          }
        }
      }
    }
  }

  // Draws all center slot caps in the complex area
  private void drawComplexCenterCaps() {
    boolean drawLeftCaps = true;
    boolean drawRightCaps = true;
    for (int i = 0; i < crossJointPosC.length; i++) {
      if (crossJointPosC[i] + xOffset < complexLeft && crossJointPosC[i] + thicknessC + xOffset > complexLeft) {
        drawLeftCaps = false;
      }
      if (crossJointPosC[i] + xOffset < complexRight && crossJointPosC[i] + thicknessC + xOffset > complexRight) {
        drawRightCaps = false;
      }
    }
    for (int i = 0; i < centerJointPosC.length; i++) {
      if (constructCenter[i] == true) {
        if (centerJointPosC[i] + thicknessC + yOffset > complexTop && centerJointPosC[i] + yOffset < complexBottom) {
          float startPoint = complexTop;
          float endPoint = complexBottom;
          if (drawLeftCaps == true) {
            if (centerJointPosC[i] + yOffset > complexTop) {
              startPoint = centerJointPosC[i] + yOffset;
            }
            if (centerJointPosC[i] + thicknessC + yOffset < complexBottom) {
              endPoint = centerJointPosC[i] + thicknessC + yOffset;
            }
            svg.line(complexLeft, startPoint, complexLeft, endPoint);
          }
          if (drawRightCaps == true) {
            if (centerJointPosC[i] + yOffset > complexTop) {
              startPoint = centerJointPosC[i] + yOffset;
            }
            if (centerJointPosC[i] + thicknessC + yOffset < complexBottom) {
              endPoint = centerJointPosC[i] + thicknessC + yOffset;
            }
            svg.line(complexRight, startPoint, complexRight, endPoint);
          }
        }
      }
    }
  }

  // Draws all of the cross slots outside of the complex zone
  private void drawCenterSingleSlots() {
    float[] capTop = new float[CENTER_PIECE_LIMIT];
    float[] capBottom = new float[CENTER_PIECE_LIMIT];
    boolean[] drawCap = new boolean[CENTER_PIECE_LIMIT];
    for (int i = 0; i < capTop.length; i++) {
      capTop[i] = complexBottom;
      capBottom[i] = complexTop;
      drawCap[i] = false;
    }    
    for (int i = 0; i < constructCross.length; i++) {
      if (constructCenter[i] == true) {
        float startPoint = complexLeft;
        float nearestPoint = complexRight;
        for (int j = 0; j < horizontalIslandPoints.length + 1; j++) {  
          nearestPoint = getNearestPoint(startPoint, horizontalIslandPoints, complexRight, xOffset);
          // Drawing top Edge
          if (centerJointPosC[i] + yOffset <= complexTop || centerJointPosC[i] + yOffset >= complexBottom) {
            svg.line(startPoint, centerJointPosC[i] + yOffset, nearestPoint, centerJointPosC[i] + yOffset);
            capTop[i] = centerJointPosC[i] + yOffset;
            drawCap[i] = true;
          }
          // Drawing bottom edge
          if (centerJointPosC[i] + thicknessC + yOffset <= complexTop || centerJointPosC[i] + thicknessC + yOffset >= complexBottom) {
            svg.line(startPoint, centerJointPosC[i] + thicknessC + yOffset, nearestPoint, centerJointPosC[i] + thicknessC + yOffset);
            capBottom[i] = centerJointPosC[i] + thicknessC + yOffset;
            drawCap[i] = true;
          }
          startPoint = nearestPoint + thicknessC;
        }

        // Drawing caps
        if (drawCap[i] == true) {
          svg.line(complexLeft, capTop[i], complexLeft, capBottom[i]);
          svg.line(complexRight, capTop[i], complexRight, capBottom[i]);
        }
      }
    }
  }

  // Draws all of the cross slots outside of the complex zone
  private void drawCrossSingleSlots() {
    float[] capLeft = new float[CENTER_PIECE_LIMIT];
    float[] capRight = new float[CENTER_PIECE_LIMIT];
    boolean[] drawCap = new boolean[CENTER_PIECE_LIMIT];
    for (int i = 0; i < capLeft.length; i++) {
      capLeft[i] = complexRight;
      capRight[i] = complexLeft;
      drawCap[i] = false;
    }
    for (int i = 0; i < constructCross.length; i++) {
      if (constructCross[i] == true) {
        float startPoint = complexTop;
        float nearestPoint = complexBottom;
        for (int j = 0; j < verticalIslandPoints.length + 1; j++) {  
          nearestPoint = getNearestPoint(startPoint, verticalIslandPoints, complexBottom, yOffset);
          // Drawing left edge
          if (crossJointPosC[i] + xOffset <= complexLeft || crossJointPosC[i] + xOffset >= complexRight) {
            svg.line(crossJointPosC[i] + xOffset, startPoint, crossJointPosC[i] + xOffset, nearestPoint);
            capLeft[i] = crossJointPosC[i] + xOffset;
            drawCap[i] = true;
          }
          // Drawing right edge
          if (crossJointPosC[i] + thicknessC + xOffset<= complexLeft || crossJointPosC[i] + thicknessC + xOffset >= complexRight) {
            svg.line(crossJointPosC[i] + thicknessC + xOffset, startPoint, crossJointPosC[i] + thicknessC + xOffset, nearestPoint);
            capRight[i] = crossJointPosC[i] + thicknessC + xOffset;
            drawCap[i] = true;
          }
          startPoint = nearestPoint + thicknessC;
        }
        // Drawing caps
        if (drawCap[i] == true) {
          svg.line(capLeft[i], complexTop, capRight[i], complexTop);
          svg.line(capLeft[i], complexBottom, capRight[i], complexBottom);
        }
      }
    }
  }

  // Close vertical island lines
  private void closeVerticalIslandLines() {
    if (verticalIslandPoints != null) {
      for (int i = 0; i < crossJointPosC.length; i++) {
        if (constructCross[i] == true) {
          for (int j = 0; j < verticalIslandPoints.length; j++) {
            svg.line(crossJointPosC[i] + xOffset, verticalIslandPoints[j] + yOffset, crossJointPosC[i] + thicknessC + xOffset, verticalIslandPoints[j] + yOffset);
            svg.line(crossJointPosC[i] + xOffset, verticalIslandPoints[j] + thicknessC+ yOffset, crossJointPosC[i] + thicknessC + xOffset, verticalIslandPoints[j] + thicknessC + yOffset);
          }
        }
      }
    }
  }

  // Close horizontal island lines
  private void closeHorizontalIslandLines() {
    if (horizontalIslandPoints != null) {
      for (int i = 0; i < centerJointPosC.length; i++) {
        if (constructCenter[i] == true) {
          for (int j = 0; j < horizontalIslandPoints.length; j++) {
            svg.line(horizontalIslandPoints[j] + xOffset, centerJointPosC[i] + yOffset, horizontalIslandPoints[j] + xOffset, centerJointPosC[i] + thicknessC + yOffset);
            svg.line(horizontalIslandPoints[j] + thicknessC + xOffset, centerJointPosC[i] + yOffset, horizontalIslandPoints[j] + thicknessC + xOffset, centerJointPosC[i] + thicknessC + yOffset);
          }
        }
      }
    }
  }

  // Draws the vertical slot lines in the complex area
  private void drawComplexCrossSlots() {
    float startPoint = complexTop;
    float endPoint = complexBottom;
    for (int i = 0; i < centerJointPosC.length; i++) {
      if (centerJointPosC[i] + yOffset < complexTop && centerJointPosC[i] + thicknessC + yOffset > complexTop) {
        startPoint = centerJointPosC[i] + thicknessC + yOffset;
      }
      if (centerJointPosC[i] + yOffset < complexBottom && centerJointPosC[i] + thicknessC + yOffset > complexBottom) {
        endPoint = centerJointPosC[i] + yOffset;
      }
    }
    verticalIslandPoints = getMidPoints(centerJointPosC, constructCenter, yOffset, 0, complexTop, complexBottom);
    float[] points = mergePointsArrays(centerJointPosC, verticalIslandPoints);
    float nearestPoint = Float.MIN_VALUE;
    while (nearestPoint != endPoint) {
      nearestPoint = getNearestPoint(startPoint, points, endPoint, yOffset);
      for (int i = 0; i < crossJointPosC.length; i++) {
        if (constructCross[i] == true) {
          if (crossJointPosC[i] + xOffset > complexLeft && crossJointPosC[i] + xOffset < complexRight) {
            svg.line(crossJointPosC[i] + xOffset, startPoint, crossJointPosC[i] + xOffset, nearestPoint);
          }
          if (crossJointPosC[i] + thicknessC + xOffset > complexLeft && crossJointPosC[i] + thicknessC + xOffset < complexRight) {
            svg.line(crossJointPosC[i] + thicknessC + xOffset, startPoint, crossJointPosC[i] + thicknessC + xOffset, nearestPoint);
          }
        }
      }
      startPoint = nearestPoint + thicknessC;
    }
  }

  // Draws the horizontal slot lines in the complex area
  private void drawComplexCenterSlots() {
    float startPoint = complexLeft;
    float endPoint = complexRight;
    for (int i = 0; i < crossJointPosC.length; i++) {
      if (crossJointPosC[i] + xOffset < complexLeft && crossJointPosC[i] + thicknessC + xOffset > complexLeft) {
        startPoint = crossJointPosC[i] + thicknessC + xOffset;
      }
      if (crossJointPosC[i] + xOffset < complexRight && crossJointPosC[i] + thicknessC + xOffset > complexRight) {
        endPoint = crossJointPosC[i] + xOffset;
      }
    }
    horizontalIslandPoints = getMidPoints(crossJointPosC, constructCross, xOffset, 0, complexLeft, complexRight);
    float[] points = mergePointsArrays(crossJointPosC, horizontalIslandPoints);
    float nearestPoint = Float.MIN_VALUE;
    while (nearestPoint != endPoint) {
      nearestPoint = getNearestPoint(startPoint, points, endPoint, xOffset);
      for (int i = 0; i < centerJointPosC.length; i++) {
        if (constructCenter[i] == true) {
          if (centerJointPosC[i] + yOffset > complexTop && centerJointPosC[i] + yOffset < complexBottom) {
            svg.line(startPoint, centerJointPosC[i] + yOffset, nearestPoint, centerJointPosC[i] + yOffset);
          }
          if (centerJointPosC[i] + thicknessC + yOffset > complexTop && centerJointPosC[i] + thicknessC + yOffset < complexBottom) {
            svg.line(startPoint, centerJointPosC[i] + thicknessC + yOffset, nearestPoint, centerJointPosC[i] + thicknessC + yOffset);
          }
        }
      }
      startPoint = nearestPoint + thicknessC;
    }
  }

  // returns all the points in the specified range
  // The points are sorted from min to max
  private float[] getPointsInRange(float[] points, boolean[] enablePoints, float pointsOffset, float startPoint, float endPoint) {
    int pointCount = 0;
    for (int i = 0; i < points.length; i++) {
      if (enablePoints[i] == true) {
        if (points[i] + thicknessC + pointsOffset > startPoint && points[i] + pointsOffset < endPoint) {
          pointCount++;
        }
      }
    }
    if (pointCount > 0) {
      float[] pointsInRange = new float[pointCount];
      int index = 0;
      for (int i = 0; i < points.length; i++) {
        if (enablePoints[i] == true) {
          if (points[i] + thicknessC + pointsOffset > startPoint && points[i] + pointsOffset < endPoint) {
            pointsInRange[index] = points[i];
            index++;
          }
        }
      }
      Arrays.sort(pointsInRange);
      return pointsInRange;
    }
    return null;
  }

  // Combines the two given point arrays into one array and orders them from least to most
  private float[] mergePointsArrays(float[] array1, float[] array2) {
    float[] mergeArray;
    mergeArray = new float[array1.length + array2.length];
    for (int i = 0; i < array1.length; i++) {
      mergeArray[i] = array1[i];
    }
    int index = array1.length;
    for (int i = 0; i < array2.length; i++) {
      mergeArray[index + i] = array2[i];
    }
    Arrays.sort(mergeArray);
    return mergeArray;
  }


  // Gets the points which are midway between given points
  private float[] getMidPoints(float[] points, boolean[] enablePoints, float pointsOffset, float midPointOffset, float startPoint, float endPoint) {
    float[] pointsInRange = getPointsInRange(points, enablePoints, pointsOffset, startPoint, endPoint);
    if (pointsInRange != null && pointsInRange.length != 0) {
      float[] midPoints = new float[pointsInRange.length - 1];
      for (int i = 0; i < midPoints.length; i++) {
        midPoints[i] = (pointsInRange[i + 1] + pointsInRange[i]) / 2;
        midPoints[i] += midPointOffset;
      }
      return midPoints;
    }
    return null;
  }

  // Gets the point in the array that is nearest to the start point and less than the limit.
  // The pointOffset is applied to the point array
  // pointOffset is not applied to the other variables
  private float getNearestPoint(float startPoint, float[] points, float limit, float pointOffset) {
    float minPoint = limit;
    for (int i = 0; i < points.length; i++) {
      if (points[i] + pointOffset < minPoint && points[i] + pointOffset > startPoint) {
        minPoint = points[i] + pointOffset;
      }
    }
    return minPoint;
  }

  // -----------------------------------------------------------------------------------------------------------

  // Draws the exterior for a top piece
  protected void drawExterior() {
    // Top
    //svg.line(leftXPos, topYPos, leftXPos + sidePieceJointLengthC, topYPos);
    svg.beginShape();
    svg.vertex(pieceLeft, pieceTop);
    svg.vertex(pieceLeft + sidePieceJointLengthC, pieceTop);
    svg.vertex(pieceLeft + sidePieceJointLengthC, pieceTop - thicknessC);
    svg.vertex(pieceLeft + (sidePieceJointLengthC * 2), pieceTop - thicknessC);
    svg.vertex(pieceLeft + (sidePieceJointLengthC * 2), pieceTop);

    // Right
    svg.vertex(pieceRight, pieceTop);
    svg.vertex(pieceRight, pieceTop + endPieceJointLengthC);
    svg.vertex(pieceRight + thicknessC, pieceTop + endPieceJointLengthC);
    svg.vertex(pieceRight + thicknessC, pieceTop + (endPieceJointLengthC * 2));
    svg.vertex(pieceRight, pieceTop + (endPieceJointLengthC * 2));

    // Bottom
    svg.vertex(pieceRight, pieceBottom);
    svg.vertex(pieceLeft + (sidePieceJointLengthC * 2), pieceBottom);
    svg.vertex(pieceLeft + (sidePieceJointLengthC * 2), pieceBottom + thicknessC);
    svg.vertex(pieceLeft + sidePieceJointLengthC, pieceBottom + thicknessC);
    svg.vertex(pieceLeft + sidePieceJointLengthC, pieceBottom);
    svg.vertex(pieceLeft, pieceBottom);

    // Left
    svg.vertex(pieceLeft, pieceTop + (endPieceJointLengthC * 2));
    svg.vertex(pieceLeft - thicknessC, pieceTop + (endPieceJointLengthC * 2));
    svg.vertex(pieceLeft - thicknessC, pieceTop + (endPieceJointLengthC * 2));
    svg.vertex(pieceLeft - thicknessC, pieceTop + endPieceJointLengthC);
    svg.vertex(pieceLeft, pieceTop + endPieceJointLengthC);
    svg.endShape(CLOSE);
    drawTopPieceGuide();
  }

  // This function draws guidelines on the svg to show where joints intersect
  // Used by the drawTopPieceTemplate Function
  private void drawTopPieceGuide() {
    if (ENABLE_GUIDES) {
      svg.stroke(color(#FF0000));
      drawDashLine(complexLeft, pieceTop, complexLeft, pieceBottom, 100);
      drawDashLine(complexRight, pieceTop, complexRight, pieceBottom, 100);
      drawDashLine(pieceLeft, complexTop, pieceRight, complexTop, 100);
      drawDashLine(pieceLeft, complexBottom, pieceRight, complexBottom, 100);
      svg.stroke(color(#000000));
    }
  }
}
