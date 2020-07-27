// Variables

// User modifiable dimension variables
float boxLength = 200;
float boxWidth = 100;
float boxHeight = 50;
float thickness = 10;
int jointAmount = 5;

// Other Dimension variables
float jointHeight = boxHeight / jointAmount;
boolean refreshBox = false;                                // When set to true, a new box object will be created and measurements will be applied
float endPieceLength = boxWidth - (thickness * 2);
float endPieceJointLength = endPieceLength / 3;                        // Used to set the starting position of the top and bottom joint
float sidePieceJointLength = (boxLength - (thickness * 2)) / 3;
int measurementType = MILLIMETRE;

// Translation Variables
float globalYRotate = 0;     // The rotation applied to the geometry every frame, used for auto rotate
float accumulatedScroll = 15;  // Accumulates the scroll of the users mouse
int scrollSlope = 0;           // If the scroll is increasing or decreasing

// Booleans
boolean inputEnabledElseWhere = false;  // set to true if text input is enalbed anywhere, used to stop the user typing in two boxes at once



// Constants

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

// Fonts
PFont robotoLight25;

// Gradient
static final int X_AXIS = 0;
static final int Y_AXIS = 1;

void initialiseFonts() {
  robotoLight25 = loadFont("Roboto-Light-25.vlw");
}
