class Block {
  float x, y, w, m, v;
  
  Block(float x, float w, float m, float v) {
    this.x = x;
    this.y = height - w;
    this.w = w;
    this.m = m;
    this.v = v;
  }
  
  Boolean hitWall() {
    //return x <= 0;
    return x <= 0 || x + w >= width;
  }
  
  void reverse() {
    v *= -1;
  }
  
  Boolean collide(Block other) {
    return !(x + w < other.x || x > other.x + other.w);
  }
  
  float bounce(Block other) {
    float newV = (m - other.m) / (m + other.m) * v + 2 * other.m / (m + other.m) * other.v;
    return newV;
  }
  
  void update() {
    x += v;
  }
  
  void show() {
    image(blockImg, x, y, w, w);
  }
  
  void showDetails() {
    fill(0);
    textSize(8);
    text("Mass: " + m, x, y - 5);
    //text("Velocity: " + abs(v), x, y - 15);
  }
};
