import processing.sound.*;

PImage blockImg;
Block block1;
Block block2;
SoundFile clack;

int count = 0;
int digits = 6;
float timeSteps = 10000;

void setup() {
  size(500, 500);
  blockImg = loadImage("skeleton.jpg");
  clack = new SoundFile(this, "clack.wav");
  block1 = new Block(100, 20, 1, 0);
  block2 = new Block(200, 100, pow(100, digits - 1), -1 / timeSteps);
}

void draw() {
  background(250);
  
  Boolean clackSound = false;
  
  for (int i=0;i<timeSteps;i++) {
    if (block1.collide(block2)) {
      final float v1 = block1.bounce(block2);
      final float v2 = block2.bounce(block1);
      block1.v = v1;
      block2.v = v2;
      clackSound = true;
      count++;
    }
    
    if (block1.hitWall()) {
      count++;
      clackSound = true;
      block1.reverse();
    }
    
    block1.update();
    block2.update();
  }
    
  if (clackSound) clack.play();
  
  block1.show();
  block2.show();
  
  fill(255, 0, 0);
  textSize(32);
  text(count, 20, 50);
}
