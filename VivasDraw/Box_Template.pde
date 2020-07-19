/** 
 *  interface designed for all boxes to use and follow.
 *  By Cian O'Gorman 18-07-2020
 */
interface Box_Template{
  
  // Handles the positioning and rotation of each individual part of the box
  void positionGeometry();
  
  // Sets the graphical context container of each part of the box
  void setGraphicContext(PGraphics graphicContext);
}
