int maxIt = 1000;
int itPrecision = 10;

float mx = -1;
float my = 0;
float movePrecision = 0.01;

float zoom = 1.2;
float zoomPrecision = 0.01;
float zoomPrecisionPrecision = 0.001;

int col = 0;

void setup() {
  //size(1500, 1000);
  fullScreen();
  colorMode(HSB, 255);
}

/*void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      my -= movePrecision;
    } else if (keyCode == DOWN) {
      my += movePrecision;
    } else if (keyCode == LEFT) {
      mx -= movePrecision;
    } else if (keyCode == RIGHT) {
      mx += movePrecision;
    }
  } else {
    if (key == 'w') {
      maxIt += itPrecision;
    } else if (key == 's') {
      maxIt -= itPrecision;
      if (maxIt < 4) maxIt = 4;
    } else if (key == 'a') {
      zoom += zoomPrecision;
    } else if (key == 'd') {
      zoom -= zoomPrecision;
      if (zoom <= 0) zoom = 0.00001;
    } else if (key == 'q') {
      zoomPrecision -= zoomPrecisionPrecision;
      if (zoomPrecision < zoomPrecisionPrecision) zoomPrecision = zoomPrecisionPrecision;
    } else if (key == 'e') {
      zoomPrecision += zoomPrecisionPrecision;
    }
  }
}*/

void draw() {
  //maxIt++;
  col++; if (col > 255) col = 0;
  pixelDensity(1);
  loadPixels();
  for (int x=0;x<width;x++) {
    for (int y=0;y<height;y++) {
      
      float ratio = (float)width / height;
      
      float a = map(x, 0, width, -zoom * ratio + mx, zoom * ratio + mx);
      float b = map(y, 0, height, -zoom + my, zoom + my);
      
      int n = 0;
     
      float ca = a;
      float cb = b;
      
      for (;n<maxIt;n++) {
        float na = a * a - b * b;
        float nb = 2 * a * b;
        
        a = na + ca;
        b = nb + cb;
        
        if (abs(a + b) > 100) {
          break;
        }
      }
      
      float bright = map(n, 0, maxIt, 0, 1);
      bright = map(sqrt(bright), 0, 1, 20, 100);
      if (n == maxIt) {
        bright = 0;
      }
      
      int pix = x + y * width;
      pixels[pix] = color(col, 255, bright);
    }
  } updatePixels();
}
