import java.util.Random;

PVector[] points;
final int pointsCount = 10;

PVector[] hull;
int currentHull =  -1;

float minX = Float.MAX_VALUE;
int minI;

PVector leftMost;
PVector currentVertex;
int index = 0;
PVector nextVertex;

final float buffer = 20;

void setup() {
  size(500, 500);
  
  points = new PVector[pointsCount];
  hull = new PVector[pointsCount + 1];
  
  Random  random = new Random();
  for (int i=0;i<pointsCount;i++) {
    points[i] = new PVector(random.nextFloat() * (width - 2 * buffer) + buffer, random.nextFloat() * (height - 2 * buffer) + buffer);
  }
  
  for (int i=0;i<pointsCount;i++) {
    PVector p = points[i];
    if (p.x < minX) {
      minX = p.x;
      minI = i;
      leftMost = p;
    }
  }
  PVector holder = points[0];
  points[0] = leftMost;
  points[minI] = holder;
  currentVertex = leftMost;
  hull[++currentHull] = currentVertex;
  nextVertex = points[1];
  index = 2;
}

void draw() {
  drawShape();
  
  stroke(0, 255, 0);
  strokeWeight(2);
  line(currentVertex.x, currentVertex.y, nextVertex.x, nextVertex.y);
  
  stroke(255, 0, 0);
  PVector checking = points[index];
  final PVector a = PVector.sub(nextVertex, currentVertex);
  final PVector b = PVector.sub(checking, currentVertex);
  final PVector cross = a.cross(b);
  if (cross.z < 0) {
    nextVertex = checking;
  } line(currentVertex.x, currentVertex.y, checking.x, checking.y);
  
  index++;
  if (index == pointsCount) {
    hull[++currentHull] = nextVertex;
    currentVertex = nextVertex;
    
    if (nextVertex == leftMost) {
      drawShape();
      noLoop();
    }
    
    nextVertex = leftMost;
    index = 0;
  }
}

void drawShape() {
  background(255);
  
  stroke(0);
  strokeWeight(8);
  for (PVector p : points) {
    point(p.x, p.y);
  }
  
  stroke(0, 0, 255);
  beginShape();
  fill(0, 0, 255, 30);
  for (int i=0;i<=currentHull;i++) {
    vertex(hull[i].x, hull[i].y);
  } endShape();
}
