// Variables

// User modifiable dimension variables
float boxLength = 100;
float boxWidth = 100;
float boxHeight = 50;
float thickness = 3;

// Other Dimension variables
float jointHeight = boxHeight / 5;
float endPieceLength = boxWidth - (thickness * 2);

// Translation Variables
float globalYRotate = 0;                          // The rotation applied to the geometry every frame, used for auto rotate



// Constants

// 3D translation constants
final int GRAPHIC_CONTEXT_VERTICLE_POSITION = 400;  // The larger the number, the higher on the screen all 3D geometry will appear
final float GLOBAL_X_ROTATE = radians(-15);         // The amount of degrees the graphic context is shifted, giving the appearance of looking down onto the 3D geometry
final float Y_ROTATE_SPEED = 0.005;                 // The amount of radians the box will rotate every frame if the auto rotate function is on

// Colors
final color STANDARD_GREY = #757575;
final color LIGHT_GREY = #A4A4A4;
final color HEADING_LIGHT_GREY = #7D7D7D;
final color HEADING_DARK_GREY = #1C1C1C;
final color TRIM_GREY = #8C8C8C;
final color TEXT_WHITE = #FAFAFA;
final color CANCEL_RED = #E53935;
final color GEO_GREEN = #00FF00;
