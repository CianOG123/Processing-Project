// Libraries
import processing.svg.*;
import java.util.Arrays;
import java.util.Collections;

// Objects
protected PGraphics svg;  // Used to render all shapes to same canvas

void settings() {
  size(200, 200, P3D);
}

void setup() {
  setCenterJointPosition();
  convertMeasurements();
  initialiseConstructBooleans();



  svg = createGraphics(1000, 1000, SVG, "Render.svg"); 

  // ---- Box Types ----
  //  -1 for default settings
  //  BOX_OPEN_TOP
  //  BOX_CLOSED
  //  BOX_OPEN_THROUGH
  //  BOX_CENTER_PART
  //  BOX_CROSS_SECTION
  //  BOX_RAISED_FLOOR

  SVG_Render render = new SVG_Render(BOX_CROSS_SECTION);
  print("\nRender complete!\n");
  exit();
}
