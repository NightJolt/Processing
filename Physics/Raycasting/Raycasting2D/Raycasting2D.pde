import java.util.Random;

Boundary[] walls = new Boundary[19];
Particle particle;

float xoff = 0;
float yoff = 1000;

void setup() {
  size(500, 500);
  
  walls[0] = new Boundary(0, 0, width, 0);
  walls[1] = new Boundary(width, 0, width, height);
  walls[2] = new Boundary(width, height, 0, height);
  walls[3] = new Boundary(0, height, 0, 0);
  for (int i=4;i<19;i++) {
    Random random = new Random();
    float x1 = random.nextFloat() * width;
    float x2 = random.nextFloat() * width;
    float y1 = random.nextFloat() * height;
    float y2 = random.nextFloat() * height;
    walls[i] = new Boundary(x1, y1, x2, y2);
  }
  particle = new Particle();
}

void draw() {
  background(0);
  
  for (Boundary wall : walls) wall.show();
  
  particle.update(noise(xoff) * width, noise(yoff) * height);
  particle.lookAt(walls);
  particle.show();
  
  xoff += 0.01;
  yoff += 0.01;
}
