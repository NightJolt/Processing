class Block {
  PImage texture;
  
  void show(int x, int y, int lx, int ly) {
    image(texture, x, y, lx, ly);
  }
}
