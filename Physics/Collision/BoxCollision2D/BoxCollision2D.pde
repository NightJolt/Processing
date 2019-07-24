import processing.sound.*;

PImage blockImg;
Block[] blocks = new Block[4];
SoundFile clack;
float timeSteps = 10000;

void setup() {
  size(1000, 500);
  blockImg = loadImage("resources/skeleton.jpg");
  clack = new SoundFile(this, "resources/clack.wav");
  blocks[0] = new Block(100, 20, 1, 0 / timeSteps);
  blocks[1] = new Block(200, 80, 100, 1 / timeSteps);
  blocks[2] = new Block(300, 40, 4, -4 / timeSteps);
  blocks[3] = new Block(400, 20, 1, 0 / timeSteps);
}

void draw() {
  background(250);
  
  Boolean clackSound = false;
  
  for (int t=0;t<timeSteps;t++) {
    for (int i=0;i<blocks.length-1;i++) {
      for (int j=i+1;j<blocks.length;j++) {
        if (blocks[i].collide(blocks[j])) {
          final float v1 = blocks[i].bounce(blocks[j]);
          final float v2 = blocks[j].bounce(blocks[i]);
          blocks[i].v = v1;
          blocks[j].v = v2;
          clackSound = true;
        }
      }
    }
    
    for (int i=0;i<blocks.length;i++) {
      if (blocks[i].hitWall()) {
        clackSound = true;
        blocks[i].reverse();
      }
    }
    
    for (int i=0;i<blocks.length;i++) {
      blocks[i].update();
    }
  }
    
  if (clackSound) clack.play();
  
  for (int i=0;i<blocks.length;i++) {
    blocks[i].show();
  }
  
  for (int i=0;i<blocks.length;i++) {
    blocks[i].showDetails();
  }
}
