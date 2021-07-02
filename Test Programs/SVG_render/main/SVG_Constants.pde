/*
*  This file contains all the variables and constants used in the SVG_Render Class
 *  23-01-2021
 */

// User modifiable variables


boolean constructTop = true;
boolean constructBottom = true;
boolean floorOffsetEnabled = false;
boolean crossExtrudeThroughSideEnabled = true;
boolean centerExtrudeThroughSideEnabled = true;


int displayedBox = 1;

float boxLength = 150;
float boxWidth = 100;
float boxHeight = 50;
float thickness = 3;
float floorOffset = 5;

int jointAmount = 7;

// ----------------------------------------------------------------------------------------------------------------------------------

// Developer modifiable constants

static final boolean ENABLE_GUIDES = false;
static final int CENTER_PIECE_LIMIT = 3;
int MEASUREMENT_TYPE = MILLIMETRE;  // Make this an option in the future

// ----------------------------------------------------------------------------------------------------------------------------------

// Generated Dimension variables

boolean refreshBox = false;
float jointHeight = boxHeight / jointAmount;
float sidePieceLength = boxLength - (thickness * 2);
float endPieceLength = boxWidth - (thickness * 2);
float sidePieceJointLength = (sidePieceLength / 3);
float endPieceJointLength = endPieceLength / 3;
float topPieceJointLength = (boxWidth / 3);
float centerJointLength = ((boxHeight) / 3); 
float[] centerJointPos = new float[CENTER_PIECE_LIMIT];
float[] crossJointPos = new float[CENTER_PIECE_LIMIT];

// ----------------------------------------------------------------------------------------------------------------------------------

// Box being displayed indexes

static final int BOX_OPEN_TOP = 1;
static final int BOX_CLOSED = 2;
static final int BOX_OPEN_THROUGH = 3;
static final int BOX_CENTER_PART = 4;
static final int BOX_CROSS_SECTION = 5;
static final int BOX_RAISED_FLOOR = 6;

// ----------------------------------------------------------------------------------------------------------------------------------

// Measurement Type

static final int PIXEL = 0;
static final int MILLIMETRE = 1;
static final int METRE = 2;
static final int INCH = 3;
static final int FOOT = 4;

// ----------------------------------------------------------------------------------------------------------------------------------

// Booleans

// Construct booleans

//boolean constructTop = false;
//boolean constructBottom = false;
boolean[] constructCenter = new boolean[CENTER_PIECE_LIMIT];
boolean[] constructCross = new boolean[CENTER_PIECE_LIMIT];

// Enable booleans

//boolean floorOffsetEnabled = true;
//boolean crossExtrudeThroughSideEnabled = true;  // When set to true the joints of the centre part will extend through the side of the piece
//boolean centerExtrudeThroughSideEnabled = false;

// ----------------------------------------------------------------------------------------------------------------------------------

// SVG Constants

static final int BOUNDARY = 10;                                       // The distance from the vector to the edge of the image
static final float PIXEL_TO_MILLIMETRE = (129600/45719.994) / 0.75 ;  // Used to convert pixel measurements to millimetre

// ----------------------------------------------------------------------------------------------------------------------------------

// Converted Measurement Variables

float boxLengthC;
float boxWidthC;
float boxHeightC;
float thicknessC;
float floorOffsetC;

float jointHeightC;

float sidePieceLengthC;
float endPieceLengthC;

float sidePieceJointLengthC;
float endPieceJointLengthC;

float centerJointLengthC;

float oddJointLengthC;
float[] centerJointPosC = new float[CENTER_PIECE_LIMIT];  // Contains the x-coord start position of each center piece that inserts into the end piece
float[] crossJointPosC = new float[CENTER_PIECE_LIMIT];    // Contains the x-coord start position of each cross piece that inserts into the side piece

// ----------------------------------------------------------------------------------------------------------------------------------

// Functions

// Converts and updates all svg measurements
public void convertMeasurements() {
  if (MEASUREMENT_TYPE == MILLIMETRE) {
    boxLengthC = boxLength * PIXEL_TO_MILLIMETRE;
    boxWidthC = boxWidth * PIXEL_TO_MILLIMETRE;
    boxHeightC = boxHeight * PIXEL_TO_MILLIMETRE;
    thicknessC = thickness * PIXEL_TO_MILLIMETRE;
    jointHeightC = jointHeight * PIXEL_TO_MILLIMETRE;
    sidePieceLengthC = sidePieceLength * PIXEL_TO_MILLIMETRE;
    endPieceLengthC = endPieceLength * PIXEL_TO_MILLIMETRE;
    endPieceJointLengthC = endPieceJointLength * PIXEL_TO_MILLIMETRE;
    sidePieceJointLengthC = sidePieceJointLength * PIXEL_TO_MILLIMETRE;
    centerJointLengthC = centerJointLength * PIXEL_TO_MILLIMETRE;
    floorOffsetC = floorOffset * PIXEL_TO_MILLIMETRE;
    for (int i = 0; i < crossJointPos.length; i++) {
      crossJointPosC[i] = crossJointPos[i] * PIXEL_TO_MILLIMETRE;
      centerJointPosC[i] = centerJointPos[i] * PIXEL_TO_MILLIMETRE;
    }
  }
}

void initialiseConstructBooleans() {
  for (int i = 0; i < constructCenter.length; i++) {
    constructCenter[i] = true;
    constructCross[i] = true;
  }
  //constructCenter[0] = false;
  //constructCross[0] = false;
}

void setCenterJointPosition() {
  centerJointPos[0] = (boxWidth - thickness) / 2;
  centerJointPos[1] = (boxWidth - thickness) / 2  - (thickness * 3);
  centerJointPos[2] = (boxWidth - thickness) / 2 + (thickness * 3);

  float test = (boxLength - thickness) / 2;
  crossJointPos[0] = test;
  crossJointPos[1] = test  - (thickness * 5);
  crossJointPos[2] = test + (thickness * 5);
}
