import java.util.*; 

class area {
  float x1, y1, x2, y2;
  
  area(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
}

class coord {
  float x, y;
  
  coord(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

/* color bar */
float colorBarH = 0.1;
float colorBarSW = 2;
color colorBarSC = color(100, 76, 69);
color colorBarFC = color(50, 50, 50);
color selectedColor = color(255);
float colorTileH = 0.8;
color[] colors = {
  color(255, 255, 255),
  color(255, 155, 0),
  color(255, 0, 0),
  color(0, 255, 0),
  color(0, 0, 255)
};
Vector<area> colorClickables = new Vector<area>();

/* tool bar */
float toolBarH = 0.1;
float toolBarSW = 2;
color toolBarSC = color(100, 76, 69);
color toolBarFC = color(50, 50, 50);
float buttonTileH = 0.8;
Vector<area> toolClickables = new Vector<area>();

/* drawing area */
float drawAreaH = 0.8;
color backgroundColor = color(0);
area drawArea;
float drawWeight = 5;
boolean isDrawing = false;
boolean hasDrew = false;
coord lastCoord;

void setup() {
  size(360, 640);
  background(0);
  
  toolBarH = height * toolBarH;
  colorBarH = height * colorBarH;
  colorTileH = (colorBarH - colorBarSW * 2) * colorTileH;
  drawAreaH = height * drawAreaH;
  
  prepareDrawingArea();
}

void draw() {
  init();
  drawColorBar();
  drawToolBar();
  
  if (mousePressed) {
    checkClickables();
  } else {
    isDrawing = false;
  }
}

void init() {
  stroke(255);
  //background(0);
}

void checkClickables() {
  float x = mouseX;
  float y = mouseY;
  
  if (isInRect(new coord(x, y), drawArea)) {
    stroke(selectedColor);
    strokeWeight(drawWeight);
    if (isDrawing && hasDrew) {
      line(lastCoord.x, lastCoord.y, x, y);
    } else {
      point(x, y);
      isDrawing = true;
      hasDrew = true;
    } lastCoord = new coord(x, y);
    return;
  }
  
  if (isDrawing) {
    hasDrew = false;
    return;
  }
  
  for (int i=0;i<colorClickables.size();i++) {
    area a = colorClickables.get(i);
    coord dot = new coord(x, y);
    if (isInRect(dot, a)) {
      selectedColor = colors[i];
      return;
    }
  }
  
  for (int i=0;i<toolClickables.size();i++) {
    area a = toolClickables.get(i);
    coord dot = new coord(x, y);
    if (isInRect(dot, a)) {
      prepareDrawingArea();
      return;
    }
  }
}

Boolean isInRect(coord c, area a) {
  if (c.x >= a.x1 && c.x <= a.x2 && c.y >= a.y1 && c.y <= a.y2) return true;
  return false;
}

void prepareDrawingArea() {
  pushMatrix();
  float y = (height - toolBarH - colorBarH - drawAreaH) / 2 + toolBarH;
  translate(0, y);
  stroke(backgroundColor);
  fill(backgroundColor);
  rect(0, 0, width, drawAreaH);
  drawArea = new area(0, y, width, y + drawAreaH);
  popMatrix();
}

void drawColorBar() {
  stroke(colorBarSC);
  strokeWeight(colorBarSW);
  fill(colorBarFC);
  rect(0, 0, width, colorBarH);
  float spacing = (width - colorTileH * colors.length) / (colors.length + 1);
  for (int i=0;i<colors.length;i++) {
    pushMatrix();
    translate(spacing * (i + 1) + colorTileH * i, (colorBarH - colorTileH) / 2);
    stroke(colors[i]);
    fill(colors[i]);
    rect(0, 0, colorTileH, colorTileH);
    if (colorClickables.size() < colors.length) {
      colorClickables.add( 
        new area(
          spacing * (i + 1) + colorTileH * i,
          (colorBarH - colorTileH) / 2,
          spacing * (i + 1) + colorTileH * (i + 1),
          (colorBarH - colorTileH) / 2 + colorTileH
        )
      );
    }
    popMatrix();
    //text(colorClickables.size(), width/2, height/2);
  }
}

void drawToolBar() {
  pushMatrix();
  float y = height - toolBarH;
  translate(0, y);
  stroke(toolBarSC);
  strokeWeight(toolBarSW);
  fill(toolBarFC);
  rect(0, 0, width, toolBarH);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("DELETE", width / 2, toolBarH / 2 - 5);
  toolClickables.add(
    new area(
      0, y, width, height
    )
  );
  popMatrix();
}
