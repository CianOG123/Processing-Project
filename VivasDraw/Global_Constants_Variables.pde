/*
*  This file contains all the variables and constants used in the SVG_Render Class
 *  23-01-2021
 */

// User modifiable variables


boolean constructTop = true;
boolean constructBottom = true;
boolean floorOffsetEnabled = true;
boolean crossExtrudeThroughSideEnabled = true;
boolean centerExtrudeThroughSideEnabled = true;


int displayedBox = 1;

float boxLength = 300;
float boxWidth = 300;
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
    constructCenter[i] = false;
    constructCross[i] = false;
  }
  constructCenter[0] = true;
  constructCross[0] = true;
}

void disableCenterPieces() {
  for (int i = 0; i < constructCenter.length; i++) {
    constructCenter[i] = false;
  }
}

void disableCrossPieces() {
  for (int i = 0; i < constructCenter.length; i++) {
    constructCross[i] = false;
  }
}

void setCenterJointPosition() {
  centerJointPos[0] = (boxWidth - thickness) / 2;
  centerJointPos[1] = (boxWidth - thickness) / 2  - (thickness * 8);
  centerJointPos[2] = (boxWidth - thickness) / 2 + (thickness * 8);

  float test = (boxLength - thickness) / 2;
  crossJointPos[0] = test;
  crossJointPos[1] = test  - (thickness * 7.7);
  crossJointPos[2] = test + (thickness * 7.7);
}

// Variables

// Translation Variables
float globalYRotate = 0;     // The rotation applied to the geometry every frame, used for auto rotate
float accumulatedScroll = 15;  // Accumulates the scroll of the users mouse
int scrollSlope = 0;           // If the scroll is increasing or decreasing

// -------------------------------------------------------------------------------------------------------------------------------

// Booleans
boolean inputEnabledElseWhere = false;  // set to true if text input is enalbed anywhere, used to stop the user typing in two boxes at once

// Button Events
boolean buttonAutoRotate = false;  // Set to true if the auto rotate checkbox has been pressed

// -------------------------------------------------------------------------------------------------------------------------------

// Constants

// GUI Top button events
static final int EVENT_NULL = 0;
static final int BUTTON_EXPORT = 1;

// Length type
static final int LENGTH = 1;
static final int WIDTH = 2;
static final int HEIGHT = 3;
static final int THICKNESS = 4;
static final int FLOOR_OFFSET = 5;
static final int JOINT_AMOUNT = 6;

// 3D translation constants
static final int GRAPHIC_CONTEXT_VERTICLE_POSITION = 400;  // The larger the number, the higher on the screen all 3D geometry will appear
final float GLOBAL_X_ROTATE = radians(-15);                // The amount of degrees the graphic context is shifted, giving the appearance of looking down onto the 3D geometry
static final float Y_ROTATE_SPEED = 0.005;                 // The amount of radians the box will rotate every frame if the auto rotate function is on

// -------------------------------------------------------------------------------------------------------------------------------

// GUI Constants

// Colors
static final color STANDARD_GREY = #757575;
static final color LIGHT_GREY = #A4A4A4;
static final color VOID_GREY = #3D3D3D;
static final color HEADING_LIGHT_GREY = #7D7D7D;
static final color HEADING_DARK_GREY = #1C1C1C;
static final color TRIM_GREY = #8C8C8C;
static final color TEXT_WHITE = #FAFAFA;
static final color CANCEL_RED = #E53935;
static final color GEO_GREEN = #00FF00;

// Gradient
static final int X_AXIS = 0;
static final int Y_AXIS = 1;

// Fonts
PFont robotoLight25;
PFont robotoLight13;
PFont robotoLight15;
PFont robotoLight16;
PFont robotoLight20;

void initialiseFonts() {
  robotoLight25 = loadFont("Roboto-Light-25.vlw");
  robotoLight15 = loadFont("Roboto-Light-15.vlw");
  robotoLight16 = loadFont("Roboto-Light-16.vlw");
  robotoLight20 = loadFont("Roboto-Light-20.vlw");
  robotoLight13 = loadFont("Roboto-Light-13.vlw");
}
