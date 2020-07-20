/** 
 *  Main GUI class responsible for containing all GUI related objects
 *  By Cian O'Gorman 19-07-2020
 */
class GUI_Main {
  
  // Objects
  private GUI_Options_Panel optionsPanel;
  private GUI_Top topPanel;
  
  GUI_Main(){
    optionsPanel = new GUI_Options_Panel();
    topPanel = new GUI_Top();
  }
  
  private void draw(){
    optionsPanel.draw();
    topPanel.draw();
  }
}
