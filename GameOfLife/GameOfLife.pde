int W = 10;
int H = 20;
float spacingW;
float spacingH;

boolean[][] map = new boolean[101][101];
boolean[][] step = new boolean[101][101];

void setup() {
  background(0);
  frameRate(10);
  spacingW = width / W;
  spacingH = height / H;
  
  map[5][7] = true;
  map[6][7] = true;
  map[7][7] = true;
  map[6][8] = true;
  map[7][8] = true;
  map[8][8] = true;
}

void draw() {
  background(0);
  
  if (mousePressed) {
    listen();
  } else {
    takeStep();
  }
  
  drawMap();
  drawGrid();
}

void drawGrid() {
  stroke(255);
  strokeWeight(1);
  for (int i=0;i<=W;i++) {
    line(i*spacingW, 0, i*spacingW, height);
  }
  for (int i=0;i<=H;i++) {
    line(0, i*spacingH, width, i*spacingH);
  }
}

void drawMap() {
  for (int i=1;i<=H;i++) {
    for (int j=1;j<=W;j++) {
      if (map[i][j]) {
        noStroke();
        fill(255, 255, 0);
        pushMatrix();
        translate((j - 1) * spacingW, (i - 1) * spacingH);
        rect(0, 0, spacingW, spacingH);
        popMatrix();
      }
    }
  }
}

void listen() {
  int x = round(map(mouseX, 0, width, 1, W));
  int y = round(map(mouseY, 0, height, 1, H));
  map[y][x] = true;
}

void takeStep() {
  step = new boolean[101][101];
  
  for (int i=1;i<=H;i++) {
    for (int j=1;j<=W;j++) {
      updateAt(i, j);
    }
  }
  
  map = step;
}

void updateAt(int y, int x) {
  int nx, ny;
  int cnt  = 0;
  
  nx = x-1; ny = y-1;
  if (checkAt(nx, ny)) cnt++;
  
  nx = x; ny = y-1;
  if (checkAt(nx, ny)) cnt++;
  
  nx = x+1; ny = y-1;
  if (checkAt(nx, ny)) cnt++;
  
  nx = x-1; ny = y+1;
  if (checkAt(nx, ny)) cnt++;
  
  nx = x; ny = y+1;
  if (checkAt(nx, ny)) cnt++;
  
  nx = x+1; ny = y+1;
  if (checkAt(nx, ny)) cnt++;
  
  nx = x-1; ny = y;
  if (checkAt(nx, ny)) cnt++;
  
  nx = x+1; ny = y;
  if (checkAt(nx, ny)) cnt++;
  
  if (cnt < 2 || cnt > 3) {
    step[y][x] = false;
  } else if (cnt == 2) {
    step[y][x] = map[y][x];
  } else {
    step[y][x] = true;
  }
}

boolean checkAt(int x, int y) {
  if (x >= 1 && x <= W && y >= 1 && y <= H) {
    if (map[y][x]) return true;
  } return false;
}
