import java.util.Random;

PVector[] dots;
int dotsCount = 10;

Boundary[] lines;
int linesCount;

Ray ray;
int rayPhase = 1;

int phase;
int dotsDrawn;
int linesDrawn;
Boolean canDrawUnusable = true;

void setup() {
  size(500, 500);
  
  dots = new PVector[dotsCount];
  linesCount = dotsCount * (dotsCount - 1) / 2 + 4;
  lines = new Boundary[linesCount];
  ray = new Ray(new PVector(0, 0));
  
  generateDots();
  generateLines();
  
  background(255);
}

void draw() {
  background(255);
  
  phase = 1;
  if (dotsDrawn == dotsCount) phase = 2;
  if (linesDrawn == linesCount) phase = 3;
  
  if (phase >= 1) {
    showDots();
  } if (phase >= 2) {
    showLines();
  } if (phase == 3) {
    ray.cast(lines);
    ellipse(ray.pos.x, ray.pos.y, 10, 10);
    if (rayPhase == 1) {
      ray.pos.add(new PVector(0, 1));
      if (ray.pos.y == height) rayPhase = 2;
    } else if (rayPhase == 2) {
      ray.dir = new PVector(0, -1);
      ray.pos.y = height;
      ray.pos.add(new PVector(1, 0));
      if (ray.pos.x == width) rayPhase = 3;
    } else if (rayPhase == 3) {
      ray.dir = new PVector(-1, 0);
      ray.pos.x = width;
      ray.pos.add(new PVector(0, -1));
      if (ray.pos.y == 0) rayPhase = 4;
    } else if (rayPhase == 4) {
      ray.dir = new PVector(0, 1);
      ray.pos.y = 0;
      ray.pos.add(new PVector(-1, 0));
      if (ray.pos.x == 0) phase = 4;
    }
  } if (phase == 4) {
    canDrawUnusable = false;
  }
}

void generateDots() {
  Random random = new Random();
  
  for (int i=0;i<dotsCount;i++) {
    float x = random.nextFloat() * (width - 100) + 50;
    float y = random.nextFloat() * (height - 100) + 50;
    dots[i] = new PVector(x, y);
  }
}

void generateLines() {
  int k = 0;
  for (int i=0;i<dotsCount-1;i++) {
    for (int j=i+1;j<dotsCount;j++) {
      lines[k] = new Boundary(dots[i], dots[j]);
      k++;
    }
  }
  
  lines[k++] = new Boundary(new PVector(-5, -5), new PVector(width + 5, -5));
  lines[k++] = new Boundary(new PVector(width + 5, -5), new PVector(width + 5, height + 5));
  lines[k++] = new Boundary(new PVector(width + 5, height + 5), new PVector(-5, height + 5));
  lines[k++] = new Boundary(new PVector(-5, height + 5), new PVector(-5, -5));
}

void showDots() {
  fill(0); if (dotsDrawn < dotsCount) dotsDrawn++;
  for (int i=0;i<dotsDrawn;i++) {
    ellipse(dots[i].x, dots[i].y, 10, 10);
  }
}

void showLines() {
  if (linesDrawn < linesCount) linesDrawn++;
  for (int i=0;i<linesDrawn;i++) {
    lines[i].show();
  }
}
