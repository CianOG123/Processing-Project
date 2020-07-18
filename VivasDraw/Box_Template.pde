/** 
 *  interface designed for all boxes to use and follow.
 *  By Cian O'Gorman 18-07-2020
 */
interface Box_Template{
  // Declaring 3D transform constants
  final float GLOBAL_X_ROTATE = radians(-15);  // The amount of degrees the graphic context is shifted, giving the appearance of looking down onto the 3D geometry
  final float Y_ROTATE_SPEED = 0.005;          // The amount of radians the box will rotate every frame
  
  // Handles the positioning and rotation of each individual part of the box
  void positionGeometry();
  
  // Sets the graphical context container of each part of the box
  void setGraphicContext(PGraphics graphicContext);
}
