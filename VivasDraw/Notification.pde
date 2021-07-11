/*
 *  Class to control pop-up notification.
 *  Created 11-07-2021
 */
class Notification{
  
  // Constants
  private static final int X_POSITION = 10;
  private static final int Y_POSITION = 620;
  private static final int BOX_WIDTH = 300;
  private static final int BOX_HEIGHT = 70;
  private static final int IMAGE_X = X_POSITION + 5;
  private static final int IMAGE_Y = Y_POSITION + 5;
  private static final int IMAGE_SIZE = 60;
  private static final int IMAGE_FILL = 100;
  private static final int TEXT_X = X_POSITION + 74;
  private static final int HEADING_Y = Y_POSITION + 8;
  private static final int BODY_Y = HEADING_Y + 20;
  private static final int TEXT_WIDTH = BOX_WIDTH - 100;
  private static final int CURVE = 10;
  private static final int TIME_LIMIT = 400;
  private static final int ALPHA_LIMIT = 100;
  
  // Variables
  private String heading;
  private String body;
  private int alpha = 0;
  private int textAlpha = 0;
  private int timer = 0;
  boolean boxLoaded = false;
  boolean isFinished = false;
  
  Notification(String heading, String body){
    this.heading = heading;
    this.body = body;
  }
  
  private void draw(){
    if(alpha < ALPHA_LIMIT && boxLoaded == false){
      alpha++;
      textAlpha += 3;
      if(alpha >= ALPHA_LIMIT){
       boxLoaded = true; 
      }
    }
    if(timer >= TIME_LIMIT){
      alpha--;
      textAlpha -= 3;
    }
    if(alpha > 0){
      noStroke();
      fill(0, 0, 0, alpha);
      rect(X_POSITION, Y_POSITION, BOX_WIDTH, BOX_HEIGHT, CURVE);
      fill(TEXT_WHITE, textAlpha);
      textAlign(LEFT, TOP);
      textFont(robotoLight16);
      text(heading, TEXT_X, HEADING_Y);
      textFont(robotoLight13);
      text(body, TEXT_X, BODY_Y, TEXT_WIDTH, BOX_HEIGHT);
      fill(IMAGE_FILL, IMAGE_FILL, IMAGE_FILL, alpha);
      shape(warning, IMAGE_X, IMAGE_Y, IMAGE_SIZE, IMAGE_SIZE);
      textAlign(LEFT, BOTTOM);
      warning.disableStyle();
      timer++;
    }
    else{
      isFinished = true;
    }
  }
}
