float rot;
float r;
float a = 1.5, b = 2;
float dampingLevel = 9;

color rcolor() {
  return color(random(100, 255), random(100, 255), random(100, 255));
}

void setup() {
  size(600, 600);
  background(0);
  r = random(a, b);
}

void draw() {
  rot += 9;
  translate(width/2, height/2);
  rotate(-HALF_PI);
  
  int hr = hour();
  int mn = minute();
  int sc = second();
  
  strokeWeight(2);
  stroke(rcolor());
  line(0, 0, cos(rot) * height, sin(rot) * height);
  fill(0);
  ellipse(0, 0, width/r, width/r);
  r = (r * dampingLevel + random(a, b)) / (dampingLevel + 1);
  
  push();
  rotate(map(hr % 12, 0, 12, 0, TWO_PI) + map(mn, 0, 60, 0, TWO_PI / 60) + map(sc, 0, 60, 0, TWO_PI / 360));
  stroke(rcolor());
  strokeWeight(6);
  line(0, 0, 50, 0);
  pop();
  
  push();
  rotate(map(mn, 0, 60, 0, TWO_PI) + map(sc, 0, 60, 0, TWO_PI / 60));
  stroke(rcolor());
  strokeWeight(6);
  line(0, 0, 80, 0);
  pop();
  
  push();
  rotate(map(sc, 0, 60, 0, TWO_PI));
  stroke(rcolor());
  strokeWeight(6);
  line(0, 0, 130, 0);
  pop();
}
