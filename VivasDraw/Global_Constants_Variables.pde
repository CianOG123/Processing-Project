// Variables

// User modifiable dimension variables
float boxLength = 200;
float boxWidth = 100;
float boxHeight = 70;
float thickness = 3;
float floorOffset = 30;
int jointAmount = 9;

// Useful Settings
int crossCenterPieceAmount = 3;
int measurementType = MILLIMETRE;
boolean multipleJoints = true;  // When set to true multiple joints will be drawn along the center piece
boolean middleJointExtrude = false;  // When set to true the middle joint of the center piece will be extruded

// Generated Dimension variables
float jointHeight = boxHeight / jointAmount;
boolean refreshBox = false;                           // When set to true, a new box object will be created and measurements will be applied
float endPieceLength = boxWidth - (thickness * 2);
float sidePieceLength = boxLength - (thickness * 2);
float endPieceJointLength = endPieceLength / 3;       // Used to set the starting position of the top and bottom joint
float sidePieceJointLength = (sidePieceLength / 3);
float topPieceJointLength = (boxWidth / 3);
float endPieceCenterJointLength = ((boxHeight - (thickness * 2)) / 3);

// Translation Variables
float globalYRotate = 0;     // The rotation applied to the geometry every frame, used for auto rotate
float accumulatedScroll = 15;  // Accumulates the scroll of the users mouse
int scrollSlope = 0;           // If the scroll is increasing or decreasing

// Converted Measurement Variables
// 'C' is short for convert
float boxLengthC;
float boxWidthC;
float boxHeightC;
float thicknessC;
float jointHeightC;
float sidePieceLengthC;
float endPieceLengthC;
float endPieceJointLengthC;
float sidePieceJointLengthC;
float endPieceCenterJointLengthC;
float oddJointLengthC;
float floorOffsetC;
float[] centerJointPosC = new float[crossCenterPieceAmount];  // Contains the x-coord start position of each center piece that inserts into the end piece
float[] crossJointPosC = new float[crossCenterPieceAmount];    // Contains the x-coord start position of each cross piece that inserts into the side piece

// -------------------------------------------------------------------------------------------------------------------------------

// Booleans
boolean inputEnabledElseWhere = false;  // set to true if text input is enalbed anywhere, used to stop the user typing in two boxes at once

// Construct booleans
boolean constructTop = false;     // A top piece will be constructed when set to true
boolean constructBottom = false;  // A bottom piece will be constructed

boolean[] constructCenter = new boolean[crossCenterPieceAmount];  // A center piece will be constructed
boolean[] constructCross = new boolean[crossCenterPieceAmount];   // A cross piece will be constructed
// Note: jointPos should always be arranged from smallest to largest this can be done on the refresh
float[] centerJointPos = new float[crossCenterPieceAmount];  // Contains the x-coord start position of each center piece that inserts into the end piece
float[] crossJointPos = new float[crossCenterPieceAmount];   // Contains the x-coord start position of each cross piece that inserts into the side piece
void initialiseConstructBooleans() {
  //for (int i = 0; i < constructCenter.length; i++) {
   // constructCenter[i] = false;
   // constructCross[i] = false;
  //}
  constructCenter[0] = false;
  constructCenter[1] = false;
  constructCenter[2] = false;
  constructCross[0] = false;
  constructCross[1] = false;
  constructCross[2] = false;
  centerJointPos[0] = (endPieceLength -thickness) / 2;
  centerJointPos[1] = (endPieceLength -thickness) / 2  + (thickness - 4 / 2);
  centerJointPos[2] = ((endPieceLength - thickness) / 2) + (thickness / 2);
  crossJointPos[0] = (boxLength -thickness) / 2;
  crossJointPos[1] = ((boxLength - thickness) / 2) + (thickness / 2);
  crossJointPos[2] = ((boxLength - thickness) / 2) + (thickness + 10 / 2);
}

// Center Piece booleans (shared between 3D and .svg shape)
// note: A minimum of one extrude boolean must be set to true otherwise a floating piece will be created
boolean centerExtrudeThroughSide = true;  // When set to true the joints of the centre part will extend through the side of the piece
boolean centerExtrudeThroughTop = true;
boolean centerExtrudeThroughFloor = true;

// Cross Piece Booleans
boolean crossExtrudeThroughSide = true;
boolean crossExtrudeThroughTop = true;
boolean crossExtrudeThroughFloor = true;

// Button Events
boolean buttonAutoRotate = false;  // Set to true if the auto rotate checkbox has been pressed

// -------------------------------------------------------------------------------------------------------------------------------

// Constants

// SVG Constants
static final int BOUNDARY = 10;                                       // The distance from the vector to the edge of the image
static final float PIXEL_TO_MILLIMETRE = (129600/45719.994) / 0.75 ;  // Used to convert pixel measurements to millimetre

// GUI Top button events
static final int EVENT_NULL = 0;
static final int BUTTON_EXPORT = 1;

// Scroll box graphic context 
static final int SCROLL_CONTEXT_X_POSITION = 960;
static final int SCROLL_CONTEXT_Y_POSITION = 115;
static final int SCROLL_CONTEXT_BOX_WIDTH = 310;
static final int SCROLL_CONTEXT_BOX_HEIGHT = 150;

// Box being displayed
int displayedBox = 0;
static final int BOX_OPEN_TOP = 1;
static final int BOX_CLOSED = 2;
static final int BOX_OPEN_THROUGH = 3;
static final int BOX_CENTER_PART = 4;
static final int BOX_CROSS_SECTION = 5;
static final int BOX_RAISED_FLOOR = 6;

// Length type
static final int LENGTH = 1;
static final int WIDTH = 2;
static final int HEIGHT = 3;
static final int THICKNESS = 4;
static final int JOINT_AMOUNT = 5;

// Measurement Type
static final int PIXEL = 0;
static final int MILLIMETRE = 1;
static final int METRE = 2;
static final int INCH = 3;
static final int FOOT = 4;



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
PFont robotoLight15;
PFont robotoLight16;
PFont robotoLight20;

void initialiseFonts() {
  robotoLight25 = loadFont("Roboto-Light-25.vlw");
  robotoLight15 = loadFont("Roboto-Light-15.vlw");
  robotoLight16 = loadFont("Roboto-Light-16.vlw");
  robotoLight20 = loadFont("Roboto-Light-20.vlw");
}
